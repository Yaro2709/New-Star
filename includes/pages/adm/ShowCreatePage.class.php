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

class ShowCreatePage extends AbstractAdminPage
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
        
        if(!isset($_GET['class'])){
            $_GET['class'] = '';
        }

        switch($_GET['class'])
        {
            case 'user':
                if ($_POST)
                {
                    $UserName 	= HTTP::_GP('name', '', UTF8_SUPPORT);
                    $UserPass 	= HTTP::_GP('password', '');
                    $UserPass2 	= HTTP::_GP('password2', '');
                    $UserMail 	= HTTP::_GP('email', '');
                    $UserMail2	= HTTP::_GP('email2', '');
                    $UserAuth 	= HTTP::_GP('authlevel', 0);
                    $Galaxy 	= HTTP::_GP('galaxy', 0);
                    $System 	= HTTP::_GP('system', 0);
                    $Planet 	= HTTP::_GP('planet', 0);
                    $Language 	= HTTP::_GP('lang', '');
					
                    $ExistsUser 	= $GLOBALS['DATABASE']->getFirstCell("SELECT (SELECT COUNT(*) FROM ".USERS." WHERE universe = ".Universe::current()." AND username = '".$GLOBALS['DATABASE']->sql_escape($UserName)."') + (SELECT COUNT(*) FROM ".USERS_VALID." WHERE universe = ".Universe::current()." AND username = '".$GLOBALS['DATABASE']->sql_escape($UserName)."')");
                    $ExistsMails	= $GLOBALS['DATABASE']->getFirstCell("SELECT (SELECT COUNT(*) FROM ".USERS." WHERE universe = ".Universe::current()." AND (email = '".$GLOBALS['DATABASE']->sql_escape($UserMail)."' OR email_2 = '".$GLOBALS['DATABASE']->sql_escape($UserMail)."')) + (SELECT COUNT(*) FROM ".USERS_VALID." WHERE universe = ".Universe::current()." AND email = '".$GLOBALS['DATABASE']->sql_escape($UserMail)."')");

                    $errors	= "";

                    $config	= Config::get();

                    if (!PlayerUtil::isMailValid($UserMail))
                        $errors .= $LNG['cr_invalid_mail_adress'];
					
                    if (empty($UserName))
                        $errors .= $LNG['cr_empty_user_field'];
										
                    if (strlen($UserPass) < 6)
                        $errors .= $LNG['cr_password_lenght_error'];
					
                    if ($UserPass != $UserPass2)
                        $errors .= $LNG['cr_different_passwords'];				
					
                    if ($UserMail != $UserMail2)
                        $errors .= $LNG['cr_different_mails'];
					
                    if (!PlayerUtil::isNameValid($UserName))
                        $errors .= $LNG['cr_user_field_specialchar'];				
										
                    if ($ExistsUser != 0)
                        $errors .= $LNG['cr_user_already_exists'];

                    if ($ExistsMails != 0)
                        $errors .= $LNG['cr_mail_already_exists'];
				
                    if (!PlayerUtil::isPositionFree(Universe::current(), $Galaxy, $System, $Planet)) {
                        $errors .= $LNG['cr_planet_already_exists'];
                    }	
				
                    if ($Galaxy > $config->max_galaxy || $System > $config->max_system || $Planet > $config->max_planets) {
                        $errors .= $LNG['cr_complete_all2'];
                    }

                    if (!empty($errors)) {
                        $this->printMessage($errors, true, array('?page=create&class=user', 10));
                    }

                    $Language	= array_key_exists($Language, $LNG->getAllowedLangs(false)) ? $Language : $config->lang;

                    PlayerUtil::createPlayer(Universe::current(), $UserName,
                        PlayerUtil::cryptPassword($UserPass), $UserMail, $Language, $Galaxy, $System, $Planet,
                        $LNG['fcm_planet'], $UserAuth);
				
                    $this->printMessage($LNG['cr_new_user_success'], true, array('?page=create&class=user', 5));
                }

                $AUTH			= array();
                $AUTH[AUTH_USR]	= $LNG['user_level_'.AUTH_USR];
			
                if($USER['authlevel'] >= AUTH_OPS)
                    $AUTH[AUTH_OPS]	= $LNG['user_level_'.AUTH_OPS];
				
                if($USER['authlevel'] >= AUTH_MOD)
                    $AUTH[AUTH_MOD]	= $LNG['user_level_'.AUTH_MOD];
				
                if($USER['authlevel'] >= AUTH_ADM)
                    $AUTH[AUTH_ADM]	= $LNG['user_level_'.AUTH_ADM];
				
			
                $this->assign(array(
                    'Selector'				=> array('auth' => $AUTH, 'lang' => $LNG->getAllowedLangs(false)),  
                ));
                
                $this->display('page.createPageUser.default.tpl');
            break;
            case 'moon':
                if ($_POST)
                {
                    $PlanetID  	= HTTP::_GP('add_moon', 0);
                    $MoonName  	= HTTP::_GP('name', '', UTF8_SUPPORT);
                    $Diameter	= HTTP::_GP('diameter', 0);
			
                    $MoonPlanet	= $GLOBALS['DATABASE']->getFirstRow("SELECT temp_max, temp_min, id_luna, galaxy, `system`, planet, planet_type, destruyed, id_owner FROM ".PLANETS." WHERE id = '".$PlanetID."' AND universe = '".Universe::current()."' AND planet_type = '1' AND destruyed = '0';");

                    if (!isset($MoonPlanet)) {
                        $this->printMessage($LNG['cr_planet_doesnt_exist'], true, array('?page=create&class=moon', 3));
                    }

                    $moonId	= PlayerUtil::createMoon(Universe::current(), $MoonPlanet['galaxy'], $MoonPlanet['system'],
                        $MoonPlanet['planet'], $MoonPlanet['id_owner'], 20,
                        (($_POST['diameter_check'] == 'on') ? NULL : $Diameter), $MoonName);

                    if($moonId !== false)
                    {
                        $this->printMessage($LNG['cr_moon_added'], true, array('?page=create&class=moon', 3));
                    }
                    else
                    {
                        $this->printMessage($LNG['cr_moon_unavaible'], true, array('?page=create&class=moon', 3));
                    }
                }
			
                $this->assign(array());

                $this->display('page.createPageMoon.default.tpl');
            break;
            case 'planet':
                if ($_POST) 
                {
                    $id          = HTTP::_GP('id', 0);
                    $Galaxy      = HTTP::_GP('galaxy', 0);
                    $System      = HTTP::_GP('system', 0);
                    $Planet      = HTTP::_GP('planet', 0);
                    $name        = HTTP::_GP('name', '', UTF8_SUPPORT);
                    $field_max   = HTTP::_GP('field_max', 0);

                    $config			= Config::get();
    
                    if ($Galaxy > $config->max_galaxy || $System > $config->max_system || $Planet > $config->max_planets) {
                        $this->printMessage($LNG['cr_complete_all2'], true, array('?page=create&class=planet', 3));
                    }
				
                    $ISUser		= $GLOBALS['DATABASE']->getFirstRow("SELECT id, authlevel FROM ".USERS." WHERE id = '".$id."' AND universe = '".Universe::current()."';");
                    if(!PlayerUtil::checkPosition(Universe::current(), $Galaxy, $System, $Planet) || !isset($ISUser)) {
                        $this->printMessage($LNG['cr_complete_all'], true, array('?page=create&class=planet', 3));
                    }

                    $planetId	= PlayerUtil::createPlanet($Galaxy, $System, $Planet, Universe::current(), $id, NULL, false, $ISUser['authlevel']);
						
                    $SQL  = "UPDATE ".PLANETS." SET ";
				
                    if ($_POST['diameter_check'] != 'on' || $field_max > 0)
                        $SQL .= "field_max = '".$field_max."' ";
			
                    if (!empty($name))
                        $SQL .= ", name = '".$GLOBALS['DATABASE']->sql_escape($name)."' ";

                    $SQL .= "WHERE ";
                    $SQL .= "id = '".$planetId."'";
                    $GLOBALS['DATABASE']->query($SQL);

                    $this->printMessage($LNG['cr_complete_succes'], true, array('?page=create&class=planet', 3));
                }

                $this->assign(array());
			
                $this->display('page.createPagePlanet.default.tpl');
            break;
            default:
                $this->assign(array());
			
                $this->display('page.createPage.default.tpl');
            break;	
        }
	}
}
