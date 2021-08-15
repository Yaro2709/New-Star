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

class ShowRightsPage extends AbstractAdminPage
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
        
        $key	= HTTP::_GP('key', '');
        
        if(!isset($_GET['get'])){
            $_GET['get'] = 'adm';
        }
        
        switch($key)
        {
            case 'rights':
			
                if ($_POST)
                {
                    $id			= HTTP::_GP('id_1', 0);
				
                    if($USER['id'] != ROOT_USER && $id == ROOT_USER) {
                        $this->printMessage($LNG['rh_authlevel_error'], true, array('?page=rights&key=rights&sid='.session_id(), 3));
                    }
				
                    if(!isset($_POST['rights'])) {
                        $_POST['rights']	= array();
                    }
				
                    if($_POST['action'] == 'send') {
                        $GLOBALS['DATABASE']->query("UPDATE ".USERS." SET `rights` = '".serialize(array_map('intval', $_POST['rights']))."' WHERE `id` = '".$id."';");
                    }
				
                    $Rights	= $GLOBALS['DATABASE']->getFirstRow("SELECT rights, username FROM ".USERS." WHERE `id` = '".$id."';");
                    if(($Rights['rights'] = unserialize($Rights['rights'])) === false) {
                        $Rights['rights']	= array();
                    }
                    
                    $name = function($val)
                    {
                        return str_replace('.php', '', $val);
                    };
				
                    $Files	= array_map($name, array_diff(scandir('includes/pages/adm/'), array('.', '..', '.svn', 'index.html', '.htaccess', 'AbstractAdminPage.class.php', 'ShowLoginPage.php', 'ShowLogoutPage.class.php', 'ShowErrorPage.class.php', 'ShowOverviewPage.class.php')));
				
                    $this->assign(array(
                        'Files'						=> $Files, 
                        'Rights'					=> $Rights['rights'], 
                        'Username'					=> $Rights['username'],
                        'id'						=> $id, 
                        'yesorno'					=> array(1 => $LNG['status_yes'], 0 => $LNG['status_no']),  
                        'sid'						=> session_id(), 
                    ));
				
                    $this->display('page.moderrationRightsPost.default.tpl');                    
                }
							
                if ($_GET['get'] == 'adm')
                    $WHEREUSERS	=	"AND `authlevel` = '".AUTH_ADM."'";
                elseif ($_GET['get'] == 'ope')
                    $WHEREUSERS	=	"AND `authlevel` = '".AUTH_OPS."'";
                elseif ($_GET['get'] == 'mod')
                    $WHEREUSERS	=	"AND `authlevel` = '".AUTH_MOD."'";
                elseif ($_GET['get'] == 'pla')
                    $WHEREUSERS	=	"AND `authlevel` = '".AUTH_USR."'";			
				
				
                $QueryUsers	=	$GLOBALS['DATABASE']->query("SELECT `id`, `username`, `authlevel` FROM ".USERS." WHERE `universe` = '".Universe::current()."'".$WHEREUSERS.";");
				
                $UserList	= "";
                while ($List = $GLOBALS['DATABASE']->fetch_array($QueryUsers)) {
                    $UserList	.=	'<option value="'.$List['id'].'">'.$List['username'].'&nbsp;&nbsp;('.$LNG['rank_'.$List['authlevel']].')</option>';
                }	

                $this->assign(array(
                    'Selector'					=> array(0 => $LNG['rank_0'], 1 => $LNG['rank_1'], 2 => $LNG['rank_2'], 3 => $LNG['rank_3']),
                    'UserList'					=> $UserList, 
                    'sid'						=> session_id(), 
                ));
	
                $this->display('page.moderrationRights.default.tpl');
            break;
            case 'users':
			
                if ($_POST)
                {
                    $id			= HTTP::_GP('id_1', 0);
                    $authlevel	= HTTP::_GP('authlevel', 0);
				
                    if($id == 0)
                        $id	= HTTP::_GP('id_2', 0);
					
                    if($USER['id'] != ROOT_USER && $id == ROOT_USER) {
                        $this->printMessage($LNG['rh_authlevel_error'], true, array('?page=rights&key=rights&sid='.session_id(), 3));
                    }	
				
                    $GLOBALS['DATABASE']->multi_query("UPDATE ".USERS." SET `authlevel` = '".HTTP::_GP('authlevel', 0)."' WHERE `id` = '".$id."';");
                    $this->printMessage($LNG['rh_authlevel_succes'], true, array('?page=rights&key=rights&sid='.session_id(), 3));
                }
							
                if ($_GET['get'] == 'adm')
                    $WHEREUSERS	=	"AND `authlevel` = '".AUTH_ADM."'";
                elseif ($_GET['get'] == 'ope')
                    $WHEREUSERS	=	"AND `authlevel` = '".AUTH_OPS."'";
                elseif ($_GET['get'] == 'mod')
                    $WHEREUSERS	=	"AND `authlevel` = '".AUTH_MOD."'";
                elseif ($_GET['get'] == 'pla')
                    $WHEREUSERS	=	"AND `authlevel` = '".AUTH_USR."'";	
				
                $QueryUsers	=	$GLOBALS['DATABASE']->query("SELECT `id`, `username`, `authlevel` FROM ".USERS." WHERE `universe` = '".Universe::current()."'".$WHEREUSERS.";");
				
                $UserList	= "";
                while ($List = $GLOBALS['DATABASE']->fetch_array($QueryUsers)) {
                    $UserList	.=	'<option value="'.$List['id'].'">'.$List['username'].'&nbsp;&nbsp;('.$LNG['rank_'.$List['authlevel']].')</option>';
                }	

                $this->assign(array(	
                    'Selector'					=> array(0 => $LNG['rank_0'], 1 => $LNG['rank_1'], 2 => $LNG['rank_2'], 3 => $LNG['rank_3']),
                    'UserList'					=> $UserList,  
                    'sid'						=> session_id(), 
                ));
	
                $this->display('page.moderrationUsers.default.tpl');
            break;
            
            default:
                $this->display('page.moderrationMenu.default.tpl');
            break;
        }
	}
}
