// Import the project schema containing all the models
using { sap.capire.dms as dms } from '../db/schema';

// Define catalog service on route "/admin"
service AdminService @(path:'admin') {
    // Require user authorization
    @requires_:'authenticated-user'
    // Allow full access to the main entities
    entity Devices as projection on dms.Devices;
    entity Categories as projection on dms.Categories;
    entity Orders as select from dms.Orders;
}

// Restrict access to orders to users with role "admin"
annotate AdminService.Orders with  @(restrict: [
    { grant: 'READ', to: 'admin' } 
]);