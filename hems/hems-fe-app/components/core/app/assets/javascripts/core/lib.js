function setLogger() {
	var info = true;
	var debug = false;
	var error = true;
	var warn = true;
	var entry = true;
	var exit = true;

    var __no_op = function() {};
    window.log = {
      debug: __no_op,
      error: __no_op,
      warn: __no_op,
      info: __no_op,
      entry: __no_op,
      exit: __no_op
    }

	if (debug) {
		window.log.debug = window.console.log.bind(window.console, 'debug: %s');
	}
	if (info) {
		window.log.info = window.console.info.bind(window.console, 'info: %s');
	}
	if (warn) {
		window.log.warn = window.console.warn.bind(window.console, 'warn: %s');
	}
	if (error) {
		window.log.error = window.console.error.bind(window.console, 'error: %s');
	}
	if (entry) {
		window.log.entry = window.console.info.bind(window.console, 'entry: %s');
	}
	if (exit) {
		window.log.exit = window.console.info.bind(window.console, 'exit: %s');
	}
}

setLogger();

var Cache = function() {
	var hasStorage = function() {
		return (typeof(Storage) !== "undefined");
	}

	var validate = function() {
		if (!hasStorage()) {
			alert("Please upgrade to latest browser.")
			return false;
		}
		return true;
	}

	return {
		set: function(key, value) {
			if (!validate()) {
				return;
			}

			sessionStorage.setItem(key, value);
		},
		get: function(key) {
			if (!validate()) {
				return;
			}

			return sessionStorage.getItem(key);
		},
		remove: function(key) {
			if (!validate()) {
				return;
			}

			sessionStorage.removeItem(key);
		},
		clear: function() {
			if (!validate()) {
				return;
			}
			
			sessionStorage.clear();
		},
		setJSON: function(key, jsonVal) {
			var value = JSON.stringify(jsonVal);
			this.set(key, value);
		},
		getJSON: function(key) {
			return JSON.parse(this.get(key))
		}
	};
}();

var User = function() {
	return {
		retrieveAccessInfo: function() {
			var access_list = Cache.getJSON("user_access_list");
			//User Access List is already fetched and stored in SessionStorage. Avoid making service call.
			if (access_list) {
				return;
			}

			var options = {
				url: "/api/home/access"
				,error : function(xhr, status, error) {
					log.error("retrieveAccessInfo error returned : status : " + status + " error : " + error);					
				}
				,success : function(resp) {
					Cache.setJSON("user_access_list", resp.data);
					ViewHandler.handleNonAngularAccess();
				}
			}

			HttpService.post(options);
		},
		hasAccess: function(key) {
			if (!key) {
				log.error("No key passed for User.hasAccess method.");
				return false;
			}
			var access_list = Cache.getJSON("user_access_list");
			if (!access_list) {
				log.error("User access list is not available but having a call to access details.");
				return false;
			}
			
			var arr = key.split(".");
			var srvc_id = key;
			switch(arr.length) {
				case 1: //Module ID is passed
					srvc_id += ".root.root";
					break;
				case 2: //Module ID.Service Group ID is passed
					srvc_id += ".root";
					break;
			}
			return ($.inArray(srvc_id, access_list) != -1);
		}
	};
}();

var HttpService = function() {
    var defaults = {
        method : "POST",
        headers : {
            "Accept" : "application/json; charset=utf-8",
            "Content-Type" : "application/json; charset=utf-8"
        },
        dataType: "json",
        data: "",
        cache : false,
        beforeSend : function(jqXHR) {
            jqXHR.setRequestHeader('Authorization', "");
        },
        error : function(xhr, status, err) {
            handleError(xhr, status, err, options);
        },
        success : function(resp) {
        	handleSuccess(resp);
        }
    };

	function execute(options) {
        var settings = $.extend(defaults, options);
        $.ajax(settings);
    }
	
	function handleError(xhr, status, err, options) { 
		log.error("HttpService error returned : status : " + status + " err : " + err);
	}

	function handleSuccess(resp) {
		log.info("HttpService success returned : response : " + response);
	}
	
	function validate(options) {
		if (!options) {
			alert("Options is mandatory to make ajax calls");
			return false;
		}
		if (!options.url) {
			alert("URL is mandatory to make ajax calls");
			return false;
		}
		if (!options.success) {
			alert("Must to specify success handler to make ajax calls");
			return false;
		}
		if (!options.error) {
			alert("Must to specify error handler to make ajax calls");
			return false;
		}
		return true;
	}

	return {
		get: function(options) {
			if (!validate(options)) {
				return;
			}
			options.method = "GET";
			execute(options);
		},
		post: function(options) {
			if (!validate(options)) {
				return;
			}
			options.method = "POST";
			execute(options);
		},
		put: function(options) {
			if (!validate(options)) {
				return;
			}
			options.method = "PUT";
			execute(options);
		}
	};
}();

var ViewHandler = function() {
	return {
		init: function() {
			this.handleNonAngularAccess();
		}
		,handleAccess: function(elem, key) {
			if (!elem) {
				log.error("Unable to handleUserAccess as element is not defined for key : " + key)
				return;
			}
			if (!key) {
				elem.addClass("_auth");
				return;
			}
			if (!User.hasAccess(key)) {
				//Safe coding
				elem.addClass("_auth");		
			}
			else {
				elem.removeClass("_auth");
			}
		}
		,handleNonAngularAccess: function() {
			$('._auth').each(function() {
				var key = this.getAttribute('data-access-key');
				ViewHandler.handleAccess($(this), key);
			});			
		}
	};
}();

$(document).ready(function() {
	ViewHandler.init();
});

//Core Angular App Definition

(function() {
	var core_access_app = angular.module('Core.Access', []);
	core_access_app.directive('accessKey', function () {
	  return {
	      link: function ($scope, element, attr) {
	    	ViewHandler.handleAccess(element, attr.accessKey);
	      }
	  };
	});

	var core_app = angular.module('Core', ['Core.Access']);
	core_app.factory('Flash', function(){
  		return { "user_info": '' };
	});
}());