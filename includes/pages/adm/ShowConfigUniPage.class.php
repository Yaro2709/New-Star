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

class ShowConfigUniPage extends AbstractAdminPage
{
	public static $requireModule = 0;

	function __construct() 
	{
        if (!allowedTo(str_replace(array(dirname(__FILE__), '\\', '/', '.php'), '', __FILE__))) throw new Exception("Permission error!");
		parent::__construct();
	}
		
	function show()
	{
		global $LNG;
            //Вселенная в сеансе админа.
            $config			= Config::get();
            //Классофикация
            $config_class = array(
                'server'				    => array('game_name', 'ttf_file', 'timezone'), 
                'user'				        => array('del_oldstuff', 'del_user_manually', 'del_user_automatic', 'sendmail_inactive', 'del_user_sendmail'), 
                'recapthca'				    => array('capaktiv', 'cappublic', 'capprivate'), 
                'smtp'				        => array('mail_active', 'mail_use', 'smtp_sendmail', 'smail_path', 'smtp_host' , 'smtp_ssl', 'smtp_port', 'smtp_user', 'smtp_pass'),
                'messages'				    => array('message_delete_behavior', 'message_delete_days'),  
                'analytics'				    => array('ga_active', 'ga_key'),  
                'chat'				        => array('chat_channelname', 'chat_botname', 'chat_nickchange', 'chat_logmessage', 'chat_allowmes', 'chat_allowchan', 'chat_closed'), 
                'teamspeak'				    => array('ts_modon', 'ts_version', 'ts_server', 'ts_tcpport', 'ts_udpport', 'ts_login', 'ts_password', 'ts_timeout', 'ts_cron_interval'),         
                'universe'					=> array('uni_name', 'lang', 'game_speed', 'fleet_speed', 'resource_multiplier', 'storage_multiplier', 'halt_speed', 'energySpeed', 'forum_url', 'game_disable', 'close_reason'),
                'queqe'					    => array('max_elements_build', 'max_elements_tech', 'max_elements_ships', 'max_fleet_per_build'),
                'referral'					=> array('ref_active', 'ref_bonus', 'ref_minpoints', 'ref_max_referals'),
                'colonization'				=> array('min_player_planets', 'planets_tech', 'planets_officier', 'planets_per_tech'),
                'start'				        => array('metal_start', 'crystal_start', 'deuterium_start', 'darkmatter_start', 'initial_fields', 'metal_basic_income', 'crystal_basic_income', 'deuterium_basic_income'),
                'other'				        => array('min_build_time', 'reg_closed', 'user_valid', 'adm_attack', 'debug', 'Fleet_Cdr', 'Defs_Cdr', 'max_galaxy', 'max_system', 'max_planets', 'planet_factor', 'max_overflow', 'moon_factor', 'moon_chance', 'deuterium_cost_galaxy', 'cost_trader', 'factor_university', 'max_fleets_per_acs', 'silo_factor', 'vmode_min_time', 'gate_wait_time', 'debris_moon', 'noobprotection', 'noobprotectiontime', 'noobprotectionmulti', 'max_dm_missions', 'alliance_create_min_points'),
                'merchant'				    => array('trade_allowed_ships', 'trade_charge'),
                'news'				        => array('OverviewNewsFrame', 'OverviewNewsText'),
                'stat'				        => array('stat_settings', 'stat', 'stat_level'),
                'facebook'				    => array('fb_on', 'fb_apikey', 'fb_skey'),
                'contacts'				    => array('disclamerAddress', 'disclamerPhone', 'disclamerMail', 'disclamerNotice'),
            );
            //Лист всех настроек
            $list = array_merge($config_class['server'], $config_class['user'], $config_class['recapthca'], $config_class['smtp'], $config_class['messages'], $config_class['analytics'], $config_class['chat'], $config_class['teamspeak'], $config_class['universe'], $config_class['queqe'], $config_class['referral'], $config_class['colonization'], $config_class['start'], $config_class['other'], $config_class['merchant'], $config_class['news'], $config_class['stat'], $config_class['facebook'], $config_class['contacts']);
            //Запрос на изменение существующих параметров
            if (!empty($_POST)){
                //Ячейки ввода новых параметров
                $config_after = array();
                foreach($list as $parameter) 
                {
                    $config_after	+= array(
                        ''.$parameter.''	=> HTTP::_GP(''.$parameter.'', '', true)
                    );
                }
                //Собор данных для лога
                $config_before = array();
                foreach($list as $parameter) 
                {
                    $config_before	+= array(
                        ''.$parameter.''	=> $config->$parameter
                    );
                }
                //Обновляем данные
                foreach($config_after as $key => $value)
                {
                    $config->$key	= $value;
                }
                $config->save();
                
                //Пишем лог       
                $LOG = new Log(3);
                $LOG->target = 0;
                $LOG->old = $config_before;
                $LOG->new = $config_after;
                $LOG->save();

                //Запрос в базу, если вселенная не под протекторатом админа
                if($config->adm_attack == 0)
                    $GLOBALS['DATABASE']->query("UPDATE ".USERS." SET `authattack` = '0' WHERE `universe` = '".Universe::current()."';");
            }
            //Вывод всех параметров на данный момент. Не ставить раньше запроса!
            $config_before = array();
            foreach($list as $parameter) 
            {
                $config_before	+= array(
                    ''.$parameter.''	=> $config->$parameter
                );
            }
        
		$this->assign(array(
            'config_before'             => $config_before, 
            'config'                    => $config_class,    
		)); 
		
		$this->display('page.configuni.default.tpl');
	}
}