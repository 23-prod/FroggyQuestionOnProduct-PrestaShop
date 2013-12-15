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