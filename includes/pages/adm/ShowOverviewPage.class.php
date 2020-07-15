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

class ShowOverviewPage extends AbstractAdminPage
{
	public static $requireModule = 0;

	function __construct() 
	{
		parent::__construct();
	}
		
	function show()
	{
		global $LNG;
        
        //где "*"это, вы можете изменить это на конкретный тип файла, если хотите, "*.sql" или вы можете сделать несколько типов файлов, как это:
        //glob($directory . "*.{jpg,png,gif}",GLOB_BRACE)
        $directory = "./includes/backups/";
        $filecount = 0;
        $files = glob($directory . "*.sql");
        if ($files){
            $filecount = count($files);
        }
        
		$this->assign(array(
            'filecount'	    => $filecount,
            'user'	        => Config::get()->users_amount,
            'useronline'	=> $GLOBALS['DATABASE']->countquery("SELECT COUNT(*) FROM ".USERS." WHERE universe = ".Universe::current()." AND onlinetime > '".(TIMESTAMP - 30 * 60 )."';"),
            'userinactive'	=> $GLOBALS['DATABASE']->countquery("SELECT COUNT(*) FROM ".USERS." WHERE universe = ".Universe::current()." AND onlinetime < ".(TIMESTAMP - INACTIVE).";"),
            'supportticks'	=> $GLOBALS['DATABASE']->getFirstCell("SELECT COUNT(*) FROM ".TICKETS." WHERE universe = ".Universe::current()." AND status = 0;"),
            'log'	        => $GLOBALS['DATABASE']->getFirstCell("SELECT COUNT(*) FROM ".LOG." WHERE universe = ".Universe::current().";"),
            'cron'	        => $GLOBALS['DATABASE']->getFirstCell("SELECT COUNT(*) FROM ".CRONJOBS." WHERE isActive = 1;"),
            'news'	        => $GLOBALS['DATABASE']->getFirstCell("SELECT COUNT(*) FROM ".NEWS.""),
            'planet'	    => $GLOBALS['DATABASE']->getFirstCell("SELECT COUNT(*) FROM ".PLANETS." WHERE universe = ".Universe::current().";"),
		));
		
		$this->display('page.overview.default.tpl');
	}
}
