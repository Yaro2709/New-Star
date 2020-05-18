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
		$pricelist		= array();
		$CombatCaps		= array();
		$reslist		= array();
		$ProdGrid		= array();

		$reslist['prod']		= array();
		$reslist['storage']		= array();
		$reslist['bonus']		= array();
		$reslist['one']			= array();
		$reslist['build']		= array();
		$reslist['allow'][1]	= array();
		$reslist['allow'][3]	= array();
		$reslist['tech']		= array();
		$reslist['fleet']		= array();
		$reslist['defense']		= array();
		$reslist['missile']		= array();
		$reslist['officier']	= array();
		$reslist['dmfunc']		= array();
        
        $reslist['race']		= array();
        $reslist['premium']	    = array();
		
		$db	= Database::get();
		
		$reqResult		= $db->nativeQuery('SELECT * FROM %%VARS_REQUIRE%%;');
		foreach($reqResult as $reqRow)
		{
			$requeriments[$reqRow['elementID']][$reqRow['requireID']]	= $reqRow['requireLevel'];
		}

		$varsResult		= $db->nativeQuery('SELECT * FROM %%VARS%%;');
		foreach($varsResult as $varsRow)
		{
			$resource[$varsRow['elementID']]	= $varsRow['name'];
			$CombatCaps[$varsRow['elementID']]	= array(
				'attack'	=> $varsRow['attack'],
				'shield'	=> $varsRow['defend'],
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
				),
				'factor'		=> $varsRow['factor'],
				'max'			=> $varsRow['maxLevel'],
				'consumption'	=> $varsRow['consumption1'],
				'consumption2'	=> $varsRow['consumption2'],
				'speed'			=> $varsRow['speed1'],
				'speed2'		=> $varsRow['speed2'],
				'capacity'		=> $varsRow['capacity'],
				'tech'			=> $varsRow['speedTech'],
				'time'			=> $varsRow['timeBonus'],
				'bonus'			=> array(
                    'AttackA'			    => array($varsRow['bonusAttackA'], $varsRow['bonusAttackAUnit']),
					'DefensiveA'		    => array($varsRow['bonusDefensiveA'], $varsRow['bonusDefensiveAUnit']), 
					'ShieldA'			    => array($varsRow['bonusShieldA'], $varsRow['bonusShieldAUnit']), 
					'AttackD'			    => array($varsRow['bonusAttackD'], $varsRow['bonusAttackDUnit']),
					'DefensiveD'		    => array($varsRow['bonusDefensiveD'], $varsRow['bonusDefensiveDUnit']), 
					'ShieldD'			    => array($varsRow['bonusShieldD'], $varsRow['bonusShieldDUnit']),
					'Attack'			    => array($varsRow['bonusAttack'], $varsRow['bonusAttackUnit']),
					'Defensive'			    => array($varsRow['bonusDefensive'], $varsRow['bonusDefensiveUnit']),
					'Shield'			    => array($varsRow['bonusShield'], $varsRow['bonusShieldUnit']),
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
                $varsRow['bonusAttack'] + $varsRow['bonusDefensive'] + $varsRow['bonusShield'] + 
                $varsRow['bonusSbuild'] + $varsRow['bonusBuildSlots'] + 
				$varsRow['bonusStech'] + $varsRow['bonusResearchSlots'] +  $varsRow['bonusResearchSlotPlanet'] +
                $varsRow['bonusSfleet'] + $varsRow['bonusSdefense'] + $varsRow['bonusSmissile'] +
                $varsRow['bonusResource'] + $varsRow['bonusPmetal'] +  $varsRow['bonusPcrystal'] +  $varsRow['bonusPdeuterium'] + $varsRow['bonusSenergy'] + 
                $varsRow['bonusResourceStorage'] + $varsRow['bonusShipStorage'] + 
                $varsRow['bonusFlyTime'] + $varsRow['bonusFlyTimeCom'] + $varsRow['bonusFlyTimeImp'] + $varsRow['bonusFlyTimeHyp'] + 
				$varsRow['bonusFleetSlots'] + $varsRow['bonusPlanets'] + $varsRow['bonusSpyPower'] + $varsRow['bonusExpedition'] + 
				$varsRow['bonusGateCoolTime'] + $varsRow['bonusMoreFound']) != 0)
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
                case 1500: 
					$reslist['race'][]	= $varsRow['elementID'];
				break;
                case 2100: 
					$reslist['premium'][]	= $varsRow['elementID'];
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
		);
	}
}