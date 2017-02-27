var module_name = "items";
var servicesPath = "http://localhost:3000/api/items/sales/";
var home_title = "Sales Items List"
var new_title = "Add Sales Item";
var edit_title = "Edit Sales Item"

var app = angular.module(module_name,['ngRoute','templates','ngResource','angular.filter', 'Core']);
var templatePath = "assets/" + module_name + "/templates/";

function handleError(response) {
	var errMsg = "Some error occured : Status : " + response.status;
	if (response.data.error) {
		errMsg += " Msg : " + response.data.error;
	}
	$('._error_hidden').removeClass("_error_hidden");
	$('._error').html(errMsg);
}

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

		$scope.accessHide = function() {
			console.log("in access hide");
			return true;
		}
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

app.service('services', function() {
	this.validate = function (formData,Fields) {
		var error = false;
		console.log(formData,Fields);
	}
});
	