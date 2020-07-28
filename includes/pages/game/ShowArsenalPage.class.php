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

class ShowArsenalPage extends AbstractGamePage
{
	public static $requireModule = MODULE_ARSENAL;

	function __construct() 
	{
		parent::__construct();
	}
	
	public function show()
	{
		global $USER, $PLANET, $resource, $reslist, $LNG, $pricelist;
	
		$arsList	= array();
		
		if(isModuleAvailable(MODULE_ARSENAL))
		{
			foreach($reslist['ars'] as $Element)
			{
				$elementBonus		= BuildFunctions::getAvalibleBonus($Element);
				
				$arsList[$Element]	= array(
					'level'				=> $USER[$resource[$Element]],
                    'factor'		    => $pricelist[$Element]['factor'],
					'elementBonus'		=> $elementBonus,
				);
			}
		}
        
		$this->assign(array(
			'arsList'		=> $arsList,
		));
		
		$this->display('page.arsenal.default.tpl');
	}
}