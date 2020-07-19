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
        'AttackSlaser',
		'AttackSion',
		'AttackSplasma',
		'AttackSgravity',
        'Defensive',
        'DefensiveSlight',
		'DefensiveSmedium',
		'DefensiveSheavy',
        'Shield',
        'ShieldSlight',
		'ShieldSmedium',
		'ShieldSheavy',
        'Sbuild',
		'BuildSlots',	
        'Stech',
		'ResearchSlots',
		'ResearchSlotPlanet',
        'Sfleet',
        'Sdefense',
        'Smissile',
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
        'CostRbuild',
        'CostRfleet',
        'CostRtech',
        'CostRdefense',
        'CostRmissile',
        'DoubleAttack',
	    'DoubleShield',
        'DoubleDefensive',
		'DoubleAttackBonus',
		'DoubleShieldBonus',
        'DoubleDefensiveBonus',
        'Debris',
        'DefRecovery',
        'Focusing',
		'AntiFocusing',
		'AccurateShots',
		'ChainReaction',
		'ExpBoost',
        'FuelConsum',
        'ShieldDome',
		'OrbitalBases',
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
            
            if(in_array($Element, $reslist['build'])) {
                $ressourceAmount	= $ressourceAmount - ($ressourceAmount * $USER['factor']['CostRbuild']);
			}elseif(in_array($Element, $reslist['fleet'])) {
                $ressourceAmount	= $ressourceAmount - ($ressourceAmount * $USER['factor']['CostRfleet']);
			}elseif(in_array($Element, $reslist['tech'])) {
                $ressourceAmount	= $ressourceAmount - ($ressourceAmount * $USER['factor']['CostRtech']);
			}elseif(in_array($Element, $reslist['defense'])) {
                $ressourceAmount	= $ressourceAmount - ($ressourceAmount * $USER['factor']['CostRdefense']);
			}elseif(in_array($Element, $reslist['missile'])) {
                $ressourceAmount	= $ressourceAmount - ($ressourceAmount * $USER['factor']['CostRmissile']);
			}

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
        global $resource, $reslist, $requeriments, $resglobal;

        $config	        = Config::get();
        $time           = 0;
        $elementCost	= 0;
        
        if(!isset($elementPrice)) {
            $elementPrice	= self::getElementPrice($USER, $PLANET, $Element, $forDestroy, $forLevel);
        }
        
        foreach($reslist['build_speed_res'] as $res) //проверка всего масива элементов
        {
            if(isset($elementPrice[$res])) {
                $elementCost	+= $elementPrice[$res];
            }
        }

        if(in_array($Element, $reslist['build'])) {		
			$time	= $elementCost/$config->game_speed * pow(0.99, ($PLANET[$resource[$resglobal['build_speed']]]));
		}elseif (in_array($Element, $reslist['fleet'])) {			
			$time	= $elementCost/$config->game_speed * pow(0.99, ($PLANET[$resource[$resglobal['fleet_speed']]]));			
		}elseif (in_array($Element, $reslist['defense'])) {
			$time	= $elementCost/$config->game_speed * pow(0.99, ($PLANET[$resource[$resglobal['defense_speed']]]));	
        }elseif (in_array($Element, $reslist['missile'])) {
			$time	= $elementCost/$config->game_speed * pow(0.99, ($PLANET[$resource[$resglobal['missile_speed']]]));	
		}elseif (in_array($Element, $reslist['tech'])) {
            if(is_numeric($PLANET[$resource[$resglobal['tech_speed']].'_inter']))
            {
                $Level	= $PLANET[$resource[$resglobal['tech_speed']]];
            } else {
                $Level = 0;
                foreach($PLANET[$resource[$resglobal['tech_speed']].'_inter'] as $Levels)
                {
                    if(!isset($requeriments[$Element][$resglobal['tech_speed']]) || $Levels >= $requeriments[$Element][$resglobal['tech_speed']])
                        $Level += $Levels;
                }
            }

            $time	= $elementCost / (100 * (1 + $Level))/($config->game_speed / 2500);
        }

        if((in_array($Element, $reslist['fleet']) || in_array($Element, $reslist['defense']) || in_array($Element, $reslist['missile']))){
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
		$MaxDomes   		= 25 + $USER['factor']['ShieldDome'];
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
		$MaxOrbits   		= 250 + $USER['factor']['OrbitalBases'];
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