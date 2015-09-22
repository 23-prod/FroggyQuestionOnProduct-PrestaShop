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

<p class="froggy-qop-link">
    {if $froggyquestiononproduct.in_fancy}
        <a id="froggy-qop-fancybox" href="#froggy-qop-fancybox-content">
            <img src="{$froggyquestiononproduct.module_path|escape:'htmlall':'UTF-8'}/views/img/help.png" alt="" /> {$froggyquestiononproduct.link_text|escape:'htmlall':'UTF-8'}
        </a>
    {else}
        <a id="froggy-qop-fancybox" href="{$froggyquestiononproduct.controller_href|escape:'htmlall':'UTF-8'}&id_product={$froggyquestiononproduct.id_product|escape:'htmlall':'UTF-8'}">
            <img src="{$froggyquestiononproduct.module_path|escape:'htmlall':'UTF-8'}/views/img/help.png" alt="" /> {$froggyquestiononproduct.link_text|escape:'htmlall':'UTF-8'}
        </a>
    {/if}
</p>