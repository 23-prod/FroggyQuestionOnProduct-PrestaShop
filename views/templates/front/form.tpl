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

{capture name=path}{l s='Question on product'  mod='froggyquestiononproduct'}{/capture}
{include file="{$smarty.const._PS_THEME_DIR_}/breadcrumb.tpl"}

<h1>{l s='Send a question about a product' mod='froggyquestiononproduct'}</h1>

<div class="froggy-qop-product">
    <div class="f_left">
        <a href="{$link->getProductLink($froggyquestiononproduct.product)|escape:'htmlall':'UTF-8'}" class="product_img_link" title="{$froggyquestiononproduct.product->name|escape:'htmlall':'UTF-8'}">
            <img src="{$link->getImageLink($froggyquestiononproduct.product->link_rewrite, $froggyquestiononproduct.product->id_image, $froggyquestiononproduct.image_format)|escape:'htmlall':'UTF-8'}" alt="{$froggyquestiononproduct.product->name|escape:'htmlall':'UTF-8'}" />
        </a>
    </div>
    <h3><a href="{$link->getProductLink($froggyquestiononproduct.product)|escape:'htmlall':'UTF-8'}" title="{$froggyquestiononproduct.product->name|escape:'htmlall':'UTF-8'}">{$froggyquestiononproduct.product->name|escape:'htmlall':'UTF-8'|truncate:35:'...'}</a></h3>
    <p class="product_desc">{$froggyquestiononproduct.product->description_short|strip_tags:'UTF-8'|truncate:360:'...'|escape:'htmlall':'UTF-8'}</p>
    <div class="clearBoth"></div>
</div>

{include file="{$smarty.const._PS_THEME_DIR_}/errors.tpl"}

{if isset($froggyquestiononproduct.success) && $froggyquestiononproduct.success}
    <div class="success">
        <p>{l s='Your question has been sended !' mod='froggyquestiononproduct'}</p>
        <p><a href="{$link->getProductLink($froggyquestiononproduct.product)|escape:'htmlall':'UTF-8'}">{l s='Return to product' mod='froggyquestiononproduct'}</a></p>
    </div>
{else}
    {include file="{$froggyquestiononproduct.module_tpl_dir}/hook/form.tpl" in_page=true}
{/if}