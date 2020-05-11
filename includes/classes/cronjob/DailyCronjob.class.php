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

class DailyCronJob implements CronjobTask
{
	function run()
	{
		$this->optimizeTables();
		$this->clearCache();
		$this->reCalculateCronjobs();
		$this->clearEcoCache();
	}
	
	function optimizeTables()
	{
		$sql			= "SHOW TABLE STATUS FROM `".DB_NAME."`;";
		$sqlTableRaw	= Database::get()->nativeQuery($sql);

		$prefixCounts	= strlen(DB_PREFIX);
		$dbTables		= array();

		foreach($sqlTableRaw as $table)
		{
			if (DB_PREFIX == substr($table['Name'], 0, $prefixCounts)) {
				$dbTables[] = $table['Name'];
			}
		}

		if(!empty($dbTables))
		{
			Database::get()->nativeQuery("OPTIMIZE TABLE ".implode(', ', $dbTables).";");
		}
	}

	function clearCache()
	{
		ClearCache();
	}
	
	function reCalculateCronjobs()
	{
		Cronjob::reCalculateCronjobs();
	}
	
	function clearEcoCache()
	{
		$sql	= "UPDATE %%PLANETS%% SET eco_hash = '';";
		Database::get()->update($sql);
	}
}
