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

class MissionCaseExpedition extends MissionFunctions implements Mission
{
	function __construct($fleet)
	{
		$this->_fleet	= $fleet;
	}
	
	function TargetEvent()
	{
		$this->setState(FLEET_HOLD);
		$this->SaveFleet();
	}
	
	function EndStayEvent()
	{
		global $pricelist, $reslist, $resource;
        
		$LNG	= $this->getLanguage(NULL, $this->_fleet['fleet_owner']);

		$config	= Config::get($this->_fleet['fleet_universe']);

        $expeditionPoints       = array();

		foreach($reslist['fleet'] as $shipId)
		{
			$expeditionPoints[$shipId]	= ($pricelist[$shipId]['cost'][901] + $pricelist[$shipId]['cost'][902]);
		}
			
		$fleetArray		= FleetFunctions::unserialize($this->_fleet['fleet_array']);
		$fleetPoints 	= 0;
		$fleetCapacity	= 0;
        $fleetPoints_id = array();

		foreach ($fleetArray as $shipId => $shipAmount)
		{
			$fleetCapacity 			   += $shipAmount * $pricelist[$shipId]['capacity'];
			$fleetPoints   			   += $shipAmount * $expeditionPoints[$shipId];
            $fleetPoints_id[$shipId]   = $shipAmount * $expeditionPoints[$shipId]; //для поиска флота
		}
        
        //Ограничитель по ресам и очкам. 
        if($fleetPoints > 50000000 * $config->stat_settings){
            $fleetPoints = 50000000 * $config->stat_settings;
        }
        //Фактор добычи от посланного флота.
        $exp_factor = 0.15; //15%
        $fleetPrize = $fleetPoints * $exp_factor;
        
		$fleetCapacity  -= $this->_fleet['fleet_resource_metal'] + $this->_fleet['fleet_resource_crystal']
			+ $this->_fleet['fleet_resource_deuterium'] + $this->_fleet['fleet_resource_darkmatter'];

        $GetEvent	= mt_rand(0,100000);
        //1. Ресурсы. 
        if($GetEvent <= 40000){
            
          $input = $reslist['resstype'][1];
            $rand_keys = array_rand($input, 1);
            $FindSize   = mt_rand(0, 100);
            $Size       = 0;

			if(10 < $FindSize) {
				$Size		= mt_rand(6, 7) * ($fleetPrize/10); 
				$Message	= $LNG['sys_expe_found_ress_1_'.mt_rand(1,4)];
			} elseif(0 < $FindSize && 10 >= $FindSize) {
				$Size		= mt_rand(8, 12) * ($fleetPrize/10);
				$Message	= $LNG['sys_expe_found_ress_2_'.mt_rand(1,3)];
			} elseif(0 == $FindSize) {
				$Size	 	= mt_rand(13, 17) * ($fleetPrize/10);
				$Message	= $LNG['sys_expe_found_ress_3_'.mt_rand(1,2)];
			}
				
			//$Size 	+=  $Size;
            
            $fleetColName	= 'fleet_resource_'.$resource[$input[$rand_keys]];
			$this->UpdateFleet($fleetColName, $this->_fleet[$fleetColName] + $Size); 
            
        //2. Поиск Темной материи. 
        }elseif($GetEvent > 40000 && $GetEvent <= 50000){

            if($fleetPoints < 500000 * $config->stat_settings){
                $Message        = $LNG['sys_expe_nothing_'.mt_rand(1,8)];
            }else{
                $FindSize   = mt_rand(0, 100);
                $Size       = 0; 

                if(10 < $FindSize) {
                    $Size		= mt_rand(12, 14) * ($fleetPrize/500000); 
                    $Message	= $LNG['sys_expe_found_dm_1_'.mt_rand(1,5)];
                } elseif(0 < $FindSize && 10 >= $FindSize) {
                    $Size		= mt_rand(16, 24)* ($fleetPrize/500000); 
                    $Message	= $LNG['sys_expe_found_dm_2_'.mt_rand(1,3)];
                } elseif(0 == $FindSize) {
                    $Size	 	= mt_rand(26, 32) * ($fleetPrize/500000);
                    $Message	= $LNG['sys_expe_found_dm_3_'.mt_rand(1,2)];
                }
                
                $this->UpdateFleet('fleet_resource_darkmatter', $this->_fleet['fleet_resource_darkmatter'] + $Size);
            }
            
        //3. Минералы.   
        }elseif($GetEvent > 50000 && $GetEvent <= 55000){ 

            if($fleetPoints < 500000 * $config->stat_settings){
                $Message        = $LNG['sys_expe_nothing_'.mt_rand(1,8)];
            }else{
                $input = $reslist['minerals'];
                $rand_keys = array_rand($input, 1);
                $Size = 1;
            
                $sql	= "UPDATE %%USERS%% SET ".$resource[$input[$rand_keys]]." = ".$resource[$input[$rand_keys]]." + ".$Size." WHERE id = :userId;";
                    Database::get()->update($sql, array(
                        ':userId'       => $this->_fleet['fleet_owner'],
                ));
                $Message        = ''.$LNG['sys_expe_found_minerals_'.mt_rand(1,7)].' <span style="color:#58c552">('.$LNG['tech'][$input[$rand_keys]].': '.pretty_number($Size).')</span>';
            }
        
        //4. Замедление и ускорение.
        }elseif($GetEvent > 55000 && $GetEvent <= 65000){
            
            $MoreTime	= mt_rand(0,100);
			$Wrapper	= array(2,2,2,2,2,3,3,5);
            
			if($MoreTime < 75) {
				$this->UpdateFleet('fleet_end_time', ($this->_fleet['fleet_end_time'] - $this->_fleet['fleet_end_stay']) * $Wrapper[mt_rand(0, 7)] + $this->_fleet['fleet_end_stay']);
				$Message = $LNG['sys_expe_time_slow_'.mt_rand(1,6)];
			} else {
				$this->UpdateFleet('fleet_end_time', ($this->_fleet['fleet_end_time'] - $this->_fleet['fleet_end_stay']) / $Wrapper[mt_rand(0, 7)] + $this->_fleet['fleet_end_stay']);
				$Message = $LNG['sys_expe_time_fast_'.mt_rand(1,3)];
			}
            
        //5. Контейнеры.
        }elseif($GetEvent > 65000 && $GetEvent <= 70000){

            if($fleetPoints < 500000 * $config->stat_settings){
                $Message        = $LNG['sys_expe_nothing_'.mt_rand(1,8)];
            }else{
                $Size = mt_rand(1,5);

                $sql	= "UPDATE %%USERS%% SET container = container + ".$Size." WHERE id = :userId;";
                    Database::get()->update($sql, array(
                        ':userId'       => $this->_fleet['fleet_owner'],
                ));
                $Message        = ''.$LNG['sys_expe_found_container_'.mt_rand(1,5)].' <span style="color:#b69149">('.$LNG['tech'][924].': '.pretty_number($Size).')</span>';
            }
            
        //6. Поиск звездной руды.
        }elseif($GetEvent > 70000 && $GetEvent <= 72000){ 

            if($fleetPoints < 500000 * $config->stat_settings){
                $Message        = $LNG['sys_expe_nothing_'.mt_rand(1,8)];
            }else{
                $sql	= "UPDATE %%USERS%% SET stardust = stardust + 1 WHERE id = :userId;";
                    Database::get()->update($sql, array(
                        ':userId'       => $this->_fleet['fleet_owner'],
                ));
                $Message	    = $LNG['sys_expe_found_so_'.mt_rand(1,7)];
            }
          
        //7. Поиск флота.
        }elseif($GetEvent > 72000 && $GetEvent <= 78000){
            
            if($fleetPoints < 200000 * $config->stat_settings){
                $Message        = $LNG['sys_expe_nothing_'.mt_rand(1,8)];     
            }else{
                $Message        = $LNG['sys_expe_found_ships_'.mt_rand(1,8)];
				
				$FoundShipMess	= "";	
				$NewFleetArray 	= "";
				
				$Found			= array();
				foreach($reslist['fleet'] as $ID) 
				{
                    //убираем, что не должно попадаться
					if(!isset($fleetArray[$ID]))
						continue;

					$Found[$ID]			= ($fleetPoints_id[$ID]/(($pricelist[$ID]['cost'][901] + $pricelist[$ID]['cost'][902]))) * ($exp_factor + (mt_rand(1,5)/100)); //колличество
                    $FoundShipMess   	.= '<br><span style="color:#d3af00">'.$LNG['tech'][$ID].': '.pretty_number($Found[$ID]).'</span>';
				}
				
				if (empty($Found)) {
					$FoundShipMess .= '<br><br>'.$LNG['sys_expe_found_ships_'.mt_rand(1,8)];;
				}

				foreach($fleetArray as $ID => $Count)
				{
					if(!empty($Found[$ID]))
					{
						$Count	+= $Found[$ID];
					}
					
					$NewFleetArray  	.= $ID.",".floatToString($Count).';';
				}	
				
				$Message	.= $FoundShipMess;
							
				$this->UpdateFleet('fleet_array', $NewFleetArray);
				$this->UpdateFleet('fleet_amount', array_sum($fleetArray));
            }

        //8. Пропажа флота.
        }elseif($GetEvent > 78000 && $GetEvent <= 79000){
            
            $this->KillFleet();
			$Message	= $LNG['sys_expe_lost_fleet_'.mt_rand(1,4)];

        //9. Пусто.
        }else{
            
            $Message        = $LNG['sys_expe_nothing_'.mt_rand(1,8)];
        
        }
        //Конец
		PlayerUtil::sendMessage($this->_fleet['fleet_owner'], 0, $LNG['sys_mess_tower'], 15,
			$LNG['sys_expe_report'], $Message, $this->_fleet['fleet_end_stay'], NULL, 1, $this->_fleet['fleet_universe']);

		$this->setState(FLEET_RETURN);
		$this->SaveFleet();
	}
	//Домой
	function ReturnEvent()
	{
		$LNG		= $this->getLanguage(NULL, $this->_fleet['fleet_owner']);
		$Message 	= sprintf(
			$LNG['sys_expe_back_home'],
			$LNG['tech'][901], pretty_number($this->_fleet['fleet_resource_metal']),
			$LNG['tech'][902], pretty_number($this->_fleet['fleet_resource_crystal']),
			$LNG['tech'][903], pretty_number($this->_fleet['fleet_resource_deuterium']),
			$LNG['tech'][921], pretty_number($this->_fleet['fleet_resource_darkmatter'])
		);

		PlayerUtil::sendMessage($this->_fleet['fleet_owner'], 0, $LNG['sys_mess_tower'], 15, $LNG['sys_mess_fleetback'],
			$Message, $this->_fleet['fleet_end_time'], NULL, 1, $this->_fleet['fleet_universe']);

		$this->RestoreFleet();
	}
}