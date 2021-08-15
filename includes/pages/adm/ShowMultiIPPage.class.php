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

class ShowMultiIPPage extends AbstractAdminPage
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
        
        if(!isset($_GET['action'])){
            $_GET['action'] = '';
        }
	
        switch($_GET['action'])
        {
            case 'known':
                $GLOBALS['DATABASE']->query("INSERT INTO ".MULTI." SET userID = ".((int) $_GET['id']).";");
                HTTP::redirectTo("admin.php?page=multiIP");
            break;
            case 'unknown':
                $GLOBALS['DATABASE']->query("DELETE FROM ".MULTI." WHERE userID = ".((int) $_GET['id']).";");
                HTTP::redirectTo("admin.php?page=multiIP");
            break;
        }
        $Query	= $GLOBALS['DATABASE']->query("SELECT id, username, email, register_time, onlinetime, user_lastip, IFNULL(multiID, 0) as isKnown FROM ".USERS." LEFT JOIN ".MULTI." ON userID = id WHERE `universe` = '".Universe::current()."' AND user_lastip IN (SELECT user_lastip FROM ".USERS." WHERE `universe` = '".Universe::current()."' GROUP BY user_lastip HAVING COUNT(*)>1) ORDER BY user_lastip, id ASC;");
        $IPs	= array();
        while($Data = $GLOBALS['DATABASE']->fetch_array($Query)) {
            if(!isset($IPs[$Data['user_lastip']]))
                $IPs[$Data['user_lastip']]	= array();
		
            $Data['register_time']	= _date($LNG['php_tdformat'], $Data['register_time']);
            $Data['onlinetime']		= _date($LNG['php_tdformat'], $Data['onlinetime']);
		
            $IPs[$Data['user_lastip']][$Data['id']]	= $Data;
        }
	
        $this->assign(array(
            'multiGroups'	=> $IPs,
        ));
        $this->display('page.multiIPs.default.tpl');
	}
}
