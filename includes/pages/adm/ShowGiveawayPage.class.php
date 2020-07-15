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

class ShowGiveawayPage extends AbstractAdminPage
{
	public static $requireModule = 0;

	function __construct() 
	{
        if (!allowedTo(str_replace(array(dirname(__FILE__), '\\', '/', '.php'), '', __FILE__))) throw new Exception("Permission error!");
		parent::__construct();
	}
		
	function show()
	{
        global $LNG, $resource, $reslist;
        
        $action	= HTTP::_GP('action', '');
        if ($action == 'send') {
            $planet			= HTTP::_GP('planet', 0);
            $moon			= HTTP::_GP('moon', 0);
            $mainplanet		= HTTP::_GP('mainplanet', 0);
            $no_inactive	= HTTP::_GP('no_inactive', 0);
		
            if (!$planet && !$moon) {
                $this->printMessage($LNG['gi_selectplanettype'], true, array('?page=giveaway', 3));
            }
		
            $planetIN	= array();
		
            if ($planet) {
                $planetIN[]	= "'1'";
            } 
		
            if ($moon) {
                $planetIN[]	= "'3'";
            } 
		
            $data		= array();
		
            $DataIDs	= array_merge($reslist['resstype'][1], $reslist['resstype'][3], $reslist['build'], $reslist['tech'], $reslist['fleet'], $reslist['defense'], $reslist['officier']);
		
            $logOld		= array();
            $logNew		= array();
		
            foreach($DataIDs as $ID)
            {
                $amount	= max(0, round(HTTP::_GP('element_'.$ID, 0.0)));
                $data[]	= $resource[$ID]." = ".$resource[$ID]." + ".$amount;
			
                $logOld[$ID]	= 0;
                $logNew[$ID]	= $amount;
            }
		
            $SQL		= "UPDATE ".PLANETS." p INNER JOIN ".USERS." u ON p.id_owner = u.id";
		
            if ($mainplanet == true) {
                $SQL	.= " AND p.id = u.id_planet";
            }
		
            if ($no_inactive == true) {
                $SQL	.= " AND u.onlinetime > ".(TIMESTAMP - INACTIVE);
            }
		
            $SQL	.= " SET ".implode(', ', $data)." WHERE p.universe = ".Universe::current()." AND p.planet_type IN (".implode(',', $planetIN).")";
		
            $GLOBALS['DATABASE']->query($SQL);
		
            $LOG = new Log(4);
            $LOG->target = 0;
            $LOG->old = $logOld;
            $LOG->new = $logNew;
            $LOG->save();
		
            $this->printMessage($LNG['gi_success'], true, array('?page=giveaway', 3));
        }	
	
        $this->assign(array(
            'reslist'		=> $reslist
        ));
        $this->display('page.giveaway.default.tpl');
	}
}