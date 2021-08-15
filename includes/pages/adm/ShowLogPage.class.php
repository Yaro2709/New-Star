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

class ShowLogPage extends AbstractAdminPage
{
	public static $requireModule = 0;

	function __construct() 
	{
        if (!allowedTo(str_replace(array(dirname(__FILE__), '\\', '/', '.php'), '', __FILE__))) throw new Exception("Permission error!");
		parent::__construct();
	}
		
	function show()
	{
        global $LNG, $resources;
	
        $table = HTTP::_GP('type', '');
	
        # Modes:
        # 1 => Playerlist Changes
        #	target => Player-ID
        # 2 => Planetlist Changes
        #	target => Planet-ID
        # 3 => Div. Settings Pages
        #	target 0 => Universe-Settings
        # 4 => Presents
        #
        # TODO: LOG Search
	
        switch ($table) {
            case 'planet':
                $this->ShowLogPlanetsList();
            break;
            case 'player':
                $this->ShowLogPlayersList();
            break;
            case 'settings':
                $this->ShowLogSettingsList();
            break;
            case 'present':
                $this->ShowLogPresent();
            break;
            case 'detail':
                $this->ShowLogDetail();
            break;
        }
        
		$this->assign(array());
		$this->display('page.log.default.tpl');
	}
    
    function ShowLogDetail() 
    {
        global $LNG, $USER;
        $logid = HTTP::_GP('id', 0);
        $result   	= $GLOBALS['DATABASE']->getFirstRow("SELECT l.*, u_a.username as admin_username FROM ".LOG." as l LEFT JOIN ".USERS." as u_a ON  u_a.id = l.admin  WHERE l.id = ".$logid."");
	
        $data = unserialize($result['data']);
        $conf_before	= array();
        $conf_after		= array();
        foreach ($data[0] as $key => $i) {
            $conf_before[$key] = $i;
        }
        foreach ($data[1] as $key => $i) {
            $conf_after[$key] = $i;
        }
	
        $Wrapper = array();
	
        foreach ($conf_before as $key => $val) {
            if ($key != 'universe') {
                if(isset($LNG['tech'][$key]))
                    $Element = $LNG['tech'][$key];
                elseif(isset($LNG['se_'.$key]))
                    $Element = $LNG['se_'.$key];
                elseif(isset($LNG[$key]))
                    $Element = $LNG[$key];
                elseif(isset($Wrapper[$key]))
                    $Element = $Wrapper[$key];
                else
                    $Element = $key;
			
                $LogArray[]	= array(
                    'Element'	=> $Element,
                    'old'		=> ($Element == 'urlaubs_until' ? _date($LNG['php_tdformat'], $val) : (is_numeric($val) ? pretty_number($val) : $val)),
                    'new'		=> ($Element == 'urlaubs_until' ? _date($LNG['php_tdformat'], $conf_after[$key]) : (is_numeric($conf_after[$key]) ? pretty_number($conf_after[$key]) : $conf_after[$key])),
                );
            }
        }
			
        $this->assign(array(	
            'LogArray'		=> $LogArray,
            'admin'			=> $result['admin_username'],
            'target'		=> $result['universe'],
            'id'			=> $result['id'],
            'time'			=> _date($LNG['php_tdformat'], $result['time'], $USER['timezone']),
        ));
        
        $this->display('page.logDetail.default.tpl');
    }

    function ShowLogSettingsList() 
    {
        global $LNG, $USER;
        
        $result    = $GLOBALS['DATABASE']->query("SELECT l.id, l.admin, l.time, l.universe, l.target,u_a.username as admin_username FROM ".LOG." as l LEFT JOIN ".USERS." as u_a ON  u_a.id = l.admin WHERE mode = 3 ORDER BY id DESC");

        if(!$result)
            $this->printMessage($LNG['log_no_data'], true, array('?page=log&type=settings', 3));
	
        $targetkey = array(
            0 => $LNG['log_usettings'],
        );
	
        while ($LogRow = $GLOBALS['DATABASE']->fetch_array($result))
        {			
            $LogArray[]	= array(
                'id'			=> $LogRow['id'],
                'admin'			=> $LogRow['admin_username'],
                'target_uni'	=> ($LogRow['target'] == 0 ? '' : $LogRow['universe']),
                'target'		=> $targetkey[$LogRow['target']],
                'time'			=> _date($LNG['php_tdformat'], $LogRow['time'], $USER['timezone']),
            );
        }
        $GLOBALS['DATABASE']->free_result($result);
        
        $this->assign(array(	
            'LogArray'				=> $LogArray,
            'log_target'	=> $LNG['log_target_universe'],
        ));
        
        $this->display('page.logList.default.tpl');
    }

    function ShowLogPlanetsList() 
    {
        global $LNG, $USER;

        $result    = $GLOBALS['DATABASE']->query("SELECT DISTINCT l.id, l.admin, l.target, l.time, l.universe,u_t.username as target_username, p.galaxy as target_galaxy, p.system as target_system, p.planet as target_planet,u_a.username as admin_username FROM ".LOG." as l LEFT JOIN ".USERS." as u_a ON  u_a.id = l.admin LEFT JOIN ".PLANETS." as p ON p.id = l.target LEFT JOIN ".USERS." as u_t ON u_t.id = p.id_owner WHERE mode = 2 ORDER BY id DESC");

        if(!$result)
            $this->printMessage($LNG['log_no_data'], true, array('?page=log&type=planet', 3));
		
        while ($LogRow = $GLOBALS['DATABASE']->fetch_array($result))
        {			
            $LogArray[]	= array(
                'id'		=> $LogRow['id'],
                'admin'		=> $LogRow['admin_username'],
                'target_uni'=> $LogRow['universe'],
                'target'	=> '['.$LogRow['target_galaxy'].':'.$LogRow['target_system'].':'.$LogRow['target_planet'].'] -> '.$LogRow['target_username'],
                'time'		=> _date($LNG['php_tdformat'], $LogRow['time'], $USER['timezone']),
            );
        }
        $GLOBALS['DATABASE']->free_result($result);
    	
        $this->assign(array(	
            'LogArray'		=> $LogArray,
            'log_target'	=> $LNG['log_target_planet'],
        ));
        
        $this->display('page.logList.default.tpl');
    }

    function ShowLogPlayersList() 
    {
        global $LNG, $USER;

        $result    = $GLOBALS['DATABASE']->query("SELECT DISTINCT l.id, l.admin, l.target, l.time, l.universe,u_t.username as target_username,u_a.username as admin_username FROM ".LOG." as l LEFT JOIN ".USERS." as u_a ON  u_a.id = l.admin LEFT JOIN ".USERS." as u_t ON u_t.id = l.target WHERE mode = 1 ORDER BY l.id DESC");
	
        if(!$result)
            $this->printMessage($LNG['log_no_data'], true, array('?page=log&type=player', 3));
		
        while ($LogRow = $GLOBALS['DATABASE']->fetch_array($result))
        {			
            $LogArray[]	= array(
                'id'		=> $LogRow['id'],
                'admin'		=> $LogRow['admin_username'],
                'target_uni'=> $LogRow['universe'],
                'target'	=> $LogRow['target_username'],
                'time'		=> _date($LNG['php_tdformat'], $LogRow['time'], $USER['timezone']),
            );
        }
        $GLOBALS['DATABASE']->free_result($result);
    
        $this->assign(array(	
            'LogArray'		=> $LogArray,
            'log_target'	=> $LNG['log_target_user'],
        ));
        
        $this->display('page.logList.default.tpl');
    }

    function ShowLogPresent() 
    {
        global $LNG, $USER;

        $result    = $GLOBALS['DATABASE']->query("SELECT DISTINCT l.id, l.admin, l.target, l.time, l.universe, u_a.username as admin_username FROM ".LOG." as l LEFT JOIN ".USERS." as u_a ON u_a.id = l.admin WHERE mode = 4 ORDER BY l.id DESC;");

        if(!$result)
            $this->printMessage($LNG['log_no_data'], true, array('?page=log&type=present', 3));
		
        while ($LogRow = $GLOBALS['DATABASE']->fetch_array($result))
        {			
            $LogArray[]	= array(
                'id'		=> $LogRow['id'],
                'admin'		=> $LogRow['admin_username'],
                'target_uni'=> $LogRow['universe'],
                'target'	=> $LNG['fcm_universe'],
                'time'		=> _date($LNG['php_tdformat'], $LogRow['time'], $USER['timezone']),
            );
        }
        $GLOBALS['DATABASE']->free_result($result);
        
        $this->assign(array(	
            'LogArray'		=> $LogArray,
            'log_target'	=> $LNG['log_target_user'],
        ));
        
        $this->display('page.logList.default.tpl');
    }  
}