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
 * @version 1.7.2 (2013-03-18)
 * @info $Id$
 * @link http://2moons.cc/
 */
 
class ShowResourcecalcPage extends AbstractGamePage
{
	public static $requireModule = 0;

	function __construct() 
	{
		parent::__construct();
	}
	
	function show()
	{
		global $LNG, $USER, $PLANET, $reslist;
		
		$elementList = array();
		$options 	= HTTP::_GP('options', 0);
		
		if($options == 400){
		$elementId = array(401,402,403,405,404,406,410,407,408,409,411);
		foreach($elementId as $Element){
			
			$costResources		= BuildFunctions::getElementPriceCalcu($USER, $PLANET, $Element);
			if(empty($costResources[901])) { $costResources[901] = -1; }
			if(empty($costResources[902])) { $costResources[902] = -1; }
			if(empty($costResources[903])) { $costResources[903] = -1; }
			if(empty($costResources[911])) { $costResources[911] = -1; }
			if(empty($costResources[921])) { $costResources[921] = -1; }
			//if(empty($costResources[922])) { $costResources[922] = -1; }
			
			$elementList[$Element]	= array(
				'id'				=> $Element,
				'costResources'		=> $costResources,
				'factor'			=> 99,
			);
		}
		}elseif($options == 200){
		$elementId = array(212,202,203,204,205,209,206,207,217,215,213,211,219,214,216,218);
		foreach($elementId as $Element){
			
			$costResources		= BuildFunctions::getElementPriceCalcu($USER, $PLANET, $Element);
			if(empty($costResources[901])) { $costResources[901] = -1; }
			if(empty($costResources[902])) { $costResources[902] = -1; }
			if(empty($costResources[903])) { $costResources[903] = -1; }
			if(empty($costResources[911])) { $costResources[911] = -1; }
			if(empty($costResources[921])) { $costResources[921] = -1; }
			//if(empty($costResources[922])) { $costResources[922] = -1; }
			
			$elementList[$Element]	= array(
				'id'				=> $Element,
				'costResources'		=> $costResources,
				'factor'			=> 99,
			);
		}
		}elseif($options == 0){
		$elementId = array(1,2,3,4,6,12,14,15,21,22,23,24,31,33,34,41,42,43,44);
		foreach($elementId as $Element){
			
			$costResources		= BuildFunctions::getElementPriceCalcu($USER, $PLANET, $Element);
			if(empty($costResources[901])) { $costResources[901] = -1; }
			if(empty($costResources[902])) { $costResources[902] = -1; }
			if(empty($costResources[903])) { $costResources[903] = -1; }
			if(empty($costResources[911])) { $costResources[911] = -1; }
			if(empty($costResources[921])) { $costResources[921] = -1; }
			//if(empty($costResources[922])) { $costResources[922] = -1; }
			$factor				= 2;
			if($Element < 5){
			$factor				= 1.50;	
			}
			
			$elementList[$Element]	= array(
				'id'				=> $Element,
				'costResources'		=> $costResources,
				'factor'			=> $factor,
			);
		}
		}elseif($options == 100){
		$elementId = array(106,108,109,110,111,113,114,115,117,118,120,121,122,123,124,131,132,133);
		foreach($elementId as $Element){
			
			$costResources		= BuildFunctions::getElementPriceCalcu($USER, $PLANET, $Element);
			if(empty($costResources[901])) { $costResources[901] = -1; }
			if(empty($costResources[902])) { $costResources[902] = -1; }
			if(empty($costResources[903])) { $costResources[903] = -1; }
			if(empty($costResources[911])) { $costResources[911] = -1; }
			if(empty($costResources[921])) { $costResources[921] = -1; }
			//if(empty($costResources[922])) { $costResources[922] = -1; }
			$factor				= 2;
			if($Element == 124){
			$factor				= 1.75;	
			}elseif($Element == 199){
			$factor				= 3;	
			}
			
			$elementList[$Element]	= array(
				'id'				=> $Element,
				'costResources'		=> $costResources,
				'factor'			=> $factor,
			);
		}
		}else{
		$elementId = array(1,2,3,4,6,12,14,15,21,22,23,24,31,33,34,41,42,43,44,71,72,73);
		foreach($elementId as $Element){
			
			$costResources		= BuildFunctions::getElementPriceCalcu($USER, $PLANET, $Element);
			if(empty($costResources[901])) { $costResources[901] = -1; }
			if(empty($costResources[902])) { $costResources[902] = -1; }
			if(empty($costResources[903])) { $costResources[903] = -1; }
			if(empty($costResources[911])) { $costResources[911] = -1; }
			if(empty($costResources[921])) { $costResources[921] = -1; }
			//if(empty($costResources[922])) { $costResources[922] = -1; }
			$factor				= 2;
			if($Element < 5){
			$factor				= 1.50;	
			}
			$elementList[$Element]	= array(
				'id'				=> $Element,
				'costResources'		=> $costResources,
				'factor'			=> $factor,
			);
		}
		}
		
		$this->tplObj->loadscript('resourcecalc.js');
		$this->assign(array(
			'elementId'	=> $elementId,
			'elementList'=> $elementList,
			'options'=> $options,
		));
		
		$this->display('page.resourcecalc.default.tpl');
	}
	

}