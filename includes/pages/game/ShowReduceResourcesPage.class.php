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

class ShowReduceResourcesPage extends AbstractGamePage
{
	public static $requireModule = MODULE_REDUCE_RESOURCES;

	function __construct() 
	{
		parent::__construct();
	}
	
	function reduce()
	{
		global $USER, $PLANET, $resource, $pricelist, $reslist, $LNG;
		
		$Plnets_target		= HTTP::_GP('palanets', array());

		if (empty($Plnets_target))
		$this->printMessage(''.$LNG['rd_planet_no'].'',true,  array("game.php?page=reduceResources", 2));
		
		
		$activeSlots	= FleetFunctions::GetCurrentFleets($USER['id']);
		$maxSlots		= FleetFunctions::GetMaxFleetSlots($USER);
		
		$PlanetRess	= new ResourceUpdate();
		
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
			
			$global_resours		= $planeta[$resource['901']] + $planeta[$resource['902']] + $planeta[$resource['903']];
			
			if((($planeta[$resource[202]] + $planeta[$resource[203]] + $planeta[$resource[217]]) == 0)||($global_resours == 0))
				continue;
			
			$small_room			= $pricelist[202]['capacity'] * (1 + $USER['factor']['ShipStorage']);
			$big_room			= $pricelist[203]['capacity'] * (1 + $USER['factor']['ShipStorage']);
			$ev_room			= $pricelist[217]['capacity'] * (1 + $USER['factor']['ShipStorage']);
			
			$small_count		= 0;
			$big_count			= 0;
			$ev_count			= 0;
			
			if($planeta[$resource[217]] != 0)
				$ev_count		= min(max(($global_resours / $ev_room), 1), $planeta[$resource[217]]);
			if($planeta[$resource[203]] != 0)
				$big_count		= min(max((($global_resours - $ev_room * $planeta[$resource[217]]) / $big_room), 0), $planeta[$resource[203]]);
			if($planeta[$resource[202]] != 0)
				$small_count	= min(max((($global_resours - $ev_room * $planeta[$resource[217]] - $big_room * $planeta[$resource[203]]) / $small_room), 0), $planeta[$resource[202]]);
			
			$PlanetMetall	  	= $planeta[$resource['901']];
			$PlanetCrystal  	= $planeta[$resource['902']];
			$PlanetDeuterium  	= $planeta[$resource['903']];
			
			$fleetArray = array();
			
			if($small_count != 0)
				$fleetArray[202]	= $small_count;
			if($big_count != 0)
				$fleetArray[203]	= $big_count;			
			if($ev_count != 0)
				$fleetArray[217]	= $ev_count;
					
			$SpeedFactor    	= FleetFunctions::GetGameSpeedFactor();
			$Distance    		= FleetFunctions::GetTargetDistance(array($planeta['galaxy'], $planeta['system'], $planeta['planet']), array($PLANET['galaxy'], $PLANET['system'], $PLANET['planet']));
			$SpeedAllMin		= FleetFunctions::GetFleetMaxSpeed($fleetArray, $USER);
			$Duration			= FleetFunctions::GetMissionDuration(10, $SpeedAllMin, $Distance, $SpeedFactor, $USER);
			$consumption		= FleetFunctions::GetFleetConsumption($fleetArray, $Duration, $Distance, $USER, $SpeedFactor);
			$Duration			= $Duration;
			
			$Sumcapacity 		= 0;
			
			if($small_count != 0)
				$Sumcapacity	+= $small_room * $small_count;
			if($big_count != 0)
				$Sumcapacity	+= $big_room * $big_count;			
			if($ev_count != 0)
				$Sumcapacity	+= $ev_room * $ev_count;
			
			if($consumption > $PlanetDeuterium || $consumption > $Sumcapacity)
				continue;
				
			$PlanetDeuterium   	-= $consumption;
			$Sumcapacity   		-= $consumption;			
			
			$booty 				= array();
			
			// Шаг 1
			$booty['metal'] 	= min($Sumcapacity / 3, $PlanetMetall);
			$Sumcapacity		-= $booty['metal'];
			 
			// Шаг 2
			$booty['crystal'] 	= min($Sumcapacity / 2, $PlanetCrystal);
			$Sumcapacity		-= $booty['crystal'];
			 
			// Шаг 3
			$booty['deuterium'] = min($Sumcapacity, $PlanetDeuterium);
			$Sumcapacity		-= $booty['deuterium'];
				 
			// Шаг 4
			$oldMetalBooty  	= $booty['metal'];
			$booty['metal'] 	+= min($Sumcapacity / 2, $PlanetMetall - $booty['metal']);
			$Sumcapacity		-= $booty['metal'] - $oldMetalBooty;
				 
			// Шаг 5
			$oldCrystalBooty	= $booty['crystal'];
			$booty['crystal'] 	+= min($Sumcapacity, $PlanetCrystal - $booty['crystal']);
			$Sumcapacity		-= $booty['crystal'] - $oldCrystalBooty;
			
			// Шаг 6
			$booty['metal'] 	+= min($Sumcapacity, $PlanetMetall - $booty['metal']);

			
			$PlanetMetall	  	-= $booty['metal'];
			$PlanetCrystal  	-= $booty['crystal'];
			$PlanetDeuterium  	-= $booty['deuterium'];
			
		  	$planeta[$resource['901']] 	= $PlanetMetall;
		  	$planeta[$resource['902']]	= $PlanetCrystal;
		  	$planeta[$resource['903']] 	= $PlanetDeuterium;
			
			list($USER, $planeta)	= $PlanetRess->CalcResource($USER, $planeta, true);
						
			$fleetRessource	= array(
				901	=> $booty['metal'],
				902	=> $booty['crystal'],
				903	=> $booty['deuterium'],
			);
	
			$fleetStartTime		= $Duration + TIMESTAMP;
			$fleetStayTime		= $fleetStartTime;
			$fleetEndTime		= $fleetStayTime + $Duration;
			
			$shipID				= array_keys($fleetArray);
			
			FleetFunctions::sendFleet($fleetArray, 3, $USER['id'], $planeta['id'], $planeta['galaxy'], $planeta['system'], $planeta['planet'], $planeta['planet_type'],
			$USER['id'], $PLANET['id'], $PLANET['galaxy'], $PLANET['system'], $PLANET['planet'], $PLANET['planet_type'], $fleetRessource, $fleetStartTime, $fleetStayTime, $fleetEndTime, 
			0, 0, $USER['ally_id']);
			unset($planeta);
		}
		$this->printMessage(''.$LNG['rd_fleet_go'].'',true,  array("game.php?page=reduceResources", 2));
	}
	
	public function show()
	{
		global $USER, $PLANET, $resource, $pricelist, $reslist, $LNG;
	
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
			'ACSList' 					=> $ACSList,
			'RedBorder'					=> rand(0, 5),
		));
		
		$this->display('page.reduceResources.default.tpl');
	}
	
	private function GetAvalibleACS()
	{
		global $USER, $PLANET, $resource, $pricelist, $reslist, $LNG;
		
		$ACSResult 	= $GLOBALS['DATABASE']->query("SELECT * FROM ".PLANETS." WHERE planet_type = '1' AND id_owner = ".$USER['id']." AND destruyed = 0 AND id <> ".$PLANET['id']." ORDER BY (metal + crystal + deuterium) DESC;");
		
		$ACSList	= array();
		
		while($planeta = $GLOBALS['DATABASE']->fetch_array($ACSResult)) 
		{
			if(0 != $GLOBALS['DATABASE']->countquery("SELECT count(*) FROM ".FLEETS." WHERE `fleet_start_time` > ".TIMESTAMP." AND (`fleet_mission` = 1 OR `fleet_mission` = 6) AND `fleet_mess` = 0 AND `fleet_owner` <> ".$USER['id']." AND `fleet_end_id` = ".$planeta['id'].";"))
			continue;
			
			$global_resours		= $planeta[$resource['901']] + $planeta[$resource['902']] + $planeta[$resource['903']];
			
			if(($planeta[$resource[202]] + $planeta[$resource[203]] + $planeta[$resource[217]]) == 0)
			{
				$planeta['small_count']			= 0;
				$planeta['big_count']			= 0;
				$planeta['ev_count']			= 0;
				$planeta['consumption_fleet']	= 0;
				$planeta['time_fleet']			= 0;
				$planeta['sumcapacity']			= 0;	
			}
			else
			{
				$small_room			= $pricelist[202]['capacity'] * (1 + $USER['factor']['ShipStorage']);
				$big_room			= $pricelist[203]['capacity'] * (1 + $USER['factor']['ShipStorage']);
				$ev_room			= $pricelist[217]['capacity'] * (1 + $USER['factor']['ShipStorage']);
				
				$small_count		= 0;
				$big_count			= 0;
				$ev_count			= 0;
				
				if($planeta[$resource[217]] != 0)
					$ev_count		= min(max(($global_resours / $ev_room), 1), $planeta[$resource[217]]);
				if($planeta[$resource[203]] != 0)
					$big_count		= min(max((($global_resours - $ev_room * $planeta[$resource[217]]) / $big_room), 0), $planeta[$resource[203]]);
				if($planeta[$resource[202]] != 0)
					$small_count	= min(max((($global_resours - $ev_room * $planeta[$resource[217]] - $big_room * $planeta[$resource[203]]) / $small_room), 0), $planeta[$resource[202]]);
				
				$PlanetMetall	  	= $planeta[$resource['901']];
				$PlanetCrystal  	= $planeta[$resource['902']];
				$PlanetDeuterium  	= $planeta[$resource['903']];
				
				$fleetArray = array();
				
				if($small_count != 0)
					$fleetArray[202]	= $small_count;
				if($big_count != 0)
					$fleetArray[203]	= $big_count;			
				if($ev_count != 0)
					$fleetArray[217]	= $ev_count;
				
				if(empty($fleetArray))
					continue;
				
				$planeta['small_count']	= $small_count;
				$planeta['big_count']	= $big_count;
				$planeta['ev_count']	= $ev_count;
		
				$SpeedFactor    	= FleetFunctions::GetGameSpeedFactor();
				$Distance    		= FleetFunctions::GetTargetDistance(array($planeta['galaxy'], $planeta['system'], $planeta['planet']), array($PLANET['galaxy'], $PLANET['system'], $PLANET['planet']));
				$SpeedAllMin		= FleetFunctions::GetFleetMaxSpeed($fleetArray, $USER);
				$Duration			= FleetFunctions::GetMissionDuration(10, $SpeedAllMin, $Distance, $SpeedFactor, $USER);
				$consumption		= FleetFunctions::GetFleetConsumption($fleetArray, $Duration, $Distance, $USER, $SpeedFactor);
				$Duration			= $Duration;
				
				$planeta['consumption_fleet']	= $consumption;
				$planeta['time_fleet']			= $Duration;
				
				$Sumcapacity 		= 0;
			
				if($small_count != 0)
					$Sumcapacity	+= $small_room * $small_count;
				if($big_count != 0)
					$Sumcapacity	+= $big_room * $big_count;			
				if($ev_count != 0)
					$Sumcapacity	+= $ev_room * $ev_count;
					
				$planeta['sumcapacity']			= $Sumcapacity;	
			}
			$ACSList[]	= $planeta;
		}
		
		$GLOBALS['DATABASE']->free_result($ACSResult);
		
		return $ACSList;
	}
}
?>