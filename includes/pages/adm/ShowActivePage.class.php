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

class ShowActivePage extends AbstractAdminPage
{
	public static $requireModule = 0;

	function __construct() 
	{
        if (!allowedTo(str_replace(array(dirname(__FILE__), '\\', '/', '.php'), '', __FILE__))) throw new Exception("Permission error!");
		parent::__construct();
	}
		
	function show()
	{
        global $LNG, $USER;
        
        if(!isset($_GET['action'])){
            $_GET['action'] = 'id';
        }
        
        $id = HTTP::_GP('id', 0);
        if($_GET['action'] == 'delete' && !empty($id))
            $GLOBALS['DATABASE']->query("DELETE FROM ".USERS_VALID." WHERE `validationID` = '".$id."' AND `universe` = '".Universe::current()."';");

        $query = $GLOBALS['DATABASE']->query("SELECT * FROM ".USERS_VALID." WHERE `universe` = '".Universe::current()."' ORDER BY validationID ASC");

        $Users	= array();
        while ($User = $GLOBALS['DATABASE']->fetch_array($query)) {
            $Users[]	= array(
                'id'			=> $User['validationID'],
                'name'			=> $User['userName'],
                'date'			=> _date($LNG['php_tdformat'], $User['date'], $USER['timezone']),
                'email'			=> $User['email'],
                'ip'			=> $User['ip'],
                'password'		=> $User['password'],
                'validationKey'	=> $User['validationKey'],
            );
        }

        $this->assign(array(	
            'Users'				=> $Users,
            'uni'				=> Universe::current(),
        ));
	
        $this->display('page.active.default.tpl');
	}
}
