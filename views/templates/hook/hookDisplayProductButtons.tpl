{*
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
*}

<p class="froggy-qop-link">
	{if $in_fancy}
		<a id="froggy-qop-fancybox" href="#froggy-qop-fancybox-content">
			<img src="{$module_path}/views/img/help.png" alt="" /> {$link_text}
		</a>
	{else}
		<a id="froggy-qop-fancybox" href="{$controller_href}&id_product={$id_product}">
			<img src="{$module_path}/views/img/help.png" alt="" /> {$link_text}
		</a>
	{/if}
</p>

{if $in_fancy}
	<div style="display: none;">
		<div id="froggy-qop-fancybox-content">
			{include file='../include/form.tpl'}
		</div>
	</div>
{/if}