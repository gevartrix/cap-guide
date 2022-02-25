// Set the project's namespace
namespace sap.capire.dms;
// Import common aspects and types
using { cuid, managed, Currency } from '@sap/cds/common';

/*
 * Entity definition for a device
 * Automatically add the `createdAt`, `createdBy`, `modifiedAt` and `modifiedBy` fields
 */
entity Devices : managed {
    key ID: Integer;
    name: localized String(32);
    category: Association to Categories;
    description: localized String(128);
    quantity: Integer;
    price: Decimal(5,2);
    currency: Currency;
}

/*
 * Entity definition for a category of devices
 * Auto-generate and add UUIDs as the primary key (via the `cuid` aspect)
 */
entity Categories : cuid {
    name: localized String(1600);
    devices: Association to many Devices on devices.category = $self;
}

/*
 * Entity definition for a single ordered device
 * Connect to the Orders entity via the `parent` field
 * Connect to the device ordered via the `device` field
 */
entity OrderItems : cuid {
    parent: Association to Orders;
    device: Association to Devices;
    quantity: Integer;
}

/*
 * Entity definition for the set of orders
 */
entity Orders : cuid, managed {
    OrderNr: String @title: 'Order Number';
    Items: Composition of many OrderItems on Items.parent = $self;
}