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

class ShowLoginPage extends AbstractLoginPage
{
	public static $requireModule = 0;

	function __construct() 
	{
		parent::__construct();
	}
	
	function show() 
	{
		if (empty($_POST)) {
			HTTP::redirectTo('index.php');	
		}

		$db = Database::get();

		$username = HTTP::_GP('username', '', UTF8_SUPPORT);
		$password = HTTP::_GP('password', '', true);

		$sql = "SELECT id, password FROM %%USERS%% WHERE universe = :universe AND username = :username;";
		$loginData = $db->selectSingle($sql, array(
			':universe'	=> Universe::current(),
			':username'	=> $username
		));

		if (!empty($loginData))
		{
			$hashedPassword = PlayerUtil::cryptPassword($password);
			if($loginData['password'] != $hashedPassword)
			{
				// Fallback pre 1.7
				if($loginData['password'] == md5($password)) {
					$sql = "UPDATE %%USERS%% SET password = :hashedPassword WHERE id = :loginID;";
					$db->update($sql, array(
						':hashedPassword'	=> $hashedPassword,
						':loginID'			=> $loginData['id']
					));
				} else {
					HTTP::redirectTo('index.php?code=1');	
				}
			}

			$session	= Session::create();
			$session->userId		= (int) $loginData['id'];
			$session->adminAccess	= 0;
			$session->save();

			HTTP::redirectTo('game.php');	
		}
		else
		{
			HTTP::redirectTo('index.php?code=1');
		}
	}
}
