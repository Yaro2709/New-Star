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

class ShowResetPage extends AbstractAdminPage
{
	public static $requireModule = 0;

	function __construct() 
	{
        if (!allowedTo(str_replace(array(dirname(__FILE__), '\\', '/', '.php'), '', __FILE__))) throw new Exception("Permission error!");
		parent::__construct();
	}
		
	function show()
	{
        global $LNG, $reslist, $resource;

        $config	= Config::get();
	
        if ($_POST)
        {		
            foreach($reslist['build'] as $ID)
            {
                $dbcol['build'][$ID]	= "`".$resource[$ID]."` = '0'";
            }
		
            foreach($reslist['tech'] as $ID)
            {
                $dbcol['tech'][$ID]		= "`".$resource[$ID]."` = '0'";
            }
		
            foreach($reslist['fleet'] as $ID)
            {
                $dbcol['fleet'][$ID]	= "`".$resource[$ID]."` = '0'";
            }
		
            foreach($reslist['defense'] as $ID)
            {
                $dbcol['defense'][$ID]	= "`".$resource[$ID]."` = '0'";
            }
		
            foreach($reslist['officier'] as $ID)
            {
                $dbcol['officier'][$ID]	= "`".$resource[$ID]."` = '0'";
            }
		
            foreach($reslist['resstype'][1] as $ID)
            {
                if(isset($config->{$resource[$ID].'_start'}))
                {
                    $dbcol['resource_planet_start'][$ID]	= "`".$resource[$ID]."` = ".$config->{$resource[$ID].'_start'};
                }
            }
		
            foreach($reslist['resstype'][3] as $ID)
            {
                if(isset($config->{$resource[$ID].'_start'}))
                {
                    $dbcol['resource_user_start'][$ID]	= "`".$resource[$ID]."` = ".$config->{$resource[$ID].'_start'};
                }
            }
		
            // Players and Planets
		
            if ($_POST['players'] == 'on'){
                $ID	= $GLOBALS['DATABASE']->getFirstCell("SELECT `id_owner` FROM ".PLANETS." WHERE `universe` = ".Universe::current()." AND `galaxy` = '1' AND `system` = '1' AND `planet` = '1';");
                $GLOBALS['DATABASE']->multi_query("DELETE FROM ".USERS." WHERE `universe` = ".Universe::current()." AND `id` != '".$ID."';DELETE FROM ".PLANETS." WHERE `universe` = ".Universe::current()." AND `id_owner` != '".$ID."';");
            }
		
            if ($_POST['planets'] == 'on')
                $GLOBALS['DATABASE']->multi_query("DELETE FROM ".PLANETS." WHERE `universe` = ".Universe::current()." AND `id` NOT IN (SELECT id_planet FROM ".USERS." WHERE `universe` = ".Universe::current().");UPDATE ".PLANETS." SET `id_luna` = '0' WHERE `universe` = ".Universe::current().";");
			
            if ($_POST['moons']	== 'on'){
                $GLOBALS['DATABASE']->multi_query("DELETE FROM ".PLANETS." WHERE `planet_type` = '3' AND `universe` = ".Universe::current().";UPDATE ".PLANETS." SET `id_luna` = '0' WHERE `universe` = ".Universe::current().";");}

            // HANGARES Y DEFENSAS
            if ($_POST['defenses']	==	'on')
                $GLOBALS['DATABASE']->query("UPDATE ".PLANETS." SET ".implode(", ",$dbcol['defense'])." WHERE `universe` = ".Universe::current().";");
	
            if ($_POST['ships']	==	'on')
                $GLOBALS['DATABASE']->query("UPDATE ".PLANETS." SET ".implode(", ",$dbcol['fleet'])." WHERE `universe` = ".Universe::current().";");
	
            if ($_POST['h_d']	==	'on')
                $GLOBALS['DATABASE']->query("UPDATE ".PLANETS." SET `b_hangar` = '0', `b_hangar_id` = '' WHERE `universe` = ".Universe::current().";");
	

            // EDIFICIOS
            if ($_POST['edif_p']	==	'on')
                $GLOBALS['DATABASE']->query("UPDATE ".PLANETS." SET ".implode(", ",$dbcol['build']).", `field_current` = '0' WHERE `planet_type` = '1' AND `universe` = ".Universe::current().";");
	
            if ($_POST['edif_l']	==	'on')
                $GLOBALS['DATABASE']->query("UPDATE ".PLANETS." SET ".implode(", ",$dbcol['build']).", `field_current` = '0' WHERE `planet_type` = '3' AND `universe` = ".Universe::current().";");
	
            if ($_POST['edif']	==	'on')
                $GLOBALS['DATABASE']->query("UPDATE ".PLANETS." SET `b_building` = '0', `b_building_id` = '' WHERE `universe` = ".Universe::current().";");
	

            // INVESTIGACIONES Y OFICIALES
            if ($_POST['inves']	==	'on')
                $GLOBALS['DATABASE']->query("UPDATE ".USERS." SET ".implode(", ",$dbcol['tech'])." WHERE `universe` = ".Universe::current().";");
	
            if ($_POST['ofis']	==	'on')
                $GLOBALS['DATABASE']->query("UPDATE ".USERS." SET ".implode(", ",$dbcol['officier'])." WHERE `universe` = ".Universe::current().";");
	
            if ($_POST['inves_c']	==	'on')
                $GLOBALS['DATABASE']->query("UPDATE ".USERS." SET `b_tech_planet` = '0', `b_tech` = '0', `b_tech_id` = '0', `b_tech_queue` = '' WHERE `universe` = ".Universe::current().";");
	
	
            // RECURSOS
            if ($_POST['dark']	==	'on')
                $GLOBALS['DATABASE']->query("UPDATE ".USERS." SET ".implode(", ",$dbcol['resource_user_start'])." WHERE `universe` = ".Universe::current().";");
	
            if ($_POST['resources']	==	'on')
                $GLOBALS['DATABASE']->query("UPDATE ".PLANETS." SET ".implode(", ",$dbcol['resource_planet_start'])." WHERE `universe` = ".Universe::current().";");
	
            // GENERAL
            if ($_POST['notes']	==	'on')
                $GLOBALS['DATABASE']->query("DELETE FROM ".NOTES." WHERE `universe` = ".Universe::current().";");

            if ($_POST['rw']	==	'on')
                $GLOBALS['DATABASE']->query("DELETE FROM ".TOPKB." WHERE `universe` = ".Universe::current().";");

            if ($_POST['friends']	==	'on')
                $GLOBALS['DATABASE']->query("DELETE FROM ".BUDDY." WHERE `universe` = ".Universe::current().";");

            if ($_POST['alliances']	==	'on')
                $GLOBALS['DATABASE']->multi_query("DELETE FROM ".ALLIANCE." WHERE `ally_universe` = '".Universe::current()."';UPDATE ".USERS." SET `ally_id` = '0', `ally_register_time` = '0', `ally_rank_id` = '0' WHERE `universe` = ".Universe::current().";");

            if ($_POST['fleets']	==	'on')
                $GLOBALS['DATABASE']->query("DELETE FROM ".FLEETS." WHERE `fleet_universe` = '".Universe::current()."';");

            if ($_POST['banneds']	==	'on')
                $GLOBALS['DATABASE']->multi_query("DELETE FROM ".BANNED." WHERE `universe` = ".Universe::current().";UPDATE ".USERS." SET `bana` = '0', `banaday` = '0' WHERE `universe` = ".Universe::current().";");

            if ($_POST['messages']	==	'on')
                $GLOBALS['DATABASE']->multi_query("DELETE FROM ".MESSAGES." WHERE `message_universe` = '".Universe::current()."';");

            if ($_POST['statpoints']	==	'on')
                $GLOBALS['DATABASE']->query("DELETE FROM ".STATPOINTS." WHERE `universe` = ".Universe::current().";");

            $this->printMessage($LNG['re_reset_excess'], true, array('?page=reset&sid='.session_id(), 3));
        }

        $this->assign(array());
	
        $this->display('page.reset.default.tpl');
	}
}