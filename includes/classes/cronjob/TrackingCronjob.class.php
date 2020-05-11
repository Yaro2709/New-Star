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

require_once 'includes/classes/cronjob/CronjobTask.interface.php';

class TrackingCronjob implements CronjobTask
{
	function run()
	{
		$serverData['php']			= PHP_VERSION;
		
		try
		{
			$sql	= 'SELECT register_time FROM %%USERS%% WHERE id = :userId';
			$serverData['installSince']	= Database::get()->selectSingle($sql, array(
				':userId'	=> ROOT_USER
			), 'register_time');
		}
		catch (Exception $e)
		{
			$serverData['installSince']	= NULL;
		}
		
		try
		{
			$sql	= 'SELECT COUNT(*) as state FROM %%USERS%%;';
			$serverData['users']		= Database::get()->selectSingle($sql, array(), 'state');
		}
		catch (Exception $e)
		{
			$serverData['users']		= NULL;
		}
		
		try {
			$sql	= 'SELECT COUNT(*) as state FROM %%CONFIG%%;';
			$serverData['unis']			= Database::get()->selectSingle($sql, array(), 'state');
		} catch (Exception $e) {
			$serverData['unis']			= NULL;
		}

		$serverData['version']		= Config::get(ROOT_UNI)->VERSION;
		
		$ch	= curl_init('http://tracking.jkroepke.de/');
		curl_setopt($ch, CURLOPT_HTTPGET, true);
		curl_setopt($ch, CURLOPT_AUTOREFERER, true);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $serverData);
		curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (compatible; 2Moons/".$serverData['version']."; +https://github.com/jkroepke/2Moons)");
		
		curl_exec($ch);
		curl_close($ch);
	}
}