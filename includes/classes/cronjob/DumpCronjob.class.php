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

class DumpCronjob implements CronjobTask
{
	function run()
	{
		$prefixCounts	= strlen(DB_PREFIX);
		$dbTables		= array();
		$tableNames		= Database::get()->nativeQuery('SHOW TABLE STATUS FROM '.DB_NAME.';');

		foreach($tableNames as $table)
		{
			if(DB_PREFIX == substr($table['Name'], 0, $prefixCounts))
			{
				$dbTables[]	= $table['Name'];
			}
		}
		
		if(empty($dbTables))
		{
			throw new Exception('No tables found for dump.');
		}
		
		$fileName	= '2MoonsBackup_'.date('d_m_Y_H_i_s', TIMESTAMP).'.sql';
		$filePath	= 'includes/backups/'.$fileName;
		
		require 'includes/classes/SQLDumper.class.php';
		
		$dump	= new SQLDumper;
		$dump->dumpTablesToFile($dbTables, $filePath);
	}
}