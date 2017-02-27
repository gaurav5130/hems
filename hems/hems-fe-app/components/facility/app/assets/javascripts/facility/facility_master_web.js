var fm_module_name = "facility";
var fm_app_name = "facility_masters";
var fm_servicesPath = "http://localhost:3000/api/facility/";
var fm_home_title = "Facility List";
var fm_new_title = "Add Facility";
var fm_edit_title = "Edit Facility";
var fm_show_title = "Show Facility";

var fm_app = angular.module(fm_app_name,['ngRoute','templates','ngResource','angular.filter', 'Core']);
var fm_templatePath = "/assets/" + fm_module_name + "/templates/master/";

fm_app.config(['$routeProvider',function($routeProvider) {
	$routeProvider.when("/",{
		controller: "HomeController",
		templateUrl: fm_templatePath + "home.html"
	}).when("/new",{
		controller: "NewController",
		templateUrl: fm_templatePath + "record.html"
	}).when("/edit/:id",{
		controller: "EditController",
		templateUrl: fm_templatePath + "record.html"
	}).when("/show/:id",{
		controller: "ShowController",
		templateUrl: fm_templatePath + "show.html"
	}).when("/delete/:id",{
		controller: "DeleteController",
		templateUrl: fm_templatePath + "home.html"
	})
}]);

fm_app.controller("HomeController",[
	"$scope","$http","$rootScope", "$location", "Flash", 
	function($scope,$http,$rootScope, $location, Flash) {
		$scope.title = fm_home_title;

		$http.get(fm_servicesPath).then(function(response) {
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

fm_app.controller("NewController",[
	"$scope","$routeParams","$http","$location","$rootScope", "Flash", 
	function($scope,$routeParams,$http,$location,$rootScope, Flash){
		$scope.title = fm_new_title;
		$("#btnSubmit").val("Create");
		$scope.submit = function(){
			//var error = validate();
			if (true){
				var sendJSON = $scope.form;
				var res = $http.post(fm_servicesPath, sendJSON);
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

fm_app.controller("EditController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = fm_edit_title;
		$http.get(fm_servicesPath + $routeParams.id).then(function(response) {
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
				var res = $http.put(fm_servicesPath+$routeParams.id, sendJSON);
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

fm_app.controller("ShowController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = fm_show_title;
		$http.get(fm_servicesPath + $routeParams.id).then(function(response) {
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

fm_app.controller("DeleteController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = fm_home_title;
		$http.delete(fm_servicesPath + $routeParams.id).then(function(response) {
			Flash.user_info =  "Record Deleted Successfully.";
			$location.url("/");
		},function(response) {
			handleError(response);
		}
		);
	}
	]);

fm_app.service('services', function() {
	this.validate = function (formData,Fields) {
		var error = false;
	}
});