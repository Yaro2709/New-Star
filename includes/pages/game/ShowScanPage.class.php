<?php

class ShowScanPage extends AbstractGamePage
{		
	function __construct() 
	{
		parent::__construct();		
	}
function Show()
	{		
		global $USER;
		$db = Database::get();		
		   $Alarm = $db->selectSingle("SELECT COUNT(`fleet_target_owner`) as nr
FROM uni".$USER['universe']."_fleets  WHERE `fleet_target_owner` = '". $USER['id'] ."' AND (`fleet_mission` = '1' OR `fleet_mission` = '2' OR `fleet_mission` = '9') AND `fleet_mess` ='0';");
          echo $Alarm['nr'];
		  exit;
}
}
