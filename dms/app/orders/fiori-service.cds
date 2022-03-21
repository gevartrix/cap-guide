/*
  Annotations for the "orders" app
*/

// Import AdminServices from the file containing admin services
using AdminService from '../../srv/admin';

// Make price field uneditable
annotate AdminService.Devices with {
	price @Common.FieldControl: #ReadOnly;
}

// Common
annotate AdminService.OrderItems with {
	device @(
		Common: {
			Text: device.name,
			FieldControl: #Mandatory
		},
		ValueList.entity: 'Devices',
	);
	amount @(
		Common.FieldControl: #Mandatory
	);
}

annotate AdminService.Orders with @(
	UI: {
		// Lists of Orders
		SelectionFields: [ createdAt, createdBy ],
		LineItem: [
			{Value: OrderNr, Label: '{i18n>OrderNr}'},
            {Value: createdBy, Label: '{i18n>Customer}'},
			{Value: createdAt, Label: '{i18n>Date}'}
		],

		//	Order details
		HeaderInfo: {
			TypeName: '{i18n>Order}', TypeNamePlural: '{i18n>Orders}',
			Title: {
				Label: '{i18n>OrderNr} ',
				Value: OrderNr
			},
			Description: {Value: createdBy}
		},
		Identification: [ //Is the main field group
			{Value: createdBy, Label: '{i18n>Customer}'},
			{Value: createdAt, Label: '{i18n>Date}'},
			{Value: OrderNr },
		],
		HeaderFacets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Created}', Target: '@UI.FieldGroup#Created'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Modified}', Target: '@UI.FieldGroup#Modified'},
		],
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>OrderItems}', Target: 'Items/@UI.LineItem'},
		],
		FieldGroup#Created: {
			Data: [
				{Value: createdBy},
				{Value: createdAt}
			]
		},
		FieldGroup#Modified: {
			Data: [
				{Value: modifiedBy},
				{Value: modifiedAt}
			]
		}
	}
) {
	createdAt @UI.HiddenFilter: false;
	createdBy @UI.HiddenFilter: false;
};

//The enity types name is AdminService.dms_OrderItems
annotate AdminService.OrderItems with @(
	UI: {
		HeaderInfo: {
			TypeName: '{i18n>OrderItem}',
            TypeNamePlural: '{i18n>OrderItems}',
			Title: {
				Value: device.name
			},
			Description: {Value: device.description}
		},
		// There is no filterbar for items so the selction fields can be omitted
		SelectionFields: [ device_ID ],
		// Lists of OrderItems
		LineItem: [
			{Value: device_ID, Label: '{i18n>ID}'},
			//The following entry is only used to have the assoication followed in the read event
			{Value: device.price, Label: '{i18n>Price'},
			{Value: quantity, Label:'{i18n>Quantity}'}
		],
		Identification: [
			{Value: device_ID, Label:'{i18n>ID}'},
			{Value: quantity, Label:'{i18n>Quantity}'}
		],
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>OrderItems}', Target: '@UI.Identification'},
		],
	}
);