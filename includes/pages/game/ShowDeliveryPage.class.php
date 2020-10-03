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

class ShowDeliveryPage extends AbstractGamePage
{
	public static $requireModule = MODULE_DELIVERY;

	function __construct() 
	{
		parent::__construct();
	}
	
	function delivery()
	{
		global $USER, $PLANET, $resource, $pricelist, $reslist, $CONF, $LNG;
		
		$Plnets_target		= HTTP::_GP('palanets', array());
		$r901		        = HTTP::_GP('r901', 0);
		$r902		        = HTTP::_GP('r902', 0);
		$r903		        = HTTP::_GP('r903', 0);
		
		if (empty($Plnets_target))
		$this->printMessage(''.$LNG['rd_planet_no'].'',true,  array("game.php?page=delivery", 2));
		
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
			
        if($r901 > $PLANET[$resource['901']])
			FleetFunctions::GotoFleetPage();
		if($r902 > $PLANET[$resource['902']])
			FleetFunctions::GotoFleetPage();
		if($r903 > $PLANET[$resource['903']])
			FleetFunctions::GotoFleetPage(19);
			
			$planeta 			= $GLOBALS['DATABASE']->uniquequery("SELECT * FROM ".PLANETS." WHERE id = ".$planetID.";");			
			
			$global_resours		= $r901 + $r902 + $r903;
			
			if((($PLANET[$resource[217]]) == 0)||($global_resours == 0))
				continue;
			
			$ev_room			= $pricelist[217]['capacity'] * (1 + $USER['factor']['ShipStorage']);
			
			$ev_count			= 0;
			
			if($PLANET[$resource[217]] != 0)
			$ev_count		= min(max(($global_resours / $ev_room), 1), $PLANET[$resource[217]]);

			if($ev_count > $PLANET[$resource[217]])
				FleetFunctions::GotoFleetPage(21);
			
			$fleetArray = array();
					
			if($ev_count != 0)
				$fleetArray[217]	= $ev_count;
					
			$SpeedFactor    	= FleetFunctions::GetGameSpeedFactor();
			$Distance    		= FleetFunctions::GetTargetDistance(array($PLANET['galaxy'], $PLANET['system'], $PLANET['planet']), array($planeta['galaxy'], $planeta['system'], $planeta['planet']));
			$SpeedAllMin		= FleetFunctions::GetFleetMaxSpeed($fleetArray, $USER);
			$Duration			= FleetFunctions::GetMissionDuration(10, $SpeedAllMin, $Distance, $SpeedFactor, $USER);
			$consumption		= FleetFunctions::GetFleetConsumption($fleetArray, $Duration, $Distance, $USER, $SpeedFactor);
			$Duration			= $Duration;
			
            
			$Sumcapacity 		= 0;
				
			if($ev_count != 0)
				$Sumcapacity	+= $ev_room * $ev_count;
			
			if($consumption > $PLANET[$resource['903']] || $consumption > $Sumcapacity)
				continue;
				
			$PLANET[$resource['903']]  	-= $consumption;
			$Sumcapacity   		-= $consumption;			
			
			$booty 				= array();
			
			$booty['metal'] 	= $r901;
			$booty['crystal'] 	= $r902; 
			$booty['deuterium'] = $r903;

			list($USER, $PLANET)	= $PlanetRess->CalcResource($USER, $PLANET, true);
						
			$fleetRessource	= array(
				901	=> $booty['metal'],
				902	=> $booty['crystal'],
				903	=> $booty['deuterium'],
			);
			
			$PLANET[$resource['901']]	-= $booty['metal'];
			$PLANET[$resource['902']]  	-= $booty['crystal'];
			$PLANET[$resource['903']]  	-= $booty['deuterium'];
			
			$fleetStartTime		= $Duration + TIMESTAMP;
			$fleetStayTime		= $fleetStartTime;
			$fleetEndTime		= $fleetStayTime + $Duration;
			
			$shipID				         = array_keys($fleetArray);
            
            if($USER[$resource[922]] < 30)
				continue;
			$USER[$resource[922]]       -= 30;
            
			$PLANET[$resource[217]]     -=$ev_count;
			
			FleetFunctions::sendFleet($fleetArray, 3, $USER['id'], $PLANET['id'], $PLANET['galaxy'], $PLANET['system'], $PLANET['planet'], $PLANET['planet_type'],
			$USER['id'], $planeta['id'], $planeta['galaxy'], $planeta['system'], $planeta['planet'], $planeta['planet_type'], $fleetRessource, $fleetStartTime, $fleetStayTime, $fleetEndTime, 
			0, 0, $USER['ally_id']);
			unset($planeta);
		}
		$this->printMessage(''.$LNG['rd_fleet_go'].'',true,  array("game.php?page=delivery", 2));
	}
	
	public function show()
	{
		global $USER, $PLANET, $resource, $pricelist, $reslist, $LNG, $CONF;
	
		if($USER['urlaubs_modus']==1)
			$this->printMessage(''.$LNG['rd_fleet_po'].'',true,  array("game.php?page=fleetTable", 2));
		
		if($PLANET['planet_type'] == '4')
			$this->printMessage($LNG['fl_send_error'][99],true, array("game.php", 3));
				
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
			'CostOne' 					=> 30,
			'countPL' 					=> $GLOBALS['DATABASE']->countquery("SELECT COUNT(*) FROM ".PLANETS." WHERE id != ".$PLANET['id']." AND id_owner = '".$USER['id']."' AND destruyed = '0';"),
			'RedBorder'					=> rand(0, 5),
		));
		
		$this->display('page.delivery.default.tpl');
	}
	
	private function GetAvalibleACS()
	{
		global $USER, $PLANET, $resource, $pricelist, $reslist;
		
		$ACSResult 	= $GLOBALS['DATABASE']->query("SELECT * FROM ".PLANETS." WHERE planet_type != '40' AND id_owner = ".$USER['id']." AND destruyed = 0 AND id <> ".$PLANET['id']." ORDER BY (metal + crystal + deuterium) DESC;");
		
		$ACSList	= array();
		
		while($planeta = $GLOBALS['DATABASE']->fetch_array($ACSResult)) 
		{
			if(0 != $GLOBALS['DATABASE']->countquery("SELECT count(*) FROM ".FLEETS." WHERE `fleet_start_time` > ".TIMESTAMP." AND (`fleet_mission` = 1 OR `fleet_mission` = 6) AND `fleet_mess` = 0 AND `fleet_owner` <> ".$USER['id']." AND `fleet_end_id` = ".$planeta['id'].";"))
			continue;
			
			$global_resours		= $planeta[$resource['901']] + $planeta[$resource['902']] + $planeta[$resource['903']];
			
			if($PLANET[$resource[217]] == 0)
			{
				$planeta['ev_count']			= 0;
				$planeta['consumption_fleet']	= 0;
				$planeta['time_fleet']			= 0;
				$planeta['sumcapacity']			= 0;	
			}
			else
			{
				$ev_room			= $pricelist[217]['capacity'] * (1 + $USER['factor']['ShipStorage']);
				
				$ev_count			= 0;
				
				if($PLANET[$resource[217]] != 0)
				$ev_count		= min(max(($global_resours / $ev_room), 1), $PLANET[$resource[217]]);

				$PlanetMetall	  	= $planeta[$resource['901']];
				$PlanetCrystal  	= $planeta[$resource['902']];
				$PlanetDeuterium  	= $planeta[$resource['903']];
				
				$fleetArray = array();
						
				if($ev_count != 0)
					$fleetArray[217]	= $ev_count;
				
				if(empty($fleetArray))
					continue;

				$planeta['ev_count']	= $ev_count;
		
				$SpeedFactor    	= FleetFunctions::GetGameSpeedFactor();
				$Distance    		= FleetFunctions::GetTargetDistance(array($PLANET['galaxy'], $PLANET['system'], $PLANET['planet']), array($planeta['galaxy'], $planeta['system'], $planeta['planet']));
				$SpeedAllMin		= FleetFunctions::GetFleetMaxSpeed($fleetArray, $USER);
				$Duration			= FleetFunctions::GetMissionDuration(10, $SpeedAllMin, $Distance, $SpeedFactor, $USER);
				$consumption		= FleetFunctions::GetFleetConsumption($fleetArray, $Duration, $Distance, $USER, $SpeedFactor);
				$Duration			= $Duration;
				
				$planeta['consumption_fleet']	= $consumption;
				$planeta['time_fleet']			= $Duration;
				
				$Sumcapacity 		= 0;
		
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