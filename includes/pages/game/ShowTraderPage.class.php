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

class ShowTraderPage extends AbstractGamePage
{
	public static $requireModule = MODULE_TRADER;

	function __construct() 
	{
		parent::__construct();
	}
    
	public function show() 
	{
		global $LNG, $USER, $resource, $Charge;

		$this->assign(array(
			'tr_cost_dm_trader'		=> sprintf($LNG['tr_cost_dm_trader'], pretty_number(Config::get()->cost_trader), $LNG['tech'][Config::get()->ressources_trader]),
			'charge'				=> $Charge,
			'resource'				=> $resource,
			'requiredDarkMatter'	=> $USER['darkmatter'] < Config::get()->cost_trader ? sprintf($LNG['tr_not_enought'], $LNG['tech'][Config::get()->ressources_trader]) : false,
		));
		
		$this->display("page.trader.default.tpl");
	}
		
	function trade()
	{
		global $USER, $LNG, $Charge;
		
		if ($USER['darkmatter'] < Config::get()->cost_trader) {
			$this->redirectTo('game.php?page=trader');
		}
		
		$resourceID	= HTTP::_GP('resource', 0);
		
		if(!in_array($resourceID, array_keys($Charge))) {
			$this->printMessage($LNG['invalid_action'], array(array(
				'label'	=> $LNG['sys_back'],
				'url'	=> 'game.php?page=trader'
			)));
		}
		
		$tradeResources	= array_values(array_diff(array_keys($Charge[$resourceID]), array($resourceID)));
		$this->tplObj->loadscript("trader.js");
		$this->assign(array(
			'tradeResourceID'	=> $resourceID,
			'tradeResources'	=> $tradeResources,
			'charge' 			=> $Charge[$resourceID],
		));

		$this->display('page.trader.trade.tpl');
	}
	
	function send()
	{
		global $USER, $PLANET, $LNG, $resource, $Charge;
		
		if ($USER['darkmatter'] < Config::get()->cost_trader) {
			$this->redirectTo('game.php?page=trader');
		}
		
		$resourceID	= HTTP::_GP('resource', 0);
		
		if(!in_array($resourceID, array_keys($Charge))) {
			$this->printMessage($LNG['invalid_action'], array(array(
				'label'	=> $LNG['sys_back'],
				'url'	=> 'game.php?page=trader'
			)));
		}

		$getTradeResources	= HTTP::_GP('trade', array());
		
		$tradeResources		= array_values(array_diff(array_keys($Charge[$resourceID]), array($resourceID)));
		$tradeSum 			= 0;
		
		foreach($tradeResources as $tradeRessID)
		{
			if(!isset($getTradeResources[$tradeRessID]))
			{
				continue;
			}
			$tradeAmount	= max(0, round((float) $getTradeResources[$tradeRessID]));
			
			if(empty($tradeAmount) || !isset($Charge[$resourceID][$tradeRessID]))
			{
				continue;  
			}
			
			if(isset($PLANET[$resource[$resourceID]]))
			{
				$usedResources	= $tradeAmount * $Charge[$resourceID][$tradeRessID];
				
				if($usedResources > $PLANET[$resource[$resourceID]])
				{
                    if ($tradeSum > 0)
					{
						$USER[$resource[Config::get()->ressources_trader]]	-= Config::get()->darkmatter_cost_trader;
					}
                    
					$this->printMessage(sprintf($LNG['tr_not_enought'], $LNG['tech'][$resourceID]), array(array(
						'label'	=> $LNG['sys_back'],
						'url'	=> 'game.php?page=trader'
					)));
				}
				
				$tradeSum	  						+= $tradeAmount;
				$PLANET[$resource[$resourceID]]		-= $usedResources;
			}
			elseif(isset($USER[$resource[$resourceID]]))
			{
				if($resourceID == Config::get()->ressources_trader)
				{
					$USER[$resource[$resourceID]]	-= Config::get()->cost_trader;
				}
				
				$usedResources	= $tradeAmount * $Charge[$resourceID][$tradeRessID];
				
				if($usedResources > $USER[$resource[$resourceID]])
				{
					$this->printMessage(sprintf($LNG['tr_not_enought'], $LNG['tech'][$resourceID]), array(array(
						'label'	=> $LNG['sys_back'],
						'url'	=> 'game.php?page=trader'
					)));
				}
				
				$tradeSum	  						+= $tradeAmount;
				$USER[$resource[$resourceID]]		-= $usedResources;
				
				if($resourceID == Config::get()->ressources_trader)
				{
					$USER[$resource[$resourceID]]	+= Config::get()->cost_trader;
				}
			}
			else
			{
				throw new Exception('Unknown resource ID #'.$resourceID);
			}
			
			if(isset($PLANET[$resource[$tradeRessID]]))
			{
				$PLANET[$resource[$tradeRessID]]	+= $tradeAmount;
			}
			elseif(isset($USER[$resource[$tradeRessID]]))
			{
				$USER[$resource[$tradeRessID]]		+= $tradeAmount;
			}
			else
			{
				throw new Exception('Unknown resource ID #'.$tradeRessID);
			}
		}
		
		if ($tradeSum > 0)
		{
			$USER[$resource[Config::get()->ressources_trader]]	-= Config::get()->cost_trader;
		}
		
		$this->printMessage($LNG['tr_exchange_done'], array(array(
			'label'	=> $LNG['sys_forward'],
			'url'	=> 'game.php?page=trader'
		)));
	}
}