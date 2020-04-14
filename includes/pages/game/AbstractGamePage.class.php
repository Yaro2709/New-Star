<?php

/**
 *  2Moons 
 *   by Jan-Otto Kröpke 2009-2016
 *
 * For the full copyright and license information, please view the LICENSE
 *
 * @package 2Moons
 * @author Jan-Otto Kröpke <slaver7@gmail.com>
 * @copyright 2009 Lucky
 * @copyright 2016 Jan-Otto Kröpke <slaver7@gmail.com>
 * @licence MIT
 * @version 1.8.0
 * @link https://github.com/jkroepke/2Moons
 */

abstract class AbstractGamePage
{
	/**
	 * reference of the template object
	 * @var template
	 */
	protected $tplObj;

	/**
	 * reference of the template object
	 * @var ResourceUpdate
	 */
	protected $ecoObj;
	protected $window;
	protected $disableEcoSystem = false;

	protected function __construct() {

		if(!AJAX_REQUEST)
		{
			$this->setWindow('full');
			if(!$this->disableEcoSystem)
			{
				$this->ecoObj	= new ResourceUpdate();
				$this->ecoObj->CalcResource();
			}
			$this->initTemplate();
		} else {
			$this->setWindow('ajax');
		}
	}

	protected function initTemplate() {
		if(isset($this->tplObj))
			return true;

		$this->tplObj	= new template;
		list($tplDir)	= $this->tplObj->getTemplateDir();
		$this->tplObj->setTemplateDir($tplDir.'game/');
		return true;
	}

	protected function setWindow($window) {
		$this->window	= $window;
	}

	protected function getWindow() {
		return $this->window;
	}

	protected function getQueryString() {
		$queryString	= array();
		$page			= HTTP::_GP('page', '');

		if(!empty($page)) {
			$queryString['page']	= $page;
		}

		$mode			= HTTP::_GP('mode', '');
		if(!empty($mode)) {
			$queryString['mode']	= $mode;
		}

		return http_build_query($queryString);
	}

	protected function getCronjobsTodo()
	{
		require_once 'includes/classes/Cronjob.class.php';

		$this->assign(array(
			'cronjobs'		=> Cronjob::getNeedTodoExecutedJobs()
		));
	}

	protected function getNavigationData()
	{
		global $PLANET, $LNG, $USER, $THEME, $resource, $reslist;

		$config			= Config::get();
        
        //PlanetSelect
		$PlanetSelect	= array();
		
		$USER['PLANETSHIDDEN']	= getPlanetsHIDDEN($USER);
		
		foreach($USER['PLANETSHIDDEN'] as $PlanetQuery)
		{
			$PlanetSelect['?'.$this->getQueryString().'&cp='.$PlanetQuery['id']]	= $PlanetQuery['name'].(($PlanetQuery['planet_type'] == 3) ? " (" . $LNG['fcm_moon'] . ")":"")." [".$PlanetQuery['galaxy'].":".$PlanetQuery['system'].":".$PlanetQuery['planet']."]";
		}
		
		$PlanetListing	= array();
		$buildInfo	= array();
		
		if(isset($USER['PLANETS'])) {
			$USER['PLANETS']	= getPlanets($USER);
		}
		foreach($USER['PLANETS'] as $PlanetQuery)
		{
			//Видимость построек
            if ($PlanetQuery['b_building'] - TIMESTAMP > 0) {
                $Queue			= unserialize($PlanetQuery['b_building_id']);
                $buildInfo['buildings']	= array(
                    'id'		=> $Queue[0][0],
                    'level'		=> $Queue[0][1],
                    'timeleft'	=> $PlanetQuery['b_building'] - TIMESTAMP,
                    'time'		=> $PlanetQuery['b_building'],
                    'starttime'	=> pretty_time($PlanetQuery['b_building'] - TIMESTAMP),
                );
            }else{
                $buildInfo['buildings']	= false;
            }
            //Видимость флота и обороны
            if (!empty($PlanetQuery['b_hangar_id'])) {
                $Queue	= unserialize($PlanetQuery['b_hangar_id']);
                $time	= BuildFunctions::getBuildingTime($USER, $PlanetQuery, $Queue[0][0]) * $Queue[0][1];
                $buildInfo['fleet']	= array(
                    'id'		=> $Queue[0][0],
                    'level'		=> $Queue[0][1],
                    'timeleft'	=> $time - $PlanetQuery['b_hangar'],
                    'time'		=> $time,
                    'starttime'	=> pretty_time($time - $PlanetQuery['b_hangar']),
                );
            }else{
			$buildInfo['fleet']	= false;
            }
            //Видимость исследований
            if ($USER['b_tech'] - TIMESTAMP > 0) {
                $Queue			= unserialize($USER['b_tech_queue']);
                $buildInfo['tech']	= array(
                    'id'		=> $Queue[0][0],
                    'level'		=> $Queue[0][1],
                    'timeleft'	=> $USER['b_tech'] - TIMESTAMP,
                    'time'		=> $USER['b_tech'],
                    'starttime'	=> pretty_time($USER['b_tech'] - TIMESTAMP),
                );
            }else{
                $buildInfo['tech']	= false;
            }
            //Видимость атак на планету
            $totalAttacks       = 0;
            $sql	            = 'SELECT COUNT(fleet_id) as fleet_id FROM %%FLEETS%% WHERE fleet_target_owner = :userId AND fleet_mission = :missionID AND fleet_mess = :mesID AND     fleet_end_id = :fleet_end_id;';
            $totalAttacks	    = Database::get()->selectSingle($sql, array(
                ':userId'	        => $USER['id'],
                ':missionID'	    => 1,
                ':mesID'	        => 0,
                ':fleet_end_id'	    => $PlanetQuery['id']
            ), 'fleet_id');
        
            if($totalAttacks != 0){
                $totalAttacks = $totalAttacks;	
            }
            //Видимость ракетных атак на планету
            $totalRockets       = 0;
            $sql	            = 'SELECT COUNT(fleet_id) as fleet_id FROM %%FLEETS%% WHERE fleet_target_owner = :userId AND fleet_mission = :missionID AND fleet_mess = :mesID AND fleet_end_id = :fleet_end_id;';
            $totalRockets	    = Database::get()->selectSingle($sql, array(
                ':userId'	        => $USER['id'],
                ':missionID'	    => 10,
                ':mesID'	        => 0,
                ':fleet_end_id' 	=> $PlanetQuery['id']
            ), 'fleet_id');
        
            if($totalRockets != 0){
                $totalRockets = $totalRockets;	
            }
            //Видимость шпионажа на планету
            $totalSpio          = 0;
            $sql	            = 'SELECT COUNT(fleet_id) as fleet_id FROM %%FLEETS%% WHERE fleet_target_owner = :userId AND fleet_mission = :missionID AND fleet_mess = :mesID AND fleet_end_id = :fleet_end_id;';
            $totalSpio	        = Database::get()->selectSingle($sql, array(
                ':userId'	        => $USER['id'],
                ':missionID'	    => 6,
                ':mesID'	        => 0,
                ':fleet_end_id'	    => $PlanetQuery['id']
            ), 'fleet_id');
        
            if($totalSpio != 0){
                $totalSpio = $totalSpio;	
            }
            //Видимость действий на луну
            $totalAttackLuna = 0;
            $totalRocketsLuna = 0;
            $totalSpioLuna = 0;
		
            if($PlanetQuery['id_luna'] != 0){
			//Видимость атак на луну
                $totalAttackLuna    = 0;
                $sql	            = 'SELECT COUNT(fleet_id) as fleet_id FROM %%FLEETS%% WHERE fleet_target_owner = :userId AND fleet_mission = :missionID AND fleet_mess = :mesID AND fleet_end_id = :fleet_end_id;';
                $totalAttackLuna    = Database::get()->selectSingle($sql, array(
                    ':userId'	        => $USER['id'],
                    ':missionID'	    => 1,
                    ':mesID'	        => 0,
                    ':fleet_end_id'	    => $PlanetQuery['id_luna']
                ), 'fleet_id');
            
                if($totalAttackLuna != 0){
                    $totalAttackLuna = $totalAttackLuna;	
                }
                //Видимость ракетных атак на луну
                $totalRocketsLuna   = 0;
                $sql	            = 'SELECT COUNT(fleet_id) as fleet_id FROM %%FLEETS%% WHERE fleet_target_owner = :userId AND fleet_mission = :missionID AND fleet_mess = :mesID AND fleet_end_id = :fleet_end_id;';
                $totalRocketsLuna	= Database::get()->selectSingle($sql, array(
                    ':userId'	        => $USER['id'],
                    ':missionID'	    => 10,
                    ':mesID'	        => 0,
                    ':fleet_end_id'	    => $PlanetQuery['id_luna']
                ), 'fleet_id');
            
                if($totalRocketsLuna != 0){
                    $totalRocketsLuna = $totalRocketsLuna;	
                }
                //Видимость шпионажа на луну
                $totalSpioLuna      = 0;
                $sql	            = 'SELECT COUNT(fleet_id) as fleet_id FROM %%FLEETS%% WHERE fleet_target_owner = :userId AND fleet_mission = :missionID AND fleet_mess = :mesID AND fleet_end_id = :fleet_end_id;';
                $totalSpioLuna	    = Database::get()->selectSingle($sql, array(
                    ':userId'	        => $USER['id'],
                    ':missionID'	    => 6,
                    ':mesID'	        => 0,
                    ':fleet_end_id'	    => $PlanetQuery['id_luna']
                ), 'fleet_id');
                
                if($totalSpioLuna != 0){
                    $totalSpioLuna = $totalSpioLuna;	
                }
            }
            //Вывод
            $PlanetListing[$PlanetQuery['id']] = array(
				'name'					=> $PlanetQuery['name'],
				'galaxy'				=> $PlanetQuery['galaxy'],
				'image'				    => $PlanetQuery['image'],
				'system'				=> $PlanetQuery['system'],
				'planet'				=> $PlanetQuery['planet'],
				'luna'					=> $PlanetQuery['id_luna'],
				'buildInfo'				=> $buildInfo,
				'totalAttacks'			=> $totalAttacks,
				'totalRockets'			=> $totalRockets,
				'totalSpio'				=> $totalSpio,
				'totalAttackLuna'		=> $totalAttackLuna,
				'totalRocketsLuna'		=> $totalRocketsLuna,
				'totalSpioLuna'			=> $totalSpioLuna,
			);
		}
        //Навигация - ресурсы
		$resourceTable	= array();
		$resourceSpeed	= $config->resource_multiplier;
        //Перебор $reslist['resstype'][1]
		foreach($reslist['resstype'][1] as $resourceID)
		{
			$resourceTable[$resourceID]['name']			    = $resource[$resourceID];
			$resourceTable[$resourceID]['current']		    = $PLANET[$resource[$resourceID]];
			$resourceTable[$resourceID]['max']			    = $PLANET[$resource[$resourceID].'_max'];
			$resourceTable[$resourceID]['percent']			= round($PLANET[$resource[$resourceID]] * 100 / $PLANET[$resource[$resourceID].'_max']);
			
			if($PLANET['planet_type'] == 1){
                $resourceTable[$resourceID]['information']		= pretty_number($PLANET[$resource[$resourceID].'_perhour']+ $config->{$resource[$resourceID].'_basic_income'} * $resourceSpeed);
                $resourceTable[$resourceID]['informationd']	    = pretty_number(($PLANET[$resource[$resourceID].'_perhour']+ $config->{$resource[$resourceID].'_basic_income'} * $resourceSpeed) *24);
                $resourceTable[$resourceID]['informationz']		= pretty_number(($PLANET[$resource[$resourceID].'_perhour']+ $config->{$resource[$resourceID].'_basic_income'} * $resourceSpeed) * 24 * 7);
			}else{
                $resourceTable[$resourceID]['information']		= 0;
                $resourceTable[$resourceID]['informationd']		= 0;
                $resourceTable[$resourceID]['informationz']		= 0;
			}
			if($USER['urlaubs_modus'] == 1 || $PLANET['planet_type'] != 1)
			{
				$resourceTable[$resourceID]['production']	= $PLANET[$resource[$resourceID].'_perhour'];
			}
			else
			{
				$resourceTable[$resourceID]['production']	= $PLANET[$resource[$resourceID].'_perhour'] + $config->{$resource[$resourceID].'_basic_income'} * $resourceSpeed;
			}
		}
        //Перебор $reslist['resstype'][2]
		foreach($reslist['resstype'][2] as $resourceID)
		{
			$resourceTable[$resourceID]['name']			    = $resource[$resourceID];
			$resourceTable[$resourceID]['used']			    = $PLANET[$resource[$resourceID].'_used'];
			$resourceTable[$resourceID]['max']			    = $PLANET[$resource[$resourceID]];
			$resourceTable[$resourceID]['used1']		    = abs($PLANET[$resource[$resourceID].'_used']);
			
			if($PLANET[$resource[$resourceID]] == 0){
                $resourceTable[$resourceID]['percent']          = 0;
                $resourceTable[$resourceID]['percenta']         = 0;
			}else{
                $resourceTable[$resourceID]['percent']		    = 100 / $PLANET[$resource[$resourceID]] * ($PLANET[$resource[$resourceID]] - abs($PLANET[$resource[$resourceID].'_used'])) / 2;
                $resourceTable[$resourceID]['percenta']		    = abs(100 / $PLANET[$resource[$resourceID]] * ($PLANET[$resource[$resourceID]] - abs($PLANET[$resource[$resourceID].'_used'])) / 2);
			}
		}
        //Перебор $reslist['resstype'][3]
		foreach($reslist['resstype'][3] as $resourceID)
		{
			$resourceTable[$resourceID]['name']			= $resource[$resourceID];
			$resourceTable[$resourceID]['current']		= $USER[$resource[$resourceID]];	
		}
        //Информация об энергии на планете
        if($PLANET['energy'] > 0){
            $PercentageEnergy = round( ($PLANET['energy'] + $PLANET['energy_used']) / ($PLANET['energy']) * 100);
		}else{
            $PercentageEnergy = 0;
		}
        //Стиль
		$themeSettings	= $THEME->getStyleSettings();
        
		$this->assign(array(
            //Для ресурсов
            'PercentageEnergy'	=> $PercentageEnergy,
            //Перменные для PlanetSelect
            'planetName'		=> $PLANET['name'],
			'planetImage'		=> $PLANET['image'],
			'planetGalaxy'		=> $PLANET['galaxy'],
			'planetSystem'		=> $PLANET['system'],
			'planetPlanet'		=> $PLANET['planet'],
            'PlanetListing'			=> $PlanetListing,
            'current_pid'		=> $PLANET['id'],
			'current_pids'		=> '?'.$this->getQueryString().'&cp='.$PLANET['id'],
            //Стандартные перменные
			'PlanetSelect'		=> $PlanetSelect,
			'new_message' 		=> $USER['messages'],
			'vacation'			=> $USER['urlaubs_modus'] ? _date($LNG['php_tdformat'], $USER['urlaubs_until'], $USER['timezone']) : false,
			'delete'			=> $USER['db_deaktjava'] ? sprintf($LNG['tn_delete_mode'], _date($LNG['php_tdformat'], $USER['db_deaktjava'] + ($config->del_user_manually * 86400)), $USER['timezone']) : false,
			'darkmatter'		=> $USER['darkmatter'],
			'current_pid'		=> $PLANET['id'],
			'image'				=> $PLANET['image'],
			'resourceTable'		=> $resourceTable,
			'shortlyNumber'		=> $themeSettings['TOPNAV_SHORTLY_NUMBER'],
			'closed'			=> !$config->game_disable,
			'hasBoard'			=> filter_var($config->forum_url, FILTER_VALIDATE_URL),
			'hasAdminAccess'	=> !empty(Session::load()->adminAccess),
			'hasGate'			=> $PLANET[$resource[43]] > 0
		));
	}

	protected function getPageData()
	{
		global $USER, $THEME;

		if($this->getWindow() === 'full') {
			$this->getNavigationData();
			$this->getCronjobsTodo();
		}

		$dateTimeServer		= new DateTime("now");
		if(isset($USER['timezone'])) {
			try {
				$dateTimeUser	= new DateTime("now", new DateTimeZone($USER['timezone']));
			} catch (Exception $e) {
				$dateTimeUser	= $dateTimeServer;
			}
		} else {
			$dateTimeUser	= $dateTimeServer;
		}

		$config	= Config::get();

		$this->assign(array(
            //Переменная имени
            'username'	        => $USER['username'],
            //Стандартные перменные
			'vmode'				=> $USER['urlaubs_modus'],
			'authlevel'			=> $USER['authlevel'],
			'userID'			=> $USER['id'],
			'bodyclass'			=> $this->getWindow(),
			'game_name'			=> $config->game_name,
			'uni_name'			=> $config->uni_name,
			'ga_active'			=> $config->ga_active,
			'ga_key'			=> $config->ga_key,
			'debug'				=> $config->debug,
			'VERSION'			=> $config->VERSION,
			'date'				=> explode("|", date('Y\|n\|j\|G\|i\|s\|Z', TIMESTAMP)),
			'isPlayerCardActive' => isModuleAvailable(MODULE_PLAYERCARD),
			'REV'				=> substr($config->VERSION, -4),
			'Offset'			=> $dateTimeUser->getOffset() - $dateTimeServer->getOffset(),
			'queryString'		=> $this->getQueryString(),
			'themeSettings'		=> $THEME->getStyleSettings(),
		));
	}
	protected function printMessage($message, $redirectButtons = NULL, $redirect = NULL, $fullSide = true)
	{
		$this->assign(array(
			'message'			=> $message,
			'redirectButtons'	=> $redirectButtons,
		));

		if(isset($redirect)) {
			$this->tplObj->gotoside($redirect[0], $redirect[1]);
		}

		if(!$fullSide) {
			$this->setWindow('popup');
		}

		$this->display('error.default.tpl');
	}

	protected function save() {
		if(isset($this->ecoObj)) {
			$this->ecoObj->SavePlanetToDB();
		}
	}

	protected function assign($array, $nocache = true) {
		$this->tplObj->assign_vars($array, $nocache);
	}

	protected function display($file) {
		global $THEME, $LNG;

		$this->save();

		if($this->getWindow() !== 'ajax') {
			$this->getPageData();
		}

		$this->assign(array(
			'lang'    		=> $LNG->getLanguage(),
			'dpath'			=> $THEME->getTheme(),
			'scripts'		=> $this->tplObj->jsscript,
			'execscript'	=> implode("\n", $this->tplObj->script),
			'basepath'		=> PROTOCOL.HTTP_HOST.HTTP_BASE,
		));

		$this->assign(array(
			'LNG'			=> $LNG,
		), false);

		$this->tplObj->display('extends:layout.'.$this->getWindow().'.tpl|'.$file);
		exit;
	}

	protected function sendJSON($data) {
		$this->save();
		echo json_encode($data);
		exit;
	}

	protected function redirectTo($url) {
		$this->save();
		HTTP::redirectTo($url);
		exit;
	}
}