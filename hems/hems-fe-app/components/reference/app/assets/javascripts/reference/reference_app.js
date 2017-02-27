var ref_module_name = "reference";
var ref_app_name = "reference";
var ref_servicesPath = "http://localhost:3000/api/reference/";

var ref_app = angular.module(ref_app_name,['ngRoute','templates','ngResource','angular.filter', 'Core']);
var ref_temPlatePath = "/assets/" + ref_module_name + "/templates/";

function titleCase(input, prefix, suffix) {
	input = input || '';
	res = input.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
	if (prefix) {
		res = prefix + " " + res;
	}
	if (suffix) {
		res += " " + suffix;
	}
	return res;
}

ref_app.filter('lowerCase', function() {
    return function(input, suffix) {
      input = input || '';
      return input.toLowerCase();
    };
  });

ref_app.config(['$routeProvider',function($routeProvider) {
	$routeProvider.when("/",{
		controller: "HomeController",
		templateUrl: ref_temPlatePath + "home.html"
	}).when("/:ref_type/home",{
		controller: "RefCodeHomeController",
		templateUrl: ref_temPlatePath + "ref_code_home.html"
	}).when("/:ref_type/new",{
		controller: "NewController",
		templateUrl: ref_temPlatePath + "record.html"
	}).when("/:ref_type/edit/:id",{
		controller: "EditController",
		templateUrl: ref_temPlatePath + "record.html"
	}).when("/:ref_type/show/:id",{
		controller: "ShowController",
		templateUrl: ref_temPlatePath + "show.html"
	}).when("/:ref_type/delete/:id",{
		controller: "DeleteController",
		templateUrl: ref_temPlatePath + "ref_code_home.html"
	})
}]);

ref_app.controller("HomeController",[
	"$scope","$http","$rootScope", "$location", "Flash", 
	function($scope,$http,$rootScope, $location, Flash) {
		$scope.title = "Reference Type List";

		$http.get(ref_servicesPath+"types").then(function(response) {
			$scope.list = response.data;
		},function(response) {
			handleError(response);
		}
	);

	}
]);

ref_app.controller("RefCodeHomeController",[
	"$scope","$http","$routeParams","$location","Flash",
	function($scope,$http,$routeParams,$location, Flash){
		$scope.codes = [];
		$http.get(ref_servicesPath+ $routeParams.ref_type).then(function(response) {
			$scope.list = response.data;
		},function(response) {
			handleError(response);
		}
		);
		$http.get(ref_servicesPath+ $routeParams.ref_type+"/header").then(function(response) {
			$scope.headerData = response.data;
			$scope.title = titleCase($scope.headerData.title, "", "List");
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
			$location.url("/" + $routeParams.ref_type + "/new");
		};
		$scope.editRow = function(id){
			$location.url("/" + $routeParams.ref_type + "/edit/"+id);

		};
		$scope.showRow = function(id){
			$location.url("/" + $routeParams.ref_type + "/show/"+id);

		};
		$scope.deleteRow = function(id){
			$location.url("/" + $routeParams.ref_type + "/delete/"+id);

		};
		$scope.back = function(){
			$location.url("/");
		};
	}
	]);

ref_app.controller("NewController",[
	"$scope","$routeParams","$http","$location","$rootScope", "Flash", 
	function($scope,$routeParams,$http,$location,$rootScope, Flash){
		$scope.additionalFieldsArr = [];
		$scope.additional_data = "additional_data";

		$http.get(ref_servicesPath+$routeParams.ref_type+"/fields").then(function(response) {
			$scope.fields = response.data;
			for (var i = 0; i < $scope.fields.length; i++) {
				if ($scope.fields[i].is_additional == true){
					$scope.additionalFieldsArr.push($scope.fields[i]);
				}
			}
		},function(response) {
			handleError(response);
		}
		);

		$http.get(ref_servicesPath+ $routeParams.ref_type+"/header").then(function(response) {
			$scope.headerData = response.data;
			$scope.title = titleCase($scope.headerData.title, "Create");
		},function(response) {
			handleError(response);
		}
		);

		$("#btnSubmit").val("Create");
		$scope.submit = function(){
			//var error = validate();
			if (true){
				var sendJSON = {"codes":$scope.form};
				var res = $http.post(ref_servicesPath+$routeParams.ref_type, sendJSON);
				res.success(function(data, status, headers, config) {
					Flash.user_info = "Record Added Successfully.";
					$location.url($routeParams.ref_type + "/home");
				});
				res.error(function(data, status, headers, config) {
					handleError({"status":status, "data":data});
				});
			}
		};

		$scope.back = function(){
			$location.url($routeParams.ref_type + "/home");
		};
	}
	]);


ref_app.controller("EditController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$scope.additionalFieldsArr = [];
		$scope.additional_data = "additional_data";

		$http.get(ref_servicesPath+$routeParams.ref_type+"/fields").then(function(response) {
			$scope.fields = response.data;
			for (var i = 0; i < $scope.fields.length; i++) {
				if ($scope.fields[i].is_additional == true){
					$scope.additionalFieldsArr.push($scope.fields[i]);
				}
			}
		},function(response) {
			handleError(response);
		}
		);

		$http.get(ref_servicesPath+ $routeParams.ref_type+"/header").then(function(response) {
			$scope.headerData = response.data;
			$scope.title = titleCase($scope.headerData.title, "Edit");
		},function(response) {
			handleError(response);
		}
		);

		$http.get(ref_servicesPath + $routeParams.ref_type + "/" + $routeParams.id).then(function(response) {
			$scope.form = response.data;
		},function(response) {
			handleError(response);
		}
		);

		$("#btnSubmit").val("Update");

		$scope.submit = function(){
			//var error =  services.validate($scope.form,$scope.fields);;
			if (true){
				var sendJSON = {"codes":$scope.form};
				var res = $http.put(ref_servicesPath+$routeParams.ref_type+"/"+$routeParams.id, sendJSON);
				res.success(function(data, status, headers, config) {
					Flash.user_info =  "Record Updated Successfully.";
					$location.url($routeParams.ref_type + "/home");
				});
				res.error(function(data, status, headers, config) {
					handleError({"status":status, "data":data});
				});
			}
		};
		$scope.back = function(){
			$location.url($routeParams.ref_type + "/home");
		};
	}
	]);

ref_app.controller("ShowController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$http.get(ref_servicesPath + $routeParams.id).then(function(response) {
			$scope.form = response.data;
		},function(response) {
			handleError(response);
		}
		);

		$scope.back = function(){
			$location.url($routeParams.ref_type + "/home");
		};
	}
	]);

ref_app.controller("DeleteController",[
	"$scope","$routeParams","$http","services","$location", "Flash", 
	function($scope,$routeParams,$http,services,$location, Flash){
		$http.delete(ref_servicesPath + $routeParams.id).then(function(response) {
			Flash.user_info =  "Record Deleted Successfully.";
			$location.url($routeParams.ref_type + "/home");
		},function(response) {
			handleError(response);
		}
		);
	}
	]);

ref_app.service('services', function() {
	this.validate = function (formData,Fields) {
		var error = false;
	}
});