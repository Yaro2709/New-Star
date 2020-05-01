<?php

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


class ShowOfficierPage extends AbstractGamePage
{
	public static $requireModule = MODULE_OFFICIER;

	function __construct() 
	{
		parent::__construct();
	}

	public function UpdateOfficier($Element)
	{
		global $PLANET, $USER, $reslist, $resource, $pricelist, $LNG;
		
		$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
			
		if (!BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element) 
			|| !BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources) 
			|| $pricelist[$Element]['max'] <= $USER[$resource[$Element]]) {
			return;
		}
        
        $amount = HTTP::_GP('amount', 0);
		$USER[$resource[$Element]]	+= $amount;
        
        $href = 'game.php?page=officier'; 
        require_once('includes/subclasses/subclass.UpdateMaxLvl.php');
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
			if(in_array($updateID, $reslist['officier'])) {
				$this->UpdateOfficier($updateID);
			}
		}
		
		$this->tplObj->loadscript('officier.js');		
		
		$officierList	= array();
		
		if(isModuleAvailable(MODULE_OFFICIER))
		{
			foreach($reslist['officier'] as $Element)
			{
   
                $techTreeList		 = array();
                $requirementsList	 = array();
                if(isset($requeriments[$Element]))
                {
                    foreach($requeriments[$Element] as $requireID => $RedCount)
                    {
                        $requirementsList[$requireID]	= array(
                            'count' => $RedCount,
                            'own'   => isset($PLANET[$resource[$requireID]]) ? $PLANET[$resource[$requireID]] : $USER[$resource[$requireID]]
                        );
                    }
                }
                
                $techTreeList[$Element]	= $requirementsList;
                
				$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
				$buyable			= BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources);
				$costOverflow		= BuildFunctions::getRestPrice($USER, $PLANET, $Element, $costResources);
				$elementBonus		= BuildFunctions::getAvalibleBonus($Element);
				
				$officierList[$Element]	= array(
					'level'				=> $USER[$resource[$Element]],
					'maxLevel'			=> $pricelist[$Element]['max'],
                    'factor'		    => $pricelist[$Element]['factor'],
					'costResources'	    => $costResources,
					'buyable'			=> $buyable,
					'costOverflow'		=> $costOverflow,
					'elementBonus'		=> $elementBonus,
					'AllTech'			=> $techTreeList,
					'techacc'			=> BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element),
				);
			}
		}
		
		$this->assign(array(	
			'officierList'		=> $officierList,
		));
		
		$this->display('page.officier.default.tpl');
	}
}