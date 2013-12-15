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

<form action="{$link->getModuleLink('froggyquestiononproduct', 'form')}&id_product={$id_product}" method="post">

	{if !$isLogged}
		<label for="email">{l s='Your e-mail address' mod='froggyquestiononproduct'}</label>
		<input type="text" name="email" value="{if isset($smarty.post.email)}{$smarty.post.email|escape:'htmlall':'UTF-8'}{/if}" />
	{/if}

	<p><b>{l s='Please enter below your question about : '}</b> {$product->name}</p>

	<label for="message">{l s='Your question' mod='froggyquestiononproduct'}</label>
	<textarea name="message">{if isset($smarty.post.message)}{$smarty.post.message|escape:'htmlall':'UTF-8'}{/if}</textarea>

	<div class="center">
		<input type="hidden" name="id_product" value="{$id_product}" />
		<input type="submit" name="submitQuestion" value="{l s='Send' mod='froggyquestiononproduct'}" />
	</div>

</form>