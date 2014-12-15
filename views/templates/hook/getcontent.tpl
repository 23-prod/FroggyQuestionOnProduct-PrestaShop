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

<script type="text/javascript">id_language = Number({$id_lang_default});</script>
<fieldset>
	<legend><img src="{$froggyquestiononproduct.module_dir}logo.png" alt="" width="16" />{l s='Froggy Question on Product' mod='froggyquestiononproduct'}</legend>

	{if $froggyquestiononproduct.post_process.result === true}
		<div class="conf">
			{l s='Configurations saved with success !' mod='froggyquestiononproduct'}
		</div>
	{elseif $froggyquestiononproduct.post_process.result === false}
		<div class="error">
			<ul>
				{foreach from=$froggyquestiononproduct.post_process.errors item=error}
					<li>{$error}</li>
				{/foreach}
			</ul>
		</div>
	{/if}

	<form action="{$smarty.server.REQUEST_URI|escape:'htmlall':'UTF-8'}" method="post">
		<h3>{l s='General' mod='froggyquestiononproduct'}</h3>

		<label>{l s='Only for registered customer' mod='froggyquestiononproduct'} <sup class="required">*</sup></label>
		<div class="margin-form">
			<img src="../img/admin/enabled.gif" alt="" />
			<input type="radio" name="FC_QOP_ONLY_FOR_CUSTOMER" value="1" {if (isset($smarty.post.FC_QOP_ONLY_FOR_CUSTOMER) && $smarty.post.FC_QOP_ONLY_FOR_CUSTOMER == 1) || (!isset($smarty.post.FC_QOP_ONLY_FOR_CUSTOMER) && $froggyquestiononproduct.FC_QOP_ONLY_FOR_CUSTOMER)}checked="checked"{/if} />
			<label class="t">{l s='Yes' mod='froggyquestiononproduct'}</label>

			<img src="../img/admin/disabled.gif" alt="" />
			<input type="radio" name="FC_QOP_ONLY_FOR_CUSTOMER" value="0" {if (isset($smarty.post.FC_QOP_ONLY_FOR_CUSTOMER) && $smarty.post.FC_QOP_ONLY_FOR_CUSTOMER == 0) || (!isset($smarty.post.FC_QOP_ONLY_FOR_CUSTOMER) && !$froggyquestiononproduct.FC_QOP_ONLY_FOR_CUSTOMER)}checked="checked"{/if} />
			<label class="t">{l s='No' mod='froggyquestiononproduct'}</label>
			<p class="preference_description">{l s='If active, only logged users see the question form on product page' mod='froggyquestiononproduct'}</p>
		</div>

		<label>{l s='Send to contact' mod='froggyquestiononproduct'} <sup class="required">*</sup></label>
		<div class="margin-form">
			<select name="FC_QOP_CONTACT_ID">
				{foreach from=$contacts item=contact}
					<option value="{$contact.id_contact}" {if $froggyquestiononproduct.FC_QOP_CONTACT_ID == $contact.id_contact}selected="selected"{/if}>
						{$contact.name|escape:'htmlall':'UTF-8'} - {$contact.email|escape:'htmlall':'UTF-8'}
					</option>
				{/foreach}
			</select>
			<p class="preference_description">{l s='The recipient of question' mod='froggyquestiononproduct'}</p>
		</div>

		<h3>{l s='Show mode' mod='froggyquestiononproduct'}</h3>

		<label>{l s='Show mode' mod='froggyquestiononproduct'} <sup class="required">*</sup></label>
		<div class="margin-form">
			<select name="FC_QOP_SHOW_MODE" id="show-mode">
				<option value="0" {if (isset($smarty.post.FC_QOP_SHOW_MODE) && $smarty.post.FC_QOP_SHOW_MODE == '0') || (!isset($smarty.post.FC_QOP_SHOW_MODE) && $froggyquestiononproduct.FC_QOP_SHOW_MODE == '0')}selected="selected"{/if} data-text="link_text">{l s='In a pop-in' mod='froggyquestiononproduct'}</option>
				<option value="1" {if (isset($smarty.post.FC_QOP_SHOW_MODE) && $smarty.post.FC_QOP_SHOW_MODE == '1') || (!isset($smarty.post.FC_QOP_SHOW_MODE) && $froggyquestiononproduct.FC_QOP_SHOW_MODE == '1')}selected="selected"{/if} data-text="tab_text">{l s='In a product tab' mod='froggyquestiononproduct'}</option>
				<option value="2" {if (isset($smarty.post.FC_QOP_SHOW_MODE) && $smarty.post.FC_QOP_SHOW_MODE == '2') || (!isset($smarty.post.FC_QOP_SHOW_MODE) && $froggyquestiononproduct.FC_QOP_SHOW_MODE == '2')}selected="selected"{/if} data-text="link_text">{l s='In a page' mod='froggyquestiononproduct'}</option>
			</select>
		</div>
		<div class="clear"></div>

		<h3>{l s='Configure text' mod='froggyquestiononproduct'}</h3>

		<div id="tab_text-fields" class="text-fields">
			<label>{l s='Tab text' mod='froggyquestiononproduct'}</label>
			<div class="margin-form">
				{foreach from=$languages item=language}
					<div id="tab_text_{$language['id_lang']}" style="display: {if $language['id_lang'] == $id_lang_default}block{else}none{/if};float: left;">
						<input type="text" name="tab_text[{$language['id_lang']}]" id="tab_text_{$language['id_lang']}" size="50" value="{if isset($smarty.post.tab_text.{$language['id_lang']})}{$smarty.post.tab_text.{$language['id_lang']}|escape:'htmlall':'UTF-8'}{else}{$froggyquestiononproduct.FC_QOP_TAB_TEXT.{$language['id_lang']}}{/if}" />
					</div>
				{/foreach}
				{$module->displayFlags($languages, $id_lang_default, $divLangName, 'tab_text', true)}
				<div class="clear"></div>
				<p class="preference_description">{l s='This text will be used on tab on product page' mod='froggyquestiononproduct'}</p>
			</div>
		</div>

		<div id="link_text-fields" class="text-fields">
			<label>{l s='Link text' mod='froggyquestiononproduct'}</label>
			<div class="margin-form">
				{foreach from=$languages item=language}
					<div id="link_text_{$language['id_lang']}" style="display: {if $language['id_lang'] == $id_lang_default}block{else}none{/if};float: left;">
						<input type="text" name="link_text[{$language['id_lang']}]" id="link_text_{$language['id_lang']}" size="50" value="{if isset($smarty.post.link_text.{$language['id_lang']})}{$smarty.post.link_text.{$language['id_lang']}|escape:'htmlall':'UTF-8'}{else}{$froggyquestiononproduct.FC_QOP_LINK_TEXT.{$language['id_lang']}}{/if}" />
					</div>
				{/foreach}
				{$module->displayFlags($languages, $id_lang_default, $divLangName, 'link_text', true)}
				<div class="clear"></div>
				<p class="preference_description">{l s='This text will be used on link on product page' mod='froggyquestiononproduct'}</p>
			</div>
		</div>

		<hr />

		<div class="center">
			<input class="button" type="submit" name="froggyquestiononproduct_config" value="{l s='Save' mod='froggyquestiononproduct'}" />
		</div>

		<p><sup class="required">*</sup> {l s='Required fields' mod='froggyquestiononproduct'}</p>
	</form>
</fieldset>
