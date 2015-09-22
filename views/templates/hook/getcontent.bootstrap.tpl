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

<script type="text/javascript">id_language = Number({$id_lang_default|escape:'htmlall':'UTF-8'});</script>
<h2 align="center">{l s='froggy question on product' mod='froggyquestiononproduct'}</h2>
<fieldset>
    <legend><img src="{$froggyquestiononproduct.module_dir|escape:'htmlall':'UTF-8'}logo.png" alt="" width="16" />{l s='Allow customer to ask a question on a product' mod='froggyquestiononproduct'}</legend>

    {if $froggyquestiononproduct.post_process.result === true}
        <div class="module_confirmation conf confirm alert alert-success">
            {l s='Configurations saved with success !' mod='froggyquestiononproduct'}
        </div>
    {elseif $froggyquestiononproduct.post_process.result === false}
        <div class="module_confirmation conf confirm alert alert-danger">
            <ul>
                {foreach from=$froggyquestiononproduct.post_process.errors item=error}
                    <li>{$error|escape:'htmlall':'UTF-8'}</li>
                {/foreach}
            </ul>
        </div>
    {/if}
    <div class="panel">
        <form action="{$smarty.server.REQUEST_URI|escape:'htmlall':'UTF-8'}" method="post" class="form-horizontal">
            <h3>{l s='General' mod='froggyquestiononproduct'}</h3>
            <div class="form-group">
                <label class="control-label col-lg-3">{l s='Only for registered customer' mod='froggyquestiononproduct'} <sup class="required">*</sup></label>
                <div class="col-lg-9">
                    <div class="radio">
                        <input type="radio" name="FC_QOP_ONLY_FOR_CUSTOMER" value="1" {if (isset($smarty.post.FC_QOP_ONLY_FOR_CUSTOMER) && $smarty.post.FC_QOP_ONLY_FOR_CUSTOMER == 1) || (!isset($smarty.post.FC_QOP_ONLY_FOR_CUSTOMER) && $froggyquestiononproduct.FC_QOP_ONLY_FOR_CUSTOMER)}checked="checked"{/if} id="fc-questiononproduct-for-1" />
                        <label class="t" for="fc-questiononproduct-for-1"><img src="../img/admin/enabled.gif" alt="" />&nbsp;{l s='Yes' mod='froggyquestiononproduct'}</label>
                    </div>
                    <div class="radio">
                        <input type="radio" name="FC_QOP_ONLY_FOR_CUSTOMER" value="0" {if (isset($smarty.post.FC_QOP_ONLY_FOR_CUSTOMER) && $smarty.post.FC_QOP_ONLY_FOR_CUSTOMER == 0) || (!isset($smarty.post.FC_QOP_ONLY_FOR_CUSTOMER) && !$froggyquestiononproduct.FC_QOP_ONLY_FOR_CUSTOMER)}checked="checked"{/if} id="fc-questiononproduct-for-2" />
                        <label class="t" for="fc-questiononproduct-for-2"><img src="../img/admin/disabled.gif" alt="" />&nbsp;{l s='No' mod='froggyquestiononproduct'}</label>
                    </div>
                    <p class="help-block">{l s='If active, only logged users see the question form on product page' mod='froggyquestiononproduct'}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-3">{l s='Send to contact' mod='froggyquestiononproduct'} <sup class="required">*</sup></label>
                <div class="col-lg-9">
                    <select name="FC_QOP_CONTACT_ID">
                        {foreach from=$contacts item=contact}
                            <option value="{$contact.id_contact}" {if $froggyquestiononproduct.FC_QOP_CONTACT_ID == $contact.id_contact}selected="selected"{/if}>
                                {$contact.name|escape:'htmlall':'UTF-8'} - {$contact.email|escape:'htmlall':'UTF-8'}
                            </option>
                        {/foreach}
                    </select>
                    <p class="help-block">{l s='The recipient of question' mod='froggyquestiononproduct'}</p>
                </div>
            </div>
            <h3>{l s='Show mode' mod='froggyquestiononproduct'}</h3>
            <div class="form-group">
                <label class="control-label col-lg-3">{l s='Show mode' mod='froggyquestiononproduct'} <sup class="required">*</sup></label>
                <div class="col-lg-9">
                    <select name="FC_QOP_SHOW_MODE" id="show-mode">
                        <option value="0" {if (isset($smarty.post.FC_QOP_SHOW_MODE) && $smarty.post.FC_QOP_SHOW_MODE == '0') || (!isset($smarty.post.FC_QOP_SHOW_MODE) && $froggyquestiononproduct.FC_QOP_SHOW_MODE == '0')}selected="selected"{/if} data-text="link_text">{l s='In a pop-in' mod='froggyquestiononproduct'}</option>
                        <option value="1" {if (isset($smarty.post.FC_QOP_SHOW_MODE) && $smarty.post.FC_QOP_SHOW_MODE == '1') || (!isset($smarty.post.FC_QOP_SHOW_MODE) && $froggyquestiononproduct.FC_QOP_SHOW_MODE == '1')}selected="selected"{/if} data-text="tab_text">{l s='In a product tab' mod='froggyquestiononproduct'}</option>
                        <option value="2" {if (isset($smarty.post.FC_QOP_SHOW_MODE) && $smarty.post.FC_QOP_SHOW_MODE == '2') || (!isset($smarty.post.FC_QOP_SHOW_MODE) && $froggyquestiononproduct.FC_QOP_SHOW_MODE == '2')}selected="selected"{/if} data-text="link_text">{l s='In a page' mod='froggyquestiononproduct'}</option>
                    </select>
                </div>
            </div>
            <h3>{l s='Configure text' mod='froggyquestiononproduct'}</h3>

            <div id="tab_text-fields" class="form-group text-fields">
                <label class="control-label col-lg-3">{l s='Tab text' mod='froggyquestiononproduct'}</label>
                <div class="col-lg-9">
                    {foreach from=$languages item=language}
                        <div id="tab_text_{$language['id_lang']}" style="display: {if $language['id_lang'] == $id_lang_default}block{else}none{/if}">
                            <input type="text" name="tab_text[{$language['id_lang']}]" id="tab_text_{$language['id_lang']}" value="{if isset($smarty.post.tab_text.{$language['id_lang']})}{$smarty.post.tab_text.{$language['id_lang']}|escape:'htmlall':'UTF-8'}{else}{$froggyquestiononproduct.FC_QOP_TAB_TEXT.{$language['id_lang']}}{/if}" />
                        </div>
                    {/foreach}
                    {FroggyDisplaySafeHtml s=$module->displayFlags($languages, $id_lang_default, $divLangName, 'tab_text', true)}
                    <p class="help-block">{l s='This text will be used on tab on product page' mod='froggyquestiononproduct'}</p>
                </div>
            </div>

            <div id="link_text-fields" class="form-group text-fields">
                <label class="control-label col-lg-3">{l s='Link text' mod='froggyquestiononproduct'}</label>
                <div class="col-lg-9">
                    {foreach from=$languages item=language}
                        <div id="link_text_{$language['id_lang']}" style="display: {if $language['id_lang'] == $id_lang_default}block{else}none{/if}">
                            <input type="text" name="link_text[{$language['id_lang']}]" id="link_text_{$language['id_lang']}" value="{if isset($smarty.post.link_text.{$language['id_lang']})}{$smarty.post.link_text.{$language['id_lang']}|escape:'htmlall':'UTF-8'}{else}{$froggyquestiononproduct.FC_QOP_LINK_TEXT.{$language['id_lang']}}{/if}" />
                        </div>
                    {/foreach}
                    {FroggyDisplaySafeHtml s=$module->displayFlags($languages, $id_lang_default, $divLangName, 'link_text', true)}
                    <p class="help-block">{l s='This text will be used on link on product page' mod='froggyquestiononproduct'}</p>
                </div>
            </div>

            <div class="form-group">
                <div class="col-lg-9 col-lg-offset-3"><input class="btn btn-default" type="submit" name="froggyquestiononproduct_config" value="{l s='Save' mod='froggyquestiononproduct'}" /></div>
            </div>

            <p><sup class="required">*</sup> {l s='Required fields' mod='froggyquestiononproduct'}</p>
        </form>
    </div>
</fieldset>
