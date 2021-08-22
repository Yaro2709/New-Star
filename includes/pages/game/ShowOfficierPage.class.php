<?php

/*
 * ╔══╗╔══╗╔╗──╔╗╔═══╗╔══╗╔╗─╔╗╔╗╔╗──╔╗╔══╗╔══╗╔══╗
 * ║╔═╝║╔╗║║║──║║║╔═╗║║╔╗║║╚═╝║║║║║─╔╝║╚═╗║║╔═╝╚═╗║
 * ║║──║║║║║╚╗╔╝║║╚═╝║║╚╝║║╔╗─║║╚╝║─╚╗║╔═╝║║╚═╗──║║
 * ║║──║║║║║╔╗╔╗║║╔══╝║╔╗║║║╚╗║╚═╗║──║║╚═╗║║╔╗║──║║
 * ║╚═╗║╚╝║║║╚╝║║║║───║║║║║║─║║─╔╝║──║║╔═╝║║╚╝║──║║
 * ╚══╝╚══╝╚╝──╚╝╚╝───╚╝╚╝╚╝─╚╝─╚═╝──╚╝╚══╝╚══╝──╚╝
 *
 * @author Tsvira Yaroslav <https://github.com/Yaro2709>
 * @info ***
 * @link https://github.com/Yaro2709/New-Star
 * @Basis 2Moons: XG-Project v2.8.0
 * @Basis New-Star: 2Moons v1.8.0
 */

class ShowOfficierPage extends AbstractGamePage
{
	public static $requireModule = MODULE_OFFICIER;

	function __construct() 
	{
		parent::__construct();
	}

	public function UpdateOfficier($Element)
	{
		global $PLANET, $USER, $reslist, $resource, $pricelist, $LNG;
		
		$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
			
		if (!BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element, array()) 
			|| !BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources) 
			|| $pricelist[$Element]['max'] <= $USER[$resource[$Element]]) {
			return;
		}
        
        $amount = HTTP::_GP('amount', 0);
		$USER[$resource[$Element]]	+= $amount;
        
        $href = 'game.php?page=officier'; 
        require_once('includes/subclasses/subclass.UpdateMaxLvl.php');
        require_once('includes/subclasses/subclass.UpdateMaxAmount.php');
        require_once('includes/subclasses/subclass.UpdateResAmount.php');
        require_once('includes/subclasses/subclass.UpdateSqlGeneral.php');
	}
	
	public function show()
	{
		global $USER, $PLANET, $resource, $reslist, $LNG, $pricelist, $requeriments;
		
		$updateID	  = HTTP::_GP('id', 0);
		
		if (!empty($updateID) && $_SERVER['REQUEST_METHOD'] === 'POST' && $USER['urlaubs_modus'] == 0)
		{
			if(in_array($updateID, $reslist['officier'])) {
				$this->UpdateOfficier($updateID);
			}
		}
		
		$this->tplObj->loadscript('officier.js');		
		
		$officierList	= array();
		
		if(isModuleAvailable(MODULE_OFFICIER))
		{
			foreach($reslist['officier'] as $Element)
			{
                $techTreeList		= BuildFunctions::requirementsList($USER, $PLANET, $Element);
				$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
				$buyable			= BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources);
				$costOverflow		= BuildFunctions::getRestPrice($USER, $PLANET, $Element, $costResources);
				$elementBonus		= BuildFunctions::getAvalibleBonus($Element);
				
				$officierList[$Element]	= array(
					'level'				=> $USER[$resource[$Element]],
					'maxLevel'			=> $pricelist[$Element]['max'],
                    'factor'		    => $pricelist[$Element]['factor'],
					'costResources'	    => $costResources,
					'buyable'			=> $buyable,
					'costOverflow'		=> $costOverflow,
					'elementBonus'		=> $elementBonus,
					'AllTech'			=> $techTreeList,
					'techacc'			=> BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element, array()),
				);
			}
		}
		
		$this->assign(array(	
			'officierList'		=> $officierList,
		));
		
		$this->display('page.officier.default.tpl');
	}
}