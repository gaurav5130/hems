var ftc_module_name = "facility";
var ftc_app_name = "facility_taxcodes";
var ftc_servicesPath = "http://localhost:3000/api/facility_tax_code/";
var ftc_home_title = "Facility Tax-Code List";
var ftc_new_title = "Add Facility Tax-Code";
var ftc_edit_title = "Edit Facility Tax-Code";
var ftc_show_title = "Show Facility Tax-Code";

var ftc_app = angular.module(ftc_app_name,['ngRoute','templates','ngResource','angular.filter', 'Core']);
var ftc_templatePath = "/assets/" + ftc_module_name + "/templates/taxcode/";

ftc_app.config(['$routeProvider',function($routeProvider) {
	$routeProvider.when("/",{
		controller: "HomeController",
		templateUrl: ftc_templatePath + "home.html"
	}).when("/new",{
		controller: "NewController",
		templateUrl: ftc_templatePath + "record.html"
	}).when("/edit/:id",{
		controller: "EditController",
		templateUrl: ftc_templatePath + "record.html"
	}).when("/show/:id",{
		controller: "ShowController",
		templateUrl: ftc_templatePath + "show.html"
	}).when("/delete/:id",{
		controller: "DeleteController",
		templateUrl: ftc_templatePath + "home.html"
	})
}]);

ftc_app.controller("HomeController",[
	"$scope","$http","$rootScope", "$location", "Flash", 
	function($scope,$http,$rootScope, $location, Flash) {
		$scope.title = ftc_home_title;

		$http.get(ftc_servicesPath).then(function(response) {
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

ftc_app.controller("NewController",[
	"$scope","$routeParams","$http","$location","$rootScope", "Flash", 
	function($scope,$routeParams,$http,$location,$rootScope, Flash){
		$scope.title = ftc_new_title;
		$("#btnSubmit").val("Create");
		$scope.submit = function(){
			//var error = validate();
			if (true){
				var sendJSON = $scope.form;
				var res = $http.post(ftc_servicesPath, sendJSON);
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

ftc_app.controller("EditController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = ftc_edit_title;
		$http.get(ftc_servicesPath + $routeParams.id).then(function(response) {
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
				var res = $http.put(ftc_servicesPath+$routeParams.id, sendJSON);
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

ftc_app.controller("ShowController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = ftc_show_title;
		$http.get(ftc_servicesPath + $routeParams.id).then(function(response) {
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

ftc_app.controller("DeleteController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = ftc_home_title;
		$http.delete(ftc_servicesPath + $routeParams.id).then(function(response) {
			Flash.user_info =  "Record Deleted Successfully.";
			$location.url("/");
		},function(response) {
			handleError(response);
		}
		);
	}
	]);

ftc_app.service('services', function() {
	this.validate = function (formData,Fields) {
		var error = false;
	}
});