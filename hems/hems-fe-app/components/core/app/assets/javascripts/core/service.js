// var access_list;

// $(document).ready(function() {
// 	userAccessInfo();
// });

// function userAccessInfo()
// {
// 	var options = {
// 		url: "/api/home/access"
// 		,error_func : function(status, error) {
// 			//alert("in error func - " + error);
// 		}
// 		,success_func : function(resp) {
// 			access_list = resp.data;
// 			hideAngular();
// 			//hideNavigation();
// 			//alert("in success func - " + resp.data);
// 		}
// 	}

// 	AjaxService(options);
// }

// function hideAngular() {
// 	//var e = angular.element('._auth');
// 	var e = angular.element(document.querySelectorAll("[access]"));
// 	if (!e || e.length == 0)
// 		console.log('no e.access');
// //	console.log("in hide : " + e[0].id);
// 	for (var i=0; i<e.length; i++) {
// 		console.log('e.access : ' + e.access);
// 		toggleAccess(e[i]);
// 	}
// 	//var list = element.find(".ng-invalid,.ng-valid");
// 	// e.each(function (el)
// 	// {
// 	//     var i = $(el);
// 	//     console.log(i.id);
// 	// });
// 	// var e = angular.element('_auth');
// 	// for (elem)
// 	// console.log(e);
// }

// function handleAccess(el, key) {
// 	if (!el) {
// 		console.error("Unable to handleAccess as element is not defined for key : " + key)
// 		return;
// 	}
// 	if (!key) {
// 		el.addClass("hidden");
// 		return;
// 	}
// 	console.log("1");
// 	var arr = key.split(".");
// 	var srvc_id = key;
// 	switch(arr.length) {
// 		case 1: //Module ID is passed
// 			srvc_id += ".root.root";
// 			break;
// 		case 2: //Module ID.Service Group ID is passed
// 			srvc_id += ".root";
// 			break;
// 	}

// 	if ($.inArray(srvc_id, access_list) == -1) {
// 		//Safe coding
// 		console.log("2");
// 		console.log(srvc_id);
// 		console.log(access_list);
// 		el.addClass("hidden");		
// 	}
// 	else {
// 		console.log("3");
// 		el.removeClass("_auth");
// 	}
// 	console.log("4");
// }

// function toggleAccess(el) {
// 		var id = el.id;
// //		console.log("in toggle : " + id);
// 		if (!el.id) {
// 			//Issue - _auth defined without ID
// 			$(el).addClass("hidden");
// 		}
// 		else {
// 			var arr = id.split(".");
// 			var srvc_id = id;
// 			switch(arr.length) {
// 				case 1: //Module ID is passed
// 					srvc_id += ".root.root";
// 					break;
// 				case 2: //Module ID.Service Group ID is passed
// 					srvc_id += ".root";
// 					break;
// 			}

// 			if ($.inArray(srvc_id, access_list) == -1) {
// 				//Safe coding
// 				$(el).addClass("hidden");		
// 			}
// 			else {
// 				$(el).removeClass("_auth");
// 				//$(this).addClass("show");	
// 			}
// 		}				
// }

// function hideNavigation()
// {
// 	$('._auth').each(function() {
// 		console.log($(this));
// 		var id = this.id;
// 		console.log(id);
// 		if (!this.id) {
// 			//Issue - _auth defined without ID
// 			$(this).addClass("hidden");
// 		}
// 		else {
// 			var arr = id.split(".");
// 			var srvc_id = id;
// 			switch(arr.length) {
// 				case 1: //Module ID is passed
// 					srvc_id += ".root.root";
// 					break;
// 				case 2: //Module ID.Service Group ID is passed
// 					srvc_id += ".root";
// 					break;
// 			}

// 			if ($.inArray(srvc_id, access_list) == -1) {
// 				//Safe coding
// 				$(this).addClass("hidden");		
// 			}
// 			else {
// 				$(this).removeClass("_auth");
// 				//$(this).addClass("show");	
// 			}
// 		}			
// 	});
// }

// function AjaxService(options)
// {
// 	var default_options = {
// 		url: null
// 		,type: "post"
// 		,datatype: "json"
// 		,error_func: null
// 		,success_func : null
// 	}

// 	var ajaxOptions = setOptions(options)

// 	$.ajax({
// 			url: ajaxOptions.url
// 			,type: ajaxOptions.type
// 			,dataType: ajaxOptions.datatype
// 			,error: function (xhr, status, error) {
// 				if (ajaxOptions.error_func) {
// 					ajaxOptions.error_func(status, error);
// 				}
// 				else {
// 					alert("An error has occured while making service call. Please try again.");
// 				}
// 			}
// 			,success: function (respData) {
// 				if (ajaxOptions.success_func) {
// 					ajaxOptions.success_func(respData);
// 				}
// 				else {
// 					alert("The response of the service call is ignored.");
// 				}
// 			}
// 		});

// 	function setOptions(options) {
// 		var ajaxOptions = default_options
// 		if (options.url) {
// 			ajaxOptions.url = options.url			
// 		}
// 		else {
// 			alert("Service URL is undefined.");
// 		}

// 		if (options.datatype) {
// 			ajaxOptions.datatype = options.datatype;
// 		}
// 		if (options.success_func) {
// 			ajaxOptions.success_func = options.success_func;
// 		}
// 		if (options.error_func) {
// 			ajaxOptions.error_func = options.error_func;
// 		}

// 		return ajaxOptions;
// 	}
// }
