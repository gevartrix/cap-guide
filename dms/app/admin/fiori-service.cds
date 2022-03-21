/*
  Annotations for the "admin" app
*/

// Import AdminServices from the file containing admin services
using { AdminService } from '../../srv/admin';

//	Devices Object Page
annotate AdminService.Devices with @(
	UI: {
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>General}', Target: '@UI.FieldGroup#General'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Details}', Target: '@UI.FieldGroup#Details'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Technical}', Target: '@UI.FieldGroup#Admin'}
		],
		FieldGroup#General: {
			Data: [
				{Value: name, Label: '{i18n>Name}'},
				{Value: category_ID, Label: '{i18n>CategoryID}'},
				{Value: quantity, Label: '{i18n>Quantity}'}
			]
		},
		FieldGroup#Details: {
			Data: [
				{Value: description, Label: '{i18n>Description}'},
				{Value: price, Label: '{i18n>Price}'},
				{Value: currency_code, Label: '{i18n>Currency}'}
			]
		},
		FieldGroup#Admin: {
			Data: [
				{Value: createdBy},
				{Value: createdAt},
				{Value: modifiedBy},
				{Value: modifiedAt}
			]
		}
	}
);
