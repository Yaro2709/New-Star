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

require_once('AbstractGamePage.class.php');

class ShowResearchPage extends AbstractGamePage
{
	private $build_anz=0;
	private $bOnInsert=FALSE;
	public static $requireModule = MODULE_RESEARCH;

	function __construct() 
	{
		parent::__construct();
	}
	
	private function FastBuildingFromQueue()
	{
		global $PLANET, $USER, $resource, $resglobal;
		$CurrentQueue  = unserialize($USER['b_tech_queue']);
		if (empty($CurrentQueue) || empty($USER['b_tech'])){
			$USER['b_tech_queue']	= '';
			$USER['b_tech_planet']	= 0;
			$USER['b_tech_id']		= 0;
			$USER['b_tech']			= 0;
			return false;
		}
		$Element		        = $USER['b_tech_id'];
		$fast                   = $resource[$Element];
		$NeededDm               = 10 + ((800*($USER['b_tech']-TIMESTAMP))/3600);
		if($NeededDm < 10)
			$NeededDm=10;
		if ($USER['darkmatter'] >= $NeededDm){
			$USER['darkmatter']				-= $NeededDm;
            $sql = "UPDATE %%USERS%% SET ".$fast." = ".$fast." + 1 WHERE id = :userId;";
		
            $USER['b_tech_id']			= 0;
            $USER['b_tech']      		= 0;
            $USER['b_tech_planet']		= 0;
            
            Database::get()->update($sql, array(':userId'	=> $USER['id']));
            array_shift($CurrentQueue);

            if (count($CurrentQueue) == 0) {
                $USER['b_tech_queue']	= '';
                $USER['b_tech_planet']	= 0;
                $USER['b_tech_id']		= 0;
                $USER['b_tech']			= 0;
            } else {
                $BuildEndTime		= TIMESTAMP;
                $NewCurrentQueue	= array();
                foreach($CurrentQueue as $ListIDArray){
                    if($ListIDArray[4] != $PLANET['id']){
                        $sql = "SELECT :resource, id FROM %%PLANETS%% WHERE id = :id;";
                        $CPLANET = Database::get()->selectSingle($sql, array(
                            ':resource'	    => $resource[$resglobal['tech_speed']],
                            ':id'			=> $ListIDArray[4]
                        ));
                    } else
                        $CPLANET		= $PLANET;
				
                    $CPLANET[$resource[$resglobal['tech_speed']].'_inter']	= $this->ecoObj->getNetworkLevel($USER, $CPLANET);
                    $BuildEndTime       				+= BuildFunctions::getBuildingTime($USER, $CPLANET, NULL, $ListIDArray[0]);
                    $ListIDArray[3]						= $BuildEndTime;
                    $NewCurrentQueue[]					= $ListIDArray;				
                }
			
                if(!empty($NewCurrentQueue)) {
                    $USER['b_tech']    			= TIMESTAMP;
                    $USER['b_tech_queue'] 		= serialize($NewCurrentQueue);
                    $this->ecoObj->setData($USER, $PLANET);
                    $this->ecoObj->SetNextQueueTechOnTop();
				list($USER, $PLANET)		= $this->ecoObj->getData();
                } else {
                    $USER['b_tech']    			= 0;
                    $USER['b_tech_queue'] 		= '';
                }
            }
		}
	}
	
	private function CheckLabSettingsInQueue()
	{
		global $USER;
		$db = Database::get();
		$sql	= "SELECT * FROM %%PLANETS%% WHERE id_owner = :owner;";
		$planets	= $db->select($sql, array(
			':owner'	=> $USER['id'],
		));

		foreach ($planets as $planet)
		{
			if ($planet['b_building'] == 0)
				continue;

			$CurrentQueue		= unserialize($planet['b_building_id']);
			foreach($CurrentQueue as $ListIDArray) {
				if($ListIDArray[0] == 6 || $ListIDArray[0] == 31)
					return false;
			}
		}

		return true;
	}
	
	private function CancelBuildingFromQueue()
	{
		global $PLANET, $USER, $resource, $resglobal;
		$CurrentQueue  = unserialize($USER['b_tech_queue']);
		if (empty($CurrentQueue) || empty($USER['b_tech']))
		{
			$USER['b_tech_queue']	= '';
			$USER['b_tech_planet']	= 0;
			$USER['b_tech_id']		= 0;
			$USER['b_tech']			= 0;

			return false;
		}

		$db = Database::get();

		$elementId		= $USER['b_tech_id'];
		$costResources	= BuildFunctions::getElementPrice($USER, $PLANET, $elementId);
		
		if($PLANET['id'] == $USER['b_tech_planet'])
		{
			if(isset($costResources[901])) { $PLANET[$resource[901]]	+= $costResources[901]; }
			if(isset($costResources[902])) { $PLANET[$resource[902]]	+= $costResources[902]; }
			if(isset($costResources[903])) { $PLANET[$resource[903]]	+= $costResources[903]; }
		}
		else
		{
			$params = array('techPlanet' => $USER['b_tech_planet']);
			$sql = "UPDATE %%PLANETS%% SET ";
			if(isset($costResources[901])) {
				$sql	.= $resource[901]." = ".$resource[901]." + :".$resource[901].", ";
				$params[':'.$resource[901]] = $costResources[901];
			}
			if(isset($costResources[902])) {
				$sql	.= $resource[902]." = ".$resource[902]." + :".$resource[902].", ";
				$params[':'.$resource[902]] = $costResources[902];
			}
			if(isset($costResources[903])) {
				$sql	.= $resource[903]." = ".$resource[903]." + :".$resource[903].", ";
				$params[':'.$resource[903]] = $costResources[903];
			}

			$sql = substr($sql, 0, -2);
			$sql .= " WHERE id = :techPlanet;";

			$db->update($sql, $params);
		}
		
		if(isset($costResources[921])) { $USER[$resource[921]]		+= $costResources[921]; }
		
		$USER['b_tech_id']			= 0;
		$USER['b_tech']      		= 0;
		$USER['b_tech_planet']		= 0;

		array_shift($CurrentQueue);

		if (count($CurrentQueue) == 0) {
			$USER['b_tech_queue']	= '';
			$USER['b_tech_planet']	= 0;
			$USER['b_tech_id']		= 0;
			$USER['b_tech']			= 0;
		} else {
			$BuildEndTime		= TIMESTAMP;
			$NewCurrentQueue	= array();
			foreach($CurrentQueue as $ListIDArray)
			{
				if($elementId == $ListIDArray[0] || empty($ListIDArray[0]))
					continue;
					
				if($ListIDArray[4] != $PLANET['id']) {
					$sql = "SELECT :resource, id FROM %%PLANETS%% WHERE id = :id;";
					$CPLANET = $db->selectSingle($sql, array(
						':resource'	    => $resource[$resglobal['tech_speed']],
						':id'			=> $ListIDArray[4]
					));
				} else
					$CPLANET		= $PLANET;
				
				$CPLANET[$resource[$resglobal['tech_speed']].'_inter']	= $this->ecoObj->getNetworkLevel($USER, $CPLANET);
				$BuildEndTime       				+= BuildFunctions::getBuildingTime($USER, $CPLANET, NULL, $ListIDArray[0]);
				$ListIDArray[3]						= $BuildEndTime;
				$NewCurrentQueue[]					= $ListIDArray;				
			}
			
			if(!empty($NewCurrentQueue)) {
				$USER['b_tech']    			= TIMESTAMP;
				$USER['b_tech_queue'] 		= serialize($NewCurrentQueue);
				$this->ecoObj->setData($USER, $PLANET);
				$this->ecoObj->SetNextQueueTechOnTop();
				list($USER, $PLANET)		= $this->ecoObj->getData();
			} else {
				$USER['b_tech']    			= 0;
				$USER['b_tech_queue'] 		= '';
			}
		}

		return true;
	}

	private function RemoveBuildingFromQueue($QueueID)
	{
		global $USER, $PLANET, $resource, $resglobal;
		
		$CurrentQueue  = unserialize($USER['b_tech_queue']);
		if ($QueueID <= 1 || empty($CurrentQueue))
		{
			return false;
		}

		$ActualCount   = count($CurrentQueue);
		if ($ActualCount <= 1)
		{
			return $this->CancelBuildingFromQueue();
		}

		if(!isset($CurrentQueue[$QueueID - 2]))
		{
			return false;
		}
			
		$elementId 		= $CurrentQueue[$QueueID - 2][0];
		$BuildEndTime	= $CurrentQueue[$QueueID - 2][3];
		unset($CurrentQueue[$QueueID - 1]);
		$NewCurrentQueue	= array();
		foreach($CurrentQueue as $ID => $ListIDArray)
		{				
			if ($ID < $QueueID - 1) {
				$NewCurrentQueue[]	= $ListIDArray;
			} else {
				if($elementId == $ListIDArray[0])
					continue;

				if($ListIDArray[4] != $PLANET['id']) {
					$db = Database::get();

					$sql = "SELECT :resource, id FROM %%PLANETS%% WHERE id = :id;";
					$CPLANET = $db->selectSingle($sql, array(
						':resource'	    => $resource[$resglobal['tech_speed']],
						':id'			=> $ListIDArray[4]
					));
				} else
					$CPLANET				= $PLANET;
				
				$CPLANET[$resource[$resglobal['tech_speed']].'_inter']	= $this->ecoObj->getNetworkLevel($USER, $CPLANET);
				
				$BuildEndTime       += BuildFunctions::getBuildingTime($USER, $CPLANET, NULL, $ListIDArray[0]);
				$ListIDArray[3]		= $BuildEndTime;
				$NewCurrentQueue[]	= $ListIDArray;				
			}
		}
		
		if(!empty($NewCurrentQueue))
			$USER['b_tech_queue'] = serialize($NewCurrentQueue);
		else
			$USER['b_tech_queue'] = "";

		return true;
	}

	private function AddBuildingToQueue($elementId, $lvlup, $lvlup1, $levelToBuildInFo, $AddMode = true)
	{
		if($this->bOnInsert==FALSE)
		{
			$this->build_anz=$lvlup - $levelToBuildInFo;
			if($this->build_anz>=1 )
			{
				$this->bOnInsert=TRUE;
				while($this->build_anz>0)
				{
					$this->DoAddBuildingToQueue($elementId, $AddMode);
					$this->build_anz=$this->build_anz-1;
				}
				$this->bOnInsert=FALSE;
		   }
		}
	}
    
	private function DoAddBuildingToQueue($elementId, $AddMode = true)
	{
		global $PLANET, $USER, $resource, $reslist, $pricelist;

		if(!in_array($elementId, $reslist['tech'])
			|| !BuildFunctions::isTechnologieAccessible($USER, $PLANET, $elementId, array())
			|| !$this->CheckLabSettingsInQueue($PLANET)
		)
		{
			return false;
		}

		$CurrentQueue  		= unserialize($USER['b_tech_queue']);
		
		if (!empty($CurrentQueue)) {
			$ActualCount   	= count($CurrentQueue);
		} else {
			$CurrentQueue  	= array();
			$ActualCount   	= 0;
		}
				
		if(Config::get()->max_elements_tech != 0 && (Config::get()->max_elements_tech + $USER['factor']['ResearchSlots']) <= $ActualCount)
		{
			return false;
		}

		$BuildLevel					= $USER[$resource[$elementId]] + 1;
		if($ActualCount == 0)
		{
			if($pricelist[$elementId]['max'] < $BuildLevel)
			{
				return false;
			}

			$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $elementId, !$AddMode); // BAG $Id_0001
			
			if(!BuildFunctions::isElementBuyable($USER, $PLANET, $elementId, $costResources))
			{
				return false;
			}
			
			if(isset($costResources[901])) { $PLANET[$resource[901]]	-= $costResources[901]; }
			if(isset($costResources[902])) { $PLANET[$resource[902]]	-= $costResources[902]; }
			if(isset($costResources[903])) { $PLANET[$resource[903]]	-= $costResources[903]; }
			if(isset($costResources[921])) { $USER[$resource[921]]		-= $costResources[921]; }
			
			$elementTime    			= BuildFunctions::getBuildingTime($USER, $PLANET, $elementId, $costResources);
			$BuildEndTime				= TIMESTAMP + $elementTime;
			
			$USER['b_tech_queue']		= serialize(array(array($elementId, $BuildLevel, $elementTime, $BuildEndTime, $PLANET['id'])));
			$USER['b_tech']				= $BuildEndTime;
			$USER['b_tech_id']			= $elementId;
			$USER['b_tech_planet']		= $PLANET['id'];
		} else {
			$addLevel = 0;
			foreach($CurrentQueue as $QueueSubArray)
			{
				if($QueueSubArray[0] != $elementId)
					continue;
					
				$addLevel++;
			}
				
			$BuildLevel					+= $addLevel;
				
			if($pricelist[$elementId]['max'] < $BuildLevel)
			{
				return false;
			}
				
			$elementTime    			= BuildFunctions::getBuildingTime($USER, $PLANET, $elementId, NULL, !$AddMode, $BuildLevel);
			
			$BuildEndTime				= $CurrentQueue[$ActualCount - 1][3] + $elementTime;
			$CurrentQueue[]				= array($elementId, $BuildLevel, $elementTime, $BuildEndTime, $PLANET['id']);
			$USER['b_tech_queue']		= serialize($CurrentQueue);
		}
		return true;
	}

	private function getQueueData()
	{
		global $LNG, $PLANET, $USER;

		$scriptData		= array();
		$quickinfo		= array();
		
		if ($USER['b_tech'] == 0 || $USER['b_tech_queue'] == "")
		return array('queue' => $scriptData, 'quickinfo' => $quickinfo);
		
		$CurrentQueue   = unserialize($USER['b_tech_queue']);
		
		foreach($CurrentQueue as $BuildArray) {
			if ($BuildArray[3] < TIMESTAMP)
				continue;
			
			$PlanetName	= '';
		
			$quickinfo[$BuildArray[0]]	= $BuildArray[1];
			
			if($BuildArray[4] != $PLANET['id'])
				$PlanetName		= $USER['PLANETS'][$BuildArray[4]]['name'];
				
			$scriptData[] = array(
				'element'	=> $BuildArray[0], 
				'level' 	=> $BuildArray[1], 
				'time' 		=> $BuildArray[2], 
				'resttime' 	=> ($BuildArray[3] - TIMESTAMP), 
				'destroy' 	=> ($BuildArray[4] == 'destroy'), 
				'endtime' 	=> _date('U', $BuildArray[3], $USER['timezone']),
				'display' 	=> _date($LNG['php_tdformat'], $BuildArray[3], $USER['timezone']),
				'planet'	=> $PlanetName,
			);
		}
		
		return array('queue' => $scriptData, 'quickinfo' => $quickinfo);
	}
	
	private static function getHighestLevelOfElement($QueueList, $ElementID, $default){
		$level = $default;
		foreach($QueueList as $TechQueue){
			if($TechQueue['element'] == $ElementID && $TechQueue['level'] > $level){
				$level = $TechQueue['level'];
			}
		}
		return $level;
	}

	public function show()
	{
		global $PLANET, $USER, $LNG, $resource, $reslist, $pricelist, $requeriments, $resglobal;
        
		$TheCommand		= HTTP::_GP('cmd','');
		$Element     	= HTTP::_GP('tech', 0);
		$ListID     	= HTTP::_GP('listid', 0);
		$lvlup      	= HTTP::_GP('lvlup', 0);
		$lvlup1      	= HTTP::_GP('lvlup1', 0);
		$levelToBuildInFo      	= HTTP::_GP('levelToBuildInFo', 0);
		
		$PLANET[$resource[$resglobal['tech_speed']].'_inter']	= ResourceUpdate::getNetworkLevel($USER, $PLANET);	

		if(!empty($TheCommand) && $_SERVER['REQUEST_METHOD'] === 'POST' && $USER['urlaubs_modus'] == 0)
		{
			switch($TheCommand)
			{
				case 'cancel':
					$this->CancelBuildingFromQueue();
				break;
				case 'remove':
					$this->RemoveBuildingFromQueue($ListID);
				break;
				 	case 'instant':
					$this->InstantBuildingFromQueue(); 	 	
				break; 	 	
				case 'insert':
					$this->AddBuildingToQueue($Element, $lvlup, $lvlup1, $levelToBuildInFo, true);
				break;
				case 'destroy':
					$this->DoAddBuildingToQueue($Element, false);
				break;
				case 'fast':
					$this->FastBuildingFromQueue();
				break;
			}
			
			$this->redirectTo('game.php?page=research');
		}
		
		$bContinue		= $this->CheckLabSettingsInQueue($PLANET);
		
		$queueData		= $this->getQueueData();
		$TechQueue		= $queueData['queue'];
		$QueueCount		= count($TechQueue);
		$ResearchList	= array();

		foreach($reslist['tech'] as $ID => $Element)
		{
			if(isset($queueData['quickinfo'][$Element]))
			{
				$levelToBuild	= $queueData['quickinfo'][$Element];
			}
			else
			{
				$levelToBuild	= $USER[$resource[$Element]];
			}
			
            $techTreeList		= BuildFunctions::requirementsList($USER, $PLANET, $Element);
			$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element, false, $levelToBuild);
			$costOverflow		= BuildFunctions::getRestPrice($USER, $PLANET, $Element, $costResources);
			$elementTime    	= BuildFunctions::getBuildingTime($USER, $PLANET, $Element, $costResources);
			$buyable			= $QueueCount != 0 || BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources);
            $elementBonus		= BuildFunctions::getAvalibleBonus($Element);

			$ResearchList[$Element]	= array(
				'id'				    => $Element,
				'level'				    => $USER[$resource[$Element]],
				'factor'			    => $pricelist[$Element]['factor'],
				'maxLevel'			    => $pricelist[$Element]['max'],
				'costResources'	        => $costResources,
				'costOverflow'		    => $costOverflow,
				'elementTime'    	    => $elementTime,
				'buyable'			    => $buyable,
				'levelToBuild'		    => $levelToBuild,
                'elementBonus'		    => $elementBonus,
				'AllTech'				=> $techTreeList,
				'techacc' 				=> BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element, array()),
			);
		}
		
		$this->tplObj->loadscript('research.js');
		$this->assign(array(
			'ResearchList'	=> $ResearchList,
			'IsLabinBuild'	=> !$bContinue,
			'IsFullQueue'	=> Config::get()->max_elements_tech == 0 || (Config::get()->max_elements_tech + $USER['factor']['ResearchSlots']) == count($TechQueue),
			'Queue'			=> $TechQueue,
			'need_dm'		=> floor(10 + ((800*($USER['b_tech']-TIMESTAMP))/3600)),
		));
		
		$this->display('page.research.default.tpl');
	}
}