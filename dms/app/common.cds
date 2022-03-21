/*
  Set of common annotations shared by all apps
*/

// Import the project schema containing all the models
using { sap.capire.dms as dms } from '../db/schema';


// Devices Lists
annotate dms.Devices with @(
	UI: {
		Identification: [{Value:name}],
	    SelectionFields: [ ID, name, category_ID, quantity, price, currency_code ],
		LineItem: [
			{Value: ID, Label: '{i18n>ID}'},
			{Value: name, Label: '{i18n>Name}'},
			{Value: category_ID.name, Label:'{i18n>Category}'},
			{Value: quantity, Label: '{i18n>Quantity}'},
			{Value: price, Label: '{i18n>Price}'},
			{Value: currency_code}
		]
	}
) 
{
	category @ValueList.entity:'Categories';
};

annotate dms.Categories with @(
	UI: {
		Identification: [{Value:name, Label: '{i18n>Name}'}],
	}
);

// Devices Details
annotate dms.Devices with @(
	UI: {
  	HeaderInfo: {
  		TypeName: '{i18n>Device}',
  		TypeNamePlural: '{i18n>Devices}',
  		Title: {Value: name, Label: '{i18n>Name}'},
  		Description: {Value: category.name, Label: '{i18n>Category}'}
  	},
	}
);

// Devices elements
annotate dms.Devices with {
	ID @title:'{i18n>ID}' @UI.HiddenFilter;
	name @title:'{i18n>Name}';
	category @title:'{i18n>CategoryID}';
	price @title:'{i18n>Price}';
	quantity @title:'{i18n>Quantity}';
	description @UI.MultiLineText;
}

// Categories elements
annotate dms.Categories with {
	ID @title:'{i18n>ID}' @UI.HiddenFilter;
	name @title:'{i18n>Category}';
}