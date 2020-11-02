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

class MissionCaseFoundDM extends MissionFunctions implements Mission
{
	const CHANCE = 30; 
	const CHANCE_SHIP = 1; 
	const MAX_CHANCE = 100; 
		
	function __construct($Fleet)
	{
		$this->_fleet	= $Fleet;
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

		foreach ($fleetArray as $shipId => $shipAmount)
		{
			$fleetCapacity 			   += $shipAmount * $pricelist[$shipId]['capacity'];
			$fleetPoints   			   += $shipAmount * $expeditionPoints[$shipId];
		}
        
        //Ограничитель по ресам и очкам. 
        if($fleetPoints > 50000000 * $config->stat_settings){
            $fleetPoints = 50000000 * $config->stat_settings;
        }
        //Фактор добычи от посланного флота.
        $exp_factor = 0.15; //15%
        $fleetPrize = $fleetPoints * $exp_factor;
        //Шанс
		$chance	= mt_rand(0, 100);
        //События
		if($chance <= min(self::MAX_CHANCE, (self::CHANCE + $this->_fleet['fleet_amount'] * self::CHANCE_SHIP))) {
            //Темная материя
            $GetEvent	= mt_rand(0,100000);
            if($GetEvent <= 70000){
                $Size 	= mt_rand(25, 62) * ($fleetPrize/500000);
                $this->UpdateFleet('fleet_resource_darkmatter', $Size);
                $Message 	= $LNG['sys_expe_found_dm_'.mt_rand(1, 3).'_'.mt_rand(1, 2).''];
            //Антиматерия
            }else{
                $Size = mt_rand(10,25);
                $sql	= "UPDATE %%USERS%% SET antimatter = antimatter + ".$Size." WHERE id = :userId;";
                    Database::get()->update($sql, array(
                        ':userId'       => $this->_fleet['fleet_owner'],
                ));
                $Message    = ''.$LNG['sys_expe_found_am_'.mt_rand(1,3)].' <span style="color:#db374b">('.$LNG['tech'][922].': '.pretty_number($Size).')</span>';
            }
		} else {
			$Message 	= $LNG['sys_expe_nothing_'.mt_rand(1, 9)];
		}
		$this->setState(FLEET_RETURN);
		$this->SaveFleet();

		PlayerUtil::sendMessage($this->_fleet['fleet_owner'], 0, $LNG['sys_mess_tower'], 15,
			$LNG['sys_expe_report'], $Message, $this->_fleet['fleet_end_stay'], NULL, 1, $this->_fleet['fleet_universe']);
	}
	
	function ReturnEvent()
	{
		$LNG	= $this->getLanguage(NULL, $this->_fleet['fleet_owner']);
		if($this->_fleet['fleet_resource_darkmatter'] > 0)
		{
			$Message	= sprintf($LNG['sys_expe_back_home_with_dm'],
				$LNG['tech'][921],
				pretty_number($this->_fleet['fleet_resource_darkmatter']),
				$LNG['tech'][921]
			);

			$this->UpdateFleet('fleet_array', '220,0;');
		}
		else
		{
			$Message	= $LNG['sys_expe_back_home_without_dm'];
		}

		PlayerUtil::sendMessage($this->_fleet['fleet_owner'], 0, $LNG['sys_mess_tower'], 15, $LNG['sys_mess_fleetback'],
			$Message, $this->_fleet['fleet_end_time'], NULL, 1, $this->_fleet['fleet_universe']);
		$this->RestoreFleet();
	}
}