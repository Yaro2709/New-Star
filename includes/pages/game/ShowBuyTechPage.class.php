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

class ShowBuyTechPage extends AbstractGamePage
{
	public static $requireModule = MODULE_BUY_TECH;

	function __construct() 
	{
		parent::__construct();
	}
	
	public function send()
	{
		global $USER, $PLANET, $LNG, $pricelist, $resource, $reslist, $resglobal;
        
        //Проверка на цену покупки
		$Element			= HTTP::_GP('Element', 0);
		if($Element == 0){
			$this->printMessage(''.$LNG['bd_limit'].'',true, array('game.php?page=buyTech', 2));	
        }
        //Проверка на колличество покупки
		$Count			= max(0, round(HTTP::_GP('count', 0.0)));
        if($Count == 0){
            $this->printMessage(''.$LNG['bd_limit'].'',true, array('game.php?page=buyTech', 2));	
        }
        //Цена
		$cost			= BuildFunctions::instantPurchasePrice($Element) * pow(($pricelist[$Element]['factor']), ($USER[$resource[$Element]] + $Count));
        //Ограничение по технологиям и $reslist
		if(!empty($Element) && in_array($Element, $reslist['tech']) && BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element, array()) && in_array($Element, $reslist['tech']) || in_array($Element, $reslist['not_bought']))
		{ 
            //Нехватка ресурса.
			if($USER[$resource[$resglobal['buy_instantly']]] < $cost )
			{
				$this->printMessage("".$LNG['bd_notres']."", true, array("game.php?page=buyTech", 1));
				return;
			}
			//Всего хватает.
			$USER[$resource[$resglobal['buy_instantly']]] -= $cost;
			
            $sql	= 'UPDATE %%USERS%% SET
            '.$resource[$Element].' = '.$resource[$Element].' + '.$Count.'
            WHERE id = :Id;';
                
            Database::get()->update($sql, array(
                ':Id'	=> $USER['id']
            ));  
            $USER[$resource[$Element]]		+= $Count;
            
			$this->printMessage(''.$LNG['bd_buy_yes'].'', true, array("game.php?page=buyTech", 1));
		}
	}
	
	function show()
	{
		global $PLANET, $LNG, $pricelist, $resource, $reslist, $USER, $resglobal;
        
        //Перебор
		$allowedElements = array();
		foreach($reslist['tech'] as $Element)
		{
			if(!BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element, array()) || !in_array($Element, $reslist['tech']) || in_array($Element, $reslist['not_bought']))
				continue;
			$allowedElements[] = $Element;
            
			$Cost[$Element]	= array($USER[$resource[$Element]], $LNG['tech'][$Element], BuildFunctions::instantPurchasePrice($Element), ($pricelist[$Element]['factor'])) ;
		}
		//Бан, если пусто.
		if(empty($Cost)) {
			$this->printMessage("".$LNG['bd_buy_no_tech']."");
		}
		$this->tplObj->loadscript('buy.js');
		$this->tplObj->assign_vars(array(
            'buy_instantly'	=> $resglobal['buy_instantly'],
			'Elements'	    => $allowedElements,
			'CostInfos'	    => $Cost,
		));
		
		$this->display('page.buyTech.default.tpl');
	}
}
?>