<?php
//$new_code
/**
 *  2Moons
 *  Copyright (C) 2012 Jan Kröpke
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @package 2Moons
 * @author Jan Kröpke <info@2moons.cc>
 * @copyright 2012 Jan Kröpke <info@2moons.cc>
 * @license http://www.gnu.org/licenses/gpl.html GNU GPLv3 License
 * @version 1.7.3 (2013-05-19)
 * @info $Id: class.ShowOfficierPage.php 2632 2013-03-18 19:05:14Z slaver7 $
 * @link http://2moons.cc/
 */


class ShowPremiumPage extends AbstractGamePage
{
	public static $requireModule = MODULE_PREMIUM;

	function __construct() 
	{
		parent::__construct();
	}

	public function UpdateExtra($Element)
	{
		global $PLANET, $USER, $reslist, $resource, $pricelist, $LNG;
		
		$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
			
		if (!BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources)) {
			return;
		}
        
        $amount = HTTP::_GP('amount', 0);
		$USER[$resource[$Element]]	= max($USER[$resource[$Element]], TIMESTAMP) + ($pricelist[$Element]['time']) * $amount;
        
        $href = 'game.php?page=premium'; 
        require_once('includes/subclasses/subclass.UpdateMaxAmount.php');
        require_once('includes/subclasses/subclass.UpdateResAmount.php');
		require_once('includes/subclasses/subclass.UpdateSqlGeneral.php');
	}
	
	public function show()
	{
		global $USER, $PLANET, $resource, $reslist, $LNG, $pricelist, $requeriments;
		
		$updateID	  = HTTP::_GP('id', 0);
		
		if (!empty($updateID) && $_SERVER['REQUEST_METHOD'] === 'POST' && $USER['urlaubs_modus'] == 0)
		{
			if(in_array($updateID, $reslist['premium'])) {
				$this->UpdateExtra($updateID);
			}
		}
		
		$this->tplObj->loadscript('officier.js');		
		
		$premiumList	= array();
		
		if(isModuleAvailable(MODULE_PREMIUM)) 
		{
			foreach($reslist['premium'] as $Element)
			{
				if($USER[$resource[$Element]] > TIMESTAMP) {
					$this->tplObj->execscript("GetOfficerTime(".$Element.", ".($USER[$resource[$Element]] - TIMESTAMP).");");
				}
			
				$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
				$buyable			= BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources);
				$costOverflow		= BuildFunctions::getRestPrice($USER, $PLANET, $Element, $costResources);
				$elementBonus		= BuildFunctions::getAvalibleBonus($Element);
		
				$premiumList[$Element]	= array(
					'timeLeft'			=> max($USER[$resource[$Element]] - TIMESTAMP, 0),
					'costResources'	    => $costResources,
					'buyable'			=> $buyable,
					'time'				=> $pricelist[$Element]['time'],
					'costOverflow'		=> $costOverflow,
					'elementBonus'		=> $elementBonus,
				);
			}
		}
		
		$this->assign(array(	
			'premiumList'	=> $premiumList,
		));
		
		$this->display('page.premium.default.tpl');
	}
}
//$new_code