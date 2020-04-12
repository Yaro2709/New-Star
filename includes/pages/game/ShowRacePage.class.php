<?php

/*
 * ╔╗╔╗╔╗╔══╗╔═══╗──╔══╗╔═══╗╔══╗╔══╗╔═══╗
 * ║║║║║║║╔╗║║╔═╗║──║╔═╝║╔═╗║║╔╗║║╔═╝║╔══╝
 * ║║║║║║║╚╝║║╚═╝║──║╚═╗║╚═╝║║╚╝║║║──║╚══╗
 * ║║║║║║║╔╗║║╔╗╔╝──╚═╗║║╔══╝║╔╗║║║──║╔══╝
 * ║╚╝╚╝║║║║║║║║║───╔═╝║║║───║║║║║╚═╗║╚══╗
 * ╚═╝╚═╝╚╝╚╝╚╝╚╝───╚══╝╚╝───╚╝╚╝╚══╝╚═══╝
 *
 * @author Tsvira Yaroslav <tsvira.yaroslav@mail.ru @@ yaros575@gmail.com>
 * @version 1.0.0 (01.01.2020)
 * @info ***
 * @link https://github.com/Yaro2709
 */

class ShowRacePage extends AbstractGamePage
{
	public static $requireModule = 0;

	function __construct() 
	{
		parent::__construct();
	}
	
	public function UpdateExtra($Element)
	{
		global $PLANET, $USER, $resource, $pricelist, $reslist;
		
		$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
			
		if (!BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources)) {
			return;
		}
			
		$USER[$resource[$Element]]	= max($USER[$resource[$Element]], TIMESTAMP) + $pricelist[$Element]['time'];
			
        $GetEvent       = mt_rand(701,706);
		$USER['Event']  = 0;
        $USER['Event']  = $GetEvent;
        require_once('includes/subclasses/subclass.ResMinus.php');
	}
	
	public function show()
	{
		global $USER, $PLANET, $resource, $reslist, $LNG, $pricelist;
		
		$updateID	  = HTTP::_GP('id', 0);
				
		if (!empty($updateID) && $_SERVER['REQUEST_METHOD'] === 'POST' && $USER['urlaubs_modus'] == 0)
		{
            if(isModuleAvailable(MODULE_DMEXTRAS) && in_array($updateID, array($USER['Event']))) {
				$this->UpdateExtra($updateID);
			}
		}
		
		$darkmatterList	= array();
		
		if(isModuleAvailable(MODULE_DMEXTRAS))
		{
			foreach(array($USER['Event']) as $Element)
			{
				if($USER[$resource[$Element]] > TIMESTAMP) {
					$this->tplObj->execscript("GetOfficerTime(".$Element.", ".($USER[$resource[$Element]] - TIMESTAMP).");");
				}
			
				$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
				$buyable			= BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources);
				$costOverflow		= BuildFunctions::getRestPrice($USER, $PLANET, $Element, $costResources);
				$elementBonus		= BuildFunctions::getAvalibleBonus($Element);

				$darkmatterList[$Element]	= array(
					'timeLeft'			=> max($USER[$resource[$Element]] - TIMESTAMP, 0),
					'costResources'		=> $costResources,
					'buyable'			=> $buyable,
					'time'				=> $pricelist[$Element]['time'],
					'costOverflow'		=> $costOverflow,
					'elementBonus'		=> $elementBonus,
				);
			}
		}
		
		$this->assign(array(
			'darkmatterList'	=> $darkmatterList,
            'of_dm_trade'		=> sprintf($LNG['of_dm_trade'], $LNG['tech'][921]),
		));
		
		$this->display('page.race.default.tpl');
	}
}