Metamodel::Reference::RefFields.where(ref_type: 'charge_type').delete_all

Metamodel::Reference::RefHeader.where(ref_type: 'charge_type').delete_all

Metamodel::Reference::RefHeader.create(ref_type: 'charge_type', title: 'Charge Code', description: 'Charge Reference Codes', category: 'charges', overridden_fields: false, additional_fields: false, )

Metamodel::Reference::RefFields.where(ref_type: 'default_type').delete_all

Metamodel::Reference::RefHeader.where(ref_type: 'default_type').delete_all

Metamodel::Reference::RefFields.create(ref_type: 'default_type', fld_name: 'code', title: 'Code', fld_desc: 'Code of Reference', fld_type: 'string', fld_size: 20, sequence: '1', editable: true, is_additional: false)

Metamodel::Reference::RefFields.create(ref_type: 'default_type', fld_name: 'desc', title: 'Description', fld_desc: 'Description of Code', fld_type: 'string', fld_size: 200, sequence: '2', editable: true, is_additional: false)

Metamodel::Reference::RefFields.create(ref_type: 'default_type', fld_name: 'alt_desc', title: 'Alternate Description', fld_desc: 'Alternate Description of code', fld_type: 'string', fld_size: 200, sequence: '3', editable: true, is_additional: false)

Metamodel::Reference::RefFields.create(ref_type: 'default_type', fld_name: 'short_desc', title: 'Short Description', fld_desc: 'Short Description of Code', fld_type: 'string', fld_size: 50, sequence: '4', editable: true, is_additional: false)

Metamodel::Reference::RefFields.where(ref_type: 'facility_type').delete_all

Metamodel::Reference::RefHeader.where(ref_type: 'facility_type').delete_all

Metamodel::Reference::RefHeader.create(ref_type: 'facility_type', title: 'Facility Master', description: 'Facility Master Reference Codes', category: 'facility', overridden_fields: false, additional_fields: false, )

Metamodel::Reference::RefFields.where(ref_type: 'inventory_type').delete_all

Metamodel::Reference::RefHeader.where(ref_type: 'inventory_type').delete_all

Metamodel::Reference::RefHeader.create(ref_type: 'inventory_type', title: 'Inventory', description: 'Inventory Reference Codes', category: 'inventory', overridden_fields: false, additional_fields: false, )

Metamodel::Reference::RefFields.where(ref_type: 'item_type').delete_all

Metamodel::Reference::RefHeader.where(ref_type: 'item_type').delete_all

Metamodel::Reference::RefHeader.create(ref_type: 'item_type', title: 'Item Master', description: 'Item Master Reference Codes', category: 'resources', overridden_fields: false, additional_fields: false, )

Metamodel::Reference::RefFields.where(ref_type: 'ledger_type').delete_all

Metamodel::Reference::RefHeader.where(ref_type: 'ledger_type').delete_all

Metamodel::Reference::RefHeader.create(ref_type: 'ledger_type', title: 'Ledger', description: 'Ledger Reference Codes', category: 'accounts', overridden_fields: false, additional_fields: false, )

Metamodel::Reference::RefFields.where(ref_type: 'resource_type').delete_all

Metamodel::Reference::RefHeader.where(ref_type: 'resource_type').delete_all

Metamodel::Reference::RefHeader.create(ref_type: 'resource_type', title: 'Item Type', description: 'Item Type Reference Codes', category: 'resources', overridden_fields: false, additional_fields: false, )

Metamodel::Reference::RefFields.where(ref_type: 'state_type').delete_all

Metamodel::Reference::RefHeader.where(ref_type: 'state_type').delete_all

Metamodel::Reference::RefHeader.create(ref_type: 'state_type', title: 'States', description: 'States Reference Codes', category: 'taxes', overridden_fields: false, additional_fields: false, )

Metamodel::Reference::RefFields.where(ref_type: 'tax_category_type').delete_all

Metamodel::Reference::RefHeader.where(ref_type: 'tax_category_type').delete_all

Metamodel::Reference::RefHeader.create(ref_type: 'tax_category_type', title: 'Tax Category', description: 'Tax Category Reference Codes', category: 'taxes', overridden_fields: false, additional_fields: false, )

Metamodel::Reference::RefFields.where(ref_type: 'tax_component_type').delete_all

Metamodel::Reference::RefHeader.where(ref_type: 'tax_component_type').delete_all

Metamodel::Reference::RefHeader.create(ref_type: 'tax_component_type', title: 'Tax/Charge Component', description: 'Tax/Charge Component Reference Codes', category: 'taxes', overridden_fields: false, additional_fields: false, )

Metamodel::Reference::RefFields.where(ref_type: 'tax_type').delete_all

Metamodel::Reference::RefHeader.where(ref_type: 'tax_type').delete_all

Metamodel::Reference::RefHeader.create(ref_type: 'tax_type', title: 'Tax Code', description: 'Tax Reference Codes', category: 'taxes', overridden_fields: false, additional_fields: false, )

