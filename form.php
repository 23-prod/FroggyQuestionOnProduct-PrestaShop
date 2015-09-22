<?php
/**
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
 * @author    Froggy Commerce <contact@froggy-commerce.com>
 * @copyright 2013-2015 Froggy Commerce
 * @license   Unauthorized copying of this file, via any medium is strictly prohibited
 */

$useSSL = false;

require_once(dirname(__FILE__).'/../../config/config.inc.php');
require_once(dirname(__FILE__).'/../../init.php');
require_once(dirname(__FILE__).'/froggyquestiononproduct.php');
require_once(dirname(__FILE__).'/froggy/FroggyContext.php');

if (!Tools::getIsset('ajax')) {
    require_once(dirname(__FILE__).'/../../header.php');
}

$context = FroggyContext::getContext();
$module = new FroggyQuestionOnProduct();
$errors = $assign = array();

if (Configuration::get('FC_QOP_ONLY_FOR_CUSTOMER') && !$module->isCustomerLogged()) {
    $errors[] = Tools::displayError('Please login, in order to send a question about a product');
} else {
    if (Tools::isSubmit('submitQuestion')) {
        if (Validate::isInt(Tools::getValue('id_product'))) {
            $product = new Product(Tools::getValue('id_product'));
            if (!Validate::isLoadedObject($product)) {
                $errors[] = $module->l('Product ID is incorrect');
            }
        } else {
            $errors[] = $module->l('Product ID is incorrect');
        }

        if (!$module->isCustomerLogged() && !Validate::isEmail(Tools::getValue('email'))) {
            $errors[] = $module->l('Your email is invalid');
        }

        if (!Validate::isCleanHtml(Tools::getValue('message')) || !Tools::getValue('message')) {
            $errors[] = $module->l('Message field is invalid');
        }

        if (!count($errors)) {
            /*
             * Create Customer Thread
             */
            $ct = new CustomerThread();
            if (isset($context->customer->id) && $context->customer->id) {
                $ct->id_customer = $context->customer->id;
            }
            $ct->id_shop = (int)$context->shop->id;
            $ct->id_product = Tools::getValue('id_product');
            $ct->id_contact = Configuration::get('FC_QOP_CONTACT_ID');
            $ct->id_lang = (int)$context->language->id;
            if ($module->isCustomerLogged()) {
                $ct->email = $context->customer->email;
            } else {
                $ct->email = Tools::getValue('email');
            }

            $ct->status = 'open';
            $ct->token = Tools::passwdGen(12);
            if ($ct->add()) {
                /*
                 * Prepare message
                 */
                $message = $module->l('A customer have a question about one product...');
                $message .= "\n\n".'---'."\n\n";
                $message .= Tools::htmlentitiesUTF8(Tools::getValue('message'));

                $cm = new CustomerMessage();
                $cm->id_customer_thread = $ct->id;
                $cm->message = $message;
                $cm->ip_address = ip2long($_SERVER['REMOTE_ADDR']);
                $cm->user_agent = $_SERVER['HTTP_USER_AGENT'];
                if ($cm->add()) {
                    $assign = array('success' => true);

                    $customer_id_lang = $context->language->id;
                    $context->language->id = Configuration::get('PS_LANG_DEFAULT');

                    Mail::Send(Configuration::get('PS_LANG_DEFAULT'), 'new-question', $module->l('A new question about a product has been asked to you'), array(
                        '{product_id}' => $product->id,
                        '{product_name}' => $product->name[Configuration::get('PS_LANG_DEFAULT')],
                        '{product_link}' => $context->link->getProductLink($product, null, null, null, Configuration::get('PS_LANG_DEFAULT')),
                        '{from_email}' => $ct->email,
                        '{question}' => Tools::htmlentitiesUTF8(Tools::getValue('message'))
                    ), Configuration::get('PS_SHOP_EMAIL'), null, $ct->email, null, null, null, _PS_MODULE_DIR_.'/'.$module->name.'/mails/', false);

                    $context->language->id = $customer_id_lang;
                } else {
                    $errors[] = Tools::displayError('An error occurred while sending the message.');
                }
            } else {
                $errors[] = Tools::displayError('An error occurred while sending the message.');
            }
        }

        if (Tools::getIsset('ajax')) {
            echo Tools::jsonEncode(array(
                'has_errors' => (bool)count($errors),
                'errors' => $errors
            ));
            exit;
        }
    }
}

$product = new Product(Tools::getValue('id_product'), false, $context->language->id);
$image = Product::getCover($product->id);
$product->id_image = $image['id_image'];
$assign = array_merge($assign, array(
    'in_page' => true,
    'isLogged' => $module->isCustomerLogged(),
    'id_product' => Tools::getValue('id_product'),
    'product' => $product,
    'controller_href' => $module->getModuleLink('form'),
    'errors' => $errors,
    'image_format' => (version_compare(_PS_VERSION_, '1.5') < 0 ? ''.'ho'.'me'.'' : 'home'.'_'.'default'),
    'module_tpl_dir' => dirname(__FILE__).'/views/templates'
));

$context->smarty->assign($module->name, $assign);

$context->smarty->display(dirname(__FILE__).'/views/templates/front/form.tpl');

if (!Tools::getIsset('ajax')) {
    require_once(dirname(__FILE__).'/../../footer.php');
}
