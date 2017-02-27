// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_tree .


function handleError(response) {
	console.log("in handle error");
	var errMsg = "Some error occured : Status : " + response.status;
	if (response.data.error) {
		errMsg += " Msg : " + response.data.error;
	}
	$('._info_hidden').removeClass("_info_hidden");
	$('#_info_div').addClass("alert-warning");
	$('._info_span').html(errMsg);
	$("#btnSubmit").removeAttr("disabled");
}

function handleSuccess(msg) {
	if (msg) {
		console.log("in handle success - " + msg);
		$('._info_hidden').removeClass("_info_hidden");
		$('#_info_div').addClass("alert-info");
		$('._info_span').html(msg);	
	}
}

