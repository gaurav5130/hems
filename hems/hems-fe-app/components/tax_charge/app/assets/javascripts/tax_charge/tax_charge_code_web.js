var code_module_name = "tax_charge";
var code_app_name = "codes";
var code_servicesPath = "http://localhost:3000/api/taxcharge/code/";
var code_home_title = "Tax / Charge Code List";
var code_new_title = "Add Tax / Charge Code";
var code_edit_title = "Edit Tax / Charge Code";
var code_show_title = "Show Tax / Charge Code";

var code_app = angular.module(code_app_name,['ngRoute','templates','ngResource','angular.filter', 'Core']);
var code_temPlatePath = "/assets/" + code_module_name + "/templates/code/";

code_app.config(['$routeProvider',function($routeProvider) {
	$routeProvider.when("/",{
		controller: "HomeController",
		templateUrl: code_temPlatePath + "home.html"
	}).when("/new",{
		controller: "NewController",
		templateUrl: code_temPlatePath + "record.html"
	}).when("/edit/:id",{
		controller: "EditController",
		templateUrl: code_temPlatePath + "record.html"
	}).when("/show/:id",{
		controller: "ShowController",
		templateUrl: code_temPlatePath + "show.html"
	}).when("/delete/:id",{
		controller: "DeleteController",
		templateUrl: code_temPlatePath + "home.html"
	})
}]);

code_app.controller("HomeController",[
	"$scope","$http","$rootScope", "$location", "Flash", 
	function($scope,$http,$rootScope, $location, Flash) {
		$scope.title = code_home_title;

		$http.get(code_servicesPath).then(function(response) {
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

code_app.controller("NewController",[
	"$scope","$routeParams","$http","$location","$rootScope", "Flash", 
	function($scope,$routeParams,$http,$location,$rootScope, Flash){
		$scope.title = code_new_title;
		$("#btnSubmit").val("Create");
		$scope.submit = function(){
			//var error = validate();
			if (true){
				var sendJSON = $scope.form;
				var res = $http.post(code_servicesPath, sendJSON);
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

code_app.controller("EditController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = code_edit_title;
		$http.get(code_servicesPath + $routeParams.id).then(function(response) {
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
				var res = $http.put(code_servicesPath+$routeParams.id, sendJSON);
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

code_app.controller("ShowController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = code_show_title;
		$http.get(code_servicesPath + $routeParams.id).then(function(response) {
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

code_app.controller("DeleteController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = code_home_title;
		$http.delete(code_servicesPath + $routeParams.id).then(function(response) {
			Flash.user_info =  "Record Deleted Successfully.";
			$location.url("/");
		},function(response) {
			handleError(response);
		}
		);
	}
	]);

code_app.service('services', function() {
	this.validate = function (formData,Fields) {
		var error = false;
	}
});