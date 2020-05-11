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

if ($USER['authlevel'] == AUTH_USR)
{
	throw new Exception("Permission error!");
}

function ShowAutoCompletePage()
{
	$searchText	= HTTP::_GP('term', '', UTF8_SUPPORT);
	$searchList	= array();
	
	if(empty($searchText) || $searchText === '#') {
		echo json_encode(array());
		exit;
	}
	
	if(substr($searchText, 0, 1) === '#')
	{
		$where = 'id = '.((int) substr($searchText, 1));
		$orderBy = ' ORDER BY id ASC';
	}
	else
	{
		$where = "username LIKE '%".$GLOBALS['DATABASE']->escape($searchText, true)."%'";
		$orderBy = " ORDER BY (IF(username = '".$GLOBALS['DATABASE']->sql_escape($searchText, true)."', 1, 0) + IF(username LIKE '".$GLOBALS['DATABASE']->sql_escape($searchText, true)."%', 1, 0)) DESC, username";
	}
	
	$userRaw		= $GLOBALS['DATABASE']->query("SELECT id, username FROM ".USERS." WHERE universe = ".Universe::getEmulated()." AND ".$where.$orderBy." LIMIT 20");
	while($userRow = $GLOBALS['DATABASE']->fetch_array($userRaw))
	{
		$searchList[]	= array(
			'label' => $userRow['username'].' (ID:'.$userRow['id'].')', 
			'value' => $userRow['username']
		);
	}
	
	echo json_encode($searchList);
	exit;
}