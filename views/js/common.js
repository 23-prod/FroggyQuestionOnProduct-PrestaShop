/*
 * 2013-2014 Froggy Commerce
 *
 * NOTICE OF LICENSE
 *
 * You should have received a licence with this module.
 * If you didn't buy this module on Froggy-Commerce.com, ThemeForest.net
 * or Addons.PrestaShop.com, please contact us immediately : contact@froggy-commerce.com
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to benefit the updates
 * for newer PrestaShop versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 *  @author Froggy Commerce <contact@froggy-commerce.com>
 *  @copyright  2013-2014 Froggy Commerce
 */

$(function() {
	if ($('.froggy-qop-form').data('in-fancy')) {
		$('#froggy-qop-fancybox').fancybox({
			'width': '650',
			'height': '300',
			'autoDimensions' : false
		});
	}

	$('.froggy-qop-form').not('.in-page').submit(function(e) {
		e.preventDefault();

		var $error_container = $('.froggy-qop-form').find('.error');
		var $success_container = $('.froggy-qop-form').find('.success');
		var $error_list = $error_container.find('.error-list');
		$error_container.hide();
		$success_container.hide();
		$error_list.html('');

		$.ajax({
			type: "POST",
			url: $('.froggy-qop-form').attr('action'),
			data: $('.froggy-qop-form').serialize(),
			dataType: 'json',
			success: function( data ) {
				if (data.has_errors) {

					$.each(data.errors, function(key, value) {
						$error_list.append(
							$('<li/>').html(value)
						);
					});

					$('.froggy-qop-form').find('.error').show();
				} else {
					$success_container.show();
					$('#froggy-qop-form-container').hide();
				}
			}
		});
	});
});