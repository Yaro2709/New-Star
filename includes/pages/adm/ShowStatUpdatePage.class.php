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

class ShowStatUpdatePage extends AbstractAdminPage
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
        
        require_once('includes/classes/class.statbuilder.php');
        $stat			= new statbuilder();
        $result			= $stat->MakeStats();
        $memory_p		= str_replace(array("%p", "%m"), $result['memory_peak'], $LNG['sb_top_memory']);
        $memory_e		= str_replace(array("%e", "%m"), $result['end_memory'], $LNG['sb_final_memory']);
        $memory_i		= str_replace(array("%i", "%m"), $result['initial_memory'], $LNG['sb_start_memory']);
        $stats_end_time	= sprintf($LNG['sb_stats_update'], $result['totaltime']);
        $stats_sql		= sprintf($LNG['sb_sql_counts'], $result['sql_count']);

        $this->printMessage(''.$LNG['sb_stats_updated'].$stats_end_time.$memory_i.$memory_e.$memory_p.$stats_sql.'', false, NULL, true);
	}
}
