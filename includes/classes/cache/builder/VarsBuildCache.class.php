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

class VarsBuildCache implements BuildCache
{
	function buildCache()
	{
		$resource		= array();
		$requeriments	= array();
        $BonusElement	= array();
		$pricelist		= array();
		$CombatCaps		= array();
		$reslist		= array();
		$ProdGrid		= array();

		$reslist['prod']		                = array();
		$reslist['storage']		                = array();
		$reslist['bonus']		                = array();
		$reslist['one']			                = array();
		$reslist['build']		                = array();
		$reslist['allow'][1]	                = array();
		$reslist['allow'][3]	                = array();
		$reslist['tech']		                = array();
		$reslist['fleet']		                = array();
		$reslist['defense']		                = array();
		$reslist['missile']		                = array();
		$reslist['officier']	                = array();
		$reslist['dmfunc']		                = array();
        $reslist['details']		                = array();
        $reslist['minerals']		            = array();
        $reslist['ideologies']	                = array();
        $reslist['party']	                    = array();
        $reslist['race']		                = array();
        $reslist['formgovernment']		        = array();
        $reslist['ethics']		                = array();
        $reslist['artifact']                    = array();
        $reslist['development']                 = array();
        $reslist['auction']                     = array();
        $reslist['ars']		                    = array();
        $reslist['premium']	                    = array();
        $reslist['band']	                    = array();
        $reslist['fair']		                = array();
        $reslist['bon']		                    = array();
        $reslist['alliance']		            = array();
        $reslist['achievements']	            = array();
		
		$db	= Database::get();
		
		$reqResult		= $db->nativeQuery('SELECT * FROM %%VARS_REQUIRE%%;');
		foreach($reqResult as $reqRow)
		{
			$requeriments[$reqRow['elementID']][$reqRow['requireID']]	= $reqRow['requireLevel'];
		}
        
        $bonusResult	= $db->nativeQuery('SELECT * FROM %%VARS_BONUS%%;');
		foreach($bonusResult as $bonRow)
		{
			$BonusElement[$bonRow['elementID']][$bonRow['bonusID']]	= $bonRow['bonusLevel'];
		}

		$varsResult		= $db->nativeQuery('SELECT * FROM %%VARS%%;');
		foreach($varsResult as $varsRow)
		{
			$resource[$varsRow['elementID']]	= $varsRow['name'];
			$CombatCaps[$varsRow['elementID']]	= array(
				'attack'	    => $varsRow['attack'],
				'shield'	    => $varsRow['shield'],
                'defend'	    => $varsRow['defend'], 
                'type_gun'		=> $varsRow['type_gun'],
				'type_shield'	=> $varsRow['type_shield'],
				'type_defend'	=> $varsRow['type_defend'],
			);
			
			$pricelist[$varsRow['elementID']]	= array(
				'cost'		=> array(
					901	=> $varsRow['cost901'],
					902	=> $varsRow['cost902'],
					903	=> $varsRow['cost903'],
					911	=> $varsRow['cost911'],
                    912	=> $varsRow['cost912'],
                    913	=> $varsRow['cost913'],
                    914	=> $varsRow['cost914'],
                    915	=> $varsRow['cost915'],
                    916	=> $varsRow['cost916'],
					921	=> $varsRow['cost921'],
                    922	=> $varsRow['cost922'],
                    923	=> $varsRow['cost923'],
                    924	=> $varsRow['cost924'],             
				),
				'factor'		     => $varsRow['factor'],
				'max'			     => $varsRow['maxLevel'],
				'consumption'	     => $varsRow['consumption1'],
				'consumption2'	     => $varsRow['consumption2'],
				'speed'			     => $varsRow['speed1'],
				'speed2'		     => $varsRow['speed2'],
				'capacity'		     => $varsRow['capacity'],
				'tech'			     => $varsRow['speedTech'],
				'time'			     => $varsRow['timeBonus'],
                'factorTechnologie'  => $varsRow['factorTechnologie'],
				'bonus'			     => array(
                    'AttackA'			    => array($varsRow['bonusAttackA'], $varsRow['bonusAttackAUnit']),
					'DefensiveA'		    => array($varsRow['bonusDefensiveA'], $varsRow['bonusDefensiveAUnit']), 
					'ShieldA'			    => array($varsRow['bonusShieldA'], $varsRow['bonusShieldAUnit']), 
					'AttackD'			    => array($varsRow['bonusAttackD'], $varsRow['bonusAttackDUnit']),
					'DefensiveD'		    => array($varsRow['bonusDefensiveD'], $varsRow['bonusDefensiveDUnit']), 
					'ShieldD'			    => array($varsRow['bonusShieldD'], $varsRow['bonusShieldDUnit']),
					'Attack'			    => array($varsRow['bonusAttack'], $varsRow['bonusAttackUnit']),
                    'AttackSlaser'		    => array($varsRow['bonusAttackSlaser'], $varsRow['bonusAttackSlaserUnit']),
					'AttackSion'		    => array($varsRow['bonusAttackSion'], $varsRow['bonusAttackSionUnit']),
					'AttackSplasma'		    => array($varsRow['bonusAttackSplasma'], $varsRow['bonusAttackSplasmaUnit']),
					'AttackSgravity'	    => array($varsRow['bonusAttackSgravity'], $varsRow['bonusAttackSgravityUnit']),
					'Defensive'			    => array($varsRow['bonusDefensive'], $varsRow['bonusDefensiveUnit']),
                    'DefensiveSlight'	    => array($varsRow['bonusDefensiveSlight'], $varsRow['bonusDefensiveSlightUnit']),
					'DefensiveSmedium'	    => array($varsRow['bonusDefensiveSmedium'], $varsRow['bonusDefensiveSmediumUnit']),
					'DefensiveSheavy'	    => array($varsRow['bonusDefensiveSheavy'], $varsRow['bonusDefensiveSheavyUnit']),
					'Shield'			    => array($varsRow['bonusShield'], $varsRow['bonusShieldUnit']),
                    'ShieldSlight'	        => array($varsRow['bonusShieldSlight'], $varsRow['bonusShieldSlightUnit']),
					'ShieldSmedium'	        => array($varsRow['bonusShieldSmedium'], $varsRow['bonusShieldSmediumUnit']),
					'ShieldSheavy'	        => array($varsRow['bonusShieldSheavy'], $varsRow['bonusShieldSheavyUnit']),
                    'Sbuild'			    => array($varsRow['bonusSbuild'], $varsRow['bonusSbuildUnit']),
                    'BuildSlots'		    => array($varsRow['bonusBuildSlots'], $varsRow['bonusBuildSlotsUnit']),
                    'Stech'		            => array($varsRow['bonusStech'], $varsRow['bonusStechUnit']),
                    'ResearchSlots'		    => array($varsRow['bonusResearchSlots'], $varsRow['bonusResearchSlotsUnit']),
                    'ResearchSlotPlanet'    => array($varsRow['bonusResearchSlotPlanet'], $varsRow['bonusResearchSlotPlanetUnit']),
                    'Sfleet'			    => array($varsRow['bonusSfleet'], $varsRow['bonusSfleetUnit']),
                    'Sdefense'		        => array($varsRow['bonusSdefense'], $varsRow['bonusSdefenseUnit']),
                    'Smissile'		        => array($varsRow['bonusSmissile'], $varsRow['bonusSmissileUnit']),
					'Resource'			    => array($varsRow['bonusResource'], $varsRow['bonusResourceUnit']),
                    'Pmetal'			    => array($varsRow['bonusPmetal'], $varsRow['bonusPmetalUnit']),
                    'Pcrystal'			    => array($varsRow['bonusPcrystal'], $varsRow['bonusPcrystalUnit']),
                    'Pdeuterium'		    => array($varsRow['bonusPdeuterium'], $varsRow['bonusPdeuteriumUnit']),
					'Senergy'			    => array($varsRow['bonusSenergy'], $varsRow['bonusSenergyUnit']),
					'ResourceStorage'	    => array($varsRow['bonusResourceStorage'], $varsRow['bonusResourceStorageUnit']),
					'ShipStorage'		    => array($varsRow['bonusShipStorage'], $varsRow['bonusShipStorageUnit']),
					'FlyTime'			    => array($varsRow['bonusFlyTime'], $varsRow['bonusFlyTimeUnit']),
                    'FlyTimeCom'		    => array($varsRow['bonusFlyTimeCom'], $varsRow['bonusFlyTimeComUnit']),
					'FlyTimeImp'	        => array($varsRow['bonusFlyTimeImp'], $varsRow['bonusFlyTimeImpUnit']),
					'FlyTimeHyp'	        => array($varsRow['bonusFlyTimeHyp'], $varsRow['bonusFlyTimeHypUnit']),
					'FleetSlots'		    => array($varsRow['bonusFleetSlots'], $varsRow['bonusFleetSlotsUnit']),
					'Planets'			    => array($varsRow['bonusPlanets'], $varsRow['bonusPlanetsUnit']),
					'SpyPower'			    => array($varsRow['bonusSpyPower'], $varsRow['bonusSpyPowerUnit']),
					'Expedition'		    => array($varsRow['bonusExpedition'], $varsRow['bonusExpeditionUnit']),
					'GateCoolTime'		    => array($varsRow['bonusGateCoolTime'], $varsRow['bonusGateCoolTimeUnit']),
					'MoreFound'			    => array($varsRow['bonusMoreFound'], $varsRow['bonusMoreFoundUnit']),
                    'CostRbuild'			=> array($varsRow['bonusCostRbuild'], $varsRow['bonusCostRbuildUnit']),
                    'CostRfleet'		    => array($varsRow['bonusCostRfleet'], $varsRow['bonusCostRfleetUnit']),
                    'CostRtech'			    => array($varsRow['bonusCostRtech'], $varsRow['bonusCostRtechUnit']),
                    'CostRdefense'			=> array($varsRow['bonusCostRdefense'], $varsRow['bonusCostRdefenseUnit']),
                    'CostRmissile'			=> array($varsRow['bonusCostRmissile'], $varsRow['bonusCostRmissileUnit']),
                    'DoubleAttack'			=> array($varsRow['bonusDoubleAttack'], $varsRow['bonusDoubleAttackUnit']),
					'DoubleShield'			=> array($varsRow['bonusDoubleShield'], $varsRow['bonusDoubleShieldUnit']),
                    'DoubleDefensive'		=> array($varsRow['bonusDoubleDefensive'], $varsRow['bonusDoubleDefensiveUnit']),
					'DoubleAttackBonus'		=> array($varsRow['bonusDoubleAttackBonus'], $varsRow['bonusDoubleAttackBonusUnit']),
					'DoubleShieldBonus'		=> array($varsRow['bonusDoubleShieldBonus'], $varsRow['bonusDoubleShieldBonusUnit']),
                    'DoubleDefensiveBonus'	=> array($varsRow['bonusDoubleDefensiveBonus'], $varsRow['bonusDoubleDefensiveBonusUnit']),
                    'Debris'			    => array($varsRow['bonusDebris'], $varsRow['bonusDebrisUnit']),
                    'DefRecovery'			=> array($varsRow['bonusDefRecovery'], $varsRow['bonusDefRecoveryUnit']),
                    'Focusing'			    => array($varsRow['bonusFocusing'], $varsRow['bonusFocusingUnit']),
					'AntiFocusing'		    => array($varsRow['bonusAntiFocusing'], $varsRow['bonusAntiFocusingUnit']),
					'AccurateShots'		    => array($varsRow['bonusAccurateShots'], $varsRow['bonusAccurateShotsUnit']),
					'ChainReaction'		    => array($varsRow['bonusChainReaction'], $varsRow['bonusChainReactionUnit']),
					'ExpBoost'		        => array($varsRow['bonusExpBoost'], $varsRow['bonusExpBoostUnit']),
                    'FuelConsum'			=> array($varsRow['bonusFuelConsum'], $varsRow['bonusFuelConsumUnit']),
                    'ShieldDome'		    => array($varsRow['bonusShieldDome'], $varsRow['bonusShieldDomeUnit']),
					'OrbitalBases'		    => array($varsRow['bonusOrbitalBases'], $varsRow['bonusOrbitalBasesUnit']),
				),
			);
			
			$ProdGrid[$varsRow['elementID']]['production']	= array(
				901	=> $varsRow['production901'],
				902	=> $varsRow['production902'],
				903	=> $varsRow['production903'],
				911	=> $varsRow['production911'],
                912	=> $varsRow['production912'],
                913	=> $varsRow['production913'],
                914	=> $varsRow['production914'],
                915	=> $varsRow['production915'],
                916	=> $varsRow['production916'],
			);
			
			$ProdGrid[$varsRow['elementID']]['storage']	= array(
				901	=> $varsRow['storage901'],
				902	=> $varsRow['storage902'],
				903	=> $varsRow['storage903'],
			);
			
			if(array_filter($ProdGrid[$varsRow['elementID']]['production']))
				$reslist['prod'][]		= $varsRow['elementID'];
				
			if(array_filter($ProdGrid[$varsRow['elementID']]['storage']))
				$reslist['storage'][]	= $varsRow['elementID'];
				
			if(($varsRow['bonusAttackA'] + $varsRow['bonusDefensiveA'] + $varsRow['bonusShieldA'] +
			    $varsRow['bonusAttackD'] + $varsRow['bonusDefensiveD'] + $varsRow['bonusShieldD'] +
                $varsRow['bonusAttack'] + $varsRow['bonusAttackSlaser'] + $varsRow['bonusAttackSion'] + $varsRow['bonusAttackSplasma'] + $varsRow['bonusAttackSgravity'] +
                $varsRow['bonusDefensive'] + $varsRow['bonusDefensiveSlight'] + $varsRow['bonusDefensiveSmedium'] + $varsRow['bonusDefensiveSheavy'] +
                $varsRow['bonusShield'] + $varsRow['bonusShieldSlight'] + $varsRow['bonusShieldSmedium'] + $varsRow['bonusShieldSheavy'] +
                $varsRow['bonusSbuild'] + $varsRow['bonusBuildSlots'] + 
				$varsRow['bonusStech'] + $varsRow['bonusResearchSlots'] +  $varsRow['bonusResearchSlotPlanet'] +
                $varsRow['bonusSfleet'] + $varsRow['bonusSdefense'] + $varsRow['bonusSmissile'] +
                $varsRow['bonusResource'] + $varsRow['bonusPmetal'] +  $varsRow['bonusPcrystal'] +  $varsRow['bonusPdeuterium'] + $varsRow['bonusSenergy'] + 
                $varsRow['bonusResourceStorage'] + $varsRow['bonusShipStorage'] + 
                $varsRow['bonusFlyTime'] + $varsRow['bonusFlyTimeCom'] + $varsRow['bonusFlyTimeImp'] + $varsRow['bonusFlyTimeHyp'] + 
				$varsRow['bonusFleetSlots'] + $varsRow['bonusPlanets'] + $varsRow['bonusSpyPower'] + $varsRow['bonusExpedition'] + 
				$varsRow['bonusGateCoolTime'] + $varsRow['bonusMoreFound'] +
                $varsRow['bonusCostRbuild'] + $varsRow['bonusCostRfleet'] + $varsRow['bonusCostRtech'] + $varsRow['bonusCostRdefense'] + $varsRow['bonusCostRmissile'] + 
                $varsRow['bonusDoubleAttack'] + $varsRow['bonusDoubleShield'] + $varsRow['bonusDoubleDefensive'] + $varsRow['bonusDoubleAttackBonus'] + $varsRow['bonusDoubleShieldBonus'] +$varsRow['bonusDoubleDefensiveBonus'] +
                $varsRow['bonusDebris'] + $varsRow['bonusDefRecovery'] +
                $varsRow['bonusFocusing'] + $varsRow['bonusAntiFocusing'] + $varsRow['bonusAccurateShots'] + $varsRow['bonusChainReaction'] + $varsRow['bonusExpBoost']) != 0)
			{
				$reslist['bonus'][]		= $varsRow['elementID'];
			}
			if($varsRow['onePerPlanet'] == 1)
				$reslist['one'][]		= $varsRow['elementID'];
			
			switch($varsRow['class']) {
				case 0: 
					$reslist['build'][]	= $varsRow['elementID'];
					$tmp	= explode(',', $varsRow['onPlanetType']);
					foreach($tmp as $type) 
						$reslist['allow'][$type][]	= $varsRow['elementID'];
				break;
				case 100: 
					$reslist['tech'][]	= $varsRow['elementID'];
				break;
				case 200: 
					$reslist['fleet'][]	= $varsRow['elementID'];
				break;
				case 400: 
					$reslist['defense'][]	= $varsRow['elementID'];
				break;
				case 500: 
					$reslist['missile'][]	= $varsRow['elementID'];
				break;
				case 600: 
					$reslist['officier'][]	= $varsRow['elementID'];
				break;
				case 700: 
					$reslist['dmfunc'][]	= $varsRow['elementID'];
				break;
                case 1000: 
					$reslist['details'][]	= $varsRow['elementID'];
				break;
                case 1100: 
					$reslist['minerals'][]	= $varsRow['elementID'];
				break;
                case 1200: 
					$reslist['party'][]	= $varsRow['elementID'];
				break;
                case 1300: 
					$reslist['ideologies'][]	= $varsRow['elementID'];
				break;
                case 1400: 
					$reslist['artifact'][]	= $varsRow['elementID'];
				break;
                case 1500: 
					$reslist['race'][]	= $varsRow['elementID'];
				break;
                case 1600: 
					$reslist['formgovernment'][]	= $varsRow['elementID'];
				break;
                case 1700: 
					$reslist['ethics'][]	= $varsRow['elementID'];
				break;
                case 1800: 
					$reslist['auction'][]	= $varsRow['elementID'];
				break;
                case 1900: 
					$reslist['development'][]	= $varsRow['elementID'];
				break;
                case 2000: 
					$reslist['ars'][]	= $varsRow['elementID'];
				break;
                case 2100: 
					$reslist['premium'][]	= $varsRow['elementID'];
				break;
                case 2200: 
					$reslist['band'][]	= $varsRow['elementID'];
				break;
                case 2300: 
					$reslist['fair'][]	= $varsRow['elementID'];
				break;
                case 2400: 
					$reslist['bon'][]	= $varsRow['elementID'];
				break;
                case 2500: 
					$reslist['alliance'][]	= $varsRow['elementID'];
				break;
                case 5000: 
					$reslist['achievements'][]	= $varsRow['elementID'];
				break;
			}
		}

		$rapidResult		= $db->nativeQuery('SELECT * FROM %%VARS_RAPIDFIRE%%;');
		foreach($rapidResult as $rapidRow)
		{
			$CombatCaps[$rapidRow['elementID']]['sd'][$rapidRow['rapidfireID']]	= $rapidRow['shoots'];
		}
		
		return array(
			'reslist'		=> $reslist,
			'ProdGrid'		=> $ProdGrid,
			'CombatCaps'	=> $CombatCaps,
			'resource'		=> $resource,
			'pricelist'		=> $pricelist,
			'requeriments'	=> $requeriments,
            'BonusElement'	=> $BonusElement,
		);
	}
}