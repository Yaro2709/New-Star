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

class FlyingFleetsTable
{
	protected $Mode = null;
	protected $userId	= null;
	protected $planetId = null;
	protected $IsPhalanx = false;
	protected $missions = false;

	public function __construct() {
		
	}

	public function setUser($userId) {
		$this->userId = $userId;
	}

	public function setPlanet($planetId) {
		$this->planetId = $planetId;
	}

	public function setPhalanxMode() {
		$this->IsPhalanx = true;
	}

	public function setMissions($missions) {
		$this->missions = implode(',', array_filter(explode(',', $missions), 'is_numeric'));
	}
	
	private function getFleets($acsID = false) {
		if($this->IsPhalanx) {
			$where = '(fleet_start_id = :planetId AND fleet_start_type = 1 AND fleet_mission != 4) OR
					  (fleet_end_id = :planetId AND fleet_end_type = 1 AND fleet_mission != 8 AND fleet_mess IN (0, 2))';

			$param = array(
				':planetId'	  => $this->planetId
			);
		} elseif(!empty($acsID)) {
			$where	= 'fleet_group = :acsId';
			$param = array(
				':acsId'	=> $acsID
			);
		} elseif($this->missions) {
			$where = '(fleet_owner = :userId OR (fleet_target_owner = :userId AND fleet_mission != 8)) AND fleet_mission IN ('.$this->missions.')';
			$param = array(
				':userId'	=> $this->userId
			);
		} else {
			$where  = 'fleet_owner = :userId OR (fleet_target_owner = :userId AND fleet_mission != 8)';
			$param = array(
				':userId'	=> $this->userId,
			);
		}

		$sql = 'SELECT DISTINCT fleet.*, ownuser.username as own_username, targetuser.username as target_username,
		ownplanet.name as own_planetname, targetplanet.name as target_planetname
		FROM %%FLEETS%% fleet
		LEFT JOIN %%USERS%% ownuser ON (ownuser.id = fleet.fleet_owner)
		LEFT JOIN %%USERS%% targetuser ON (targetuser.id = fleet.fleet_target_owner)
		LEFT JOIN %%PLANETS%% ownplanet ON (ownplanet.id = fleet.fleet_start_id)
		LEFT JOIN %%PLANETS%% targetplanet ON (targetplanet.id = fleet.fleet_end_id)
		WHERE '.$where.';';

		return Database::get()->select($sql, $param);
	}

	public function renderTable()
	{
		$fleetResult	= $this->getFleets();
		$ACSDone		= array();
		$FleetData		= array();
		
		foreach($fleetResult as $fleetRow)
		{
			if ($fleetRow['fleet_mess'] == 0 && $fleetRow['fleet_start_time'] > TIMESTAMP && ($fleetRow['fleet_group'] == 0 || !isset($ACSDone[$fleetRow['fleet_group']])))
			{
				$ACSDone[$fleetRow['fleet_group']]		= true;
				$FleetData[$fleetRow['fleet_start_time'].$fleetRow['fleet_id']] = $this->BuildFleetEventTable($fleetRow, 0);
			}
				
			if ($fleetRow['fleet_mission'] == 10 || ($fleetRow['fleet_mission'] == 4 && $fleetRow['fleet_mess'] == 0))
				continue;
				
			if ($fleetRow['fleet_end_stay'] != $fleetRow['fleet_start_time'] && $fleetRow['fleet_end_stay'] > TIMESTAMP && ($this->IsPhalanx && $fleetRow['fleet_end_id'] == $this->planetId))
				$FleetData[$fleetRow['fleet_end_stay'].$fleetRow['fleet_id']] = $this->BuildFleetEventTable($fleetRow, 2);
			
			$MissionsOK = array(5,11,15,18);
			if ($fleetRow['fleet_end_stay'] > TIMESTAMP && in_array($fleetRow['fleet_mission'], $MissionsOK))
			$FleetData[$fleetRow['fleet_end_stay'].$fleetRow['fleet_id']] = $this->BuildFleetEventTable($fleetRow, 2);
				
			if ($fleetRow['fleet_owner'] != $this->userId)
				continue;
		
			if ($fleetRow['fleet_end_time'] > TIMESTAMP)
				$FleetData[$fleetRow['fleet_end_time'].$fleetRow['fleet_id']] = $this->BuildFleetEventTable($fleetRow, 1);
		}
		
		ksort($FleetData);
		return $FleetData;
	}

	private function BuildFleetEventTable($fleetRow, $FleetState)
	{
		$Time	= 0;
		$Rest	= 0;
        $Rest1	= 0;

		if ($FleetState == 0 && $this->IsPhalanx && $fleetRow['fleet_group'] != 0 && (strpos((isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]", 'page=phalanx') !== false))
		{
			$acsResult		= $this->getFleets($fleetRow['fleet_group']);
			$EventString	= '';

			foreach($acsResult as $acsRow)
			{
				$Return			= $this->getEventData($acsRow, $FleetState);
					
				$Rest			= $Return[0];
				$EventString    .= $Return[1].'<br><br>';
				$Time			= $Return[2];
                $Rest1			= $Return[3];
			}

			$EventString	= substr($EventString, 0, -8);
		}
		else
		{
			list($Rest, $EventString, $Time, $Rest1) = $this->getEventData($fleetRow, $FleetState);
		}
		
		return array(
			'text'			=> $EventString,
			'returntime'	=> $Time,
			'resttime'		=> $Rest,
            'resttime1'		=> $Rest1
		);
	}
	
	public function getEventData($fleetRow, $Status)
	{
		global $LNG;
		$Owner			= $fleetRow['fleet_owner'] == $this->userId;
		$FleetStyle  = array (
			1 => 'attack',
			2 => 'federation',
			3 => 'transport',
			4 => 'deploy',
			5 => 'hold',
			6 => 'espionage',
			7 => 'colony',
			8 => 'harvest',
			9 => 'destroy',
			10 => 'missile',
			11 => 'expdm',
			15 => 'expedit',
            18 => 'warexpedit',
		);
		
	    $GoodMissions	= array(3, 5);
		$MissionType    = $fleetRow['fleet_mission'];

		$FleetPrefix    = ($Owner == true) ? 'own' : '';
		$FleetType		= $FleetPrefix.$FleetStyle[$MissionType];
		$FleetName		= (!$Owner && ($MissionType == 1 || $MissionType == 2) && $Status == FLEET_OUTWARD && $fleetRow['fleet_target_owner'] != $this->userId) ? $LNG['cff_acs_fleet'] : $LNG['ov_fleet'];
		$FleetContent   = $this->CreateFleetPopupedFleetLink($fleetRow, $FleetName, $FleetPrefix.$FleetStyle[$MissionType]);
		$FleetCapacity  = $this->CreateFleetPopupedMissionLink($fleetRow, $LNG['type_mission_'.$MissionType], $FleetPrefix.$FleetStyle[$MissionType]);
		$FleetStatus    = array(0 => 'flight', 1 => 'return' , 2 => 'holding');
		$StartType		= $LNG['type_planet_'.$fleetRow['fleet_start_type']];
		$TargetType		= $LNG['type_planet_'.$fleetRow['fleet_end_type']];
	
		if ($MissionType == 8) {
			if ($Status == FLEET_OUTWARD)
				$EventString = sprintf($LNG['cff_mission_own_recy_0'], $FleetContent, $StartType, $fleetRow['own_planetname'], GetStartAddressLink($fleetRow, $FleetType), GetTargetAddressLink($fleetRow, $FleetType), $FleetCapacity);
			else
				$EventString = sprintf($LNG['cff_mission_own_recy_1'], $FleetContent, GetTargetAddressLink($fleetRow, $FleetType), $StartType, $fleetRow['own_planetname'], GetStartAddressLink($fleetRow, $FleetType), $FleetCapacity);
		} elseif ($MissionType == 10) {
			if ($Owner)
				$EventString = sprintf($LNG['cff_mission_own_mip'], $fleetRow['fleet_amount'], $StartType, $fleetRow['own_planetname'], GetStartAddressLink($fleetRow, $FleetType), $TargetType, $fleetRow['target_planetname'], GetTargetAddressLink($fleetRow, $FleetType));
			else
				$EventString = sprintf($LNG['cff_mission_target_mip'], $fleetRow['fleet_amount'], $this->BuildHostileFleetPlayerLink($fleetRow), $StartType, $fleetRow['own_planetname'], GetStartAddressLink($fleetRow, $FleetType), $TargetType, $fleetRow['target_planetname'], GetTargetAddressLink($fleetRow, $FleetType));
		} elseif ($MissionType == 11 || $MissionType == 15 || $MissionType == 18) {		
			if ($Status == FLEET_OUTWARD)
				$EventString = sprintf($LNG['cff_mission_own_expo_0'], $FleetContent, $StartType, $fleetRow['own_planetname'], GetStartAddressLink($fleetRow, $FleetType), GetTargetAddressLink($fleetRow, $FleetType), $FleetCapacity);
			elseif ($Status == FLEET_HOLD)
				$EventString = sprintf($LNG['cff_mission_own_expo_2'], $FleetContent, $StartType, $fleetRow['own_planetname'], GetStartAddressLink($fleetRow, $FleetType), GetTargetAddressLink($fleetRow, $FleetType), $FleetCapacity);
			else
				$EventString = sprintf($LNG['cff_mission_own_expo_1'], $FleetContent, GetTargetAddressLink($fleetRow, $FleetType), $StartType, $fleetRow['own_planetname'], GetStartAddressLink($fleetRow, $FleetType), $FleetCapacity);
		} else {
			if ($Owner == true) {
				if ($Status == FLEET_OUTWARD) {
					if (!$Owner && ($MissionType == 1 || $MissionType == 2))
						$Message  = $LNG['cff_mission_acs']	;
					else
						$Message  = $LNG['cff_mission_own_0'];
						
					$EventString  = sprintf($Message, $FleetContent, $StartType, $fleetRow['own_planetname'], GetStartAddressLink($fleetRow, $FleetType), $TargetType, $fleetRow['target_planetname'], GetTargetAddressLink($fleetRow, $FleetType), $FleetCapacity);
				} elseif($Status == FLEET_RETURN)
					$EventString  = sprintf($LNG['cff_mission_own_1'], $FleetContent, $TargetType, $fleetRow['target_planetname'], GetTargetAddressLink($fleetRow, $FleetType), $StartType, $fleetRow['own_planetname'], GetStartAddressLink($fleetRow, $FleetType), $FleetCapacity);
				else
					$EventString  = sprintf($LNG['cff_mission_own_2'], $FleetContent, $StartType, $fleetRow['own_planetname'], GetStartAddressLink($fleetRow, $FleetType), $TargetType, $fleetRow['target_planetname'], GetTargetAddressLink($fleetRow, $FleetType), $FleetCapacity);
			} else {
				if ($Status == FLEET_HOLD)
					$Message	= $LNG['cff_mission_target_stay'];
				elseif(in_array($MissionType, $GoodMissions))
					$Message	= $LNG['cff_mission_target_good'];
				else
					$Message	= $LNG['cff_mission_target_bad'];

				$EventString	= sprintf($Message, $FleetContent, $this->BuildHostileFleetPlayerLink($fleetRow), $StartType, $fleetRow['own_planetname'], GetStartAddressLink($fleetRow, $FleetType), $TargetType, $fleetRow['target_planetname'], GetTargetAddressLink($fleetRow, $FleetType), $FleetCapacity);
			}		       
		}
		$EventString = '<span class="'.$FleetStatus[$Status].' '.$FleetType.'">'.$EventString.'</span>';

		if ($Status == FLEET_OUTWARD)
			$Time = $fleetRow['fleet_start_time'];
		elseif ($Status == FLEET_RETURN)
			$Time = $fleetRow['fleet_end_time'];
		elseif ($Status == FLEET_HOLD)
			$Time = $fleetRow['fleet_end_stay'];
		else
			$Time = TIMESTAMP;
        
        $sql			= "SELECT * FROM %%USERS%% WHERE id = :userId;";
		$targetUser 	= database::get()->selectSingle($sql, array(
			':userId'	=> $this->userId
		));

		$Rest	= $Time - TIMESTAMP;
		$Rest1				= _date('H:i:s', TIMESTAMP + $Rest, $targetUser['timezone']);
		return array($Rest, $EventString, $Time, $Rest1);
	}

	private function BuildHostileFleetPlayerLink($fleetRow)
    {
		global $LNG;
		return $fleetRow['own_username'].' <a href="#" onclick="return Dialog.PM('.$fleetRow['fleet_owner'].')">'.$LNG['PM'].'</a>';
	}

	private function CreateFleetPopupedMissionLink($fleetRow, $Texte, $FleetType)
	{
		global $LNG, $THEME;
		$FleetTotalC  = $fleetRow['fleet_resource_metal'] + $fleetRow['fleet_resource_crystal'] + $fleetRow['fleet_resource_deuterium'] + $fleetRow['fleet_resource_darkmatter'];
		if ($FleetTotalC != 0)
		{
			$textForBlind = $LNG['tech'][900].': ';
			$textForBlind .= floatToString($fleetRow['fleet_resource_metal']).' '.$LNG['tech'][901];
			$textForBlind .= '; '.floatToString($fleetRow['fleet_resource_crystal']).' '.$LNG['tech'][902];
			$textForBlind .= '; '.floatToString($fleetRow['fleet_resource_deuterium']).' '.$LNG['tech'][903];
			if($fleetRow['fleet_resource_darkmatter'] > 0)
				$textForBlind .= '; '.floatToString($fleetRow['fleet_resource_darkmatter']).' '.$LNG['tech'][921];
			
			$FRessource   = '<table class=\'reducefleet_table\'>';
			$FRessource  .= '<tr><td <td class=\'reducefleet_img_res\'><img src=\''.$THEME->getTheme().'img/resources/901f.png\'></td><td class=\'reducefleet_name_ship\'>'.$LNG['tech'][901].' <span class=\'reducefleet_count_ship\'>'. pretty_number($fleetRow['fleet_resource_metal']).'</span></td></tr>';
			$FRessource  .= '<tr><td <td class=\'reducefleet_img_res\'><img src=\''.$THEME->getTheme().'img/resources/902f.png\'></td><td class=\'reducefleet_name_ship\'>'.$LNG['tech'][902].' <span class=\'reducefleet_count_ship\'>'. pretty_number($fleetRow['fleet_resource_crystal']).'</span></td></tr>';
			$FRessource  .= '<tr><td <td class=\'reducefleet_img_res\'><img src=\''.$THEME->getTheme().'img/resources/903f.png\'></td><td class=\'reducefleet_name_ship\'>'.$LNG['tech'][903].' <span class=\'reducefleet_count_ship\'>'. pretty_number($fleetRow['fleet_resource_deuterium']).'</span></td></tr>';
			if($fleetRow['fleet_resource_darkmatter'] > 0)
				$FRessource  .= '<tr><td <td class=\'reducefleet_img_res\'><img src=\''.$THEME->getTheme().'img/resources/921f.png\'></td><td class=\'reducefleet_name_ship\'>'.$LNG['tech'][921].' <span class=\'reducefleet_count_ship\'>'. pretty_number($fleetRow['fleet_resource_darkmatter']).'</span></td></tr>';
			$FRessource  .= '</table>';
			
			$MissionPopup  = '<a data-tooltip-content="'.$FRessource.'" class="tooltip '.$FleetType.'">'.$Texte.'</a>';
		}
		else
			$MissionPopup  = $Texte;

		return $MissionPopup;
	}

	private function CreateFleetPopupedFleetLink($fleetRow, $Text, $FleetType)
	{
		global $LNG, $USER, $resource, $THEME;
		$SpyTech		= $USER[$resource[106]];
		$Owner			= $fleetRow['fleet_owner'] == $this->userId;
		$FleetRec		= explode(';', $fleetRow['fleet_array']);
		$FleetPopup		= '<a href="#" data-tooltip-content="<table class=\'reducefleet_table\'>';
		$textForBlind	= '';
		if ($this->IsPhalanx || $SpyTech >= 4 || $Owner)
		{
			
			if($SpyTech < 8 && !$Owner)
			{
				$FleetPopup		.= '<tr><td style=\'width:100%;color:white\'>'.$LNG['cff_aproaching'].$fleetRow['fleet_amount'].$LNG['cff_ships'].':</td></tr>';
				$textForBlind	= $LNG['cff_aproaching'].$fleetRow['fleet_amount'].$LNG['cff_ships'].': ';
			}
			$shipsData	= array();
			foreach($FleetRec as $Item => $Group)
			{
				if (empty($Group))
					continue;
					
				$Ship    = explode(',', $Group);
				if($Owner) {
					$FleetPopup 	.= '<tr><td class=\'reducefleet_img_ship\'><img src=\''.$THEME->getTheme().'gebaeude/'.$Ship[0].'.gif\'></td><td class=\'reducefleet_name_ship\'>'.$LNG['tech'][$Ship[0]].': <span class=\'reducefleet_count_ship\'>'.pretty_number($Ship[1]).'</span></td></tr>';
					$shipsData[]	= floatToString($Ship[1]).' '.$LNG['tech'][$Ship[0]];
				} else {
					if($SpyTech >= 8)
					{
						$FleetPopup 	.= '<tr><td class=\'reducefleet_img_ship\'><img src=\''.$THEME->getTheme().'gebaeude/'.$Ship[0].'.gif\'></td><td class=\'reducefleet_name_ship\'>'.$LNG['tech'][$Ship[0]].': <span class=\'reducefleet_count_ship\'>'.pretty_number($Ship[1]).'</span></td></tr>';
						$shipsData[]	= floatToString($Ship[1]).' '.$LNG['tech'][$Ship[0]];
					}
					else
					{
						$FleetPopup		.= '<tr><td style=\'width:100%;color:white\'>'.$LNG['tech'][$Ship[0]].'</td></tr>';
						$shipsData[]	= $LNG['tech'][$Ship[0]];
					}
				}
			}
			
			$textForBlind	.= implode('; ', $shipsData);
		} else {
			$FleetPopup 	.= '<tr><td style=\'width:100%;color:white\'>'.$LNG['cff_no_fleet_data'].'</span></td></tr>';
			$textForBlind	= $LNG['cff_no_fleet_data'];
		}
		
		$FleetPopup  .= '</table>" class="tooltip '. $FleetType .'">'. $Text .'</a>';

		return $FleetPopup;
	}		
}
