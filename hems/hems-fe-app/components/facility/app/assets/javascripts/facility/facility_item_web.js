var fi_module_name = "facility";
var fi_app_name = "facility_items";
var fi_servicesPath = "http://localhost:3000/api/facility_item/";
var fi_home_title = "Facility Item List";
var fi_new_title = "Add Facility Item";
var fi_edit_title = "Edit Facility Item";
var fi_show_title = "Show Facility Item";

var fi_app = angular.module(fi_app_name,['ngRoute','templates','ngResource','angular.filter', 'Core']);
var fi_templatePath = "/assets/" + fi_module_name + "/templates/item/";

fi_app.config(['$routeProvider',function($routeProvider) {
	$routeProvider.when("/",{
		controller: "HomeController",
		templateUrl: fi_templatePath + "home.html"
	}).when("/new",{
		controller: "NewController",
		templateUrl: fi_templatePath + "record.html"
	}).when("/edit/:id",{
		controller: "EditController",
		templateUrl: fi_templatePath + "record.html"
	}).when("/show/:id",{
		controller: "ShowController",
		templateUrl: fi_templatePath + "show.html"
	}).when("/delete/:id",{
		controller: "DeleteController",
		templateUrl: fi_templatePath + "home.html"
	})
}]);

fi_app.controller("HomeController",[
	"$scope","$http","$rootScope", "$location", "Flash", 
	function($scope,$http,$rootScope, $location, Flash) {
		$scope.title = fi_home_title;

		$http.get(fi_servicesPath).then(function(response) {
			$scope.list = response.data;
		},function(response) {
			handleError(response);
		}
	);

	$scope.init = function () {
		handleSuccess(Flash.user_info);
		Flash.user_info = '';
	}

	$scope.init();

		$scope.newRow = function(){
			$location.url("/new");
		};
		$scope.editRow = function(id){
			$location.url("/edit/"+id);

		};
		$scope.showRow = function(id){
			$location.url("/show/"+id);

		};
		$scope.deleteRow = function(id){
			$location.url("/delete/"+id);

		};
	}
]);

fi_app.controller("NewController",[
	"$scope","$routeParams","$http","$location","$rootScope", "Flash", 
	function($scope,$routeParams,$http,$location,$rootScope, Flash){
		$scope.title = fi_new_title;
		$("#btnSubmit").val("Create");
		$scope.submit = function(){
			//var error = validate();
			if (true){
				var sendJSON = $scope.form;
				var res = $http.post(fi_servicesPath, sendJSON);
				res.success(function(data, status, headers, config) {
					Flash.user_info = "Record Added Successfully.";
					$location.url("/");
				});
				res.error(function(data, status, headers, config) {
					handleError({"status":status, "data":data});
				});
			}
		};

		$scope.back = function(){
			$location.url("/");
		};
	}
	]);

fi_app.controller("EditController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = fi_edit_title;
		$http.get(fi_servicesPath + $routeParams.id).then(function(response) {
			$scope.form = response.data;
		},function(response) {
			handleError(response);
		}
		);

		$("#btnSubmit").val("Update");

		$scope.submit = function(){
			//var error =  services.validate($scope.form,$scope.fields);;
			if (true){
				var sendJSON = $scope.form;
				var res = $http.put(fi_servicesPath+$routeParams.id, sendJSON);
				res.success(function(data, status, headers, config) {
					Flash.user_info =  "Record Updated Successfully.";
					$location.url("/");
				});
				res.error(function(data, status, headers, config) {
					handleError({"status":status, "data":data});
				});
			}
		};
		$scope.back = function(){
			$location.url("/");
		};
	}
	]);

fi_app.controller("ShowController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = fi_show_title;
		$http.get(fi_servicesPath + $routeParams.id).then(function(response) {
			$scope.form = response.data;
		},function(response) {
			handleError(response);
		}
		);

		$scope.back = function(){
			$location.url("/");
		};
	}
	]);

fi_app.controller("DeleteController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = fi_home_title;
		$http.delete(fi_servicesPath + $routeParams.id).then(function(response) {
			Flash.user_info =  "Record Deleted Successfully.";
			$location.url("/");
		},function(response) {
			handleError(response);
		}
		);
	}
	]);

fi_app.service('services', function() {
	this.validate = function (formData,Fields) {
		var error = false;
	}
});