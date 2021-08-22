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

class ShowBuyDefensePage extends AbstractGamePage
{
	public static $requireModule = MODULE_BUY_DEFENSE;

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
			$this->printMessage(''.$LNG['bd_limit'].'',true, array('game.php?page=buyDefense', 2));	
        }
        //Проверка на колличество покупки
		$Count			= max(0, round(HTTP::_GP('count', 0.0)));
        if($Count == 0){
            $this->printMessage(''.$LNG['bd_limit'].'',true, array('game.php?page=buyDefense', 2));	
        }
        //Цена
		$cost			= BuildFunctions::instantPurchasePrice($Element) * $Count;
        //Ограничение по технологиям и $reslist
		if(!empty($Element) && in_array($Element, $reslist['defense']) && BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element, array()) && in_array($Element, $reslist['defense']) || in_array($Element, $reslist['not_bought']))
		{ 
            //Нехватка ресурса.
			if($USER[$resource[$resglobal['buy_instantly']]] < $cost )
			{
				$this->printMessage("".$LNG['bd_notres']."", true, array("game.php?page=buyDefense", 1));
				return;
			}
			//Всего хватает.
			$USER[$resource[$resglobal['buy_instantly']]] -= $cost;
			
            $sql	= 'UPDATE %%PLANETS%% SET
            '.$resource[$Element].' = '.$resource[$Element].' + '.$Count.'
            WHERE id = :Id;';
                
            Database::get()->update($sql, array(
                ':Id'	=> $PLANET['id']
            ));  
            $PLANET[$resource[$Element]]		+= $Count;
            
			$this->printMessage(''.$LNG['bd_buy_yes'].'', true, array("game.php?page=buyDefense", 1));
		}
	}
	
	function show()
	{
		global $PLANET, $LNG, $pricelist, $resource, $reslist, $USER, $resglobal;
        
        //Перебор
		$allowedElements = array();
		foreach($reslist['defense'] as $Element)
		{
			if(!BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element, array()) || !in_array($Element, $reslist['defense']) || in_array($Element, $reslist['not_bought']))
				continue;
			$allowedElements[] = $Element;
            
			$Cost[$Element]	= array($PLANET[$resource[$Element]], $LNG['tech'][$Element], BuildFunctions::instantPurchasePrice($Element), ($pricelist[$Element]['factor'])) ;
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
		
		$this->display('page.buyDefense.default.tpl');
	}
}
?>