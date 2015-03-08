{*
* 2013-2015 Froggy Commerce
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
*  @copyright  2013-2015 Froggy Commerce
*}

{if $in_fancy}
	<div style="display: none;">
		<div id="froggy-qop-fancybox-content">
			{include file="{$froggyquestiononproduct.module_tpl_dir|escape:'htmlall':'UTF-8'}/hook/form.bootstrap.tpl"}
		</div>
	</div>
{else}
	<h3 class="page-product-heading">{$froggyquestiononproduct.tab_text|escape:'htmlall':'UTF-8'}</h3>

	<div id="idTabfroggyquestiononproduct">
		{include file="{$froggyquestiononproduct.module_tpl_dir|escape:'htmlall':'UTF-8'}/hook/form.bootstrap.tpl"}
	</div>
{/if}