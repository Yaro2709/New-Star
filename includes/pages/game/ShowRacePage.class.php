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
	public static $requireModule = MODULE_OFFICIER;

	function __construct() 
	{
		parent::__construct();
	}

	public function UpdateRace($Element)
	{
		global $PLANET, $USER, $reslist, $resource, $pricelist, $LNG;
		
		$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
			
		if (!BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element) 
			|| !BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources) 
			|| $pricelist[$Element]['max'] <= $USER[$resource[$Element]]) {
			return;
		}
		
		if (($pricelist[$Element]['max']) < $USER[$resource[$Element]]){
			$this->printMessage("".$LNG['race_stop_choice']."", true, array('game.php?page=race', 2));
		}	
        
        foreach($reslist['resstype'][1] as $resPM)
		{
            if(isset($costResources[$resPM])) {
                if($PLANET[$resource[$resPM]] < $costResources[$resPM]){
                    $this->printMessage("".$LNG['race_stop_res']."", true, array('game.php?page=officier', 2));
                }
            }
        }
        
        foreach($reslist['resstype'][3] as $resUM)
		{
            if(isset($costResources[$resUM])) {
                if($USER[$resource[$resUM]] < $costResources[$resUM]){
                    $this->printMessage("".$LNG['race_stop_res']."", true, array('game.php?page=officier', 2));
                }
            }
        }
        
        foreach($reslist['resstype'][1] as $resP)
		{
            if(isset($costResources[$resP])) {$PLANET[$resource[$resP]]	-= $costResources[$resP]; }
        }
        
        foreach($reslist['resstype'][3] as $resU)
		{
            if(isset($costResources[$resU])) {$USER[$resource[$resU]]	-= $costResources[$resU]; }
        }
		
        foreach($reslist['race'] as $Elements)
		{ 
            $sql	= 'UPDATE %%USERS%% SET
            '.$resource[$Elements].' = 0
            WHERE
            id = :userId;';

            Database::get()->update($sql, array(
                ':userId'	=> $USER['id']
            ));
        }
        
        $sql	= 'UPDATE %%USERS%% SET
        race = '.$Element.',
        '.$resource[$Element].' = 1
		WHERE
		id = :userId;';

		Database::get()->update($sql, array(
			':userId'	=> $USER['id']
		));
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
		
		if(isModuleAvailable(MODULE_OFFICIER))
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
            'rac'               => $USER['race'],
		));
		
		$this->display('page.race.default.tpl');
	}
}