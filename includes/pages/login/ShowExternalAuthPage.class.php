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

class ShowExternalAuthPage extends AbstractLoginPage
{
	public static $requireModule = 0;

	function __construct() 
	{
		parent::__construct();
	}
	
	function show() 
	{
		$method			= HTTP::_GP('method', '');
		$method			= strtolower(str_replace(array('_', '\\', '/', '.', "\0"), '', $method));
		$path			= 'includes/classes/extauth/'.$method.'.class.php';
		
		if(!file_exists($path)) {
			HTTP::redirectTo('index.php');			
		}

		$session	= Session::create();

		require 'includes/classes/extauth/externalAuth.interface.php';
		require $path;
		
		$methodClass	= ucwords($method).'Auth';

		/** @var $authObj externalAuth */
		$authObj		= new $methodClass;
		
		if(!$authObj->isActiveMode())
		{
			$session->delete();
			$this->redirectTo('index.php?code=5');
		}
		
		if(!$authObj->isValid())
		{
			$session->delete();
			$this->redirectTo('index.php?code=4');
		}
		
		$loginData	= $authObj->getLoginData();
		
		if(empty($loginData))
		{
			$session->delete();
			$this->redirectTo('index.php?page=register&externalAuth[account]='.$authObj->getAccount().'&externalAuth[method]='.$method);
		}

		$session->userId		= (int) $loginData['id'];
		$session->adminAccess	= 0;
		$session->save();
		$this->redirectTo("game.php");	
	}
}