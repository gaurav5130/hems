Rails.application.routes.draw do
  mount TaxCharge::Engine => "/tax_charge"
end
