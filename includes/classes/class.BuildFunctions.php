<?php

/**
 *  2Moons
 *   by Jan-Otto Kröpke 2009-2016
 *
 * For the full copyright and license information, please view the LICENSE
 *
 * @package 2Moons
 * @author Jan-Otto Kröpke <slaver7@gmail.com>
 * @copyright 2009 Lucky
 * @copyright 2016 Jan-Otto Kröpke <slaver7@gmail.com>
 * @licence MIT
 * @version 1.8.0
 * @link https://github.com/jkroepke/2Moons
 */

class BuildFunctions
{

    static $bonusList	= array(
    	'AttackA',
		'DefensiveA', 
		'ShieldA', 	
		'AttackD',
		'DefensiveD', 
		'ShieldD',
        'Attack',
        'Defensive',
        'Shield',
		'BuildTime',
		'BuildSlots',	
		'ResearchTime',
		'ResearchSlots',
		'ResearchSlotPlanet',
        'ShipTime',
        'DefensiveTime',
        'Resource',
        'Pmetal',
        'Pcrystal',
        'Pdeuterium',   
        'Senergy',          
        'ResourceStorage',
        'ShipStorage',
        'FlyTime',
        'FlyTimeCom',
		'FlyTimeImp',
		'FlyTimeHyp',
        'FleetSlots',
        'Planets',
        'SpyPower',
        'Expedition',
        'GateCoolTime',
        'MoreFound',
    );

    public static function getBonusList()
    {
        return self::$bonusList;
    }

    public static function getRestPrice($USER, $PLANET, $Element, $elementPrice = NULL)
    {
        global $resource;

        if(!isset($elementPrice)) {
            $elementPrice	= self::getElementPrice($USER, $PLANET, $Element);
        }

        $overflow	= array();

        foreach ($elementPrice as $resType => $resPrice) {
            $available			= isset($PLANET[$resource[$resType]]) ? $PLANET[$resource[$resType]] : $USER[$resource[$resType]];
            $overflow[$resType] = max($resPrice - floor($available), 0);
        }

        return $overflow;
    }
    //code_update
    public static function getElementPriceCalcu($USER, $PLANET, $Element, $forDestroy = false, $forLevel = NULL) { 
		global $pricelist, $resource, $reslist;

       	if (in_array($Element, array_merge($reslist['defense'], $reslist['missile'],$reslist['fleet']))) {
			$elementLevel = $forLevel;
		} elseif (isset($forLevel)) {
			$elementLevel = $forLevel;
		} elseif (isset($PLANET[$resource[$Element]])) {
			$elementLevel = $PLANET[$resource[$Element]];
		} elseif (isset($USER[$resource[$Element]])) {
			$elementLevel = $USER[$resource[$Element]];
		} else {
			return array();
		}
		
		$price	= array();
		foreach ($reslist['ressources'] as $resType)
		{
			
			$ressourceAmount	= $pricelist[$Element]['cost'][$resType];
			
			if(in_array($Element, $reslist['fleet'])) {
				$ressourceAmount	= $ressourceAmount - ($ressourceAmount / 100);
			}elseif(in_array($Element, $reslist['defense']) || in_array($Element, $reslist['missile'])) {
				$ressourceAmount	= $ressourceAmount - ($ressourceAmount / 100);
			}

			$price[$resType]	= $ressourceAmount;
			$config	= Config::get($USER['universe']);
		}
		
		return $price; 
	}
//code_update
    public static function getElementPrice($USER, $PLANET, $Element, $forDestroy = false, $forLevel = NULL) {
        global $pricelist, $resource, $reslist;

        if (in_array($Element, $reslist['fleet']) || in_array($Element, $reslist['defense']) || in_array($Element, $reslist['missile'])) {
            $elementLevel = $forLevel;
        } elseif (isset($forLevel)) {
            $elementLevel = $forLevel;
        } elseif (isset($PLANET[$resource[$Element]])) {
            $elementLevel = $PLANET[$resource[$Element]];
        } elseif (isset($USER[$resource[$Element]])) {
            $elementLevel = $USER[$resource[$Element]];
        } else {
            return array();
        }

        $price	= array();
        foreach ($reslist['ressources'] as $resType)
        {
            if (!isset($pricelist[$Element]['cost'][$resType])) {
                continue;
            }
            $ressourceAmount	= $pricelist[$Element]['cost'][$resType];

            if ($ressourceAmount == 0) {
                continue;
            }

            $price[$resType]	= $ressourceAmount;

            if(isset($pricelist[$Element]['factor']) && $pricelist[$Element]['factor'] != 0 && $pricelist[$Element]['factor'] != 1) {
                $price[$resType]	*= pow($pricelist[$Element]['factor'], $elementLevel);
            }

            if($forLevel && (in_array($Element, $reslist['fleet']) || in_array($Element, $reslist['defense']) || in_array($Element, $reslist['missile']))) {
                $price[$resType]	*= $elementLevel;
            }

            if($forDestroy === true) {
                $price[$resType]	/= 2;
            }
        }

        return $price;
    }

    public static function isTechnologieAccessible($USER, $PLANET, $Element)
    {
        global $requeriments, $resource;

        if(!isset($requeriments[$Element]))
            return true;

        foreach($requeriments[$Element] as $ReqElement => $EleLevel)
        {
            if (
                (isset($USER[$resource[$ReqElement]]) && $USER[$resource[$ReqElement]] < $EleLevel) ||
                (isset($PLANET[$resource[$ReqElement]]) && $PLANET[$resource[$ReqElement]] < $EleLevel)
            ) {
                return false;
            }
        }
        return true;
    }

    public static function getBuildingTime($USER, $PLANET, $Element, $elementPrice = NULL, $forDestroy = false, $forLevel = NULL)
    {
        global $resource, $reslist, $requeriments;

        $config	= Config::get($USER['universe']);

        $time   = 0;

        if(!isset($elementPrice)) {
            $elementPrice	= self::getElementPrice($USER, $PLANET, $Element, $forDestroy, $forLevel);
        }

        $elementCost	= 0;

        if(isset($elementPrice[901])) {
            $elementCost	+= $elementPrice[901];
        }

        if(isset($elementPrice[902])) {
            $elementCost	+= $elementPrice[902];
        }

        if(in_array($Element, $reslist['build'])) {		
			$time	= $elementCost / ($config->game_speed * (1 + $PLANET[$resource[14]])) * pow(0.5, $PLANET[$resource[15]]) * (pow(0.99, ($USER['factor']['BuildTime'] * 100)));
		}elseif (in_array($Element, $reslist['fleet'])) {			
			$time	= $elementCost/($config->game_speed * (1 + $PLANET[$resource[14]] + $PLANET[$resource[21]])) * pow(0.88, $PLANET[$resource[15]]) * pow(0.99, $USER['factor']['ShipTime'] * 100);			
		}elseif (in_array($Element, $reslist['defense'])) {
			$time	= $elementCost/($config->game_speed * (1 + $PLANET[$resource[14]] + $PLANET[$resource[21]])) * pow(0.88, $PLANET[$resource[15]]) * pow(0.99, $USER['factor']['DefensiveTime'] * 100);	
        }elseif (in_array($Element, $reslist['missile'])) {
			$time	= $elementCost/($config->game_speed * (1 + (3 * $PLANET[$resource[44]])));	
		}elseif (in_array($Element, $reslist['tech'])) {
            if(is_numeric($PLANET[$resource[31].'_inter']))
            {
                $Level	= $PLANET[$resource[31]];
            } else {
                $Level = 0;
                foreach($PLANET[$resource[31].'_inter'] as $Levels)
                {
                    if(!isset($requeriments[$Element][31]) || $Levels >= $requeriments[$Element][31])
                        $Level += $Levels;
                }
            }

            $time	= $elementCost / (1000 * (1 + $Level)) / ($config->game_speed / 2500) * pow(1 - $config->factor_university / 100, $PLANET[$resource[6]]) * (pow(0.99, $USER['factor']['ResearchTime'] * 100));
        }

        if((in_array($Element, $reslist['fleet']) || in_array($Element, $reslist['defense']))){
			$time	= $time * 3600;
		}	
		else{
			if($forDestroy) {
				$time	= floor($time * 1300);
			} else {
				$time	= floor($time * 3600);
			}
			$time	 = max($time, $config->min_build_time);
		}		
		return $time; 
    }

    public static function isElementBuyable($USER, $PLANET, $Element, $elementPrice = NULL, $forDestroy = false, $forLevel = NULL)
    {
        $rest	= self::getRestPrice($USER, $PLANET, $Element, $elementPrice, $forDestroy, $forLevel);
        return count(array_filter($rest)) === 0;
    }

    public static function getMaxConstructibleElements($USER, $PLANET, $Element, $elementPrice = NULL)
    {
        global $resource, $reslist;

        if(!isset($elementPrice)) {
            $elementPrice	= self::getElementPrice($USER, $PLANET, $Element);
        }

        $maxElement	= array();

        foreach($elementPrice as $resourceID => $price)
        {
            if(isset($PLANET[$resource[$resourceID]]))
            {
                $maxElement[]	= floor($PLANET[$resource[$resourceID]] / $price);
            }
            elseif(isset($USER[$resource[$resourceID]]))
            {
                $maxElement[]	= floor($USER[$resource[$resourceID]] / $price);
            }
            else
            {
                throw new Exception("Unknown Ressource ".$resourceID." at element ".$Element.".");
            }
        }

        if(in_array($Element, $reslist['one'])) {
            $maxElement[]	= 1;
        }

        return min($maxElement);
    }

    public static function getMaxConstructibleRockets($USER, $PLANET, $Missiles = NULL)
    {
        global $resource, $reslist;

        if(!isset($Missiles))
        {
            $Missiles	= array();

            foreach($reslist['missile'] as $elementID)
            {
                $Missiles[$elementID]	= $PLANET[$resource[$elementID]];
            }
        }

        $BuildArray  	  	= !empty($PLANET['b_hangar_id']) ? unserialize($PLANET['b_hangar_id']) : array();
        $MaxMissiles   		= $PLANET[$resource[44]] * 10 * max(Config::get()->silo_factor, 1);

        foreach($BuildArray as $ElementArray) {
            if(isset($Missiles[$ElementArray[0]]))
                $Missiles[$ElementArray[0]] += $ElementArray[1];
        }

        $ActuMissiles  = $Missiles[502] + (2 * $Missiles[503]);
        $MissilesSpace = max(0, $MaxMissiles - $ActuMissiles);

        return array(
            502	=> $MissilesSpace,
            503	=> floor($MissilesSpace / 2),
        );
    }
    
    //code_update
    public static function getMaxConstructibleDomes($USER, $PLANET, $Domes = NULL)
	{
		global $resource, $reslist;
		if(!isset($Domes))
		{		
		$Domes	= array();
		foreach($Domes as $elementID)
		{
		$Domes[$elementID]	= $PLANET[$resource[$elementID]];
		}
		}
		$BuildArray  	  	= !empty($PLANET['b_hangar_id']) ? unserialize($PLANET['b_hangar_id']) : array();
		$MaxDomes   		= 25;
		foreach($BuildArray as $ElementArray) {
			if(isset($Domes[$ElementArray[0]]))
				$Domes[$ElementArray[0]] += $ElementArray[1];
		}
		$ActuDomes  = max(0, $MaxDomes - $Domes[407]);
		$DomesSpace = max(0, $MaxDomes - $Domes[408]);
		$DomesPlanet = max(0, $MaxDomes - $Domes[409]);
		return array(
			407	=> $ActuDomes,
			408	=> $DomesSpace,
			409	=> $DomesPlanet,
		);
	}
	
	public static function getMaxConstructibleOrbits($USER, $PLANET, $Orbits = NULL)
	{
		global $resource, $reslist;
		if(!isset($Orbits))
		{		
		$Orbits	= array();
		foreach($Orbits as $elementID)
		{
		$Orbits[$elementID]	= $PLANET[$resource[$elementID]];
		}
		}
		$BuildArray  	  	= !empty($PLANET['b_hangar_id']) ? unserialize($PLANET['b_hangar_id']) : array();
		$MaxOrbits   		= 250;
		foreach($BuildArray as $ElementArray) {
			if(isset($Orbits[$ElementArray[0]]))
				$Orbits[$ElementArray[0]] += $ElementArray[1];
		}
		$ActuOrbits  = max(0, $MaxOrbits - $Orbits[411]);
		return array(
			411	=> $ActuOrbits,
		);
	}
    //code_update
    
    //$new_code
    public static function getAvalibleBonus($Element)
    {
        global $pricelist;

        $elementBonus	= array();

        foreach(self::$bonusList as $bonus)
        {
            if (array_key_exists(''.$bonus.'', $pricelist[$Element]['bonus'])) {
                
            $temp	= (float) $pricelist[$Element]['bonus'][$bonus][0];
            if(empty($temp))
            {
                continue;
            }

            $elementBonus[$bonus]	= $pricelist[$Element]['bonus'][$bonus];
            
            }
        }

        return $elementBonus;
    }
    //$new_code
}