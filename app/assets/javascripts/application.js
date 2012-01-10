// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

simplebanana.form_validations = function() {
	function validateForm() {
		return $.isNumeric($('#discounted_price').val()) && $.isNumeric($('#original_price').val()) && (parseInt($('#discounted_price').val(),10)<parseInt($('#original_price').val(),10)) && (parseInt($("#start_time option:selected").text(),10)<parseInt($('#end_time option:selected').text(),10));
	};
	$('#deal_create_form').submit(validateForm);
	$('#discounted_price').change(function() {
		if(!$.isNumeric($(this).val()))
			$('#discounted_price_validation').text('Discounted price must be a number');
		else
			$('#discounted_price_validation').text('');
		if(($('original_price').val()!='') && (parseInt($(this).val(),10)>=parseInt($('#original_price').val(),10)))
			$('#price_difference_validation').text('Discounted price must be less than original price');
		else
			$('#price_difference_validation').text('');
	});
	$('#original_price').change(function() {
		if(!$.isNumeric($(this).val()))
			$('#original_price_validation').text('original price must be a number');
		else
			$('#original_price_validation').text('');
		if(($('discounted_price').val()!='') && (parseInt($('#discounted_price').val(),10)>=parseInt($(this).val(),10)))
			$('#price_difference_validation').text('Discounted price must be less than original price');
		else
			$('#price_difference_validation').text('');
	});
	$('#start_time').change(function() {
		if(parseInt($("#start_time option:selected").text(),10)>=parseInt($('#end_time option:selected').text(),10))
			$('#time_difference_validation').text('End time must be after start time');
		else
			$('#time_difference_validation').text('');
	});	
	$('#end_time').change(function() {
		if(parseInt($("#start_time option:selected").text(),10)>=parseInt($('#end_time option:selected').text(),10))
			$('#time_difference_validation').text('End time must be after start time');
		else
			$('#time_difference_validation').text('');
	});
};

simplebanana.deal_expander = function () {
	$('.deal_expander').click(function() {
		$(this).parent().next().toggle();
		return false;
	});
};
