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

require_once(ROOT_PATH . 'includes/classes/class.FleetFunctions.php');

class ShowReduceFleetPage extends AbstractGamePage
{
	public static $requireModule = MODULE_REDUCE_FLEET;

	function __construct() 
	{
		parent::__construct();
	}
	
	function reduce()
	{
		global $LNG, $USER, $PLANET, $resource, $pricelist, $reslist;
		
		$Plnets_target		= HTTP::_GP('palanets', array());
		$fleetSpeed  		= HTTP::_GP('speed', 10);

		if (empty($Plnets_target))
		$this->printMessage(''.$LNG['rd_planet_no'].'',true,  array("game.php?page=reduceFleet", 2));
		
		
		$activeSlots	= FleetFunctions::GetCurrentFleets($USER['id']);
		$maxSlots		= FleetFunctions::GetMaxFleetSlots($USER);
		
		foreach($Plnets_target as $planetID) 
		{
			if($PLANET['id'] == $planetID)
				continue;
				
			if(0 != $GLOBALS['DATABASE']->countquery("SELECT count(*) FROM ".FLEETS." WHERE `fleet_start_time` > ".TIMESTAMP." AND (`fleet_mission` = 1 OR `fleet_mission` = 6) AND `fleet_mess` = 0 AND `fleet_owner` <> ".$USER['id']." AND `fleet_end_id` = ".$planetID.";"))
				continue;
				
			$activeSlots		+= 1;
			if($activeSlots > $maxSlots)
			break;
						
			$planeta 			= $GLOBALS['DATABASE']->uniquequery("SELECT * FROM ".PLANETS." WHERE id = ".$planetID.";");			
			list($USER, $planeta)	= $this->ecoObj->CalcResource($USER, $planeta, true);
			
			$global_resours		= $planeta[$resource['903']];
			
			$Sumcapacity 		= 0;			
			$fleet_count		= 0;
			$fleetArray = array();
			
			foreach ($reslist['reducefleet'] as $Ship)
			{
				$fleet_count += $planeta[$resource[$Ship]];
				$planeta[$Ship] = $planeta[$resource[$Ship]];
				if($planeta[$resource[$Ship]])
					$fleetArray[$Ship]	= $planeta[$resource[$Ship]];
					
				$Sumcapacity += $pricelist[$Ship]['capacity'] * $planeta[$resource[$Ship]] * (1 + $USER['factor']['ShipStorage']);
			}			
			
			
			if(($global_resours == 0 || $fleet_count == 0))
				continue;
		
			$SpeedFactor    	= FleetFunctions::GetGameSpeedFactor();
			$Distance    		= FleetFunctions::GetTargetDistance(array($planeta['galaxy'], $planeta['system'], $planeta['planet']), array($PLANET['galaxy'], $PLANET['system'], $PLANET['planet']));
			$SpeedAllMin		= FleetFunctions::GetFleetMaxSpeed($fleetArray, $USER);
			$Duration			= FleetFunctions::GetMissionDuration($fleetSpeed, $SpeedAllMin, $Distance, $SpeedFactor, $USER);
			$consumption		= FleetFunctions::GetFleetConsumption($fleetArray, $Duration, $Distance, $USER, $SpeedFactor);
			$Duration			= $Duration;
			
			if($consumption > $planeta[$resource['903']] || $consumption > $Sumcapacity)
				continue;	
			
			$GLOBALS['DATABASE']->query("UPDATE ".PLANETS." SET ".$resource['903']." = ".$resource['903']." - ".$consumption." WHERE `id` = '".$planeta["id"]."';");
			
			$fleetRessource	= array(
				901	=> 0,
				902	=> 0,
				903	=> 0,
			);	
			
			$fleetStartTime		= $Duration + TIMESTAMP;
			$fleetStayTime		= $fleetStartTime;
			$fleetEndTime		= $fleetStayTime + $Duration;
			
			$shipID				= array_keys($fleetArray);
			
			FleetFunctions::sendFleet($fleetArray, 4, $USER['id'], $planeta['id'], $planeta['galaxy'], $planeta['system'], $planeta['planet'], $planeta['planet_type'],
			$USER['id'], $PLANET['id'], $PLANET['galaxy'], $PLANET['system'], $PLANET['planet'], $PLANET['planet_type'], $fleetRessource, $fleetStartTime, $fleetStayTime, $fleetEndTime);
		}
		$this->printMessage(''.$LNG['rd_fleet_go'].'',true,  array("game.php?page=reduceFleet", 2));
	}
	
	public function show()
	{
		global $USER, $PLANET, $resource, $pricelist, $reslist;
		
		$fleetSpeed  		= HTTP::_GP('speed', 10);
		
		if($USER['urlaubs_modus']==1)
			$this->printMessage(''.$LNG['rd_fleet_po'].'',true,  array("game.php?page=fleetTable", 2));
				
		$activeSlots	= FleetFunctions::GetCurrentFleets($USER['id']);
		$maxSlots		= FleetFunctions::GetMaxFleetSlots($USER);
		
		if($activeSlots >= $maxSlots)
			$this->printMessage(''.$LNG['rd_fleet_slot'].'',true,  array("game.php?page=fleetTable", 2));
		
		if($USER['planet_sort'] == 0) {
			$Order	= "id ";
		} elseif($USER['planet_sort'] == 1) {
			$Order	= "galaxy, system, planet, planet_type ";
		} elseif ($USER['planet_sort'] == 2) {
			$Order	= "name ";	
		}
		
		$Order .= ($USER['planet_sort_order'] == 1) ? "DESC" : "ASC" ;
		
		$PlanetsRAW = $GLOBALS['DATABASE']->query("SELECT * FROM ".PLANETS." WHERE id != ".$PLANET['id']." AND id_owner = '".$USER['id']."' AND destruyed = '0' ORDER BY ".$Order.";");
		$PLANETS	= array($PLANET);
		
		$PlanetRess	= new ResourceUpdate();
		
		while($CPLANET = $GLOBALS['DATABASE']->fetch_array($PlanetsRAW))
		{
			list($USER, $CPLANET)	= $PlanetRess->CalcResource($USER, $CPLANET, true);
			
			$PLANETS[]	= $CPLANET;
			unset($CPLANET);
		}
		
		$ACSList 		= $this->GetAvalibleACS();
		
		$this->tplObj->assign_vars(array(		
			'ACSList' 		=> $ACSList,
			'reducefleet'	=> $reslist['reducefleet'],
			'speedSelect'	=> FleetFunctions::$allowedSpeed,
			'speed'	=> $fleetSpeed,
		));
		
		$this->display('page.reduceFleet.default.tpl');
	}
	
	private function GetAvalibleACS()
	{
		global $USER, $PLANET, $resource, $pricelist, $reslist;
		
		$fleetSpeed  		= HTTP::_GP('speed', 10);
		
		$ACSResult 	= $GLOBALS['DATABASE']->query("SELECT * FROM ".PLANETS." WHERE id_owner = ".$USER['id']." AND destruyed = 0 AND deuterium <> 0 AND id <> ".$PLANET['id'].";");
		
		$ACSList	= array();
		
		while($planeta = $GLOBALS['DATABASE']->fetch_array($ACSResult)) 
		{
			if(0 != $GLOBALS['DATABASE']->countquery("SELECT count(*) FROM ".FLEETS." WHERE `fleet_start_time` > ".TIMESTAMP." AND (`fleet_mission` = 1 OR `fleet_mission` = 6) AND `fleet_mess` = 0 AND `fleet_owner` <> ".$USER['id']." AND `fleet_end_id` = ".$planeta['id'].";"))
				continue;
			
			$global_resours		= $planeta[$resource['903']];
			
			$fleet_count		= 0;
			$fleetArray = array();
			
			foreach ($reslist['reducefleet'] as $Ship)
			{
				$fleet_count += $planeta[$resource[$Ship]];
				$planeta[$Ship] = $planeta[$resource[$Ship]];
				if($planeta[$resource[$Ship]])
					$fleetArray[$Ship]	= $planeta[$resource[$Ship]];
			}			
			
			if($fleet_count == 0)
				continue;
	
			$SpeedFactor    	= FleetFunctions::GetGameSpeedFactor();
			$Distance    		= FleetFunctions::GetTargetDistance(array($planeta['galaxy'], $planeta['system'], $planeta['planet']), array($PLANET['galaxy'], $PLANET['system'], $PLANET['planet']));
			$SpeedAllMin		= FleetFunctions::GetFleetMaxSpeed($fleetArray, $USER);
			$Duration			= FleetFunctions::GetMissionDuration($fleetSpeed, $SpeedAllMin, $Distance, $SpeedFactor, $USER);
			$consumption		= FleetFunctions::GetFleetConsumption($fleetArray, $Duration, $Distance, $USER, $SpeedFactor);
			$Duration			= $Duration;
			
			$planeta['consumption_fleet']	= $consumption;
			$planeta['time_fleet']			= $Duration;
			$planeta['sum']			        = $fleet_count;
			
			$Sumcapacity 		= 0;
			
			foreach ($reslist['reducefleet'] as $Ship)
			{
				$Sumcapacity += $pricelist[$Ship]['capacity'] * $planeta[$resource[$Ship]] * (1 + $USER['factor']['ShipStorage']);
			}	
						
			$planeta['sumcapacity']			= $Sumcapacity;	
			
			$ACSList[]	= $planeta;
		}
		
		$GLOBALS['DATABASE']->free_result($ACSResult);
		
		return $ACSList;
	}
}
?>