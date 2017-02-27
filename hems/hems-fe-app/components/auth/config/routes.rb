Auth::Engine.routes.draw do
	devise_for :users, {
		class_name: "Auth::Users",
		module: :devise,
		path: "/auth/users",
		skip: [:unlocks]
	}
end