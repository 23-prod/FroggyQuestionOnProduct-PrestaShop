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

class FroggyQuestionOnProductFormModuleFrontController extends ModuleFrontController
{

    protected $assign = array();

    public function __construct()
    {
        parent::__construct();

        $this->context = Context::getContext();
    }

    public function postProcess()
    {
        if (Configuration::get('FC_QOP_ONLY_FOR_CUSTOMER') && !$this->module->isCustomerLogged()) {
            $this->errors[] = Tools::displayError('Please login, in order to send a question about a product');
        } else {

            if (Tools::isSubmit('submitQuestion')) {
                if (Validate::isInt(Tools::getValue('id_product'))) {
                    $product = new Product(Tools::getValue('id_product'));
                    if (!Validate::isLoadedObject($product)) {
                        $this->errors[] = $this->module->l('Product ID is incorrect');
                    }
                } else {
                    $this->errors[] = $this->module->l('Product ID is incorrect');
                }

                if (!$this->module->isCustomerLogged() && !Validate::isEmail(Tools::getValue('email'))) {
                    $this->errors[] = $this->module->l('Your email is invalid');
                }

                if (!Validate::isCleanHtml(Tools::getValue('message')) || !Tools::getValue('message')) {
                    $this->errors[] = $this->module->l('Message field is invalid');
                }

                if (!count($this->errors)) {
                    // Create Customer Thread
                    $ct = new CustomerThread();
                    if (isset($this->context->customer->id) && $this->context->customer->id) {
                        $ct->id_customer = $this->context->customer->id;
                    }
                    $ct->id_shop = (int)$this->context->shop->id;
                    $ct->id_product = Tools::getValue('id_product');
                    $ct->id_contact = Configuration::get('FC_QOP_CONTACT_ID');
                    $ct->id_lang = (int)$this->context->language->id;
                    if ($this->module->isCustomerLogged()) {
                        $ct->email = $this->context->customer->email;
                    } else {
                        $ct->email = Tools::getValue('email');
                    }
                    $ct->status = 'open';
                    $ct->token = Tools::passwdGen(12);

                    if ($ct->add()) {
                        // Prepare message
                        $message = $this->module->l('A customer have a question about a product...');
                        $message .= "\n\n".'---'."\n\n";
                        $message .= Tools::htmlentitiesUTF8(Tools::getValue('message'));

                        $cm = new CustomerMessage();
                        $cm->id_customer_thread = $ct->id;
                        $cm->message = $message;
                        $cm->ip_address = ip2long($_SERVER['REMOTE_ADDR']);
                        $cm->user_agent = $_SERVER['HTTP_USER_AGENT'];

                        if ($cm->add()) {
                            $this->assign = array('success' => true);

                            $customer_id_lang = $this->context->language->id;
                            $this->context->language->id = Configuration::get('PS_LANG_DEFAULT');

                            if (version_compare(_PS_VERSION_, '1.5.0') >= 0) {
                                $product_link = $this->context->link->getProductLink($product, null, null, null, Configuration::get('PS_LANG_DEFAULT'), (int)$this->context->shop->id);
                            } else {
                                $product_link = $this->context->link->getProductLink($product, null, null, null, Configuration::get('PS_LANG_DEFAULT'));
                            }

                            Mail::Send(Configuration::get('PS_LANG_DEFAULT'), 'new-question', $this->module->l('A new question about a product has been asked to you').': '.$product->name[Configuration::get('PS_LANG_DEFAULT')], array(
                                    '{product_id}' => $product->id,
                                    '{product_name}' => $product->name[Configuration::get('PS_LANG_DEFAULT')],
                                    '{product_link}' => $product_link,
                                    '{from_email}' => $ct->email,
                                    '{question}' => Tools::htmlentitiesUTF8(Tools::getValue('message'))
                                ), Configuration::get('PS_SHOP_EMAIL'), null, $ct->email, null, null, null, _PS_MODULE_DIR_.'/'.$this->module->name.'/mails/', false, (int)$this->context->shop->id);

                            $this->context->language->id = $customer_id_lang;
                        } else {
                            $this->errors[] = Tools::displayError('An error occurred while sending the message.');
                        }
                    } else {
                        $this->errors[] = Tools::displayError('An error occurred while sending the message.');
                    }
                }

                if (Tools::getIsset('ajax')) {
                    echo Tools::jsonEncode(array(
                        'has_errors' => (bool)count($this->errors),
                        'errors' => $this->errors
                    ));
                    exit;
                }
            }
        }

        parent::postProcess();
    }

    public function initContent()
    {
        parent::initContent();

        $product = new Product(Tools::getValue('id_product'), false, $this->context->language->id);
        $image = Product::getCover($product->id);
        $product->id_image = $image['id_image'];
        $this->assign = array_merge($this->assign, array(
            'in_page' => true,
            'isLogged' => $this->module->isCustomerLogged(),
            'id_product' => Tools::getValue('id_product'),
            'product' => $product,
            'controller_href' => $this->module->getModuleLink('form').(version_compare(_PS_VERSION_, '1.5') >= 0 && Configuration::get('PS_REWRITING_SETTINGS') ? '?' : ''),
            'image_format' => (version_compare(_PS_VERSION_, '1.5') < 0 ? ''.'ho'.'me'.'' : 'home'.'_'.'default'),
            'module_tpl_dir' => dirname(__FILE__).'/../../views/templates'
        ));
        $this->context->smarty->assign($this->module->name, $this->assign);

        if (version_compare(_PS_VERSION_, '1.6.0') >= 0) {
            return $this->setTemplate('form.bootstrap.tpl');
        } else {
            return $this->setTemplate('form.tpl');
        }
    }
}
