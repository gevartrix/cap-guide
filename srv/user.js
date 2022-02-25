// Load the CDS module
const cds = require('@sap/cds');
// Load current data-models from a set of CDS entities
const {Devices} = cds.entities;

// Define service implementation for CatalogService
module.exports = (srv) => {
    // Append the "out of stock" label to devices' names AFTER it's been read and processed
    srv.after('READ', 'Devices', (each) => !each.quantity && _handleOutOfStock(each));
  
    // Attempt to reduce device's quantity BEFORE creating an order
    // in case the requested quantity is not available
    srv.before('CREATE', 'Orders', _handleDeviceQuantity);
}

// Append the out-of-stock label to the passed device's name
function _handleOutOfStock(device) {
    device.name += ' -- Currently out of stock';
}

// Handle the devices' quantities account on new order
async function _handleDeviceQuantity(req) {
    // Get the order's data (list of ordered devices)
    const order = req.data;
    // Good practice to store a DB transaction in a variable
    const tx = cds.transaction(req);
    // If the list of ordered items is non-empty
    if (order.Items) {
        const affectedRows = await tx.run(order.Items.map(item =>
            // For each device in the order list reduce its stock quantity,
            // if the requested amount is available
            UPDATE(Devices).where({ID: item.device_ID})
                           .and(`quantity >=`, item.quantity)
                           .set(`quantity -=`, item.quantity)
        ));
        // If the requested amount is more than available, inform user
        if (affectedRows.some(row => !row)) req.error(409, 'Currently out of stock');
    }
}
