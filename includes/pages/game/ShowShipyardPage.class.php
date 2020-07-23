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
 
class ShowShipyardPage extends AbstractGamePage
{
	public static $requireModule = 0;
	
	public static $defaultController = 'show';

	function __construct() 
	{
		parent::__construct();
	}
	
	private function CancelAuftr() 
	{
		global $USER, $PLANET, $resource, $reslist; //$new_code
		$ElementQueue = unserialize($PLANET['b_hangar_id']);
		
		$CancelArray	= HTTP::_GP('auftr', array());
		
		if(!is_array($CancelArray))
		{
			return false;
		}	
		
		foreach ($CancelArray as $Auftr)
		{
			if(!isset($ElementQueue[$Auftr])) {
				continue;
			}
			
			if($Auftr == 0) {
				$PLANET['b_hangar']	= 0;
			}
			
			$Element		= $ElementQueue[$Auftr][0];
			$Count			= $ElementQueue[$Auftr][1];
			
			$costResources	= BuildFunctions::getElementPrice($USER, $PLANET, $Element, false, $Count);
            /*$old_code
			if(isset($costResources[901])) { $PLANET[$resource[901]]	+= $costResources[901] * FACTOR_CANCEL_SHIPYARD; }
			if(isset($costResources[902])) { $PLANET[$resource[902]]	+= $costResources[902] * FACTOR_CANCEL_SHIPYARD; }
			if(isset($costResources[903])) { $PLANET[$resource[903]]	+= $costResources[903] * FACTOR_CANCEL_SHIPYARD; }
			if(isset($costResources[921])) { $USER[$resource[921]]		+= $costResources[921] * FACTOR_CANCEL_SHIPYARD; }
            $old_code*/
            //$new_code
            $factor_prices = FACTOR_CANCEL_SHIPYARD;
            include('includes/subclasses/subclass.ResPlusFactor.php');
            //$new_code
			
			unset($ElementQueue[$Auftr]);
		}
		
		if(empty($ElementQueue)) {
			$PLANET['b_hangar_id']	= '';
		} else {
			$PLANET['b_hangar_id']	= serialize(array_values($ElementQueue));
		}

		return true;
	}
	
	private function BuildAuftr($fmenge)
	{
		global $USER, $PLANET, $reslist, $resource;
		/*$old_code
		$Missiles	= array(
			502	=> $PLANET[$resource[502]],
			503	=> $PLANET[$resource[503]],
		);
        $old_code*/
        //$new_code
        $Missiles	= array();
        
        foreach($reslist['missile'] as $elementID)
		{
            $Missiles	+= array(
                $elementID	=> $PLANET[$resource[$elementID]],
            );
		}
        //$new_code
		//$code_update
		$Domes	= array(
			407	=> $PLANET[$resource[407]],
			408	=> $PLANET[$resource[408]],
			409	=> $PLANET[$resource[409]],
		);
		
		$Orbits	= array(
			411	=> $PLANET[$resource[411]],
		);
		//$code_update
		foreach($fmenge as $Element => $Count)
		{
			if(empty($Count)
				|| !in_array($Element, array_merge($reslist['fleet'], $reslist['defense'], $reslist['missile']))
				|| !BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element)
			) {
				continue;
			}
			
			$MaxElements 	= BuildFunctions::getMaxConstructibleElements($USER, $PLANET, $Element);
			$Count			= is_numeric($Count) ? round($Count) : 0;
			$Count 			= max(min($Count, Config::get()->max_fleet_per_build), 0);
			$Count 			= min($Count, $MaxElements);
			
			$BuildArray    	= !empty($PLANET['b_hangar_id']) ? unserialize($PLANET['b_hangar_id']) : array();
			if (in_array($Element, $reslist['missile']))
			{
				$MaxMissiles		= BuildFunctions::getMaxConstructibleRockets($USER, $PLANET, $Missiles);
				$Count 				= min($Count, $MaxMissiles[$Element]);

				$Missiles[$Element] += $Count;
            //$code_update
			}elseif ($Element == 407 || $Element == 408 || $Element == 409){
				$MaxDomes		= BuildFunctions::getMaxConstructibleDomes($USER, $PLANET, $Domes);
				$Count 				= min($Count, $MaxDomes[$Element]);
                
				$Domes[$Element] += $Count;
			}elseif ($Element == 411){
				$MaxOrbits		= BuildFunctions::getMaxConstructibleOrbits($USER, $PLANET, $Orbits);
				$Count 				= min($Count, $MaxOrbits[$Element]);
				$Orbits[$Element] += $Count;
            //$code_update
			} elseif(in_array($Element, $reslist['one'])) {
				$InBuild	= false;
				foreach($BuildArray as $ElementArray) {
					if($ElementArray[0] == $Element) {
						$InBuild	= true;
						break;
					}
				}
				
				if ($InBuild)
					continue;

				if($Count != 0 && $PLANET[$resource[$Element]] == 0 && $InBuild === false)
					$Count =  1;
			}

			if(empty($Count))
				continue;
				
			$costResources	= BuildFunctions::getElementPrice($USER, $PLANET, $Element, false, $Count);
            /*$old_code
			if(isset($costResources[901])) { $PLANET[$resource[901]]	-= $costResources[901]; }
			if(isset($costResources[902])) { $PLANET[$resource[902]]	-= $costResources[902]; }
			if(isset($costResources[903])) { $PLANET[$resource[903]]	-= $costResources[903]; }
			if(isset($costResources[921])) { $USER[$resource[921]]		-= $costResources[921]; }
            $old_code*/
            //$new_code
            include('includes/subclasses/subclass.ResMinus.php');
            //$new_code
			$BuildArray[]			= array($Element, $Count);
			$PLANET['b_hangar_id']	= serialize($BuildArray);
		}
	}
	
	public function show()
	{
		global $USER, $PLANET, $LNG, $resource, $reslist, $requeriments;

		$buildTodo	= HTTP::_GP('fmenge', array());
		$action		= HTTP::_GP('action', '');
								
		$NotBuilding = true;
		if (!empty($PLANET['b_building_id']))
		{
			$CurrentQueue 	= unserialize($PLANET['b_building_id']);
			foreach($CurrentQueue as $ElementArray)
			{
                //$new_code
                foreach($reslist['shipyard'] as $elementID) //проверка всего масива элементов
                {
                    if($ElementArray[0] == $elementID) {
                        $NotBuilding = false;
                        break;
                    }
                }
                //$new_code
                /* $old_code
                if($ElementArray[0] == 21 || $ElementArray[0] == 15) {
					$NotBuilding = false;
					break;
				}
                $old_code*/   
			}
		}
		
		$ElementQueue 	= unserialize($PLANET['b_hangar_id']);
		if(empty($ElementQueue))
			$Count	= 0;
		else
			$Count	= count($ElementQueue);
			
		if($USER['urlaubs_modus'] == 0 && $NotBuilding == true)
		{
			if (!empty($buildTodo))
			{
				$maxBuildQueue	= Config::get()->max_elements_ships;
				if ($maxBuildQueue != 0 && $Count >= $maxBuildQueue)
				{
					$this->printMessage(sprintf($LNG['bd_max_builds'], $maxBuildQueue));
				}

				$this->BuildAuftr($buildTodo);
			}
					
			if ($action == "delete")
			{
				$this->CancelAuftr();
			}
		}
		
		$elementInQueue	= array();
		$ElementQueue 	= unserialize($PLANET['b_hangar_id']);
		$Buildlist		= array();
		//$elementList	= array();
        
		if(!empty($ElementQueue))
		{
			$Shipyard		= array();
			$QueueTime		= 0;
			foreach($ElementQueue as $Element)
			{
				if (empty($Element))
					continue;
					
				$elementInQueue[$Element[0]]	= true;
				$ElementTime  	= BuildFunctions::getBuildingTime($USER, $PLANET, $Element[0]);
				$QueueTime   	+= $ElementTime * $Element[1];
				$Shipyard[]		= array($LNG['tech'][$Element[0]], $Element[1], $ElementTime, $Element[0]);		
			}
			
			$Buildlist	= array(
				'Queue' 				=> $Shipyard,
				'b_hangar_id_plus' 		=> $PLANET['b_hangar'],
				'pretty_time_b_hangar' 	=> pretty_time(max($QueueTime - $PLANET['b_hangar'],0)),
			);
		}
		
		
		$mode		= HTTP::_GP('mode', 'fleet');

		if($mode == 'defense') {
			$elementIDs	= array_merge($reslist['defense'], $reslist['missile']);
		}elseif($mode == 'fleet') {
			$elementIDs	= $reslist['fleet'];
		}
		
		$Missiles	= array();
        //$code_update
		$Domes	= array();
		$Orbits	= array();
        //$code_update
		
		foreach($reslist['missile'] as $elementID)
		{
			$Missiles[$elementID]	= $PLANET[$resource[$elementID]];
		}
		//$code_update
		foreach($reslist['defense'] as $elementID)
		{
			$Domes[$elementID]	= $PLANET[$resource[$elementID]];
			$Orbits[$elementID]	= $PLANET[$resource[$elementID]];
		}
		//$code_update
		$MaxMissiles	= BuildFunctions::getMaxConstructibleRockets($USER, $PLANET, $Missiles);
        //$code_update
		$MaxDomes	= BuildFunctions::getMaxConstructibleDomes($USER, $PLANET, $Domes);
		$MaxOrbits	= BuildFunctions::getMaxConstructibleOrbits($USER, $PLANET, $Orbits);
        //$code_update
		foreach($elementIDs as $Element)
		{
            $techTreeList		= BuildFunctions::requirementsList($Element);
			$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
			$costOverflow		= BuildFunctions::getRestPrice($USER, $PLANET, $Element, $costResources);
			$elementTime    	= BuildFunctions::getBuildingTime($USER, $PLANET, $Element, $costResources);
			$buyable			= BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources);
			$maxBuildable		= BuildFunctions::getMaxConstructibleElements($USER, $PLANET, $Element, $costResources);

			if(isset($MaxMissiles[$Element])) {
				$maxBuildable	= min($maxBuildable, $MaxMissiles[$Element]);
			}
			//$code_update
			if(isset($MaxDomes[$Element])) {
				$maxBuildable	= min($maxBuildable, $MaxDomes[$Element]);
			}
			
			if(isset($MaxOrbits[$Element])) {
				$maxBuildable	= min($maxBuildable, $MaxOrbits[$Element]);
			}
			//$code_update
			$AlreadyBuild		= in_array($Element, $reslist['one']) && (isset($elementInQueue[$Element]) || $PLANET[$resource[$Element]] != 0);
			
			$elementList[$Element]	= array(
				'id'				=> $Element,
				'available'			=> $PLANET[$resource[$Element]],
				'costResources'	    => $costResources,
				'costOverflow'		=> $costOverflow,
				'elementTime'    	=> $elementTime,
                'perSec'			=> floor(1/$elementTime),
				'buyable'			=> $buyable,
				'maxBuildable'		=> floattostring($maxBuildable),
				'AlreadyBuild'		=> $AlreadyBuild,
				'AllTech'			=> $techTreeList,
				'techacc' 			=> BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element),
				
			);
		}
		
		$this->tplObj->loadscript('shipyard.js');
		$this->assign(array(
            'fleet1'		=> $reslist['spec_fleet'][1],
            'fleet2'		=> $reslist['spec_fleet'][2],
            'fleet3'		=> $reslist['spec_fleet'][3],
            'fleet4'		=> $reslist['spec_fleet'][4],
            'defense1'		=> $reslist['spec_defense'][1],
            'defense2'		=> $reslist['spec_defense'][2],
            'defense3'		=> $reslist['spec_defense'][3],
            'defense4'		=> $reslist['spec_defense'][4],
			'elementList'	=> $elementList,
			'NotBuilding'	=> $NotBuilding,
			'BuildList'		=> $Buildlist,
			'maxlength'		=> strlen(Config::get()->max_fleet_per_build),
			'mode'			=> $mode,
            'max'		    => Config::get()->max_fleet_per_build,
		));

		$this->display('page.shipyard.default.tpl');
	}
}