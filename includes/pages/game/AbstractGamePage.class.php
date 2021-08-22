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
		global $PLANET, $LNG, $USER, $THEME, $resource, $reslist, $pricelist;

		$config			= Config::get();
        
        //PlanetSelect
        if($USER['bana']==1) { 
            echo 'Ты забанен!'; 
            die(); 
        }
        
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
            $resourceTable[$resourceID]['name']			= $resource[$resourceID];
			$resourceTable[$resourceID]['used']			= $PLANET[$resource[$resourceID]] + $PLANET[$resource[$resourceID].'_used'];
			$resourceTable[$resourceID]['max']			= $PLANET[$resource[$resourceID]];
			$resourceTable[$resourceID]['percent']		= round(($PLANET[$resource[$resourceID]] + $PLANET[$resource[$resourceID].'_used']) * 100 / max(1,$PLANET[$resource[$resourceID]]));
		}
        //Перебор $reslist['resstype'][3]
		foreach($reslist['resstype'][3] as $resourceID)
		{
			$resourceTable[$resourceID]['name']			= $resource[$resourceID];
			$resourceTable[$resourceID]['current']		= $USER[$resource[$resourceID]];	
		}
        //Стиль
		$themeSettings	= $THEME->getStyleSettings();
        //Ачивки
        foreach($reslist['achievements'] as $Element)
        {
            //Блок
            if(!BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element, array()) || $pricelist[$Element]['max'] <= $USER[$resource[$Element]])
				continue;
            //Получаешь награду
            $amount = 1;
            $USER[$resource[$Element]]	+= $amount;
            include('includes/subclasses/subclass.UpdateSqlGeneral.php');
            //Параметры сообщения
            $From           = $LNG['ach_system'];
            $pmSubject      = $LNG['lm_achievements'];
            $sendMessage    = '
                <a href="#" onclick="return Dialog.info('.$Element.')">
                    <img alt="" style="float:left; width:60px; margin-right:6px;" src="'.$THEME->getTheme().'gebaeude/'.$Element.'.gif">
                </a>
                '.$LNG['ach_reached'].' <span class="achiev_mes_head">'.$LNG['tech'][$Element].' '.$USER[$resource[$Element]].'</span>
                <br><a href="#" onclick="return Dialog.info('.$Element.')">'.$LNG['ach_bonus'].'</a>
                <br><a href="/game.php?page=achievements">'.$LNG['ach_go_achievements'].'</a>
            ';
            //Сообщение о награде
            PlayerUtil::sendMessage($USER['id'], $USER['id'], $From, 4, $pmSubject, $sendMessage, TIMESTAMP, NULL, 1, Universe::current());
        }
        
		$this->assign(array(
            //Перменные для PlanetSelect
            'planetName'		=> $PLANET['name'],
			'planetImage'		=> $PLANET['image'],
			'planetGalaxy'		=> $PLANET['galaxy'],
			'planetSystem'		=> $PLANET['system'],
			'planetPlanet'		=> $PLANET['planet'],
            'PlanetListing'		=> $PlanetListing,
            'current_pid'		=> $PLANET['id'],
			'current_pids'		=> '?'.$this->getQueryString().'&cp='.$PLANET['id'],
            //Бонус
            'bonus_time'		=> $USER['bonus_time'],
            'bonus_time_rest'   => _date('d.m.Y H:i:s', ($USER['bonus_time']), $USER['timezone']),
            //Стандартные перменные
			'PlanetSelect'		=> $PlanetSelect,
			'new_message' 		=> $USER['messages'],
			'vacation'			=> $USER['urlaubs_modus'] ? _date($LNG['php_tdformat'], $USER['urlaubs_until'], $USER['timezone']) : false,
			'delete'			=> $USER['db_deaktjava'] ? sprintf($LNG['tn_delete_mode'], _date($LNG['php_tdformat'], $USER['db_deaktjava'] + ($config->del_user_manually * 86400)), $USER['timezone']) : false,
			'current_pid'		=> $PLANET['id'],
			'image'				=> $PLANET['image'],
			'resourceTable'		=> $resourceTable,
			'shortlyNumber'		=> $themeSettings['TOPNAV_SHORTLY_NUMBER'],
			'closed'			=> !$config->game_disable,
			'hasBoard'			=> filter_var($config->forum_url, FILTER_VALIDATE_URL),
			'hasAdminAccess'	=> !empty(Session::load()->adminAccess),
			'hasGate'			=> $PLANET[$resource[43]] > 0,
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
        
        $sql	= "SELECT COUNT(*) as count FROM %%FLEETS%% WHERE fleet_start_time > :time AND fleet_mission = :missionId AND fleet_mess = 0 AND fleet_owner <> :userId AND fleet_target_owner = :userId;";
        $total	= Database::get()->selectSingle($sql, array(
            ':userId'	    => $USER['id'],
            ':time'	        => TIMESTAMP,
            ':missionId'	=> 1
            
        ));
        $AJAX['ataks'] = $total['count'];

        $sql	= "SELECT COUNT(*) as count FROM %%FLEETS%% WHERE fleet_start_time > :time AND fleet_mission = :missionId AND fleet_mess = 0 AND fleet_owner <> :userId AND fleet_target_owner = :userId;";
        $total	= Database::get()->selectSingle($sql, array(
            ':userId'	    => $USER['id'],
            ':time'	        => TIMESTAMP,
            ':missionId'	=> 6
            
        ));
        $AJAX['spio'] = $total['count'];

        $sql	= "SELECT COUNT(*) as count FROM %%FLEETS%% WHERE fleet_start_time > :time AND fleet_mission = :missionId AND fleet_mess = 0 AND fleet_owner <> :userId AND fleet_target_owner = :userId;";
        $total	= Database::get()->selectSingle($sql, array(
            ':userId'	    => $USER['id'],
            ':time'	        => TIMESTAMP,
            ':missionId'	=> 9
            
        ));
        $AJAX['unic'] = $total['count'];

        $sql	= "SELECT COUNT(*) as count FROM %%FLEETS%% WHERE fleet_start_time > :time AND fleet_mission = :missionId AND fleet_mess = 0 AND fleet_owner <> :userId AND fleet_target_owner = :userId;";
        $total	= Database::get()->selectSingle($sql, array(
            ':userId'	    => $USER['id'],
            ':time'	        => TIMESTAMP,
            ':missionId'	=> 10
            
        ));
        $AJAX['rakets'] = $total['count'];

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
            //Индикаторы
            'ataks'				=> $AJAX['ataks'],
			'spio'				=> $AJAX['spio'],
			'unic'				=> $AJAX['unic'],
			'rakets'			=> $AJAX['rakets'],
            //Настройка индикаторов
            'msgvolume'         => $USER['setting_msg']/10,
			'volume'            => $USER['sound_ataks']/10,
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
		global $THEME, $LNG, $reslist, $USER;

		$this->save();

		if($this->getWindow() !== 'ajax') {
			$this->getPageData();
		}

		$this->assign(array(
            //Аватарки
            'foto'			=> $USER['foto'],
            'background'	=> $USER['background'],
            //Стандартные перменные
			'lang'    		=> $LNG->getLanguage(),
			'dpath'			=> $THEME->getTheme(),
			'scripts'		=> $this->tplObj->jsscript,
			'execscript'	=> implode("\n", $this->tplObj->script),
			'basepath'		=> PROTOCOL.HTTP_HOST.HTTP_BASE,
		));

		$this->assign(array(
			'LNG'			=> $LNG,
            'reslist'		=> $reslist,
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