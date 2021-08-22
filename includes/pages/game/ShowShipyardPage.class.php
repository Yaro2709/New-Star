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
		global $USER, $PLANET, $resource, $reslist;
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
            $factor_prices = FACTOR_CANCEL_SHIPYARD;
            include('includes/subclasses/subclass.ResPlusFactor.php');
			
			unset($ElementQueue[$Auftr]);
		}
		
		if(empty($ElementQueue)) {
			$PLANET['b_hangar_id']	= '';
		} else {
			$PLANET['b_hangar_id']	= serialize(array_values($ElementQueue));
		}

		return true;
	}  
    
    private function getShipData()
	{
		global $LNG, $PLANET, $USER, $pricelist;
		
		$scriptData		= array();
		$quickinfo		= array();
		
		if ($PLANET['b_hangar_id'] == "")
			return array('queue' => $scriptData, 'quickinfo' => $quickinfo);
		
		$buildQueue		= unserialize($PLANET['b_hangar_id']);
		
		foreach($buildQueue as $BuildArray) {
			$ElementTime  	= BuildFunctions::getBuildingTime($USER, $PLANET, $BuildArray[0]);
			$QueueTime   	= $ElementTime * $BuildArray[1];
			
			$quickinfo[$BuildArray[0]]	= $BuildArray[1];
			
			$scriptData[] = array(
				'element'	=> $BuildArray[0], 
				'amount'	=> $BuildArray[1], 
				'timeque'	=> max($QueueTime - $PLANET['b_hangar'],0),
				
			);
		}
		
		return array('queue' => $scriptData, 'quickinfo' => $quickinfo);
	}
	
	private function BuildAuftr($fmenge)
	{
		global $USER, $PLANET, $reslist, $resource;

        $Missiles = array();
        foreach($reslist['missile'] as $elementID)
		{
            $Missiles	+= array(
                $elementID	=> $PLANET[$resource[$elementID]],
            );
		}

        $Domes = array();
        foreach($reslist['domes'] as $elementID)
		{
            $Domes	+= array(
                $elementID	=> $PLANET[$resource[$elementID]],
            );
		}
        
        $Orbits = array();
        foreach($reslist['orbital_bases'] as $elementID)
		{
            $Orbits	+= array(
                $elementID	=> $PLANET[$resource[$elementID]],
            );
		}

		foreach($fmenge as $Element => $Count)
		{
			if(empty($Count)
				|| !in_array($Element, array_merge($reslist['fleet'], $reslist['defense'], $reslist['missile']))
				|| !BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element, array())
			) {
				continue;
			}
			
			$MaxElements 	= BuildFunctions::getMaxConstructibleElements($USER, $PLANET, $Element);
			$Count			= is_numeric($Count) ? round($Count) : 0;
			$Count 			= max(min($Count, Config::get()->max_fleet_per_build), 0);
			$Count 			= min($Count, $MaxElements);
			
			$BuildArray    	= !empty($PLANET['b_hangar_id']) ? unserialize($PLANET['b_hangar_id']) : array();
            
			if (in_array($Element, $reslist['missile'])){
				$MaxMissiles		= BuildFunctions::getMaxConstructibleRockets($USER, $PLANET, $Missiles);
				$Count 				= min($Count, $MaxMissiles[$Element]);
				$Missiles[$Element] += $Count;
			}elseif (in_array($Element, $reslist['domes'])){
				$MaxDomes		    = BuildFunctions::getMaxConstructibleDomes($USER, $PLANET, $Domes);
				$Count 				= min($Count, $MaxDomes[$Element]);
				$Domes[$Element]    += $Count;
			}elseif (in_array($Element, $reslist['orbital_bases'])){
				$MaxOrbits		    = BuildFunctions::getMaxConstructibleOrbits($USER, $PLANET, $Orbits);
				$Count 				= min($Count, $MaxOrbits[$Element]);
				$Orbits[$Element]   += $Count;
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
            include('includes/subclasses/subclass.ResMinus.php');

			$BuildArray[]			= array($Element, $Count);
			$PLANET['b_hangar_id']	= serialize($BuildArray);
		}
	}
	
	public function show()
	{
		global $USER, $PLANET, $LNG, $resource, $reslist, $requeriments, $CombatCaps, $pricelist;

		$buildTodo	= HTTP::_GP('fmenge', array());
		$action		= HTTP::_GP('action', '');
								
		$NotBuilding = true;
		if (!empty($PLANET['b_building_id']))
		{
			$CurrentQueue 	= unserialize($PLANET['b_building_id']);
			foreach($CurrentQueue as $ElementArray)
			{
                foreach($reslist['shipyard'] as $elementID) 
                {
                    if($ElementArray[0] == $elementID) {
                        $NotBuilding = false;
                        break;
                    }
                } 
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
        $elementList	= array();
        
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
				$Shipyard[]		= array($LNG['tech'][$Element[0]], $Element[1], ($ElementTime), $Element[0]);		
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
		$Domes	    = array();
		$Orbits	    = array();

		foreach($reslist['missile'] as $elementID)
		{
			$Missiles[$elementID]	= $PLANET[$resource[$elementID]];
		}

		foreach($reslist['defense'] as $elementID)
		{
			$Domes[$elementID]	= $PLANET[$resource[$elementID]];
			$Orbits[$elementID]	= $PLANET[$resource[$elementID]];
		}

		$MaxMissiles	= BuildFunctions::getMaxConstructibleRockets($USER, $PLANET, $Missiles);
		$MaxDomes	    = BuildFunctions::getMaxConstructibleDomes($USER, $PLANET, $Domes);
		$MaxOrbits	    = BuildFunctions::getMaxConstructibleOrbits($USER, $PLANET, $Orbits);

		foreach($elementIDs as $Element)
		{
            if(!BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element, $reslist['race']))
				continue;
            
            $techTreeList		= BuildFunctions::requirementsList($USER, $PLANET, $Element);
			$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
			$costOverflow		= BuildFunctions::getRestPrice($USER, $PLANET, $Element, $costResources);
			$elementTime    	= BuildFunctions::getBuildingTime($USER, $PLANET, $Element, $costResources);
			$buyable			= BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources);
			$maxBuildable		= BuildFunctions::getMaxConstructibleElements($USER, $PLANET, $Element, $costResources);
            
            $FleetGun = '';
            if($CombatCaps[$Element]['type_gun'] == 'none')
			{			
				$FleetGun = '';
			}
			elseif($CombatCaps[$Element]['type_gun'] == 'notype')
			{
				$FleetGun = 'notype';
			}
			else
			{
				$type_gun			= explode(';', $CombatCaps[$Element]['type_gun']);
				$FleetGun        	= array();
			
				foreach ($type_gun as $Item => $gun)
				{
					if (empty($gun)) continue;	
					
					$Class							= explode(',', $gun);
					$FleetGun[$Class[0]]['attack']	= round($CombatCaps[$Element]['attack'] * $Class[1] / 100);
				}									
			}
            
            $Info = array(
				'class_defend'	=> $CombatCaps[$Element]['type_defend'],	
				'class_shield'	=> $CombatCaps[$Element]['type_shield'],		
			);

			if(isset($MaxMissiles[$Element])) {
				$maxBuildable	= min($maxBuildable, $MaxMissiles[$Element]);
			}

			if(isset($MaxDomes[$Element])) {
				$maxBuildable	= min($maxBuildable, $MaxDomes[$Element]);
			}
			
			if(isset($MaxOrbits[$Element])) {
				$maxBuildable	= min($maxBuildable, $MaxOrbits[$Element]);
			}

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
				'techacc' 			=> BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element, array()),
				
                'fleetgun'		    => $FleetGun,
                'info'		        => $Info,
                'attack'		    => $CombatCaps[$Element]['attack'],
				'shield'		    => $CombatCaps[$Element]['shield'],
                'defend'		    => $CombatCaps[$Element]['defend'],
                'capacity'		    => $pricelist[$Element]['capacity'],
				'speed1'		    => $pricelist[$Element]['speed'],
				'speed2'		    => $pricelist[$Element]['speed2'],
				'consumption1'	    => $pricelist[$Element]['consumption'],
				'consumption2'	    => $pricelist[$Element]['consumption2'],
                'tech'			    => $pricelist[$Element]['tech'],
			);
		}
        //Для очереди
        $queueShipData	 			= $this->getShipData();
		$Queue	 		            = $queueShipData['queue'];
		
		$this->tplObj->loadscript('shipyard.js');
		$this->assign(array(
            'Queue'	        => $Queue,
            
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