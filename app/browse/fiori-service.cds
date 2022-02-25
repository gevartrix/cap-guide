/*
  Annotations for the "browse" app
*/

// Import CatalogService from the file containing user services
using CatalogService from '../../srv/user';

// Devices list
annotate CatalogService.Devices with @(
	UI: {
	  SelectionFields: [ category, price ],
		LineItem: [
			{Value: name, Label:'{i18n>Name}'},
			{Value: category, Label:'{i18n>Category}'},
            {Value: quantity, Label:'{i18n>Quantity}'},
			{Value: price, Label:'{i18n>Price}'}
		]
	}
);

// Devices object page
annotate CatalogService.Devices with @(
	UI: {
  	HeaderInfo: {
  		Description: {Value: category}
  	},
		HeaderFacets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Description}', Target: '@UI.FieldGroup#Descr'},
		],
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Details}', Target: '@UI.FieldGroup#Price'},
		],
		FieldGroup#Descr: {
			Data: [
				{Value: description, Label: '{i18n>Description}'},
			]
		},
		FieldGroup#Price: {
			Data: [
				{Value: price, Label: '{i18n>Price}'},
				{Value: currency_code, Label: '{i18n>Currency}'},
			]
		}
	}
);