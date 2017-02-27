Rails.application.routes.draw do
  mount Bill::Engine => "/bill"
end
