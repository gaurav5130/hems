var module_name = "tax_charge";
var app_name = "comps";
var servicesPath = "http://localhost:3000/api/taxcharge/component/";
var home_title = "Tax / Charge Component List";
var new_title = "Add Tax / Charge Component";
var edit_title = "Edit Tax / Charge Component";
var show_title = "Show Tax / Charge Component";

var app = angular.module(app_name,['ngRoute','templates','ngResource','angular.filter', 'Core']);
var templatePath = "/assets/" + module_name + "/templates/component/";

app.config(['$routeProvider',function($routeProvider) {
	$routeProvider.when("/",{
		controller: "HomeController",
		templateUrl: templatePath + "home.html"
	}).when("/new",{
		controller: "NewController",
		templateUrl: templatePath + "record.html"
	}).when("/edit/:id",{
		controller: "EditController",
		templateUrl: templatePath + "record.html"
	}).when("/show/:id",{
		controller: "ShowController",
		templateUrl: templatePath + "show.html"
	}).when("/delete/:id",{
		controller: "DeleteController",
		templateUrl: templatePath + "home.html"
	})
}]);

app.controller("HomeController",[
	"$scope","$http","$rootScope", "$location", "Flash", 
	function($scope,$http,$rootScope, $location, Flash) {
		$scope.title = home_title;

		$http.get(servicesPath).then(function(response) {
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

app.controller("NewController",[
	"$scope","$routeParams","$http","$location","$rootScope", "Flash", 
	function($scope,$routeParams,$http,$location,$rootScope, Flash){
		$scope.title = new_title;
		$("#btnSubmit").val("Create");
		$scope.submit = function(){
			//var error = validate();
			if (true){
				var sendJSON = $scope.form;
				var res = $http.post(servicesPath, sendJSON);
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

app.controller("EditController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = edit_title;
		$http.get(servicesPath + $routeParams.id).then(function(response) {
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
				var res = $http.put(servicesPath+$routeParams.id, sendJSON);
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

app.controller("ShowController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = show_title;
		$http.get(servicesPath + $routeParams.id).then(function(response) {
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

app.controller("DeleteController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.title = home_title;
		$http.delete(servicesPath + $routeParams.id).then(function(response) {
			Flash.user_info =  "Record Deleted Successfully.";
			$location.url("/");
		},function(response) {
			handleError(response);
		}
		);
	}
	]);

app.service('services', function() {
	this.validate = function (formData,Fields) {
		var error = false;
	}
});