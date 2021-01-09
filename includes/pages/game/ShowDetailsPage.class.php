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

class ShowDetailsPage extends AbstractGamePage
{
	public static $requireModule = MODULE_DETAILS;

	function __construct() 
	{
		parent::__construct();
	}

	public function UpdateDetails($Element)
	{
		global $PLANET, $USER, $reslist, $resource, $pricelist, $LNG, $BonusElement;
		
        $costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
			
		if ( !BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources)) {
			return;
		}
        
        $amount = HTTP::_GP('amount', 0);    
        $USER[$resource[$Element]]	+= $amount;
        
        $href = 'game.php?page=details'; 
        require_once('includes/subclasses/subclass.UpdateMaxAmount.php');
        require_once('includes/subclasses/subclass.UpdateResAmount.php');
        $bonus = 1;
        require_once('includes/subclasses/subclass.UpdateSqlBonusElementNole.php');
		require_once('includes/subclasses/subclass.UpdateSqlGeneral.php');
	}
	
	public function show()
	{
		global $USER, $PLANET, $resource, $reslist, $LNG, $pricelist, $requeriments;
		
		$updateID	  = HTTP::_GP('id', 0);
        $listDetails  = explode(',', Config::get()->details_cron);
		
		if (!empty($updateID) && $_SERVER['REQUEST_METHOD'] === 'POST' && $USER['urlaubs_modus'] == 0)
		{
			if(in_array($updateID, $listDetails)) {
				$this->UpdateDetails($updateID);
			}
		}
		
		$this->tplObj->loadscript('officier.js');	
        
		
		$detailsList	= array();
		
		if(isModuleAvailable(MODULE_DETAILS)) 
		{
			foreach($listDetails as $Element)
			{
                $bonusElementList   = BuildFunctions::bonusElementList($Element);
				$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
				$buyable			= BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources);
				$costOverflow		= BuildFunctions::getRestPrice($USER, $PLANET, $Element, $costResources);
				
				$detailsList[$Element]	= array(
                    'level'				=> $USER[$resource[$Element]],
                    'maxLevel'			=> $pricelist[$Element]['max'],
                    'factor'		    => $pricelist[$Element]['factor'],
					'costResources'	    => $costResources,
					'buyable'			=> $buyable,
					'costOverflow'		=> $costOverflow,
					'AllTech'			=> $bonusElementList,
				);
			}
		}
        
        $detailsOverview	= array();
		
		if(isModuleAvailable(MODULE_DETAILS))
		{
			foreach($reslist['details'] as $Element)
			{
				$elementBonus		= BuildFunctions::getAvalibleBonus($Element);
				
				$detailsOverview[$Element]	= array(
					'level'				=> $USER[$resource[$Element]],
                    'factor'		    => $pricelist[$Element]['factor'],
					'elementBonus'		=> $elementBonus,
				);
			}
		}
        
        $sql =  "SELECT nextTime FROM %%CRONJOBS%% WHERE cronjobID = :cronId;";
		$nextTime = Database::get()->selectSingle($sql, array(
			':cronId'			=> 9
		), 'nextTime');
        
        require_once 'includes/classes/Cronjob.class.php';
		
		$this->assign(array(	
			'detailsList'	    => $detailsList,
            'detailsOverview'	=> $detailsOverview,
            'nextStatUpdate' 	=> abs(TIMESTAMP - $nextTime),
            'stat_date'			=> _date($LNG['php_tdformat'], Cronjob::getLastExecutionTime('details'), $USER['timezone']),
		));
		
		$this->display('page.details.default.tpl');
	}
}
