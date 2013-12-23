$(function() {
	$('#show-mode').change(function() {
		updateTextFieldsShowing();
	});
	updateTextFieldsShowing();
});

function updateTextFieldsShowing()
{
	var text_type = $('#show-mode').children('option:selected').data('text');

	$('.text-fields').hide();
	$('#'+text_type+'-fields').show();
}