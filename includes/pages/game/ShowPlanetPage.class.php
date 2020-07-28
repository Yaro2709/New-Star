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

class ShowPlanetPage extends AbstractGamePage
{
	public static $requireModule = MODULE_PLANET;
	
	function __construct() 
	{
		parent::__construct();
	}
	
	function coord() 
	{
		global $LNG, $PLANET, $USER;

		$galaxyr        = HTTP::_GP('galaxyt', $PLANET['galaxy']);
		$systemr        = HTTP::_GP('systemt', $PLANET['system']);
		$planetsr       = HTTP::_GP('planetst', $PLANET['planet']);
		$galaxy1        = $PLANET['galaxy'];
		$system1        = $PLANET['system'];
		$planet1        = $PLANET['planet'];
		$fleetPlanet    = 0;
		$fleetMoon      = 0;

		$planetData	= array();
		require 'includes/vars/PlanetData.php';

		$config		= Config::get(Universe::current());

		$dataIndex		= (int) ceil($planetsr / ($config->max_planets / count($planetData)));   
        $maxTemperature	= $planetData[$dataIndex]['temp'];
		$minTemperature	= $maxTemperature - 40;
		
		$cost_tp 		= 1000 * abs($system1 - $systemr) + 15000 * abs($galaxy1 - $galaxyr) + 2500 * abs($planet1 - $planetsr);
		$checkPosition	= PlayerUtil::checkPosition(Universe::current(), $galaxyr,$systemr, $planetsr);
		$isPositionFree	= PlayerUtil::isPositionFree(Universe::current(), $galaxyr,$systemr, $planetsr);	
		
		$sql	= 'SELECT COUNT(*) as count
		FROM %%FLEETS%%
		WHERE (fleet_start_id = :planetId AND fleet_universe = :fleetUni AND fleet_mission != :fleet_mission) OR (`fleet_end_id` = :planetId AND fleet_universe = :fleetUni AND fleet_mission != :fleet_mission) OR (`fleet_start_id` = :planetId AND fleet_universe = :fleetUni AND fleet_mission = :fleet_mission AND fleet_owner = :fleet_owner)' ;

		$fleetPlanet	= Database::get()->selectSingle($sql, array(
			':planetId'			=> $PLANET['id'],
			':fleetUni'			=> Universe::current(),
			':fleet_mission'	=> 8,
			':fleet_owner'		=> $USER['id']
		), 'count' );
		
		if($PLANET['id_luna'] != 0){
			$sql	= 'SELECT COUNT(*) as count
			FROM %%FLEETS%%
			WHERE (fleet_start_id = :planetId AND fleet_universe = :fleetUni) OR (`fleet_end_id` = :planetId AND fleet_universe = :fleetUni)' ;

			$fleetMoon	= Database::get()->selectSingle($sql, array(
				':planetId'	=> $PLANET['id_luna'],
				':fleetUni'	=> Universe::current()
			), 'count' );
		}
		
		if($USER['darkmatter'] < $cost_tp){
			$this->printMessage($LNG['pla_notenogu'], true, array('game.php?page=planet', 2));
		}elseif($fleetPlanet > 0 || $fleetMoon > 0){
			$this->printMessage($LNG['pla_tel_fleet'], true, array('game.php?page=planet', 2));
		}elseif($PLANET['planet_type'] == 3){
			$this->printMessage($LNG['pla_no_planet'], true, array('game.php?page=planet', 2));
		}elseif(empty($galaxyr) || empty($systemr) || empty($planetsr)){
			$this->printMessage($LNG['pla_tel_busy'],true, array('game.php?page=planet', 2));
		}elseif($galaxyr < 0 || $systemr < 0 || $planetsr < 0){
			$this->printMessage($LNG['pla_tel_busy'], true, array('game.php?page=planet', 2));
		}elseif($galaxyr > Config::get()->max_galaxy || $systemr > Config::get()->max_system || $planetsr > Config::get()->max_planets){
			$this->printMessage($LNG['pla_tel_busy'], true, array('game.php?page=planet', 2));
		}elseif(!$isPositionFree || !$checkPosition){
			$this->printMessage($LNG['pla_tel_busy'], true, array('game.php?page=planet', 2));
		}elseif($PLANET['last_relocate'] + 259200 > TIMESTAMP && $systemr != $PLANET['system'] || $PLANET['last_relocate'] + 259200 > TIMESTAMP && $galaxyr != $PLANET['galaxy'] ){
			$this->printMessage($LNG['pla_reactor'], true, array('game.php?page=planet', 2));
		}else{
			$sql	= "UPDATE %%PLANETS%% SET last_relocate = :timeStamp WHERE id = :planetId AND universe = :Universe;";
			Database::get()->update($sql, array(
				':timeStamp'		=> TIMESTAMP,
				':planetId'       	=> $PLANET['id'],
				':Universe'       	=> Universe::current()
			));
			$sql	= "UPDATE %%PLANETS%% SET galaxy = :galaxy, system = :system, planet = :planet, temp_min = :temp_min, temp_max = :temp_max WHERE id = :planetId AND universe = :Universe;";
			Database::get()->update($sql, array(
				':galaxy'			=> $galaxyr,
				':system'			=> $systemr,
				':planet'       	=> $planetsr,
				':planetId'       	=> $PLANET['id'],
				':temp_min'       	=> $minTemperature,
				':temp_max'       	=> $maxTemperature,
				':Universe'       	=> Universe::current()
			));
			
			if(!empty($PLANET['id_luna'])){
				$sql	= 'SELECT *
				FROM %%PLANETS%%
				WHERE id = :lunaId AND planet_type = :planetType AND universe = :fleetUni' ;
				$moonData	= Database::get()->selectSingle($sql, array(
					':lunaId'		=> $PLANET['id_luna'],
					':planetType'	=> 3,
					':fleetUni'		=> Universe::current()
				));

				$sql	= "UPDATE %%PLANETS%% SET last_relocate = :timeStamp, galaxy = :galaxy, system = :system, planet = :planet, temp_min = :minTemperature, temp_max = :maxTemperature WHERE id = :lunaId AND universe = :Universe;";
				Database::get()->update($sql, array(
					':timeStamp'		=> TIMESTAMP,
					':galaxy'			=> $galaxyr,
					':system'			=> $systemr,
					':planet'       	=> $planetsr,
					':minTemperature'	=> $minTemperature,
					':maxTemperature'	=> $maxTemperature,
					':lunaId'       	=> $moonData['id'],
					
					':Universe'       	=> Universe::current()
				));
				$sql	= "UPDATE %%PLANETS%% SET last_relocate = :timeStamp WHERE id = :lunaId AND universe = :Universe;";
				Database::get()->update($sql, array(
					':timeStamp'		=> TIMESTAMP,
					':lunaId'       	=> $PLANET['id_luna'],
					':Universe'       	=> Universe::current()
				));
			}
			if($USER['id_planet'] == $PLANET['id']){
				$sql	= "UPDATE %%USERS%% SET galaxy = :galaxy, system = :system, planet = :planet WHERE id = :userId AND universe = :Universe;";
				Database::get()->update($sql, array(
					':galaxy'			=> $galaxyr,
					':system'			=> $systemr,
					':planet'       	=> $planetsr,
					':userId'       	=> $USER['id'],
					':Universe'       	=> Universe::current()
				));
			}
			$USER['darkmatter'] -= $cost_tp;
				
			$this->printMessage($LNG['pla_tel_ok'], true, array('game.php?page=planet', 2));
		}	
	}  
    
    function field() 
	{
		global $LNG, $PLANET, $USER;
			
		$totalFields    = HTTP::_GP('filds', 0);
		$cost_i 		= 0;
		$cost 			= 0;

		for($i = 0; $i < $totalFields; $i++){
			$cost_i 	= round(200 * pow(1.1,$PLANET['field_purchased'] + $i));
			$cost 		= $cost + $cost_i;
		}
		
		if($totalFields < 0){
			$this->printMessage($LNG['pla_error'], true, array('game.php?page=planet', 3));
		}elseif($USER['darkmatter'] < $cost){
			$this->printMessage($LNG['pla_notenogu'], true, array('game.php?page=planet', 2));
		}else{
			$db = Database::get();
			$sql = "UPDATE %%PLANETS%% SET field_max = field_max + :field_max WHERE id = :planetID;";
			$db->update($sql, array(
				':field_max'  	=> $totalFields,
				':planetID' 	=> $PLANET['id']
			));
			$sql = "UPDATE %%PLANETS%% SET field_purchased = field_purchased + :field_purchased WHERE id = :planetOwner;";
			$db->update($sql, array(
				':field_purchased'  		=> $totalFields,
				':planetOwner' 	=> $PLANET['id']
			));
			$USER['darkmatter'] -= $cost;

			$this->printMessage($LNG['pla_added'], true, array('game.php?page=planet', 2));
		}
	}
    
    function diameter() 
	{
		global $LNG, $PLANET, $USER;
			
		$totalDiameter    = HTTP::_GP('diameters', 0);
		$cost_i 		= 0;
		$cost 			= 0;

		for($i = 0; $i < $totalDiameter; $i++){
			$cost_i 	= round(20000 * pow(1.31,$PLANET['diameter_purchased'] + $i));
			$cost 		= $cost + $cost_i;
		}
		
		if($totalDiameter < 0){
			$this->printMessage($LNG['pla_error'], true, array('game.php?page=planet', 3));
		}elseif($USER['darkmatter'] < $cost){
			$this->printMessage($LNG['pla_notenogu'], true, array('game.php?page=planet', 2));
		}else{
			$db = Database::get();
			$sql = "UPDATE %%PLANETS%% SET diameter = diameter + :diameter WHERE id = :planetID;";
			$db->update($sql, array(
				':diameter'  	=> $totalDiameter,
				':planetID' 	=> $PLANET['id']
			));
			$sql = "UPDATE %%PLANETS%% SET diameter_purchased = diameter_purchased + :diameter_purchased WHERE id = :planetOwner;";
			$db->update($sql, array(
				':diameter_purchased'  		=> $totalDiameter,
				':planetOwner' 	=> $PLANET['id']
			));
			$USER['darkmatter'] -= $cost;

			$this->printMessage($LNG['pla_added'], true, array('game.php?page=planet', 2));
		}
	}
    
    function GenerateName() 
	{
		global $LNG, $PLANET;

		$Names		= file('botnames.txt');
		$NamesCount	= count($Names);
		$Rand		= mt_rand(0, $NamesCount);
		$UserName 	= trim($Names[$Rand]);
		
		$this->sendJSON(array('message' => $UserName));
	}
	
	function show()
	{
		global $USER, $PLANET, $LNG;
        
		$this->tplObj->loadscript("planet.js");
		$this->tplObj->loadscript("overview.actions.js");
		$this->tplObj->assign_vars(array(
            //Общее
		    'planet_type'           => $PLANET['planet_type'],
			'planetImage'           => $PLANET['image'],
            //Телепорт
            'last_relocate' 		=> $PLANET['last_relocate'] + 259200,
			'last_relocate_next' 	=> date('d.m.Y H:i:s', $PLANET['last_relocate'] + 259200),
            'tGalaxy' 				=> $PLANET['galaxy'],
			'tSystem' 				=> $PLANET['system'],
			'tPlanet' 				=> $PLANET['planet'],
            //Покупка полей
            'field_max'             => $PLANET['field_max'],
            'type_fields' 			=> 200,
            'power_fields' 			=> 1.1,
            'purchased_fields' 		=> $PLANET['field_purchased'],
            //Диаметр
            'diameter'              => $PLANET['diameter'],
            'type_diameters' 		=> 20000,
            'power_diameters' 		=> 1.31,
            'purchased_diameters' 	=> $PLANET['diameter_purchased'],
            //Удаление планеты
			'ov_security_confirm'	=> sprintf($LNG['ov_security_confirm'], $PLANET['name'].' ['.$PLANET['galaxy'].':'.$PLANET['system'].':'.$PLANET['planet'].']'),
		));
		
		$this->display('page.planet.default.tpl');
	
	}
}