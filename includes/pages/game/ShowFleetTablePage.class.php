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

class ShowFleetTablePage extends AbstractGamePage
{
	public static $requireModule = MODULE_FLEET_TABLE;

	function __construct() 
	{
		parent::__construct();
	}
	
	public function createACS($fleetID, $fleetData) {
		global $USER;
		
		$rand 			= mt_rand(100000, 999999999);
		$acsName	 	= 'AG'.$rand;
		$acsCreator		= $USER['id'];

        $db = Database::get();
        $sql = "INSERT INTO %%AKS%% SET name = :acsName, ankunft = :time, target = :target;";
        $db->insert($sql, array(
            ':acsName'	=> $acsName,
            ':time'		=> $fleetData['fleet_start_time'],
			':target'	=> $fleetData['fleet_end_id']
        ));

        $acsID	= $db->lastInsertId();

        $sql = "INSERT INTO %%USERS_ACS%% SET acsID = :acsID, userID = :userID;";
        $db->insert($sql, array(
            ':acsID'	=> $acsID,
            ':userID'	=> $acsCreator
        ));

        $sql = "UPDATE %%FLEETS%% SET fleet_group = :acsID WHERE fleet_id = :fleetID;";
        $db->update($sql, array(
            ':acsID'	=> $acsID,
            ':fleetID'	=> $fleetID
        ));

		return array(
			'name' 			=> $acsName,
			'id' 			=> $acsID,
		);
	}
	
	public function loadACS($fleetData) {
		global $USER;
		
		$db = Database::get();
        $sql = "SELECT id, name FROM %%USERS_ACS%% INNER JOIN %%AKS%% ON acsID = id WHERE userID = :userID AND acsID = :acsID;";
        $acsResult = $db->selectSingle($sql, array(
            ':userID'   => $USER['id'],
            ':acsID'    => $fleetData['fleet_group']
        ));

		return $acsResult;
	}
	
	public function getACSPageData($fleetID)
	{
		global $USER, $LNG;
		
		$db = Database::get();

        $sql = "SELECT fleet_start_time, fleet_end_id, fleet_group, fleet_mess FROM %%FLEETS%% WHERE fleet_id = :fleetID;";
        $fleetData = $db->selectSingle($sql, array(
            ':fleetID'  => $fleetID
        ));

        if ($db->rowCount() != 1)
			return array();

		if ($fleetData['fleet_mess'] == 1 || $fleetData['fleet_start_time'] <= TIMESTAMP)
			return array();
				
		if ($fleetData['fleet_group'] == 0)
			$acsData	= $this->createACS($fleetID, $fleetData);
		else
			$acsData	= $this->loadACS($fleetData);
	
		if (empty($acsData))
			return array();
			
		$acsName	= HTTP::_GP('acsName', '', UTF8_SUPPORT);
		if(!empty($acsName)) {
			if(!PlayerUtil::isNameValid($acsName))
			{
				$this->sendJSON($LNG['fl_acs_newname_alphanum']);
			}
			
			$sql = "UPDATE %%AKS%% SET name = :acsName WHERE id = :acsID;";
            $db->update($sql, array(
                ':acsName'  => $acsName,
                ':acsID'    => $acsData['id']
            ));
            $this->sendJSON(false);
		}
		
		$invitedUsers	= array();

        $sql = "SELECT id, username FROM %%USERS_ACS%% INNER JOIN %%USERS%% ON userID = id WHERE acsID = :acsID;";
        $userResult = $db->select($sql, array(
            ':acsID'    => $acsData['id']
        ));

        foreach($userResult as $userRow)
		{
			$invitedUsers[$userRow['id']]	= $userRow['username'];
		}

		$newUser		= HTTP::_GP('username', '', UTF8_SUPPORT);
		$statusMessage	= "";
		if(!empty($newUser))
		{
			$sql = "SELECT id FROM %%USERS%% WHERE universe = :universe AND username = :username;";
            $newUserID = $db->selectSingle($sql, array(
                ':universe' => Universe::current(),
                ':username' => $newUser
            ), 'id');

            if(empty($newUserID)) {
				$statusMessage			= $LNG['fl_player']." ".$newUser." ".$LNG['fl_dont_exist'];
			} elseif(isset($invitedUsers[$newUserID])) {
				$statusMessage			= $LNG['fl_player']." ".$newUser." ".$LNG['fl_already_invited'];
			} else {
				$statusMessage			= $LNG['fl_player']." ".$newUser." ".$LNG['fl_add_to_attack'];
				
				$sql = "INSERT INTO %%USERS_ACS%% SET acsID = :acsID, userID = :newUserID;";
                $db->insert($sql, array(
                    ':acsID'        => $acsData['id'],
                    ':newUserID'    => $newUserID
                ));

                $invitedUsers[$newUserID]	= $newUser;
				
				// get target player language while sending ACS invite instead of attack owner.
				$GetTargetLang			= getLanguage(null, $newUserID);
				$inviteTitle			= $GetTargetLang['fl_acs_invitation_title'];
				$inviteMessage 			= $GetTargetLang['fl_player'] . $USER['username'] . $GetTargetLang['fl_acs_invitation_message'];
				PlayerUtil::sendMessage($newUserID, $USER['id'], $USER['username'], 1, $inviteTitle, $inviteMessage, TIMESTAMP);
			}
		}
		
		return array(
			'invitedUsers'	=> $invitedUsers,
			'acsName'		=> $acsData['name'],
			'mainFleetID'	=> $fleetID,
			'statusMessage'	=> $statusMessage,
		);
	}

	public function delgroop()
	{
		global $USER, $LNG;
		
		$id	= HTTP::_GP('id', 0);

		$fleet_groop = array();
		$USER_SETING	= $GLOBALS['DATABASE']->uniquequery("SELECT fleet_groop FROM ".USERS." WHERE id = ".$USER["id"].";");
						
		if(!empty($USER_SETING['fleet_groop']))
			$fleet_groop = unserialize($USER_SETING['fleet_groop']);
		
		$cnt = 0; 
		foreach($fleet_groop as $key => $Row) 
		{ 
			if ($cnt == $id) 
			{
				$name = $Row[0];
				unset($fleet_groop[$key]);
				break;
			}
			$cnt ++;
		} 
		
		if(!empty($name))	
		{			
			if(empty($fleet_groop))
				$fleet_groop_text = '';
			else
				$fleet_groop_text = serialize($fleet_groop);
		
			$GLOBALS['DATABASE']->query("UPDATE ".USERS." SET fleet_groop = '".$fleet_groop_text."' WHERE `id` = ".$USER["id"].";");	
			
			$this->printMessage(sprintf($LNG['fl_del_groop_mes'], $name),true, array("game.php?page=fleetTable", 3));			
		}else	
            $this->printMessage($LNG['fl_no_del_groop_mes'],true, array("game.php?page=fleetTable", 3));
	}
		
	public function show()
	{
		global $USER, $PLANET, $reslist, $pricelist, $resource, $LNG;
		
		$acsData			= array();
		$parse				= $LNG;
		$FleetID			= HTTP::_GP('fleetID', 0);
		$GetAction			= HTTP::_GP('action', "");
		$Code				= HTTP::_GP('code', 0);
		$TheCommand			= HTTP::_GP('cmd', '');
		$this->tplObj->loadscript('galaxy.js');
		$this->tplObj->loadscript('pointes.js');
		$this->tplObj->loadscript('flotten.js');
        $this->tplObj->loadscript('fleetTable.js');
        
        $db = Database::get();

		if($Code >2)
			$this->printMessage($LNG['fl_send_error'][$Code],true, array("game.php?page=fleetTable", 3));
		
		if(!empty($FleetID) && !IsVacationMode($USER))
		{
			switch($GetAction){
				case "sendfleetback":
					FleetFunctions::SendFleetBack($USER, $FleetID);
				break;
				case "acs":
					$acsData	= $this->getACSPageData($FleetID);
				break;
			}
		}
		
		if(!empty($TheCommand) && $_SERVER['REQUEST_METHOD'] === 'POST')
	    {
	        switch($TheCommand)
				{
					case '1':
						$this->go_expeditions();
					break;
					case '2':
						$this->go_hostail();
					break;
				}
			$this->redirectTo('game.php?page=fleetTable');
		}
		
		$techExpedition      = $USER[$resource[124]];

		if ($techExpedition >= 1)
		{
			$activeExpedition   = FleetFunctions::GetCurrentFleets($USER['id'], 15, true);
            $activeExpedition  += FleetFunctions::GetCurrentFleets($USER['id'], 18, true);
			$maxExpedition 		= floor(sqrt($techExpedition));
		}
		else
		{
			$activeExpedition 	= 0;
			$maxExpedition 		= 0;
		}
		
		$maxFleetSlots	= FleetFunctions::GetMaxFleetSlots($USER);

		$targetGalaxy	    = HTTP::_GP('galaxy', (int) $PLANET['galaxy']);
		$targetSystem	    = HTTP::_GP('system', (int) $PLANET['system']);
		$targetPlanet	    = HTTP::_GP('planet', (int) $PLANET['planet']);
		$targetType		    = HTTP::_GP('planettype', (int) $PLANET['planet_type']);
		$targetMission	    = HTTP::_GP('target_mission', 0);
		
		$sql = "SELECT * FROM %%FLEETS%% WHERE fleet_owner = :userID AND fleet_mission <> 10 ORDER BY fleet_end_time ASC;";
        $fleetResult = $db->select($sql, array(
            ':userID'   => $USER['id']
        ));

        $activeFleetSlots	= $db->rowCount();

		$FlyingFleetList	= array();
		
		foreach ($fleetResult as $fleetsRow)
		{
			$fleet = explode(";", $fleetsRow['fleet_array']);

            $FleetList  = array();

			foreach ($fleet as $shipDetail)
			{
				if (empty($shipDetail))
					continue;

				$ship = explode(",", $shipDetail);
				
				$FleetList[$fleetsRow['fleet_id']][$ship[0]] = $ship[1];
			}
			
			if($fleetsRow['fleet_mission'] == 4 && $fleetsRow['fleet_mess'] == FLEET_OUTWARD){
				$returnTime	= $fleetsRow['fleet_start_time'];
			}else{
				$returnTime	= $fleetsRow['fleet_end_time'];
			}
			
			$FlyingFleetList[]	= array(
				'id'			=> $fleetsRow['fleet_id'],
				'mission'		=> $fleetsRow['fleet_mission'],
				'state'			=> $fleetsRow['fleet_mess'],
				'startGalaxy'	=> $fleetsRow['fleet_start_galaxy'],
				'startSystem'	=> $fleetsRow['fleet_start_system'],
				'startPlanet'	=> $fleetsRow['fleet_start_planet'],
				'startTime'		=> _date($LNG['php_tdformat'], $fleetsRow['fleet_start_time'], $USER['timezone']),
				'endGalaxy'		=> $fleetsRow['fleet_end_galaxy'],
				'endSystem'		=> $fleetsRow['fleet_end_system'],
				'endPlanet'		=> $fleetsRow['fleet_end_planet'],
				'endTime'		=> _date($LNG['php_tdformat'], $fleetsRow['fleet_end_time'], $USER['timezone']),
				'amount'		=> pretty_number($fleetsRow['fleet_amount']),
				'returntime'	=> $returnTime,
				'resttime'		=> $returnTime - TIMESTAMP,
				'backin'		=> pretty_time(floor(($fleetsRow['fleet_mission'] == 4 ? $fleetsRow['fleet_start_time'] : $fleetsRow['fleet_end_time']) - TIMESTAMP)),
				'FleetList'		=> $FleetList[$fleetsRow['fleet_id']],
			);
		}
		
		$elem[1] = $reslist['tablefleet_combat'];	
		$elem[2] = $reslist['tablefleet_transport'];
		$elem[3] = $reslist['tablefleet_recyclers'];
		$elem[4] = $reslist['tablefleet_special'];
		
		$pointsPrice	= array();
		$FleetsOnPlanet	= array();
		$elementList 	= array();
		$elementListM	= array();
		$elementListP	= array();
		$elementListO	= array();
		$elementListD	= array();

		foreach($reslist['fleet'] as $FleetID)
		{
			if ($PLANET[$resource[$FleetID]] == 0)
				continue;
			
			$FleetsOnPlanet[]	= array(
					'id'	=> $FleetID,
					'speed'	=> FleetFunctions::GetFleetMaxSpeed($FleetID, $USER),
					'count'	=> $PLANET[$resource[$FleetID]],
				);
            $resourcesPoints = BuildFunctions::resourcesPoints($USER, $FleetID);
            $pointsPrice['ship'.$FleetID] = ($resourcesPoints) /  Config::get()->stat_settings;
			if(in_array($FleetID, $elem[1]))
			{
				$elementListM[$FleetID]	= array(
					'name'	=> '<div class="gray_ship2">'.$LNG['fl_grop_1'].'       
                                    <a href="javascript:maxShipsBatle();" class="fl_max_ships">Max</a>		 
                                    <a href="javascript:noShipsBatle();" class="fl_min_ships">Min</a>
                                </div>',
					'id'	=> $FleetID,
					'speed'	=> FleetFunctions::GetFleetMaxSpeed($FleetID, $USER),
					'count'	=> $PLANET[$resource[$FleetID]],
				);
			}
			elseif(in_array($FleetID, $elem[2]))
			{
				$elementListP[$FleetID]	= array(
					'name'	=> '<div class="gray_ship2">'.$LNG['fl_grop_2'].'   
                                    <a href="javascript:maxShipsTransports();" class="fl_max_ships">Max</a>		 
                                    <a href="javascript:noShipsTransports();" class="fl_min_ships">Min</a>
                                </div>',
					'id'	=> $FleetID,
					'speed'	=> FleetFunctions::GetFleetMaxSpeed($FleetID, $USER),
					'count'	=> $PLANET[$resource[$FleetID]],
				);
			}
			elseif(in_array($FleetID, $elem[3]))
			{
				$elementListO[$FleetID]	= array(
					'name'	=> '<div class="gray_ship2">'.$LNG['fl_grop_3'].'       
                                    <a href="javascript:maxShipsProcessors();" class="fl_max_ships">Max</a>		 
                                    <a href="javascript:noShipsProcessors();" class="fl_min_ships">Min</a>
                                </div>',
					'id'	=> $FleetID,
					'speed'	=> FleetFunctions::GetFleetMaxSpeed($FleetID, $USER),
					'count'	=> $PLANET[$resource[$FleetID]],
				);
			}
			elseif(in_array($FleetID, $elem[4]))
			{
				$elementListD[$FleetID]	= array(
					'name'	=> '<div class="gray_ship2">'.$LNG['fl_grop_4'].'       
                                    <a href="javascript:maxShipsSpecial();" class="fl_max_ships">Max</a>		 
                                    <a href="javascript:noShipsSpecial();" class="fl_min_ships">Min</a>
                                </div>',
					'id'	=> $FleetID,
					'speed'	=> FleetFunctions::GetFleetMaxSpeed($FleetID, $USER),
					'count'	=> $PLANET[$resource[$FleetID]],
				);
			}
			else
			{
				$elementList[$FleetID]	= array(
					'name'	=> '',
					'id'	=> $FleetID,
					'speed'	=> FleetFunctions::GetFleetMaxSpeed($FleetID, $USER),
					'count'	=> $PLANET[$resource[$FleetID]],
				);
			}
		}
		
		$fleet_groop = array();
					
		if(!empty($USER['fleet_groop']))
			$fleet_groop = unserialize($USER['fleet_groop']);
		
		$fleetGroopShip = array();
		$fleetGroopName = array();
		
		foreach ($fleet_groop as $Row)
		{
			$fleetGroopShip[] = $Row[1];
			$fleetGroopName[] = $Row[0];
		}
		
		$this->assign(array(
		    'acsData'				=> $acsData,
			'FleetsOnPlanet'		=> $FleetsOnPlanet,
			'elementList'			=> $elementList,
			'elementListM'			=> $elementListM,
			'elementListP'			=> $elementListP,
			'elementListO'			=> $elementListO,
			'elementListD'			=> $elementListD,
			'FlyingFleetList'		=> $FlyingFleetList,
			'activeExpedition'		=> $activeExpedition,
			'maxExpedition'			=> $maxExpedition,
			'activeFleetSlots'		=> $activeFleetSlots,
			'maxFleetSlots'			=> $maxFleetSlots,
			'targetGalaxy'			=> $targetGalaxy,
			'targetSystem'			=> $targetSystem,
			'targetPlanet'			=> $targetPlanet,
			'targetType'			=> $targetType,
			'targetMission'			=> $targetMission,
			'fleetGroopShip'		=> $fleetGroopShip,
			'fleetGroopName'		=> $fleetGroopName,
			'isVacation'			=> IsVacationMode($USER),
			'pointsPrice'           => $pointsPrice,
            'mission'				=> HTTP::_GP('target_mission', 0),
		));
		
		$this->display('page.fleetTable.default.tpl');
	}
}
?>