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

class MissionCaseMIP extends MissionFunctions implements Mission
{
	function __construct($Fleet)
	{
		$this->_fleet	= $Fleet;
	}
	
	function TargetEvent()
	{
		global $resource, $reslist;

		$db	= Database::get();

		$sqlFields	= array();
		$elementIDs	= array_merge($reslist['fleet'], $reslist['defense'], $reslist['missile']);

		foreach($elementIDs as $elementID)
		{
			$sqlFields[]	= '%%PLANETS%%.`'.$resource[$elementID].'`';
		}
			
		$sql = 'SELECT lang, shield_tech,
		%%PLANETS%%.id, name, id_owner, '.implode(', ', $sqlFields).'
		FROM %%PLANETS%%
		INNER JOIN %%USERS%% ON id_owner = %%USERS%%.id
		WHERE %%PLANETS%%.id = :planetId;';

		$targetData	= $db->selectSingle($sql, array(
			':planetId'	=> $this->_fleet['fleet_end_id']
		));

		if($this->_fleet['fleet_end_type'] == 3)
		{
			$sql	= 'SELECT '.$resource[502].' FROM %%PLANETS%% WHERE id_luna = :moonId;';
			$targetData[$resource[502]]	= $db->selectSingle($sql, array(
				':moonId'	=> $this->_fleet['fleet_end_id']
			), $resource[502]);
		}

		$sql		= 'SELECT lang, military_tech FROM %%USERS%% WHERE id = :userId;';
		$senderData	= $db->selectSingle($sql, array(
			':userId'	=> $this->_fleet['fleet_owner']
		));

		if(!in_array($this->_fleet['fleet_target_obj'], $elementIDs)
			|| $this->_fleet['fleet_target_obj'] == 502
			|| $this->_fleet['fleet_target_obj'] == 0)
		{
			$primaryTarget	= 401;
		}
		else
		{
			$primaryTarget	= $this->_fleet['fleet_target_obj'];
		}

        $targetDefensive    = array();

		foreach($elementIDs as $elementID)	
		{
			$targetDefensive[$elementID]	= $targetData[$resource[$elementID]];
		}
		
		unset($targetDefensive[502]);

		$LNG	= $this->getLanguage(Config::get($this->_fleet['fleet_universe'])->lang, array('L18N', 'FLEET', 'TECH'));
				
		if ($targetData[$resource[502]] >= $this->_fleet['fleet_amount'])
		{
			$message 	= $LNG['sys_irak_no_att'];
			$where 		= $this->_fleet['fleet_end_type'] == 3 ? 'id_luna' : 'id';
			
			$sql		= 'UPDATE %%PLANETS%% SET '.$resource[502].' = '.$resource[502].' - :amount WHERE '.$where.' = :planetId;';

			$db->update($sql, array(
				':amount'	=> $this->_fleet['fleet_amount'],
				':planetId'	=> $targetData['id']
			));
		}
		else
		{
			if ($targetData[$resource[502]] > 0)
			{
				$where 	= $this->_fleet['fleet_end_type'] == 3 ? 'id_luna' : 'id';
				$sql	= 'UPDATE %%PLANETS%% SET '.$resource[502].' = :amount WHERE '.$where.' = :planetId;';

				$db->update($sql, array(
					':amount'	=> 0,
					':planetId'	=> $targetData['id']
				));
			}
			
			$targetDefensive = array_filter($targetDefensive);
			
			if(!empty($targetDefensive))
			{
				require_once 'includes/classes/missions/functions/calculateMIPAttack.php';
				$result   	= calculateMIPAttack($targetData["shield_tech"], $senderData["military_tech"],
					$this->_fleet['fleet_amount'], $targetDefensive, $primaryTarget, $targetData[$resource[502]]);

				$result		= array_filter($result);
				
				$message	= sprintf($LNG['sys_irak_def'], $targetData[$resource[502]]).'<br><br>';
				
				ksort($result, SORT_NUMERIC);
				
				foreach ($result as $Element => $destroy)
				{
					$message .= sprintf('%s (- %d)<br>', $LNG['tech'][$Element], $destroy);

					$sql	= 'UPDATE %%PLANETS%% SET '.$resource[$Element].' = '.$resource[$Element].' - :amount WHERE id = :planetId;';
					$db->update($sql, array(
						':planetId' => $targetData['id'],
						':amount'	=> $destroy
					));
				}
			}
			else
			{
				$message = $LNG['sys_irak_no_def'];
			}
		}

		$sql		= 'SELECT name FROM %%PLANETS%% WHERE id = :planetId;';
		$planetName	= Database::get()->selectSingle($sql, array(
			':planetId'	=> $this->_fleet['fleet_start_id'],
		), 'name');

		$ownerLink			= $planetName." ".GetStartAddressLink($this->_fleet);
		$targetLink 		= $targetData['name']." ".GetTargetAddressLink($this->_fleet);
		$message			= sprintf($LNG['sys_irak_mess'], $this->_fleet['fleet_amount'], $ownerLink, $targetLink).$message;

		PlayerUtil::sendMessage($this->_fleet['fleet_owner'], 0, $LNG['sys_mess_tower'], 3,
			$LNG['sys_irak_subject'], $message, $this->_fleet['fleet_start_time'], NULL, 1, $this->_fleet['fleet_universe']);

		PlayerUtil::sendMessage($this->_fleet['fleet_target_owner'], 0, $LNG['sys_mess_tower'], 3,
			$LNG['sys_irak_subject'], $message, $this->_fleet['fleet_start_time'], NULL, 1, $this->_fleet['fleet_universe']);

		$this->KillFleet();
	}
	
	function EndStayEvent()
	{
		return;
	}
	
	function ReturnEvent()
	{
		return;
	}
}
