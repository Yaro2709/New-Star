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

class ShowCreateMoonPage extends AbstractGamePage
{
	public static $requireModule = MODULE_CREATE_MOON;

	function __construct() 
	{
		parent::__construct();
	}
    
	function buy()
	{
		global $LNG, $PLANET, $USER, $resource, $resglobal;
		
        if($USER[$resource[$resglobal['buy_moon_res']]] < $resglobal['buy_moon_price']){
            $this->printMessage($LNG['crm_not_res'], array('game.php?page=createMoon', 3));
		}else{
		
            if($PLANET['planet_type'] == 1 && $PLANET['id_luna'] == 0){
                $a = mt_rand(8000, 9000);
                $u_have_moon = PlayerUtil::createMoon($PLANET['universe'], $PLANET['galaxy'], $PLANET['system'], $PLANET['planet'], $USER['id'],'', $a, '', 'Moon');
                $USER[$resource[$resglobal['buy_moon_res']]] -= $resglobal['buy_moon_price'];
                $this->printMessage($LNG['crm_create'], array('game.php?page=overview', 3));
            }else{
				$this->printMessage($LNG['crm_moon_is'], true, array('game.php?page=overview', 2));
            }
		}
	}
    
	function show()
	{
        global $LNG, $PLANET, $USER, $resource, $resglobal;
        
		$this->tplObj->assign_vars(array(	   
            'buy_moon_price'        => $resglobal['buy_moon_price'],
            'buy_moon_res_user'     => $USER[$resource[$resglobal['buy_moon_res']]],
            'buy_moon_res'          => $resglobal['buy_moon_res'],
		));
		$this->display('page.createmoon.default.tpl');
	}
}