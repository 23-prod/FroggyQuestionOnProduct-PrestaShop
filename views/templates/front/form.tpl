{capture name=path}{l s='Question on product'  mod='froggyquestiononproduct'}{/capture}
{include file="{$smarty.const._PS_THEME_DIR_}/breadcrumb.tpl"}

<h1>{l s='Send a question about a product' mod='froggyquestiononproduct'}</h1>

<div>
	<a href="{$link->getProductLink($product)}" class="product_img_link" title="{$product->name|escape:'htmlall':'UTF-8'}">
		<img src="{$link->getImageLink($product->link_rewrite, $product->id_image, 'home_default')}" alt="{$product->legend|escape:'htmlall':'UTF-8'}" />
	</a>
	<h3><a href="{$link->getProductLink($product)}" title="{$product->name|escape:'htmlall':'UTF-8'}">{$product->name|escape:'htmlall':'UTF-8'|truncate:35:'...'}</a></h3>
	<p class="product_desc">{$product->description_short|strip_tags:'UTF-8'|truncate:360:'...'}</p>
</div>

<hr />

{include file="{$smarty.const._PS_THEME_DIR_}/errors.tpl"}

{if isset($success) && $success}
	<div class="success">
		<p>{l s='Your question has been sended !' mod='froggyquestiononproduct'}</p>
		<p><a href="{$link->getProductLink($product)}">{l s='Return to product' mod='froggyquestiononproduct'}</a></p>
	</div>
{else}
	{include file='../include/form.tpl'}
{/if}