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

class ShowBuyBuildPage extends AbstractGamePage
{
	public static $requireModule = MODULE_BUY_BUILD;

	function __construct() 
	{
		parent::__construct();
	}
    
    private function CheckLabSettingsInQueue($Element)
	{
		global $PLANET, $CONF;
		if ($PLANET['b_building'] == 0)
			return true;
			
		$CurrentQueue		= unserialize($PLANET['b_building_id']);
		foreach($CurrentQueue as $ListIDArray) {
			if($ListIDArray[0] == $Element)
				return false;
		}

		return true;
	}
	
	public function send()
	{
		global $USER, $PLANET, $LNG, $pricelist, $resource, $reslist, $resglobal;
        
        $Elements = $reslist['allow'][$PLANET['planet_type']];
        $CurrentMaxFields  	= CalculateMaxPlanetFields($PLANET);
        //Проверка на цену покупки
		$Element			= HTTP::_GP('Element', 0);
		if($Element == 0){
			$this->printMessage(''.$LNG['bd_limit'].'',true, array('game.php?page=buyBuild', 2));	
        }
        //Проверка на колличество покупки
		$Count			= max(0, round(HTTP::_GP('count', 0.0)));
        if($Count == 0){
            $this->printMessage(''.$LNG['bd_limit'].'',true, array('game.php?page=buyBuild', 2));	
        }
        //Цена
		$cost			= BuildFunctions::instantPurchasePrice($Element) * pow(($pricelist[$Element]['factor']), ($PLANET[$resource[$Element]] + $Count));
        //Условие блока
        if (!$this->CheckLabSettingsInQueue($Element) ||  ($PLANET['field_current'] + $Count) > $CurrentMaxFields)
		{
			$this->redirectTo('game.php?page=buyBuild');
			return;
		}
        //Ограничение по технологиям и $reslist
		if(!empty($Element) && in_array($Element, $Elements) && BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element, array()) && in_array($Element, $Elements) || in_array($Element, $reslist['not_bought']))
		{ 
            //Нехватка ресурса.
			if($USER[$resource[$resglobal['buy_instantly']]] < $cost )
			{
				$this->printMessage("".$LNG['bd_notres']."", true, array("game.php?page=buyBuild", 1));
				return;
			}
			//Всего хватает.
			$USER[$resource[$resglobal['buy_instantly']]] -= $cost;
			$PLANET['field_current'] += $Count;
            
            $sql	= 'UPDATE %%PLANETS%% SET
            '.$resource[$Element].' = '.$resource[$Element].' + '.$Count.'
            WHERE id = :Id;';
                
            Database::get()->update($sql, array(
                ':Id'	=> $PLANET['id']
            ));  
            $PLANET[$resource[$Element]]		+= $Count;
            
			$this->printMessage(''.$LNG['bd_buy_yes'].'', true, array("game.php?page=buyBuild", 1));
		}
	}
	
	function show()
	{
		global $PLANET, $LNG, $pricelist, $resource, $reslist, $USER, $resglobal;
        
        //Перебор
        $Elements = $reslist['allow'][$PLANET['planet_type']];
		$allowedElements = array();
		foreach($Elements as $Element)
		{
			if(!BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element, array()) || !in_array($Element, $Elements) || in_array($Element, $reslist['not_bought']))
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
		
		$this->display('page.buyBuild.default.tpl');
	}
}
?>