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

class ShowBattleHallPage extends AbstractGamePage
{
	public static $requireModule = MODULE_BATTLEHALL;

	function __construct()
    {
		parent::__construct();
	}

	function show()
	{
		global $USER, $LNG;
		$order  = HTTP::_GP('order', 'units');
		$sort   = HTTP::_GP('sort', 'desc');
		$sort   = strtoupper($sort) === "DESC" ? "DESC" : "ASC";


		switch($order)
		{
			case 'date':
				$key = '%%TOPKB%%.time '.$sort;
				break;
			case 'units':
			default:
				$key = '%%TOPKB%%.units '.$sort;
				break;
		}

		$db = Database::get();
		$sql = "SELECT *, (
			SELECT DISTINCT
			IF(%%TOPKB_USERS%%.username = '', GROUP_CONCAT(%%USERS%%.username SEPARATOR ' & '), GROUP_CONCAT(%%TOPKB_USERS%%.username SEPARATOR ' & '))
			FROM %%TOPKB_USERS%%
			LEFT JOIN %%USERS%% ON uid = %%USERS%%.id
			WHERE %%TOPKB_USERS%%.rid = %%TOPKB%%.rid AND role = 1
		) as attacker,
		(
			SELECT DISTINCT
			IF(%%TOPKB_USERS%%.username = '', GROUP_CONCAT(%%USERS%%.username SEPARATOR ' & '), GROUP_CONCAT(%%TOPKB_USERS%%.username SEPARATOR ' & '))
			FROM %%TOPKB_USERS%% INNER JOIN %%USERS%% ON uid = id
			WHERE %%TOPKB_USERS%%.rid = %%TOPKB%%.`rid` AND `role` = 2
		) as defender
		FROM %%TOPKB%% WHERE universe = :universe ORDER BY ".$key." LIMIT 100;";

		$top = $db->select($sql, array(
			':universe' => Universe::current()
		));

		$TopKBList	= array();
		foreach($top as $data)
		{
			$TopKBList[]	= array(
				'result'	=> $data['result'],
				'date'		=> _date($LNG['php_tdformat'], $data['time'], $USER['timezone']),
				'time'		=> TIMESTAMP - $data['time'],
				'units'		=> $data['units'],
				'rid'		=> $data['rid'],
				'attacker'	=> $data['attacker'],
				'defender'	=> $data['defender'],
			);
		}

		$this->assign(array(
			'TopKBList'		=> $TopKBList,
			'sort'			=> $sort,
			'order'			=> $order,
		));

		$this->display('page.battleHall.default.tpl');
	}
}