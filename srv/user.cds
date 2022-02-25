// Import the project schema containing all the models
using { sap.capire.dms as dms } from '../db/schema';

// Define catalog service on route "/browse"
service CatalogService @(path:'/browse') {
    // Require user authorization
    @requires_: 'authenticated-user'
    // Allow users to only view devices with no access to its administrative fields
    @readonly entity Devices as select from dms.Devices {*,
      category.name as category  // Output category by name
    } excluding {createdAt, createdBy, modifiedAt, modifiedBy};
    // Allow only to create orders
    @insertonly entity Orders as projection on dms.Orders;
}

// Allow users to view and edit only the orders they created
annotate CatalogService.Orders with 
    @restrict: [
        {grant: 'READ', to: 'authenticated-user', where: 'createdBy = $user'},
        {grant: 'UPDATE', to: 'authenticated-user', where: 'createdBy = $user'}
    ];
