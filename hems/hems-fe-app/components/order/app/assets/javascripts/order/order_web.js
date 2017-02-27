var module_name = "order";
var orderServicesPath = "http://localhost:3000/api/manageorder";
var billServicesPath="http://localhost:3000/api/managebill"

var app = angular.module(module_name,['ngRoute','templates','ngResource','angular.filter', 'Core']);
var templatePath = "/assets/" + module_name + "/templates/";

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
		templateUrl: templatePath + "takeorder.html"
	})
}]);

app.controller("HomeController",[
	"$scope","$http","$rootScope", "$location", "Flash", 
	function($scope,$http,$rootScope, $location, Flash) {
		$scope.facility=[
			{facility_code: "FAC001", facility_name: "A/C Restaurant"},
			{facility_code: "FAC002", facility_name: "Non A/C Restaurant"},
			{facility_code: "FAC003", facility_name: "Gym"},
			{facility_code: "FAC004", facility_name: "Party"},
			{facility_code: "FAC005", facility_name: "Sports"}
		]

		$scope.init = function () {
			log.info("calling init..");
			handleSuccess(Flash.user_info);
			Flash.user_info = '';
		}

		$scope.init();

		$scope.saveOrder = function(){
				var sendJSON = $scope.form;
				console.log(sendJSON);
				var res = $http.post(orderServicesPath+"/save", sendJSON);
				res.success(function(data, status, headers, config) {
					Flash.user_info = "Order Saved Successfully.";
					$scope.init();
					$scope.resetForm($scope.form);
					$("#btnSubmit").removeAttr("disabled");
					$scope.focusElement = "facility_code";
				});
				res.error(function(data, status, headers, config) {
					handleError({"status":status, "data":data});
				});
		};
		$scope.prepare = function(){
				var member_id = $scope.form.member_id;
				var fac_code = $scope.form.facility_code; 
				window.location.href = "http://localhost:4000/bill/prepare#?member_id="+member_id+"&facility_code="+fac_code;			
				// var res = $http.post(billServicesPath+"/prepare", sendJSON);
				// res.success(function(data, status, headers, config) {
				// 	Flash.user_info = "Record Added Successfully.";
				// 	$location.url("/");
				// });
				// res.error(function(data, status, headers, config) {
				// 	handleError({"status":status, "data":data});
				// });
		};
		$scope.resetForm = function(form) {
	      //Even when you use form = {} it does not work
	      angular.copy({},form);
	    };

	}
]);

app.service('services', function() {
	this.validate = function (formData,Fields) {
		var error = false;
		console.log(formData,Fields);
	}
});
	
