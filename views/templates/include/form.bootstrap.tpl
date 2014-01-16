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

<form class="froggy-qop-form{if isset($in_page)} in-page{/if}" action="{$controller_href}&id_product={$id_product}" method="post" data-in-fancy="{if isset($in_fancy)}1{else}0{/if}">

	{if !isset($in_page)}
		<div class="alert alert-success success" style="display: none;">
			{l s='Your question has been sended !' mod='froggyquestiononproduct'}
		</div>
		<div class="alert alert-danger error" style="display: none;">
			{l s='Some errors occured:' mod='froggyquestiononproduct'}
			<ol class="error-list"></ol>
		</div>
		<input type="hidden" name="ajax" value="1" />
		<input type="hidden" name="submitQuestion" value="1" />
	{/if}

	<div id="froggy-qop-form-container">
		{if !isset($in_page)}
			<p class="lead"><b>{l s='Please enter below your question about :' mod='froggyquestiononproduct'}</b> {$product->name}</p>
		{/if}

		{if !$isLogged}
			<label for="email">{l s='Your e-mail address' mod='froggyquestiononproduct'}</label>
			<input type="text" name="email" value="{if isset($smarty.post.email)}{$smarty.post.email|escape:'htmlall':'UTF-8'}{/if}" size="40" placeholder="{l s='your@email' mod='froggyquestiononproduct'}" />
			<div class="clearBoth"></div>
		{/if}

		<label for="message">{l s='Your question' mod='froggyquestiononproduct'}</label>
		<textarea name="message" placeholder="{l s='Type your question here...' mod='froggyquestiononproduct'}">{if isset($smarty.post.message)}{$smarty.post.message|escape:'htmlall':'UTF-8'}{/if}</textarea>
		<div class="clearBoth"></div>

		<hr class="froggy-qop" />

		<div class="center">
			<input type="hidden" name="id_product" value="{$id_product}" />
			<button class="button btn btn-default button-small" type="submit" name="submitQuestion"><span>{l s='Send' mod='froggyquestiononproduct'}</span></button>
		</div>
	</div>

</form>