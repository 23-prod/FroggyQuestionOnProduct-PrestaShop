<?php
/*
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
*/

// Security
defined('_PS_VERSION_') || require dirname(__FILE__).'/index.php';

// Include Froggy Library
if (!class_exists('FroggyModule', false)) require_once __DIR__.'/froggy/FroggyModule.php';

/**
 * Module Froggy Question On Product
 *
 * Version: 1.0.0
 */
class FroggyQuestionOnProduct extends FroggyModule
{
	/**
	 * @var array contains error form postProcess()
	 */
	protected $errors = array();

	/**
	 * Constructor
	 */
	public function __construct()
	{
		parent::__construct();

		$this->displayName = $this->l('Froggy Question On Product');
		$this->description = $this->l('Purpose to your customer to contact you about a product');
	}

	/**
	 * {@inheritdoc}
	 */
	public function getContent()
	{
		$this->context->controller->addCss($this->_path.'views/css/backend.css');

		$configurations = $this->getModuleConfigurations();

		// Call POST process
		$assign = array(
			'post_process' => array(
				'result' => $this->postProcess(),
				'errors' => $this->errors
			),
			'module_dir' => $this->_path
		);

		$this->smarty->assign($this->name, array_merge($configurations, $assign));
		return $this->display(__FILE__, 'getcontent.tpl');
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
		// If we want use a Fancybox
		if (Configuration::get('FG_QOP_ON_FANCY')) {
			$this->context->controller->addCSS(_PS_CSS_DIR_.'jquery.fancybox-1.3.4.css', 'screen');
			$this->context->controller->addCSS($this->_path.'views/css/frontend.css');
			$this->context->controller->addJqueryPlugin('fancybox');
		}
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
		// TODO Uncomment
		//if (!Configuration::get('FG_QOP_ON_FANCY')) {
			$this->context->smarty->assign(array(
				'tab_text' => Configuration::get('FG_QOP_TAB_TEXT', $this->context->language->id)
			));
			return $this->display(__FILE__, 'hookDisplayProductTab.tpl');
		//}
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
		// TODO Uncomment
		//if (!Configuration::get('FG_QOP_ON_FANCY')) {
		return $this->display(__FILE__, 'hookDisplayProductTabContent.tpl');
		//}
	}

	/**
	 * Hook Display Product Buttons
	 * Uses in order to show link that allow open fancybox
	 *
	 * @param $params
	 * @return string display for this hook
	 */
	public function hookDisplayProductButtons($params)
	{
		if (Configuration::get('FG_QOP_ON_FANCY')) {
			$this->context->smarty->assign(array(
				'link_text' => Configuration::get('FG_QOP_LINK_TEXT', $this->context->language->id),
				'path' => $this->_path
			));
			return $this->display(__FILE__, 'hookDisplayProductButtons.tpl');
		}
		return null;
	}

	/**
	 * Hook Action Admin Controller SetMedia
	 * Uses in order to add CSS file in backend
	 *
	 * @param $params
	 */
	public function hookActionAdminControllerSetMedia($params)
	{
		/*
		if (Tools::getValue('controller') == 'adminmodules' && Tools::getValue('configure') == $this->name)
			$this->context->controller->addCSS($this->_path.'views/css/backend.css', 'all');
		*/
	}

	/**
	 * Uses for treat data form getContent form
	 *
	 * @return bool, this method can return null, if form isn't send
	 */
	protected function postProcess()
	{
		// TODO
	}

	/**
	 * Return true if customer is logged
	 * @return bool
	 */
	protected function isCustomerLogged()
	{
		return (bool)$this->context->customer->id;
	}
}
