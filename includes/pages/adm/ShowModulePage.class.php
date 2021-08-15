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

class ShowModulePage extends AbstractAdminPage
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
	
        $config	= Config::get();
        $module	= explode(';', $config->moduls);
        
        if(!isset($_GET['act'])){
            $_GET['act'] = '';
        }
        
        if($_GET['act']) {
            $module[HTTP::_GP('id', 0)]	= ($_GET['act'] == 'aktiv') ? 1 : 0;
            $config->moduls = implode(";", $module);
            $config->save();
            ClearCache();
        }
	
        $IDs	= range(0, MODULE_AMOUNT - 1);
        foreach($IDs as $ID => $Name) {
            $Modules[$ID]	= array(
                'name'	=> $LNG['mod_'.$ID],
                'state'	=> isset($module[$ID]) ? $module[$ID] : 1,
            );
        }
	
        asort($Modules);
        
		$this->assign(array(
            'Modules'				=> $Modules,
		));
		
		$this->display('page.module.default.tpl');
	}
}
