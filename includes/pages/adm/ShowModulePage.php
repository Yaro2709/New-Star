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

if (!allowedTo(str_replace(array(dirname(__FILE__), '\\', '/', '.php'), '', __FILE__))) throw new Exception("Permission error!");

function ShowModulePage()
{
	global $LNG;

	$config	= Config::get(Universe::getEmulated());
	$module	= explode(';', $config->moduls);
	
	if($_GET['mode']) {
		$module[HTTP::_GP('id', 0)]	= ($_GET['mode'] == 'aktiv') ? 1 : 0;
		$config->moduls = implode(";", $module);
		$config->save();
		ClearCache();
	}
	
	$IDs	= range(0, MODULE_AMOUNT - 1);
	foreach($IDs as $ID => $Name) {
		$Modules[$ID]	= array(
			'name'	=> $LNG['modul_'.$ID],
			'state'	=> isset($module[$ID]) ? $module[$ID] : 1,
		);
	}
	
	asort($Modules);
	$template	= new template();

	$template->assign_vars(array(
		'Modules'				=> $Modules,
		'mod_module'			=> $LNG['mod_module'],
		'mod_info'				=> $LNG['mod_info'],
		'mod_active'			=> $LNG['mod_active'],
		'mod_deactive'			=> $LNG['mod_deactive'],
		'mod_change_active'		=> $LNG['mod_change_active'],
		'mod_change_deactive'	=> $LNG['mod_change_deactive'],
	));
	
	$template->show('ModulePage.tpl');
}