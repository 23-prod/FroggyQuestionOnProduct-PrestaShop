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

/*
 * Security
 */
defined('_PS_VERSION_') || require dirname(__FILE__).'/index.php';

/*
 * Include Froggy Library
 */
if (!class_exists('FroggyModule', false)) {
    require_once dirname(__FILE__).'/froggy/FroggyModule.php';
}

/**
 * Module Froggy Question On Product
 *
 * Version: 1.3.1
 */
class FroggyQuestionOnProduct extends FroggyModule
{
    /**
     * @var array contains error form postProcess()
     */
    protected $errors = array();

    /**
     * Constants definition
     */
    const SHOW_MODE_FANCY = 0;
    const SHOW_MODE_TAB = 1;
    const SHOW_MODE_PAGE = 2;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->name = 'froggyquestiononproduct';
        $this->author = 'Froggy Commerce';
        $this->version = '1.3.4';
        $this->tab = 'front_office_features';

        parent::__construct();

        $this->displayName = $this->l('Froggy Question On Product');
        $this->description = $this->l('Purpose to your customer to contact you about a product');
        $this->module_key = '0c2451a33253621fec31aa977dd20cc2';
    }

    /**
     * {@inheritdoc}
     */
    public function getContent()
    {
        $this->context->controller->addCss($this->_path.'views/css/backend.css');

        // Call POST process
        $assign = array(
            'post_process' => array(
                'result' => $this->postProcess(),
                'errors' => $this->errors
            ),
            'module_dir' => $this->_path
        );

        $configurations = $this->getModuleConfigurations();

        $this->smarty->assign(array(
            $this->name => array_merge($configurations, $assign),
            'contacts' => Contact::getContacts($this->context->language->id),
            'id_lang_default' => Configuration::get('PS_LANG_DEFAULT'),
            'languages' => Language::getLanguages(false),
            'divLangName' => 'link_text¤tab_text',
            'module' => $this
        ));

        return $this->fcdisplay(__FILE__, 'getcontent.tpl');
    }

    /**
     * Hook Display Header
     * Uses for adding javascript
     *
     * @param $params
     * @return string display for this hook
     */
    public function hookDisplayHeader($params)
    {
        $this->context->controller->addJS($this->_path.'views/js/common.js');
        $this->context->controller->addCSS($this->_path.'views/css/frontend.css');
    }

    /**
     * Hook Display Product Tab
     * Uses for adding product tab in product page
     *
     * @param $params
     * @return string display for this hook
     */
    public function hookDisplayProductTab($params)
    {
        if (Configuration::get('FC_QOP_ONLY_FOR_CUSTOMER') && !$this->isCustomerLogged()) {
            return;
        }

        if (version_compare(_PS_VERSION_, '1.6.0') >= 0) {
            return;
        }

        if ($this->isInTab()) {
            $this->smarty->assign($this->name, array(
                'tab_text' => Configuration::get('FC_QOP_TAB_TEXT', $this->context->language->id)
            ));
            return $this->fcdisplay(__FILE__, 'hookDisplayProductTab.tpl');
        }
    }

    /**
     * Hook Display Product Tab Content
     * Uses in order to fill product tab add by the hookDisplayProductTab
     *
     * @param $params
     * @return string display for this hook
     */
    public function hookDisplayProductTabContent($params)
    {
        if (Configuration::get('FC_QOP_ONLY_FOR_CUSTOMER') && !$this->isCustomerLogged()) {
            return;
        }

        if ($this->isInTab()) {
            $this->smarty->assign($this->name, array(
                'isLogged' => $this->isCustomerLogged(),
                'id_product' => Tools::getValue('id_product'),
                'product' => new Product(Tools::getValue('id_product'), false, $this->context->language->id),
                'tab_text' => Configuration::get('FC_QOP_TAB_TEXT', $this->context->language->id),
                'controller_href' => $this->getModuleLink('form').(version_compare(_PS_VERSION_, '1.5') >= 0 && Configuration::get('PS_REWRITING_SETTINGS') ? '?' : ''),
                'module_tpl_dir' => dirname(__FILE__).'/views/templates',
                'in_fancy' => $this->isInFancybox(),
            ));

            return $this->fcdisplay(__FILE__, 'hookDisplayProductTabContent.tpl');
        } elseif (version_compare(_PS_VERSION_, '1.6.0') >= 0 && $this->isInFancybox()) {
            $this->processProductButtons();
            return $this->fcdisplay(__FILE__, 'hookDisplayProductTabContent.tpl');
        }
    }

    /**
     * Hook DisplayLeftColumnProduct
     * Uses in order to show link that allow open fancybox
     *
     * @param $params
     * @return string display for this hook
     */
    public function hookDisplayLeftColumnProduct($params)
    {
        if (version_compare(_PS_VERSION_, '1.6.0') >= 0) {
            return;
        }

        return $this->processProductButtons();
    }

    /**
     * Hook DisplayProductButtons
     * Uses in order to show link that allow open fancybox
     *
     * @param $params
     * @return string display for this hook
     */
    public function hookDisplayProductButtons($params)
    {
        if (version_compare(_PS_VERSION_, '1.6.0') < 0) {
            return;
        }

        return $this->processProductButtons();
    }

    /**
     * Hook Action Admin Controller SetMedia
     * Uses in order to add CSS file in backend
     *
     * @param $params
     */
    public function hookActionAdminControllerSetMedia($params)
    {
        if (Tools::strtolower(Tools::getValue('controller')) == 'adminmodules' && Tools::getValue('configure') == $this->name) {
            $this->context->controller->addJs($this->_path.'views/js/backend.js');
        }
    }

    /**
     * Uses for treat data form getContent form
     *
     * @return bool, this method can return null, if form isn't send
     */
    protected function postProcess()
    {
        if (Tools::getIsset('froggyquestiononproduct_config')) {
            if (!Validate::isInt(Tools::getValue('FC_QOP_CONTACT_ID'))) {
                $this->errors[] = $this->l('Contact field is incorrect');
            }

            if (Tools::getValue('FC_QOP_SHOW_MODE') != self::SHOW_MODE_FANCY &&
                Tools::getValue('FC_QOP_SHOW_MODE') != self::SHOW_MODE_TAB &&
                Tools::getValue('FC_QOP_SHOW_MODE') != self::SHOW_MODE_PAGE) {
                $this->errors[] = $this->l('Show mode is incorrect');
            }

            $multilang_fields = array(
                'tab_text' => $this->l('Tab text is invalid'),
                'link_text' => $this->l('Link text is invalid')
            );
            $languages = Language::getLanguages(true);
            foreach ($multilang_fields as $field => $message) {
                $values = Tools::getValue($field);
                if (is_array($values)) {
                    foreach ($languages as $language) {
                        if (!isset($values[$language['id_lang']]) || !Validate::isCleanHtml($values[$language['id_lang']]) || $values[$language['id_lang']] == '') {
                            $this->errors[] = $message;
                        }
                    }
                } else {
                    $this->errors[] = $message;
                }
            }

            if (!count($this->errors)) {
                $multilang_fields = array(
                    'FC_QOP_TAB_TEXT' => 'tab_text',
                    'FC_QOP_LINK_TEXT' => 'link_text'
                );
                foreach ($this->getModuleConfigurationsKeys() as $configuration) {
                    if (isset($multilang_fields[$configuration])) {
                        Configuration::updateValue($configuration, Tools::getValue($multilang_fields[$configuration]));
                    } else {
                        Configuration::updateValue($configuration, Tools::getValue($configuration));
                    }
                }
                return true;
            } else {
                return false;
            }
        }
        return null;
    }

    /**
     * @return mixed
     */
    protected function processProductButtons()
    {
        if (Configuration::get('FC_QOP_ONLY_FOR_CUSTOMER') && !$this->isCustomerLogged()) {
            return;
        }

        if (!$this->isInTab()) {
            $this->smarty->assign($this->name, array(
                'link_text' => Configuration::get('FC_QOP_LINK_TEXT', $this->context->language->id),
                'controller_href' => $this->getModuleLink('form').(version_compare(_PS_VERSION_, '1.5') >= 0 && Configuration::get('PS_REWRITING_SETTINGS') ? '?' : ''),
                'module_path' => $this->_path,
                'isLogged' => $this->isCustomerLogged(),
                'id_product' => Tools::getValue('id_product'),
                'product' => new Product(Tools::getValue('id_product'), false, $this->context->language->id),
                'in_fancy' => $this->isInFancybox(),
                'module_tpl_dir' => dirname(__FILE__).'/views/templates'
            ));
            return $this->fcdisplay(__FILE__, 'hookDisplayProductButtons.tpl');
        }
        return null;
    }

    /**
     * @return bool
     */
    protected function isInFancybox()
    {
        return Configuration::get('FC_QOP_SHOW_MODE') == self::SHOW_MODE_FANCY;
    }

    /**
     * @return bool
     */
    protected function isInTab()
    {
        return Configuration::get('FC_QOP_SHOW_MODE') == self::SHOW_MODE_TAB;
    }

    /**
     * @return bool
     */
    protected function isInPage()
    {
        return Configuration::get('FC_QOP_SHOW_MODE') == self::SHOW_MODE_PAGE;
    }

    /**
     * Return true if customer is logged
     * @return bool
     */
    public function isCustomerLogged()
    {
        return (bool)$this->context->customer->id;
    }


    /**
     * Backward 1.4
     */
    public function hookBackOfficeHeader($params)
    {
        return '<script type="text/javascript" src="'.$this->_path.'views/js/backend.js"></script>';
    }

    public function hookHeader($params)
    {
        return $this->hookDisplayHeader($params);
    }

    public function hookExtraLeft($params)
    {
        return $this->hookDisplayLeftColumnProduct($params);
    }

    public function hookProductTab($params)
    {
        return $this->hookDisplayProductTab($params);
    }

    public function hookProductTabContent($params)
    {
        return $this->hookDisplayProductTabContent($params);
    }
}
