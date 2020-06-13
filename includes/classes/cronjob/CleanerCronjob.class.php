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

class CleanerCronjob implements CronjobTask
{
	function run()
	{
        $config	= Config::get(ROOT_UNI);

		$unis	= Universe::availableUniverses();
	
		//Delete old messages
		$del_before 	= TIMESTAMP - ($config->del_oldstuff * 86400);
		$del_inactive 	= TIMESTAMP - ($config->del_user_automatic * 86400);
		$del_deleted 	= TIMESTAMP - ($config->del_user_manually * 86400);
		$del_messages 	= TIMESTAMP - ($config->message_delete_days * 86400);

		if($del_inactive === TIMESTAMP)
		{
			$del_inactive = 2147483647;
		}

		$sql	= 'DELETE FROM %%MESSAGES%% WHERE `message_time` < :time;';
		Database::get()->delete($sql, array(
			':time'	=> $del_before
		));

		$sql	= 'DELETE FROM %%ALLIANCE%% WHERE `ally_members` = 0;';
		Database::get()->delete($sql);

		$sql	= 'DELETE FROM %%PLANETS%% WHERE `destruyed` < :time AND `destruyed` != 0;';
		Database::get()->delete($sql, array(
			':time'	=> TIMESTAMP
		));

		$sql	= 'DELETE FROM %%SESSION%% WHERE `lastonline` < :time;';
		Database::get()->delete($sql, array(
			':time'	=> TIMESTAMP - SESSION_LIFETIME
		));

		$sql	= 'DELETE FROM %%FLEETS_EVENT%% WHERE fleetID NOT IN (SELECT fleet_id FROM %%FLEETS%%);';
		Database::get()->delete($sql);
        
        $sql	= 'DELETE FROM %%LOG_FLEETS%% WHERE `start_time` < :time;';
		Database::get()->delete($sql, array(
			':time'	=> $del_before
		));

		$sql	= 'UPDATE %%USERS%% SET `email_2` = `email` WHERE `setmail` < :time;';
		Database::get()->update($sql, array(
			':time'	=> TIMESTAMP
		));

		$sql	= 'SELECT `id` FROM %%USERS%% WHERE `authlevel` = :authlevel
		AND ((`db_deaktjava` != 0 AND `db_deaktjava` < :timeDeleted) OR `onlinetime` < :timeInactive);';

		$deleteUserIds = Database::get()->select($sql, array(
			':authlevel'	=> AUTH_USR,
			':timeDeleted'	=> $del_deleted,
			':timeInactive'	=> $del_inactive
		));

		if(!empty($deleteUserIds))
		{
			foreach($deleteUserIds as $dataRow)
			{
				PlayerUtil::deletePlayer($dataRow['id']);
			}	
		}

		$sql	= 'DELETE FROM %%MESSAGES%% WHERE `message_deleted` < :time;';
		Database::get()->delete($sql, array(
			':time'	=> $del_messages
		));
	}
}