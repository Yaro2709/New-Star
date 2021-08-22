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

class ShowRacePage extends AbstractGamePage
{
	public static $requireModule = MODULE_RACE;

	function __construct() 
	{
		parent::__construct();
	}

	public function UpdateRace($Element)
	{
		global $PLANET, $USER, $reslist, $resource, $pricelist, $LNG;
		
		$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
			
		if (!BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element, array())
			|| !BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources) 
			|| $pricelist[$Element]['max'] <= $USER[$resource[$Element]]) {
			return;
		}
        
        $amount = 1;
        $USER[$resource[$Element]]	+= $amount;
		
        $href = 'game.php?page=race'; 
        require_once('includes/subclasses/subclass.UpdateMaxLvl.php');
        require_once('includes/subclasses/subclass.UpdateResAmount.php');
        $mode = 'race';
        require_once('includes/subclasses/subclass.UpdateSqlСhoice.php');
        
		$this->printMessage(''.$LNG['race_yes'].'', true, array("?page=race", 2));	
	}
	
	public function show()
	{
		global $USER, $PLANET, $resource, $reslist, $LNG, $pricelist;
		
		$updateID	  = HTTP::_GP('id', 0);
		
		if (!empty($updateID) && $_SERVER['REQUEST_METHOD'] === 'POST' && $USER['urlaubs_modus'] == 0)
		{
			if(in_array($updateID, $reslist['race'])) {
				$this->UpdateRace($updateID);
			}
		}
		
		$this->tplObj->loadscript('officier.js');		
		
		$RaceList	= array();
		
		if(isModuleAvailable(MODULE_RACE))
		{
			foreach($reslist['race'] as $Element)
			{
                
				$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
				$buyable			= BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources);
				$costOverflow		= BuildFunctions::getRestPrice($USER, $PLANET, $Element, $costResources);
				$elementBonus		= BuildFunctions::getAvalibleBonus($Element);
				
				$RaceList[$Element]	= array(
					'level'				=> $USER[$resource[$Element]],
					'maxLevel'			=> $pricelist[$Element]['max'],
					'costResources'	    => $costResources,
					'buyable'			=> $buyable,
					'costOverflow'		=> $costOverflow,
					'elementBonus'		=> $elementBonus,
				);
			}
		}
		
		$this->assign(array(	
			'RaceList'		    => $RaceList,
            'name'              => $USER['race'],
		));
		
		$this->display('page.race.default.tpl');
	}
}