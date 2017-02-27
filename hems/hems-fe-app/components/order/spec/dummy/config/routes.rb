Rails.application.routes.draw do
  mount Order::Engine => "/order"
end
