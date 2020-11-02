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

require(ROOT_PATH.'includes/classes/missions/functions/HostileSector.php');
require(ROOT_PATH.'includes/classes/missions/functions/SetHostileSectorBot.php');

class MissionCaseMilitaryExpedition extends MissionFunctions implements Mission
{
	/**
	 * MissionCaseMilitaryExpedition constructor.
	 * @param $fleet
	 */
	function __construct($fleet)
	{
		$this->_fleet = $fleet;
	}

	/**
	 * @return void
	 */
	function TargetEvent()
	{
		$this->setState(FLEET_HOLD);
		$this->SaveFleet();
	}

	/**
	 * @return void
	 */
	function EndStayEvent()
	{
		global $pricelist, $reslist, $SectorME, $resource;

		// get language for messages
		$LNG = $this->getLanguage(NULL, $this->_fleet['fleet_owner']);
        
        $config	= Config::get($this->_fleet['fleet_universe']);

		// set sector number, name and first expedition message
		$Sector  = in_array($this->_fleet['sector'], $SectorME) ? $this->_fleet['sector'] : $SectorME[mt_rand(0, count($SectorME) - 1)];
		$Name    = $LNG['fl_enemy'][$Sector];
		$Message = sprintf($LNG['fl_enemy_msg']['main'], $LNG['fl_enemy'][$Sector]);

		// create hostileSector object
		$hostileSector = new SetHostileSectorBot();

		// get user data
        $sql = 'SELECT * FROM %%USERS%% WHERE id = :userId;';

		$Player['user']	= Database::get()->selectSingle($sql, array(
			':userId'	=> $this->_fleet['fleet_owner']
		));
        
        $Player['factor'] = getFactors($Player['user']);

		// declare variable of points of the fleet units
		$expeditionPoints = array();

		// count up points of the fleet units     
        foreach($reslist['fleet'] as $ID)
		{
			$expeditionPoints[$ID] = ($pricelist[$ID]['cost'][901] + $pricelist[$ID]['cost'][902]);
		}

		// explode user fleet array from database
		$fleetRaw      = explode(";", $this->_fleet['fleet_array']);
		$fleetPoints   = 0;
		$fleetCapacity = 0;

		// count up points of the user fleet
		foreach($fleetRaw as $Group)
		{
			if(empty($Group))
				continue;

			$Class          = explode(",", $Group);
			$fleetCapacity += $Class[1] * $pricelist[$Class[0]]['capacity'];
			$fleetPoints   += $Class[1] * $expeditionPoints[$Class[0]];
		}

		// calculate fleet capacity
		$fleetCapacity *= 1 + $Player['factor']['ShipStorage'];
		$fleetCapacity -= $this->_fleet['fleet_resource_metal'] + $this->_fleet['fleet_resource_crystal'] + $this->_fleet['fleet_resource_deuterium'] + $this->_fleet['fleet_resource_darkmatter'];

		// init & set attacker
		$attackFleets = array();
		$attackFleets[$this->_fleet['fleet_id']]['fleetDetail']      = $this->_fleet;     // set attacker fleet
		$attackFleets[$this->_fleet['fleet_id']]['player']           = $Player['user'];   // set attacker data
		$attackFleets[$this->_fleet['fleet_id']]['player']['factor'] = $Player['factor']; // set attacker factor
		$attackFleets[$this->_fleet['fleet_id']]['unit']             = array();           // init attacker fleet

		// set attacker fleet
		foreach($fleetRaw as $temp)
		{
			$temp = explode(',', $temp);

			if($temp[0] < 100)
				continue;

			if(!isset($attackFleets[$this->_fleet['fleet_id']]['unit'][$temp[0]]))
				$attackFleets[$this->_fleet['fleet_id']]['unit'][$temp[0]] = 0;

			$attackFleets[$this->_fleet['fleet_id']]['unit'][$temp[0]] += $temp[1];
		}

		$hostileSector->CreateBot($Sector, $Player, $Name); // set sector bot
		$hostileSector->setBotFleetArray($fleetPoints);     // set bot fleet

		// init defender
		$defenderFleets = array();
        $defenderFleets[0]['fleetDetail'] = $this->_fleet; 
		$defenderFleets[0]['player'] = $hostileSector->getBotInfo();             // set bot info, technologies & academy
		$defenderFleets[0]['player']['factor'] = $hostileSector->getBotFactor(); // get bot factor
		$defenderFleets[0]['unit'] = $hostileSector->getBotFleetArray();         // set bot fleet

		// sort bot fleet array
		ksort($defenderFleets[0]['unit']);

		// connect the battle calculator
		require_once('includes/classes/missions/functions/calculateAttack.php');

        $fleetIntoDebris	= $config->Fleet_Cdr;
		$defIntoDebris		= $config->Defs_Cdr;

		// calculate the battle
		$result = calculateAttack($attackFleets, $defenderFleets, $fleetIntoDebris, $defIntoDebris);

		// update attacker fleets
		foreach($attackFleets as $attacker)
		{
			$fleetArray = '';
			$totalCount = 0;
			foreach($attacker['unit'] as $element => $amount)
			{
				if($amount)
					$fleetArray .= $element.','.$amount.';';

				$totalCount += $amount;
			}

			if($totalCount <= 0)
				$this->KillFleet();
			else
			{
				$this->UpdateFleet('fleet_array', substr($fleetArray, 0, -1));
				$this->UpdateFleet('fleet_amount', $totalCount);
			}
		}

		// connect the battle calculator
		require_once('includes/classes/missions/functions/GenerateReport.php');

		// get debris
		$debris = $hostileSector->getDebris($result['debris']);


		$ShipmentDebris = array(901 => 0, 902 => 0);

		// shipment debris
		$Size = min($debris[901], $fleetCapacity);
		$fleetCapacity      -= $Size;
		$ShipmentDebris[901] = $Size;
		$this->UpdateFleet('fleet_resource_metal', $this->_fleet['fleet_resource_metal'] + $Size);

		$Size = min($debris[902], $fleetCapacity);
		$ShipmentDebris[902] = $Size;
		$this->UpdateFleet('fleet_resource_crystal', $this->_fleet['fleet_resource_crystal'] + $Size);

		// set steal deuterium to zero
		$ShipmentDebris[903] = 0;

		// preparation report info
		$reportInfo = array(
			'thisFleet'           => $this->_fleet,
			'debris'              => $debris,
			'stealResource'       => $ShipmentDebris,
			'moonChance'          => 0,
			'moonDestroy'         => false,
			'moonName'            => null,
			'moonDestroyChance'   => null,
			'moonDestroySuccess'  => null,
			'fleetDestroyChance'  => null,
			'fleetDestroySuccess' => null,
		);

		// generate report
		$reportData = GenerateReport($result, $reportInfo);

		// save report to db
        $reportID	= md5(uniqid('', true).TIMESTAMP);

		$sql		= "INSERT INTO %%RW%% SET
			rid			= :reportId,
			raport		= :reportData,
			time		= :time,
			attacker	= :attacker;";

		Database::get()->insert($sql, array(
			':reportId'		=> $reportID,
			':reportData'	=> serialize($reportData),
			':time'			=> $this->_fleet['fleet_start_time'],
			':attacker'		=> $this->_fleet['fleet_owner'],
		));

		// set message color
		$attackClass = "white";
		$defendClass = "white";

		switch ($result['won'])
		{
			case "a":
				$attackClass = 'style="color:green;"';
				$defendClass = 'style="color:red;"';
				break;
			case "w":
				$attackClass = 'style="color:orange;"';
				$defendClass = 'style="color:orange;"';
				break;
			case "r":
				$attackClass = 'style="color:red;"';
				$defendClass = 'style="color:green;"';
				break;
		}

		if($result['won'] == "a")
		{
            $sql			= 'SELECT * FROM %%USERS%% WHERE id = :userId;';
            $senderUser		= Database::get()->selectSingle($sql, array(
                ':userId'	=> $this->_fleet['fleet_owner']
            ));
            $senderUser['factor']	= getFactors($senderUser, 'attack', $this->_fleet['fleet_start_time']);

            $Size =  1;
            
			$searchUpgradeResult = $hostileSector->SearchForUpgrade();
			if($searchUpgradeResult)
			{  
                $sql	= "UPDATE %%USERS%% SET ".$resource[$searchUpgradeResult]." = ".$resource[$searchUpgradeResult]." + ".$Size." WHERE id = :userId;";
                    Database::get()->update($sql, array(
                        ':userId'       => $this->_fleet['fleet_owner'],
                ));
                
				$Message .= "<br>".sprintf($LNG['fl_enemy_msg']['up'], $LNG['tech'][$searchUpgradeResult], pretty_number($Size));
			}

			$searchDarkMatterResult = $hostileSector->SearchForDarkMatter();
			if($searchDarkMatterResult)
			{
				$this->UpdateFleet('fleet_resource_darkmatter', $this->_fleet['fleet_resource_darkmatter'] + $searchDarkMatterResult * ($config->stat_settings/1000)* $Size);
				$Message .= "<br>".sprintf($LNG['fl_enemy_msg']['tm'], pretty_number($searchDarkMatterResult * $Size));
			}
		}

		// set battle message
		$MessageAtt = sprintf(
			str_replace(array("\n", "\t", "\r"), "", $LNG['batl_log_mesage']),
			$reportID,
			$attackClass,
			$LNG['sys_mess_attack_report'],
			$LNG['host_mission_mesag'],
			$Name,
			$LNG['sys_lost'],
			$attackClass,
			$LNG['sys_attack_attacker_pos'],
			pretty_number($result['unitLost']['attacker']),
			$defendClass,
			$LNG['sys_attack_defender_pos'],
			pretty_number($result['unitLost']['defender']),
			$LNG['sys_gain'],
			$LNG['tech'][901],
			pretty_number($ShipmentDebris[901]),
			$LNG['tech'][902],
			pretty_number($ShipmentDebris[902]),
			$LNG['tech'][903],
			0,
			$LNG['sys_debris'],
			$LNG['tech'][901],
			pretty_number($debris[901]),
			$LNG['tech'][902],
			pretty_number($debris[902])
		);

		// send battle message and first expedition message
		PlayerUtil::sendMessage($this->_fleet['fleet_owner'], 0, $LNG['sys_mess_tower'], 3, $LNG['sys_mess_fleetback'], 
            $MessageAtt, $this->_fleet['fleet_end_time'], NULL, 1, $this->_fleet['fleet_universe']);
            
		PlayerUtil::sendMessage($this->_fleet['fleet_owner'], 0, $LNG['sys_mess_tower'], 15, $LNG['sys_mess_fleetback'], 
            $Message, $this->_fleet['fleet_end_time'], NULL, 1, $this->_fleet['fleet_universe']); 

		// return fleet
		$this->setState(FLEET_RETURN);
		$this->SaveFleet();
	}

	/**
	 * @return void
	 */
	function ReturnEvent()
	{
		$LNG     = $this->getLanguage(NULL, $this->_fleet['fleet_owner']);
		$Message = sprintf($LNG['sys_expe_back_home'], $LNG['tech'][901], pretty_number($this->_fleet['fleet_resource_metal']), $LNG['tech'][902], pretty_number($this->_fleet['fleet_resource_crystal']),  $LNG['tech'][903], pretty_number($this->_fleet['fleet_resource_deuterium']), $LNG['tech'][921], pretty_number($this->_fleet['fleet_resource_darkmatter']));
        
        PlayerUtil::sendMessage($this->_fleet['fleet_owner'], 0, $LNG['sys_mess_tower'], 15, $LNG['sys_mess_fleetback'],
			$Message, $this->_fleet['fleet_end_time'], NULL, 1, $this->_fleet['fleet_universe']);
        
		$this->RestoreFleet();
	}
}
