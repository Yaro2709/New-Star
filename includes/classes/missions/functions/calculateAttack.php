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

function calculateAttack(&$attackers, &$defenders, $FleetTF, $DefTF)
{
	global $pricelist, $CombatCaps, $resource;

	$TRES 	= array('attacker' => 0, 'defender' => 0);
	$ARES 	= $DRES = array('metal' => 0, 'crystal' => 0);
	$ROUND	= array();
	$RF		= array();

	$attackAmount = array();
	$defenseAmount = array();
	$STARTDEF = array();

	foreach ($attackers as $fleetID => $attacker) 
	{
		foreach ($attacker['unit'] as $element => $amount) 
		{
			$ARES['metal'] 		+= $pricelist[$element]['cost'][901] * $amount;
			$ARES['crystal'] 	+= $pricelist[$element]['cost'][902] * $amount;
		}
	}

	foreach($CombatCaps as $e => $arr) {
		if(!isset($arr['sd'])) continue;
		
		foreach($arr['sd'] as $t => $sd) {
			if($sd == 0) continue;
			$RF[$t][$e] = $sd;
		}
	}
	
	$TRES['attacker']	= $ARES['metal'] + $ARES['crystal'];

	foreach ($defenders as $fleetID => $defender) 
	{
		foreach ($defender['unit'] as $element => $amount)
		{
			if ($element < 300) {
				$DRES['metal'] 		+= $pricelist[$element]['cost'][901] * $amount;
				$DRES['crystal'] 	+= $pricelist[$element]['cost'][902] * $amount ;

				$TRES['defender'] 	+= $pricelist[$element]['cost'][901] * $amount;
				$TRES['defender'] 	+= $pricelist[$element]['cost'][902] * $amount;
			} else {
				if (!isset($STARTDEF[$element])) 
					$STARTDEF[$element] = 0;
				
				$STARTDEF[$element] += $amount;

				$TRES['defender']	+= $pricelist[$element]['cost'][901] * $amount;
				$TRES['defender']	+= $pricelist[$element]['cost'][902] * $amount;
			}
		}
	}
	
	for ($ROUNDC = 0; $ROUNDC <= MAX_ATTACK_ROUNDS; $ROUNDC++) 
	{
		$attackDamage  = array('total' => 0);
		$attackShield  = array('total' => 0);
		$attackAmount  = array('total' => 0);
		$defenseDamage = array('total' => 0);
		$defenseShield = array('total' => 0);
		$defenseAmount = array('total' => 0);
		$attArray = array();
		$defArray = array();
        
        $attackShoting 	 = array('light' => 0, 'medium' => 0, 'heavy' => 0);
		$defenseShoting  = array('light' => 0, 'medium' => 0, 'heavy' => 0);

		foreach ($attackers as $fleetID => $attacker) {
			$attackDamage[$fleetID] = 0;
			$attackShield[$fleetID] = 0;
			$attackAmount[$fleetID] = 0;

			$attTech	= (1 + $attacker['player']['factor']['Attack'] + $attacker['player']['factor']['AttackA']); 
			$defTech	= (1 + $attacker['player']['factor']['Defensive'] + $attacker['player']['factor']['DefensiveA']); 
			$shieldTech = (1 + $attacker['player']['factor']['Shield'] + $attacker['player']['factor']['ShieldA']); 
			$attackers[$fleetID]['techs'] = array($attTech, $defTech, $shieldTech);
	
            foreach ($attacker['unit'] as $element => $amount) 
			{
                //Удвоение
                $DK		= 1;
                $SK		= 1;
                $UK		= 1;

                $procen_DK = $attacker['player']['factor']['DoubleAttack'] * 100;
                $procen_SK = $attacker['player']['factor']['DoubleShield'] * 100;
                $procen_UK = $attacker['player']['factor']['DoubleDefensive'] * 100;
                $power_DK = $attacker['player']['factor']['DoubleAttackBonus'];
                $power_SK = $attacker['player']['factor']['DoubleShieldBonus'];
                $power_UK = $attacker['player']['factor']['DoubleDefensiveBonus'];

                if(mt_rand(1,100) <= $procen_DK) $DK	= 2 + $power_DK;
                if(mt_rand(1,100) <= $procen_SK) $SK	= 2 + $power_SK;
                if(mt_rand(1,100) <= $procen_UK) $UK	= 2 + $power_UK;
                
                $KritAttacker['DK'][$fleetID][$element] = $DK;
                $KritAttacker['SK'][$fleetID][$element] = $SK;
                $KritAttacker['UK'][$fleetID][$element] = $UK;
                
				switch($CombatCaps[$element]['type_gun'])
				{	
					case 'none':
					{	
						$thisAtt	= 0;
						break;
					}
					case 'notype':
					{	
						$thisAtt	= $amount * ($CombatCaps[$element]['attack']) * $attTech * $DK;
						$attackShoting['light'] += round(($amount) * rand(45,55)/100);
						$attackShoting['medium'] += round(($amount) * rand(1,5)/100);
						$attackShoting['heavy'] += floor($amount * 0.00000015);
						break;
					}
					default: 
					{	
						$thisAtt			= 0; 
						$type_gun			= explode(';', $CombatCaps[$element]['type_gun']);
						$FleetGun        	= array();
						
						foreach ($type_gun as $Item => $gun) 
						{
							if (empty($gun)) continue;	
							
							$Class		= explode(',', $gun);
							
							$thisAtt	+=	round((($CombatCaps[$element]['attack'] * $Class[1]/100) * (1 +($attacker['player']['factor']['AttackS'.$Class[0]]))));
							switch($Class[0]) 
							{
								case 'laser':
								{
									$attackShoting['light'] += round(($amount * $Class[1]/100) * rand(65,75)/100);
									$attackShoting['medium'] += round(($amount * $Class[1]/100) * rand(15,25)/100);
									$attackShoting['heavy'] += floor($amount * 0.0000015);
									break;
								}
								case 'ion':
								{
									$attackShoting['light'] += round(($amount * $Class[1]/100) * rand(55,65)/100);
									$attackShoting['medium'] += round(($amount * $Class[1]/100) * rand(65,75)/100);
									$attackShoting['heavy'] += round(($amount * $Class[1]/100) * rand(0,10)/100);
									break;
								}
								case 'plasma':
								{
									$attackShoting['light'] += round(($amount * $Class[1]/100) * rand(0,2)/100);
									$attackShoting['medium'] += round(($amount * $Class[1]/100) * rand(35,45)/100);
									$attackShoting['heavy'] += round(($amount * $Class[1]/100) * rand(50,60)/100);
									break;
								}
								case 'gravity':
								{
									$attackShoting['light'] += round(($amount * $Class[1]/100) * rand(0,5)/100);
									$attackShoting['medium'] += round(($amount * $Class[1]/100) * rand(10,20)/100);
									$attackShoting['heavy'] += round(($amount * $Class[1]/100) * rand(65,75)/100);
									break;
								}
							}								
						}
						$thisAtt *= $amount * $attTech * $DK;				
						break;
					}
				}
								
				if($CombatCaps[$element]['type_shield'] == 'none')
				{
					$thisShield	= 0; 
				}						
				else 
				{
					$thisShield	= $amount * ($CombatCaps[$element]['shield'] * (1 + $attacker['player']['factor']['ShieldS'.$CombatCaps[$element]['type_shield']])) * $shieldTech * $SK; 
				}				
				
				$thisDef	= $amount * ($CombatCaps[$element]['defend'] * (1 + $attacker['player']['factor']['DefensiveS'.$CombatCaps[$element]['type_defend']])) *  $defTech * $UK; 

				//Конец
				$attArray[$fleetID][$element] = array('def' => $thisDef, 'shield' => $thisShield, 'att' => $thisAtt);
				
				$attackDamage[$fleetID] += $thisAtt;
				$attackDamage['total'] += $thisAtt;
				$attackShield[$fleetID] += $thisDef;
				$attackShield['total'] += $thisDef;
				$attackAmount[$fleetID] += $amount;
				$attackAmount['total'] += $amount;
			}
		}

		foreach ($defenders as $fleetID => $defender) {
			$defenseDamage[$fleetID] = 0;
			$defenseShield[$fleetID] = 0;
			$defenseAmount[$fleetID] = 0;

			$attTech	= (1 + $defender['player']['factor']['Attack'] + $defender['player']['factor']['AttackD']); 
			$defTech	= (1 + $defender['player']['factor']['Defensive'] + $defender['player']['factor']['DefensiveD']); 
			$shieldTech = (1 + $defender['player']['factor']['Shield'] + $defender['player']['factor']['ShieldD']); 
			$defenders[$fleetID]['techs'] = array($attTech, $defTech, $shieldTech);

            foreach ($defender['unit'] as $element => $amount) 
			{
                //Удвоение
                $DK		= 1;
                $SK		= 1;
                $UK		= 1;

                $procen_DK = $defender['player']['factor']['DoubleAttack'] * 100;
                $procen_SK = $defender['player']['factor']['DoubleShield'] * 100;
                $procen_UK = $defender['player']['factor']['DoubleDefensive'] * 100;
                $power_DK = $defender['player']['factor']['DoubleAttackBonus'];
                $power_SK = $defender['player']['factor']['DoubleShieldBonus'];
                $power_UK = $defender['player']['factor']['DoubleDefensiveBonus'];
						
                if(rand(1,100) <= $procen_DK) $DK	= 2 + $power_DK;
                if(rand(1,100) <= $procen_SK) $SK	= 2 + $power_SK;	
                if(rand(1,100) <= $procen_UK) $UK	= 2 + $power_UK;
			
                $KritDefender['DK'][$fleetID][$element] = $DK;
                $KritDefender['SK'][$fleetID][$element] = $SK;
                $KritDefender['UK'][$fleetID][$element] = $UK;
                
				switch($CombatCaps[$element]['type_gun']) 
				{	
					case 'none':
					{	
						$thisAtt	= 0;
						break;
					}
					case 'notype':
					{	
						$thisAtt	= $amount * ($CombatCaps[$element]['attack']) * $attTech * $DK; 
						$defenseShoting['light'] += round(($amount) * rand(45,55)/100);
						$defenseShoting['medium'] += round(($amount) * rand(1,5)/100);
						$defenseShoting['heavy'] += floor($amount * 0.0000015);
						break;
					}
					default: 
					{	
						$thisAtt			= 0; 
						$type_gun			= explode(';', $CombatCaps[$element]['type_gun']);
						$FleetGun        	= array();
						
						foreach ($type_gun as $Item => $gun) 
						{
							if (empty($gun)) continue;	
							
							$Class		= explode(',', $gun);
							
							$thisAtt	+=	round((($CombatCaps[$element]['attack'] * $Class[1]/100) * (1 +($defender['player']['factor']['AttackS'.$Class[0]])))); 
							switch($Class[0]) 
							{
								case 'laser':
								{
									$defenseShoting['light'] += round(($amount * $Class[1]/100) * rand(65,75)/100);
									$defenseShoting['medium'] += round(($amount * $Class[1]/100) * rand(15,25)/100);
									$defenseShoting['heavy'] += floor($amount * 0.0000015);
									break;
								}
								case 'ion':
								{
									$defenseShoting['light'] += round(($amount * $Class[1]/100) * rand(55,65)/100);
									$defenseShoting['medium'] += round(($amount * $Class[1]/100) * rand(65,75)/100);
									$defenseShoting['heavy'] += round(($amount * $Class[1]/100) * rand(0,10)/100);
									break;
								}
								case 'plasma':
								{
									$defenseShoting['light'] += round(($amount * $Class[1]/100) * rand(0,2)/100);
									$defenseShoting['medium'] += round(($amount * $Class[1]/100) * rand(35,45)/100);
									$defenseShoting['heavy'] += round(($amount * $Class[1]/100) * rand(50,60)/100);
									break;
								}
								case 'gravity':
								{
									$defenseShoting['light'] += round(($amount * $Class[1]/100) * rand(0,5)/100);
									$defenseShoting['medium'] += round(($amount * $Class[1]/100) * rand(10,20)/100);
									$defenseShoting['heavy'] += round(($amount * $Class[1]/100) * rand(65,75)/100);
									break;
								}
							}															
						}
						$thisAtt *= $amount * $attTech * $DK;			
						break;
					}
				}
								
				if($CombatCaps[$element]['type_shield'] == 'none')
				{
					$thisShield	= 0; 
				}						
				else 
				{
                    $thisShield	= $amount * ($CombatCaps[$element]['shield'] * (1 + $defender['player']['factor']['ShieldS'.$CombatCaps[$element]['type_shield']])) * $shieldTech * $SK; 
				}
					
                $thisDef	= $amount * ($CombatCaps[$element]['defend'] * (1 + $defender['player']['factor']['DefensiveS'.$CombatCaps[$element]['type_defend']])) *  $defTech * $UK; 
			
				if ($element == 407 || $element == 408 || $element == 409) $thisAtt = 0;
		
                //Конец

				$defArray[$fleetID][$element] = array('def' => $thisDef, 'shield' => $thisShield, 'att' => $thisAtt);

				$defenseDamage[$fleetID] += $thisAtt;
				$defenseDamage['total'] += $thisAtt;
				$defenseShield[$fleetID] += $thisShield;
				$defenseShield['total'] += $thisShield;
				$defenseAmount[$fleetID] += $amount;
				$defenseAmount['total'] += $amount;
			}
            
		}
        
		$ROUND[$ROUNDC] = array('attackers' => $attackers, 'defenders' => $defenders, 'attackA' => $attackAmount, 'defenseA' => $defenseAmount, 'infoA' => $attArray, 'infoD' => $defArray);
        
        if (!empty($KritAttacker)) {
            $ROUND[$ROUNDC] += array('kA' => $KritAttacker);
        }
        if (!empty($KritDefender)) {
            $ROUND[$ROUNDC] += array('kD' => $KritDefender);
        }

		if ($ROUNDC >= MAX_ATTACK_ROUNDS || $defenseAmount['total'] <= 0 || $attackAmount['total'] <= 0) {
			break;
		}

		// Calculate hit percentages (ACS only but ok)
		$attackPct = array();
		foreach ($attackAmount as $fleetID => $amount) {
			if (!is_numeric($fleetID)) continue;
				$attackPct[$fleetID] = $amount / $attackAmount['total'];
		}

		$defensePct = array();
		foreach ($defenseAmount as $fleetID => $amount) {
			if (!is_numeric($fleetID)) continue;
				$defensePct[$fleetID] = $amount / $defenseAmount['total'];
		}
        
        
        // CALCUL DES PERTES !!!
		$attacker_n = array();
		$attacker_shield = 0;
		$defenderAttack	= 0;
		foreach ($attackers as $fleetID => $attacker) {
			$attacker_n[$fleetID] = array();

			foreach($attacker['unit'] as $element => $amount) {
				if ($amount <= 0) {
					$attacker_n[$fleetID][$element] = 0;
					continue;
				}
								
				$defender_moc = $amount * ($defenseDamage['total'] * $attackPct[$fleetID]) / $attackAmount[$fleetID];
				$defenseAmountRF = 0;
				if(isset($RF[$element])) {
					foreach($RF[$element] as $shooter => $shots) {
						foreach($defArray as $fID => $rfdef) {
							if(empty($rfdef[$shooter]['att']) || $attackAmount[$fleetID] <= 0) continue;					

							$defenseAmountRF += $defenders[$fID]['unit'][$shooter] * $shots;
						}
					}
				}				
				
				$CV = 0;
				$CR = 0;
				$Max_dex = 1.0;
				$Fcus = 1.0;	
                $minimize_RF = 1;
                
                foreach($defArray as $fID => $rfatt) 
				{ 
					if ($defenseAmount[$fID] <= 0 ) continue;
					//------CV
					if(empty($defenders[$fID]['player']['factor']['ChainReaction'])){
                        $CV = 0;
                    }else{
                        $CV += $defensePct[$fID] + ($defenders[$fID]['player']['factor']['ChainReaction']);
                    }
					//------CR
					if(empty($defenders[$fID]['player']['factor']['ExpBoost'])){
                        $CR += 1;
                    }else{
                        $CR += $defensePct[$fID] * rand(1,($defenders[$fID]['player']['factor']['ExpBoost']));
                    }
					//------max destruction
					if(empty($defenders[$fID]['player']['factor']['AccurateShots'])){
                        $Max_dex += 0;
                    }else{
                        $Max_dex += $defensePct[$fID] * (($defenders[$fID]['player']['factor']['AccurateShots']));
                    }
					//------skil_fcus
					if(empty($defenders[$fID]['player']['factor']['Focusing'])){
                        $Fcus -= 0;
                    }else{
                        $Fcus -= $defensePct[$fID] * (($defenders[$fID]['player']['factor']['Focusing']));
                    }
				}
                
                if(empty($attacker['player']['factor']['AntiFocusing']))
				{$minimize_RF = 1;}
				else
				{$minimize_RF = max(0, 1 - (($attacker['player']['factor']['AntiFocusing'])));}
				
				$defenderAttack	+= $defender_moc;
				
				if (($attArray[$fleetID][$element]['shield'] / $attackAmount[$fleetID]) >= $defender_moc) {
					$attacker_n[$fleetID][$element] = round($amount);
					$attacker_shield += $defender_moc;
					continue;
				}				
				
				$max_removePoints = floor($amount * $Max_dex * ($defenseShoting[$CombatCaps[$element]['type_defend']]+($defenseAmountRF * $minimize_RF)) / $attackAmount[$fleetID] * $attackPct[$fleetID]);
				$max_removePoints += min($max_removePoints, floor($max_removePoints*$CV*$CR)); // цепная реакция
				
				$amount_dex 	= min($attackAmount[$fleetID], min($max_removePoints * rand(1,3), ($attackAmount[$fleetID] * ((($defenseDamage['total'] * $attackPct[$fleetID])) / (($attArray[$fleetID][$element]['def']/10 + $attArray[$fleetID][$element]['shield'])))))); // число максимально уничтоженных за залп игнорируя скарострел
				$procent_wars	= ($amount_dex / $attackAmount[$fleetID]) * max(0.5,$Fcus); // процент стражающихся пачки по которой стреляют
				
				$attacker_shield  += min(round($procent_wars * $attArray[$fleetID][$element]['shield']), $defender_moc);
				$defender_moc 	  -= min(round($procent_wars * $attArray[$fleetID][$element]['shield']), $defender_moc);	
							
				$ile_removePoints = max(min($max_removePoints, $amount * min((min(1,(1.0 * $procent_wars)) * $defender_moc) / max(1,($procent_wars * ($attArray[$fleetID][$element]['def']/10))), 1)), 0);
				
				$attacker_n[$fleetID][$element] = max(ceil($amount - $ile_removePoints), 0);
			}
		}

		$defender_n = array();
		$defender_shield = 0;
		$attackerAttack	= 0;
		foreach ($defenders as $fleetID => $defender) {
			$defender_n[$fleetID] = array();

			foreach($defender['unit'] as $element => $amount) {
				if ($amount <= 0) {
					$defender_n[$fleetID][$element] = 0;
					continue;
				}
								
				$attacker_moc = $amount * ($attackDamage['total'] * $defensePct[$fleetID]) / $defenseAmount[$fleetID];
				$attackAmountRF = 0;
				if (isset($RF[$element])) {
					foreach($RF[$element] as $shooter => $shots) {
						foreach($attArray as $fID => $rfatt) {
							if (empty($rfatt[$shooter]['att']) || $defenseAmount[$fleetID] <= 0 ) continue;

							$attackAmountRF += $attackers[$fID]['unit'][$shooter] * $shots;							
						}
					}
				}
				
				$CV = 0;
				$CR = 0;
				$Max_dex = 1.0;
				$Fcus = 1.0;	
                $minimize_RF = 1;
                
                foreach($attArray as $fID => $rfatt) 
				{
					if ($attackAmount[$fID] <= 0 ) continue;
					//------CV
					if(empty($attackers[$fID]['player']['factor']['ChainReaction'])){
                        $CV = 0;
                    }else{
                        $CV += $attackPct[$fID] * ($attackers[$fID]['player']['factor']['ChainReaction']);
                    }
					//------CR
					if(empty($attackers[$fID]['player']['factor']['ExpBoost'])){
                        $CR += 1;
                    }else{
                        $CR += $attackPct[$fID] * rand(1,($attackers[$fID]['player']['factor']['ExpBoost']));
                    }
					//------max destruction
					if(empty($attackers[$fID]['player']['factor']['AccurateShots'])){
                        $Max_dex += 0;
                    }else{
                        $Max_dex += $attackPct[$fID] * (($attackers[$fID]['player']['factor']['AccurateShots']));
                    }
					//------skil_fcus
					if(empty($attackers[$fID]['player']['factor']['Focusing'])){
                        $Fcus -= 0;
                    }else{
                        $Fcus -= $attackPct[$fID] * (($attackers[$fID]['player']['factor']['Focusing']));
                    }
				}
                
                if(empty($defender['player']['factor']['AntiFocusing'])){
                    $minimize_RF = 1;
                }else{
                    $minimize_RF = max(0, 1 - (($defender['player']['factor']['AntiFocusing'])));
                }
                
				$attackerAttack	+= $attacker_moc;
				
				if (($defArray[$fleetID][$element]['shield'] / $defenseAmount[$fleetID]) >= $attacker_moc) {
					$defender_n[$fleetID][$element] = round($amount);
					$defender_shield += $attacker_moc;
					continue;
				}

				$max_removePoints = floor($amount * $Max_dex * ($attackShoting[$CombatCaps[$element]['type_defend']]+($attackAmountRF * $minimize_RF)) / $defenseAmount[$fleetID] * $defensePct[$fleetID]);
				$max_removePoints += min($max_removePoints, floor($max_removePoints*$CV*$CR)); // цепная реакция
				
				$amount_dex 	= min($defenseAmount[$fleetID], min($max_removePoints * rand(1,3), ($defenseAmount[$fleetID] * ((($attackDamage['total'] * $defensePct[$fleetID])) / (($defArray[$fleetID][$element]['def']/10 + $defArray[$fleetID][$element]['shield'])))))); // число максимально уничтоженных за залп игнорируя скарострел
				$procent_wars	= ($amount_dex / $defenseAmount[$fleetID]) * max(0.5,$Fcus); // процент стражающихся пачки по которой стреляют
				
				$defender_shield += min(round($procent_wars * $defArray[$fleetID][$element]['shield']), $attacker_moc);
				$attacker_moc 	 -= min(round($procent_wars * $defArray[$fleetID][$element]['shield']), $attacker_moc);				
		
				$ile_removePoints = max(min($max_removePoints, $amount * min((min(1,(1.0 * $procent_wars)) * $attacker_moc) / max(1,($procent_wars * ($defArray[$fleetID][$element]['def']/10))), 1)), 0);

				$defender_n[$fleetID][$element] = max(ceil($amount - $ile_removePoints), 0);
			}
		}
		
		$ROUND[$ROUNDC]['attack'] 		= $attackerAttack;
		$ROUND[$ROUNDC]['defense'] 		= $defenderAttack;
		$ROUND[$ROUNDC]['attackShield'] = $attacker_shield;
		$ROUND[$ROUNDC]['defShield'] 	= $defender_shield;
		foreach ($attackers as $fleetID => $attacker) {
			$attackers[$fleetID]['unit'] = array_map('round', $attacker_n[$fleetID]);
		}

		foreach ($defenders as $fleetID => $defender) {
			$defenders[$fleetID]['unit'] = array_map('round', $defender_n[$fleetID]);
		}
	}
	
	if ($attackAmount['total'] <= 0 && $defenseAmount['total'] > 0) {
		$won = "r"; // defender
	} elseif ($attackAmount['total'] > 0 && $defenseAmount['total'] <= 0) {
		$won = "a"; // attacker
	} else {
		$won = "w"; // draw
	}

	// CDR
	foreach ($attackers as $fleetID => $attacker) {					   // flotte attaquant en CDR
		foreach ($attacker['unit'] as $element => $amount) {
			$TRES['attacker'] -= $pricelist[$element]['cost'][901] * $amount ;
			$TRES['attacker'] -= $pricelist[$element]['cost'][902] * $amount ;

			$ARES['metal'] -= $pricelist[$element]['cost'][901] * $amount ;
			$ARES['crystal'] -= $pricelist[$element]['cost'][902] * $amount ;
		}
	}

	$DRESDefs = array('metal' => 0, 'crystal' => 0);
    $RD	= ($defender['player']['factor']['DefRecovery'] * 100);

	foreach ($defenders as $fleetID => $defender) {
		foreach ($defender['unit'] as $element => $amount) {
			if ($element < 300) {							// flotte defenseur en CDR
				$DRES['metal'] 	 -= $pricelist[$element]['cost'][901] * $amount ;
				$DRES['crystal'] -= $pricelist[$element]['cost'][902] * $amount ;

				$TRES['defender'] -= $pricelist[$element]['cost'][901] * $amount ;
				$TRES['defender'] -= $pricelist[$element]['cost'][902] * $amount ;
			} else {									// defs defenseur en CDR + reconstruction
				$TRES['defender'] -= $pricelist[$element]['cost'][901] * $amount ;
				$TRES['defender'] -= $pricelist[$element]['cost'][902] * $amount ;

				$lost = $STARTDEF[$element] - $amount;
				$giveback = round($lost * (rand(50+$RD, 70+$RD) / 100));
				$defenders[$fleetID]['unit'][$element] += $giveback;
				$DRESDefs['metal'] 	 += $pricelist[$element]['cost'][901] * ($lost - $giveback) ;
				$DRESDefs['crystal'] += $pricelist[$element]['cost'][902] * ($lost - $giveback) ;
			}
		}
	}
	
	$ARES['metal']		= max($ARES['metal'], 0);
	$ARES['crystal']	= max($ARES['crystal'], 0);
	$DRES['metal']		= max($DRES['metal'], 0);
	$DRES['crystal']	= max($DRES['crystal'], 0);
	$TRES['attacker']	= max($TRES['attacker'], 0);
	$TRES['defender']	= max($TRES['defender'], 0);
	
	$totalLost = array('attacker' => $TRES['attacker'], 'defender' => $TRES['defender']);
	$debAttMet = ($ARES['metal'] * ($FleetTF / (100 - ($attacker['player']['factor']['Debris'] * 100))));
	$debAttCry = ($ARES['crystal'] * ($FleetTF / (100 - ($attacker['player']['factor']['Debris'] * 100))));
	$debDefMet = ($DRES['metal'] * ($FleetTF / 100)) + ($DRESDefs['metal'] * ($DefTF / 100));
	$debDefCry = ($DRES['crystal'] * ($FleetTF / 100)) + ($DRESDefs['crystal'] * ($DefTF / 100));

	return array('won' => $won, 'debris' => array('attacker' => array(901 => $debAttMet, 902 => $debAttCry), 'defender' => array(901 => $debDefMet, 902 => $debDefCry)), 'rw' => $ROUND, 'unitLost' => $totalLost);
}