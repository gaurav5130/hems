var bill_module_name = "bill";
var bill_app_name = "bills";
var bill_servicesPath = "http://localhost:3000/api/managebill";
var bill_home_title = "Bill Summary";

var bill_app = angular.module(bill_app_name,['ngRoute','templates','ngResource','angular.filter']);
var bill_temPlatePath = "/assets/" + bill_module_name + "/templates/";

bill_app.config(['$routeProvider',function($routeProvider) {
	$routeProvider.when("/",{
		controller: "HomeController",
		templateUrl: bill_temPlatePath + "prepare.html"
	})
}]);

// make a factory to share data between controllers
bill_app.factory('SharedData', function(){
	return { "user_info": '' };
});

bill_app.controller("HomeController",[
	"$scope","$http","$rootScope", "$location", "SharedData", "$routeParams",
	function($scope,$http,$rootScope, $location, SharedData,$routeParams) {
		$scope.title = bill_home_title;
		$scope.charge_total = 0;
		$scope.taxes_total = 0;
		/*{
		"context": {
			"corporate_id": "C1",
			"establishment_id": "E1"
		},
		"bill_number": "E1B264",
		"items": [{
			"code": "001",
			"quantity": 1.0,
			"rate_per_unit": 100.0,
			"discount": 0.0,
			"invoice_amount": 100.0
		}, {
			"code": "007",
			"quantity": 1.0,
			"rate_per_unit": 150.0,
			"discount": 0.0,
			"invoice_amount": 150.0
		}, {
			"code": "011",
			"quantity": 1.0,
			"rate_per_unit": 60.0,
			"discount": 0.0,
			"invoice_amount": 60.0
		}],
		"total_published_amount": 310.0,
		"discount_benefit_to_customer": 0.0,
		"total_invoice_amount": 310.0,
		"total_charges": 31.0,
		"total_taxes": 335.158,
		"total_payable": 676.158,
		"amount_collected": null
	}*/

	var res = $http.post(bill_servicesPath+"/prepare?member_id="+$routeParams.member_id+"&facility_code="+$routeParams.facility_code);
	res.success(function(data, status, headers, config) {
		$scope.items = data.items;
		$scope.charges = data.total_charges;
		$scope.taxes = data.total_taxes;
		$scope.billNumber = data.bill_number;
		$scope.payable = data.total_payable;
		$scope.steward = data.steward;
		$scope.waitor = data.waitor;
		$scope.billDate = data.bill_date;
		$scope.member_id = data.member_id;
		$scope.billDis = 0;
		$scope.items_total = 0;
		for(var index in $scope.items){
			$scope.items_total += ($scope.items[index].published_rate * $scope.items[index].quantity);
			$scope.items[index].disType = "rupee";
		}
		$scope.billdisType = "rupee";

		// $scope.getSubTotal = function(){
		// 	return parseFloat($scope.getGrossTotal() + $scope.charges.tot_amt + $scope.taxes.tot_amt);
		// }
		$scope.getGrossTotal = function(){
			var grossTotal = 0;
			for(var index in $scope.items) {
				grossTotal += $scope.items[index].invoice_amount;
			}
			return grossTotal;
		};

		$scope.getTotal = function(){
			if ($scope.billdisType == "rupee"){
				return $scope.payable - $scope.billDis;
			}else if($scope.billdisType == "percentage"){
				return $scope.payable - (($scope.payable * $scope.billDis)/100);
			}
		};
	});
	res.error(function(data, status, headers, config) {
	});


	$scope.recalBill = function(){
		var recalJSON = {};
		recalJSON.bill_number = $scope.billNumber;
		recalJSON.itemsDiscount = [];
		for(var index in $scope.items) {
			if (typeof($scope.items[index].discount) != "undefined" && $scope.items[index].discount != 0){	
				itemObj = {};
				itemObj.code = $scope.items[index].code;
				itemObj.discount = $scope.items[index].discount;
				itemObj.disType = $scope.items[index].disType;
				recalJSON.itemsDiscount.push(itemObj);
			}
		}
		recalJSON.billDiscount = {};
		if($scope.billDis != "" && $scope.billDis != 0 && $scope.billDis != "0"){
			recalJSON.billDiscount.discount = $scope.billDis;
			recalJSON.billDiscount.disType = $scope.billdisType;

		}
		console.log(recalJSON);
		var res = $http.post(bill_servicesPath+"/update", recalJSON);
		res.success(function(data, status, headers, config) {
			$scope.items = data.items;
			$scope.charges = data.total_charges;
			$scope.taxes = data.total_taxes;
			$scope.billNumber = data.bill_number;
			$scope.payable = data.total_payable;
			$scope.steward = data.steward;
			$scope.waitor = data.waitor;
			$scope.billDate = data.bill_date;
			$scope.member_id = data.member_id;
			$scope.billDis = 0;
			$scope.items_total = 0;
			for(var index in $scope.items){
				$scope.items_total += ($scope.items[index].published_rate * $scope.items[index].quantity);
				$scope.items[index].disType = "rupee";
			}
		});

		res.error(function(data, status, headers, config) {
			alert( "failure message: " + JSON.stringify({data: data}));
		});
	}

	$scope.deleteBill = function(){
		delJSON = {"bill_number":$scope.billNumber};
		var res = $http.post(bill_servicesPath+"/delete", delJSON);
		res.success(function(data, status, headers, config) {
			
		});

		res.error(function(data, status, headers, config) {
			alert( "failure message: " + JSON.stringify({data: data}));
		});
	};
	$scope.init = function () {
		handleSuccess(SharedData.user_info);
		SharedData.user_info = '';
	}

	$scope.init();

}
]);

bill_app.service('services', function() {
	this.validate = function (formData,Fields) {
		var error = false;
	}
});