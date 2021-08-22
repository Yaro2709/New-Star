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

class ShowAlliancePage extends AbstractGamePage
{
	public static $requireModule = MODULE_ALLIANCE;

	private $allianceData;
	private $ranks;
	private $rights;
	private $hasAlliance = false;
	private $hasApply = false;
	public $availableRanks	= array(
		'MEMBERLIST',
		'ONLINESTATE',
		'TRANSFER',
		'SEEAPPLY',
		'MANAGEAPPLY',
		'ROUNDMAIL',
		'ADMIN',
		'KICK',
		'DIPLOMATIC',
		'RANKS',
		'MANAGEUSERS',
		'EVENTS',
        'BANK'
	);

	function __construct()
	{
		global $USER;
		parent::__construct();
		$this->hasAlliance	= $USER['ally_id'] != 0;
		$this->hasApply		= $this->isApply();
		if($this->hasAlliance && !$this->hasApply) {
			$this->setAllianceData($USER['ally_id']);
		}
	}

	private function setAllianceData($allianceId)
	{
		global $USER;
		$db	= Database::get();

		$sql	= 'SELECT * FROM %%ALLIANCE%% WHERE id = :allianceId;';
		$this->allianceData = $db->selectSingle($sql, array(
			':allianceId'	=> $allianceId
		));

		if($USER['ally_id'] == $allianceId)
		{
			if ($this->allianceData['ally_owner'] == $USER['id']) {
				$this->rights	= array_combine($this->availableRanks, array_fill(0, count($this->availableRanks), true));
			} elseif($USER['ally_rank_id'] != 0) {
				$sql	= 'SELECT '.implode(', ', $this->availableRanks).' FROM %%ALLIANCE_RANK%% WHERE allianceId = :allianceId AND rankID = :ally_rank_id;';
				$this->rights = $db->selectSingle($sql, array(
					':allianceId'		=> $allianceId,
					':ally_rank_id'		=> $USER['ally_rank_id'],
				));
			}

			if(!isset($this->rights)) {
				$this->rights	= array_combine($this->availableRanks, array_fill(0, count($this->availableRanks), false));
			}

			if(isset($this->tplObj))
			{
				$this->assign(array(
					'rights'		=> $this->rights,
					'AllianceOwner'	=> $this->allianceData['ally_owner'] == $USER['id'],
				));
			}
		}
	}

	private function isApply()
	{
		global $USER;
		$db	= Database::get();
		$sql = "SELECT COUNT(*) as count FROM %%ALLIANCE_REQUEST%% WHERE userId = :userId;";
		return $db->selectSingle($sql, array(
			':userId'	=> $USER['id']
		), 'count');
	}

	function info()
	{
		global $LNG, $USER;

		$allianceId = HTTP::_GP('id', 0);

		$statisticData	= array();
		$diplomaticmaticData	= false;

		$this->setAllianceData($allianceId);

		if(!isset($this->allianceData))
		{
			$this->printMessage($LNG['al_not_exists']);
		}

		require 'includes/classes/BBCode.class.php';

		if ($this->allianceData['ally_diplo'] == 1)
		{
			$diplomaticmaticData	= $this->getDiplomatic();
		}

		if ($this->allianceData['ally_stats'] == 1)
		{
			$sql	= 'SELECT SUM(wons) as wons, SUM(loos) as loos, SUM(draws) as draws, SUM(kbmetal) as kbmetal,
            SUM(kbcrystal) as kbcrystal, SUM(lostunits) as lostunits, SUM(desunits) as desunits
            FROM %%USERS%% WHERE ally_id = :allyID;';

			$statisticResult = Database::get()->selectSingle($sql, array(
				':allyID'	=> $this->allianceData['id']
			));
            
            if (($statisticResult['lostunits']) == 0 || $statisticResult['desunits'] == 0) {
                $damageCoefficient = 0;
                $damageDes = 50;
                $damageLost = 50;
            } else {
                $damageCoefficient = $statisticResult['desunits']/$statisticResult['lostunits'];
                $damageDes = ($statisticResult['desunits']/($statisticResult['desunits'] + $statisticResult['lostunits'])) * 100;
                $damageLost = ($statisticResult['lostunits']/($statisticResult['desunits'] + $statisticResult['lostunits'])) * 100;
            }

			$statisticData	= array(
				'totalfight'	=> $statisticResult['wons'] + $statisticResult['loos'] + $statisticResult['draws'],
				'fightwon'		=> $statisticResult['wons'],
				'fightlose'		=> $statisticResult['loos'],
				'fightdraw'		=> $statisticResult['draws'],
				'unitsshot'		=> pretty_number($statisticResult['desunits']),
				'unitslose'		=> pretty_number($statisticResult['lostunits']),
				'dermetal'		=> pretty_number($statisticResult['kbmetal']),
				'dercrystal'	=> pretty_number($statisticResult['kbcrystal']),
                'damageCoef'    => round($damageCoefficient, 2),
                'damageDes'     => $damageDes,
                'damageLost'    => $damageLost,
                'lostunits'     => pretty_number($statisticResult['lostunits']),
                'desunits'      => pretty_number($statisticResult['desunits']),
			);
		}

		$sql	= 'SELECT total_points
		FROM %%STATPOINTS%%
		WHERE id_owner = :userId AND stat_type = :statType';

		$userPoints	= Database::get()->selectSingle($sql, array(
			':userId'	=> $USER['id'],
			':statType'	=> 1
		), 'total_points');

		$this->assign(array(
			'diplomaticData'				=> $diplomaticmaticData,
			'statisticData'					=> $statisticData,
			'ally_description' 				=> BBCode::parse($this->allianceData['ally_description']),
			'ally_id'	 					=> $this->allianceData['id'],
			'ally_image' 					=> $this->allianceData['ally_image'],
			'ally_web'						=> $this->allianceData['ally_web'],
			'ally_member_scount' 			=> $this->allianceData['ally_members'],
			'ally_max_members' 				=> $this->allianceData['ally_max_members'],
			'ally_name' 					=> $this->allianceData['ally_name'],
			'ally_tag' 						=> $this->allianceData['ally_tag'],
			'ally_stats' 					=> $this->allianceData['ally_stats'],
			'ally_diplo' 					=> $this->allianceData['ally_diplo'],
			'ally_request'              	=> !$this->hasAlliance && !$this->hasApply && $this->allianceData['ally_request_notallow'] == 0 && $this->allianceData['ally_max_members'] > $this->allianceData['ally_members'],
			'ally_request_min_points'		=> $userPoints >= $this->allianceData['ally_request_min_points'],
			'ally_request_min_points_info'  => sprintf($LNG['al_requests_min_points'], pretty_number($this->allianceData['ally_request_min_points']))
		));

		$this->display('page.alliance.info.tpl');
	}

	function show()
	{
		if($this->hasAlliance) {
			$this->homeAlliance();
		} elseif($this->hasApply) {
			$this->applyWaitScreen();
		} else {
			$this->createSelection();
		}
	}

	private function redirectToHome()
	{
		$this->redirectTo('game.php?page=alliance');
	}

	private function getAction()
	{
		return HTTP::_GP('action', '');
	}

	private function applyWaitScreen()
	{
		global $USER, $LNG;

		$db	= Database::get();
		$sql	= "SELECT a.ally_tag FROM %%ALLIANCE_REQUEST%% r INNER JOIN %%ALLIANCE%% a ON a.id = r.allianceId WHERE r.userId = :userId;";
		$allianceResult = $db->selectSingle($sql, array(
			':userId'	=> $USER['id_planet']
		));
        
        if(empty($allianceResult['ally_tag'])) { $allianceResult['ally_tag'] = 0; }

		$this->assign(array(
			'request_text'	=> sprintf($LNG['al_request_wait_message_step_1'], $allianceResult['ally_tag']),
		));

		$this->display('page.alliance.applyWait.tpl');
	}

	private function createSelection()
	{
		$this->display('page.alliance.createSelection.tpl');
	}
    
	function apply()
	{
		global $LNG, $USER;

		if($this->hasApply) {
			$this->redirectToHome();
		}

		$text		= HTTP::_GP('text' , '', true);
		$allianceId	= HTTP::_GP('id', 0);

		$db 	= Database::get();
		$sql	= "SELECT ally_tag, ally_request, ally_request_notallow FROM %%ALLIANCE%% WHERE id = :allianceId AND ally_universe = :universe;";
		$allianceResult = $db->selectSingle($sql, array(
			':allianceId'	=> $allianceId,
			':universe'     => Universe::current()
		));

		if (!isset($allianceResult)) {
			$this->redirectToHome();
		}

		if($allianceResult['ally_request_notallow'] == 1)
		{
			$this->printMessage($LNG['al_alliance_closed'], array(array(
				'label'	=> $LNG['sys_forward'],
				'url'	=> '?page=alliance'
			)));
		}

		if (!empty($text))
		{
			$sql = "INSERT INTO %%ALLIANCE_REQUEST%% SET
                allianceId	= :allianceId,
                text		= :text,
                time		= :time,
                userId		= :userId;";

			$db->insert($sql, array(
				':allianceId'	=> $allianceId,
				':text'			=> $text,
				':time'			=> TIMESTAMP,
				':userId'		=> $USER['id']
			));

			$this->printMessage($LNG['al_request_confirmation_message'], array(array(
				'label'	=> $LNG['sys_forward'],
				'url'	=> '?page=alliance'
			)));
		}

		$this->assign(array(
			'allyid'			=> $allianceId,
			'applytext'			=> $allianceResult['ally_request'],
			'al_write_request'	=> sprintf($LNG['al_write_request'], $allianceResult['ally_tag']),
		));

		$this->display('page.alliance.apply.tpl');
	}

	function cancelApply()
	{
		global $LNG, $USER;

		if(!$this->hasApply) {
			$this->redirectToHome();
		}

		$db = Database::get();
		$sql	= "SELECT a.ally_tag FROM %%ALLIANCE_REQUEST%% r INNER JOIN %%ALLIANCE%% a ON a.id = r.allianceId WHERE r.userId = :userId;";
		$allyTag = $db->selectSingle($sql, array(
			':userId'	=> $USER['id']
		), 'ally_tag');

		$sql = "DELETE FROM %%ALLIANCE_REQUEST%% WHERE userId = :userId;";
		$db->delete($sql, array(
			':userId'	=> $USER['id']
		));

		$this->printMessage(sprintf($LNG['al_request_deleted'], $allyTag), array(array(
			'label'	=> $LNG['sys_forward'],
			'url'	=> '?page=alliance'
		)));
	}

	function create()
	{
		global $USER, $LNG;

		if($this->hasApply) {
			$this->redirectToHome();
		}
		$sql	= 'SELECT total_points
		FROM %%STATPOINTS%%
		WHERE id_owner = :userId AND stat_type = :statType';

		$userPoints	= Database::get()->selectSingle($sql, array(
			':userId'	=> $USER['id'],
			':statType'	=> 1
		), 'total_points');

		$min_points = Config::get()->alliance_create_min_points;

		if($userPoints >= $min_points)
		{
			$action    = $this->getAction();
			if($action == "send") {
				$this->createAlliance();
			} else {
				$this->display('page.alliance.create.tpl');
			}
		}
		else
		{
			$diff_points 	= $min_points - $userPoints;
			$messageText	= sprintf($LNG['al_make_ally_insufficient_points'],
				pretty_number($min_points), pretty_number($diff_points));

			$this->printMessage($messageText, array(array(
				'label'	=> $LNG['sys_back'],
				'url'	=> '?page=alliance'
			)));
		}
	}

	private function createAlliance()
	{
		$action	= $this->getAction();
		if($action == "send") {
			$this->createAllianceProcessor();
		} else {
			$this->display('page.alliance.create.tpl');
		}
	}

	private function createAllianceProcessor()
	{
		global $USER, $LNG;
		$allianceTag	= HTTP::_GP('atag' , '', UTF8_SUPPORT);
		$allianceName	= HTTP::_GP('aname', '', UTF8_SUPPORT);

		if (empty($allianceTag)) {
			$this->printMessage($LNG['al_tag_required'], array(array(
				'label'	=> $LNG['sys_back'],
				'url'	=> '?page=alliance&mode=create'
			)));
		}

		if (empty($allianceName)) {
			$this->printMessage($LNG['al_name_required'], array(array(
				'label'	=> $LNG['sys_back'],
				'url'	=> '?page=alliance&mode=create'
			)));
		}

		if (!PlayerUtil::isNameValid($allianceName) || !PlayerUtil::isNameValid($allianceTag)) {
			$this->printMessage($LNG['al_newname_specialchar'], array(array(
				'label'	=> $LNG['sys_back'],
				'url'	=> '?page=alliance&mode=create'
			)));
		}

		$db		= Database::get();

		$sql	= 'SELECT COUNT(*) as count FROM %%ALLIANCE%% WHERE ally_universe = :universe
        AND (ally_tag = :allianceTag OR ally_name = :allianceName);';

		$allianceCount = $db->selectSingle($sql, array(
			':universe'	=> Universe::current(),
			':allianceTag' => $allianceTag,
			':allianceName' => $allianceName
		), 'count');

		if ($allianceCount != 0) {
			$this->printMessage(sprintf($LNG['al_already_exists'], $allianceName), array(array(
				'label'	=> $LNG['sys_back'],
				'url'	=> '?page=alliance&mode=create'
			)));
		}

		$sql	= "INSERT INTO %%ALLIANCE%% SET ally_name = :allianceName, ally_tag = :allianceTag, ally_owner = :userId,
        ally_owner_range = :allianceOwnerRange, ally_members = 1, ally_register_time = :time, ally_universe = :universe;";
		$db->insert($sql, array(
			':allianceName'			=> $allianceName,
			':allianceTag'			=> $allianceTag,
			':userId'			    => $USER['id'],
			':allianceOwnerRange'	=> $LNG['al_default_leader_name'],
			':time'                 => TIMESTAMP,
			':universe'             => Universe::current(),
		));

		$allianceId = $db->lastInsertId();

		$sql	= "UPDATE %%USERS%% SET ally_id	= :allianceId, ally_rank_id	= 0, ally_register_time = :time WHERE id = :userId;";
		$db->update($sql, array(
			':allianceId'	=> $allianceId,
			':time'			=> TIMESTAMP,
			':userId'       => $USER['id']
		));

		$sql	= "UPDATE %%STATPOINTS%% SET id_ally = :allianceId WHERE id_owner = :userId;";
		$db->update($sql, array(
			':allianceId'	=> $allianceId,
			':userId'       => $USER['id']
		));

		$this->printMessage(sprintf($LNG['al_created'], $allianceName.' ['.$allianceTag.']'), array(array(
			'label'	=> $LNG['sys_forward'],
			'url'	=> '?page=alliance'
		)));
	}

	private function getDiplomatic()
	{
		$Return	= array();
		$db = Database::get();

		$sql	= "SELECT d.level, d.accept, d.accept_text, d.id, a.id as ally_id, a.ally_name, a.ally_tag, d.owner_1, d.owner_2 FROM %%DIPLO%% as d INNER JOIN %%ALLIANCE%% as a ON IF(:allianceId = d.owner_1, a.id = d.owner_2, a.id = d.owner_1) WHERE :allianceId = d.owner_1 OR :allianceId = d.owner_2;";
		$DiploResult	= $db->select($sql, array(
			':allianceId'		=> $this->allianceData['id'],
		));

		foreach($DiploResult as $CurDiplo)
		{
			if($CurDiplo['accept'] == 0 && $CurDiplo['owner_2'] == $this->allianceData['id'])
				$Return[5][$CurDiplo['id']] = array($CurDiplo['ally_name'], $CurDiplo['ally_id'], $CurDiplo['level'], $CurDiplo['accept_text'], $CurDiplo['ally_tag']);
			elseif($CurDiplo['accept'] == 0 && $CurDiplo['owner_1'] == $this->allianceData['id'])
				$Return[6][$CurDiplo['id']] = array($CurDiplo['ally_name'], $CurDiplo['ally_id'], $CurDiplo['level'], $CurDiplo['accept_text'], $CurDiplo['ally_tag']);
			else
				$Return[$CurDiplo['level']][$CurDiplo['id']] = array($CurDiplo['ally_name'], $CurDiplo['ally_id'], $CurDiplo['owner_1'], $CurDiplo['ally_tag']);
		}
		return $Return;
	}

	private function homeAlliance()
	{
		global $USER, $LNG;

		require 'includes/classes/BBCode.class.php';

		$db	= Database::get();

		if ($this->allianceData['ally_owner'] == $USER['id']) {
			$rankName	= ($this->allianceData['ally_owner_range'] != '') ? $this->allianceData['ally_owner_range'] : $LNG['al_founder_rank_text'];
		} elseif ($USER['ally_rank_id'] != 0) {
			$sql	= "SELECT rankName FROM %%ALLIANCE_RANK%% WHERE rankID = :UserRankID;";
			$rankName = $db->selectSingle($sql, array(
				':UserRankID'	=> $USER['ally_rank_id']
			),'rankName');
		}

		if (empty($rankName)) {
			$rankName	= $LNG['al_new_member_rank_text'];
		}

		$sql	= "SELECT SUM(wons) as wons, SUM(loos) as loos, SUM(draws) as draws, SUM(kbmetal) as kbmetal, SUM(kbcrystal) as kbcrystal, SUM(lostunits) as lostunits, SUM(desunits) as desunits FROM %%USERS%% WHERE ally_id = :AllianceID;";
		$statisticResult = $db->selectSingle($sql, array(
			':AllianceID'	=> $this->allianceData['id']
		));

		$sql = "SELECT COUNT(*) as count FROM %%ALLIANCE_REQUEST%% WHERE allianceId = :AllianceID;";
		$ApplyCount = $db->selectSingle($sql, array(
			':AllianceID'	=> $this->allianceData['id']
		),'count');

		$ally_events = array();

		if(!empty($this->allianceData['ally_events']))
		{
			$sql = "SELECT id, username FROM %%USERS%% WHERE ally_id = :AllianceID;";
			$result = $db->select($sql, array(
				':AllianceID'	=> $this->allianceData['id']
			));


			require_once('includes/classes/class.FlyingFleetsTable.php');
			$FlyingFleetsTable = new FlyingFleetsTable;

			$this->tplObj->loadscript('overview.js');

			foreach($result as $row)
			{
				$FlyingFleetsTable->setUser($row['id']);
				$FlyingFleetsTable->setMissions($this->allianceData['ally_events']);
				$ally_events[$row['username']] = $FlyingFleetsTable->renderTable();
			}

			$ally_events = array_filter($ally_events);
		}
        
        if (($statisticResult['lostunits']) == 0 || $statisticResult['desunits'] == 0) {
            $damageCoefficient = 0;
            $damageDes = 50;
            $damageLost = 50;
        } else {
            $damageCoefficient = $statisticResult['desunits']/$statisticResult['lostunits'];
            $damageDes = ($statisticResult['desunits']/($statisticResult['desunits'] + $statisticResult['lostunits'])) * 100;
            $damageLost = ($statisticResult['lostunits']/($statisticResult['desunits'] + $statisticResult['lostunits'])) * 100;
        }

		$this->assign(array(
			'DiploInfo'					=> $this->getDiplomatic(),
			'ally_web'					=> $this->allianceData['ally_web'],
			'ally_tag'	 				=> $this->allianceData['ally_tag'],
			'ally_members'	 			=> $this->allianceData['ally_members'],
			'ally_max_members'	 		=> $this->allianceData['ally_members'],
			'ally_name'					=> $this->allianceData['ally_name'],
			'ally_image'				=> $this->allianceData['ally_image'],
			'ally_description'			=> BBCode::parse($this->allianceData['ally_description']),
			'ally_text' 				=> BBCode::parse($this->allianceData['ally_text']),
			'rankName'					=> $rankName,
			'requests'					=> sprintf($LNG['al_new_requests'], $ApplyCount),
			'applyCount'				=> $ApplyCount,
			'totalfight'				=> $statisticResult['wons'] + $statisticResult['loos'] + $statisticResult['draws'],
			'fightwon'					=> $statisticResult['wons'],
			'fightlose'					=> $statisticResult['loos'],
			'fightdraw'					=> $statisticResult['draws'],
			'unitsshot'					=> pretty_number($statisticResult['desunits']),
			'unitslose'					=> pretty_number($statisticResult['lostunits']),
			'dermetal'					=> pretty_number($statisticResult['kbmetal']),
			'dercrystal'				=> pretty_number($statisticResult['kbcrystal']),
			'isOwner'					=> $this->allianceData['ally_owner'] == $USER['id'],
			'ally_events'				=> $ally_events,
            'damageCoef'                => round($damageCoefficient, 2),
            'damageDes'                 => $damageDes,
            'damageLost'                => $damageLost,
            'lostunits'                 => pretty_number($statisticResult['lostunits']),
            'desunits'                  => pretty_number($statisticResult['desunits']),
		));

		$this->display('page.alliance.home.tpl');
	}

	public function memberList()
	{
		global $USER, $LNG;
		if (!$this->rights['MEMBERLIST']) {
			$this->redirectToHome();
		}

		$rankList	= array();

		$db = Database::get();
		$sql = "SELECT rankID, rankName FROM %%ALLIANCE_RANK%% WHERE allianceId = :AllianceID";
		$rankResult = $db->select($sql, array(
			':AllianceID'	=> $this->allianceData['id']
		));

		foreach($rankResult as $rankRow)
			$rankList[$rankRow['rankID']]	= $rankRow['rankName'];

		$memberList	= array();

		$sql = "SELECT DISTINCT u.id, u.username,u.galaxy, u.system, u.planet, u.ally_register_time, u.onlinetime, u.ally_rank_id, s.total_points FROM %%USERS%% u LEFT JOIN %%STATPOINTS%% as s ON s.stat_type = '1' AND s.id_owner = u.id WHERE ally_id = :AllianceID;";
		$memberListResult = $db->select($sql, array(
			':AllianceID'	=> $this->allianceData['id']
		));

		foreach ($memberListResult as $memberListRow)
		{
			if ($this->allianceData['ally_owner'] == $memberListRow['id'])
				$memberListRow['ally_rankName'] = empty($this->allianceData['ally_owner_range']) ? $LNG['al_founder_rank_text'] : $this->allianceData['ally_owner_range'];
			elseif ($memberListRow['ally_rank_id'] != 0 && isset($rankList[$memberListRow['ally_rank_id']]))
				$memberListRow['ally_rankName'] = $rankList[$memberListRow['ally_rank_id']];
			else
				$memberListRow['ally_rankName'] = $LNG['al_new_member_rank_text'];

			$memberList[$memberListRow['id']]	= array(
				'username'		=> $memberListRow['username'],
				'galaxy'		=> $memberListRow['galaxy'],
				'system'		=> $memberListRow['system'],
				'planet'		=> $memberListRow['planet'],
				'register_time'	=> _date($LNG['php_tdformat'], $memberListRow['ally_register_time'], $USER['timezone']),
				'points'		=> $memberListRow['total_points'],
				'rankName'		=> $memberListRow['ally_rankName'],
				'onlinetime'	=> floor((TIMESTAMP - $memberListRow['onlinetime']) / 60),
			);
		}

		$this->assign(array(
			'memberList'		=> $memberList,
			'al_users_list'		=> sprintf($LNG['al_users_list'], count($memberList)),
		));

		$this->display('page.alliance.memberList.tpl');
	}

	public function close()
	{
		global $USER;

		$db = Database::get();

		$sql	= "UPDATE %%USERS%% SET ally_id = 0, ally_register_time = 0, ally_register_time = 5 WHERE id = :UserID;";
		$db->update($sql, array(
			':UserID'			=> $USER['id']
		));

		$sql	= "UPDATE %%STATPOINTS%% SET id_ally = 0 WHERE id_owner = :UserID AND stat_type = 1;";
		$db->update($sql, array(
			':UserID'			=> $USER['id']
		));

		$sql	= "UPDATE %%ALLIANCE%% SET ally_members = (SELECT COUNT(*) FROM %%USERS%% WHERE ally_id = :AllianceID) WHERE id = :AllianceID;";
		$db->update($sql, array(
			':AllianceID'			=> $this->allianceData['id']
		));

		$this->redirectTo('game.php?page=alliance');
	}

	public function circular()
	{
		global $LNG, $USER;

		if (!$this->rights['ROUNDMAIL'])
			$this->redirectToHome();

		$action	= HTTP::_GP('action', '');

		if ($action == "send")
		{
			$rankId		= HTTP::_GP('rankID', 0);
			$subject 	= HTTP::_GP('subject', '', true);
			$text 		= HTTP::_GP('text', $LNG['mg_no_subject'], true);

			if(empty($text)) {
				$this->sendJSON(array('message' => $LNG['mg_empty_text'], 'error' => true));
			}

			$db = Database::get();

			if($rankId == 0) {
				$sql	= 'SELECT id, username FROM %%USERS%% WHERE ally_id = :AllianceID;';
				$sendUsersResult	= $db->select($sql, array(
					':AllianceID'	=> $this->allianceData['id'],
				));
			} else {
				$sql	= 'SELECT id, username FROM %%USERS%% WHERE ally_id = :AllianceID AND ally_rank_id = :RankID;';
				$sendUsersResult	= $db->select($sql, array(
					':AllianceID'	=> $this->allianceData['id'],
					':RankID'	    => $rankId
				));
			}

			$sendList 	= $LNG['al_circular_sended'];
			$title		= $LNG['al_circular_alliance'].$this->allianceData['ally_tag'];
			$text		= sprintf($LNG['al_circular_front_text'], $USER['username'])."\r\n".$text;

			foreach ($sendUsersResult as $sendUsersRow)
			{
				PlayerUtil::sendMessage($sendUsersRow['id'], $USER['id'], $title, 2, $subject, makebr($text), TIMESTAMP);
				$sendList	.= "\n".$sendUsersRow['username'];
			}

			$this->sendJSON(array('message' => $sendList, 'error' => false));
		}

		$this->initTemplate();
		$this->setWindow('popup');
		$RangeList[]	= $LNG['al_all_players'];

		if (is_array($this->ranks))
		{
			foreach($this->ranks as $id => $array)
			{
				$RangeList[$id + 1]	= $array['name'];
			}
		}

		$this->assign(array(
			'RangeList'						=> $RangeList,
		));

		$this->display('page.alliance.circular.tpl');
	}
    /******************************************************************************************************/
    /*Функция прокачки альянса*/
    public function Update($Element)
	{
		global $PLANET, $USER, $reslist, $resource, $pricelist, $LNG;
        
        if (!$this->rights['ADMIN']) {
			$this->redirectToHome();
		}
		
		$costResources		= BuildFunctions::getElementPrice($this->allianceData, $this->allianceData, $Element);
			
		if (!BuildFunctions::isTechnologieAccessible($this->allianceData, $this->allianceData, $Element, array()) 
			|| !BuildFunctions::isElementBuyable($this->allianceData, $this->allianceData, $Element, $costResources) 
			|| $pricelist[$Element]['max'] <= $this->allianceData[$resource[$Element]]) {
			return;
		}
        
        $amount = HTTP::_GP('amount', 0);
		$this->allianceData[$resource[$Element]]	+= $amount;
        
        $href = 'game.php?page=alliance&mode=development'; 
        
        if (($pricelist[$Element]['max']) < $this->allianceData[$resource[$Element]]){
            $this->printMessage("".$LNG['bd_maxlevel']."", true, array($href, 2));
        }
        
        if($amount > $pricelist[$Element]['max']){
            $this->printMessage(''.$LNG['bd_limit'].'',true, array($href, 2));	
        }
        
        foreach(array_merge($reslist['resstype'][1],$reslist['resstype'][3]) as $resPM)
        {
            if(isset($costResources[$resPM])) {
                if($this->allianceData[$resource[$resPM]] < $costResources[$resPM]* $amount){
                    $this->printMessage("".$LNG['bd_notres']."", true, array($href, 2));
                }
            }
        }
            
        foreach(array_merge($reslist['resstype'][1],$reslist['resstype'][3]) as $resP)
        {
            if(isset($costResources[$resP])) { 
                $sql	= 'UPDATE %%ALLIANCE%% SET
                '.$resource[$resP].' = '.$this->allianceData[$resource[$resP]].' - '.$costResources[$resP]* $amount.'
                WHERE
                id = :userId;';

                Database::get()->update($sql, array(
                    ':userId'	=> $this->allianceData['id']
                ));
            }
        }
        
        $sql	= 'UPDATE %%ALLIANCE%% SET
        '.$resource[$Element].' = :newPost
        WHERE
        id = :userId;';

        Database::get()->update($sql, array(
            ':newPost'	=> $this->allianceData[$resource[$Element]],
            ':userId'	=> $this->allianceData['id']
        ));
        
        $sql	= 'UPDATE %%USERS%% SET
        '.$resource[$Element].' = :newPost
        WHERE
        ally_id = :id;';

        Database::get()->update($sql, array(
            ':newPost'	=> $this->allianceData[$resource[$Element]],
            ':id'	    => $this->allianceData["id"]
        ));
	}
    /*Вывод, основа прокачки*/
    public function development()
	{
        global $USER, $PLANET, $resource, $reslist, $LNG, $pricelist, $requeriments;
        
        $resourceStorage	= array();
        $working_array = array_merge($reslist['resstype'][1],$reslist['resstype'][3]);
        
        foreach($working_array as $resourceID)
        {
            $resourceStorage[$resourceID]['name']			    = $resource[$resourceID];
            $resourceStorage[$resourceID]['current']		    = $this->allianceData[$resource[$resourceID]];
        }
		
		$updateID	  = HTTP::_GP('id', 0);
        
		if(in_array($updateID, $reslist['alliance'])) {
			$this->Update($updateID);
		}
		
		$this->tplObj->loadscript('officier.js');		
		
		$allianceList	= array();
		
		if(isModuleAvailable(MODULE_OFFICIER))
		{
			foreach($reslist['alliance'] as $Element)
			{
                $techTreeList		= BuildFunctions::requirementsList($this->allianceData, $this->allianceData, $Element);
				$costResources		= BuildFunctions::getElementPrice($this->allianceData, $this->allianceData, $Element);
				$buyable			= BuildFunctions::isElementBuyable($this->allianceData, $this->allianceData, $Element, $costResources);
				$costOverflow		= BuildFunctions::getRestPrice($this->allianceData, $this->allianceData, $Element, $costResources);
				$elementBonus		= BuildFunctions::getAvalibleBonus($Element);
				
				$allianceList[$Element]	= array(
					'level'				=> $this->allianceData[$resource[$Element]],
					'maxLevel'			=> $pricelist[$Element]['max'],
                    'factor'		    => $pricelist[$Element]['factor'],
					'costResources'	    => $costResources,
					'buyable'			=> $buyable,
					'costOverflow'		=> $costOverflow,
					'elementBonus'		=> $elementBonus,
					'AllTech'			=> $techTreeList,
					'techacc'			=> BuildFunctions::isTechnologieAccessible($this->allianceData, $this->allianceData, $Element, array()),
				);
			}
		}
		
		$this->assign(array(	
			'allianceList'		        => $allianceList,
            'resourceStorage'		    => $resourceStorage,
		));
		
		$this->display('page.alliance.development.tpl');
	}
    /******************************************************************************************************/
    /*Начало хранилища*/
    function storage()
	{
		global $USER, $PLANET, $LNG, $reslist, $resource;
        
        $resourceStorage	= array();
        $working_array = array_merge($reslist['resstype'][1],$reslist['resstype'][3]);
        
        foreach($working_array as $resourceID)
        {
            $resourceStorage[$resourceID]['name']			    = $resource[$resourceID];
            $resourceStorage[$resourceID]['current']		    = $this->allianceData[$resource[$resourceID]];
        }
		
		$this->assign(array(
            'resourceStorage'		    => $resourceStorage,
			'time_put'					=> $USER['ally_put'] - TIMESTAMP,
			'time_vlyat'				=> $USER['ally_vlyat'] - TIMESTAMP,			
		));
		
		$this->display('page.alliance.storage.tpl');
	}
    /*Отдать ресурсы клану*/
    function put()
	{
		global $USER, $PLANET, $LNG, $reslist, $resource;	

        $resourceStorage	= array();
        $working_array = array_merge($reslist['resstype'][1],$reslist['resstype'][3]);
        
        foreach($working_array as $resourceID)
        {
            $resourceStorage[$resourceID]['name']			    = $resource[$resourceID];
            $resourceStorage[$resourceID]['current']		    = $this->allianceData[$resource[$resourceID]];
        }        
        
        $max_res = 1000;
		
		$this->tplObj->loadscript("trader_all.js");
		$this->tplObj->assign_vars(array(
            'resourceStorage'		    => $resourceStorage,
			'max_res'                   => $max_res,
		));
		
		$this->display('page.alliance.put.tpl');
	}
    
    function putsend()
	{
		global $USER, $PLANET, $LNG, $reslist, $resource;
		
		if ($USER['ally_put'] > TIMESTAMP) {
			$this->redirectToHome();
		}
        
        $working_array = array_merge($reslist['resstype'][1],$reslist['resstype'][3]);
        $res           = array();
        $total         = 0;
        $max_res       = 1000;
        
        foreach($working_array as $resourceID)
        {
            $res[$resourceID]	= max(0, HTTP::_GP(''.$resourceID.'', 0));
            $total += $res[$resourceID];
        }  
		
		if(($total == 0) || ($total < 0)){
			$this->printMessage(''.$LNG['al_storage_msg_enter'].'', true, array("?page=alliance&amp;mode=storage", 2));
        }

        if($total > $max_res){
			$this->printMessage(''.$LNG['al_storage_msg_much'].'', true, array("?page=alliance&amp;mode=storage", 2));
        }
        
        foreach($working_array as $resourceID)
        {
            if(isset($PLANET[$resource[$resourceID]])){
                if($PLANET[$resource[$resourceID]] < $res[$resourceID]) {
                    $this->printMessage(''.$LNG['al_storage_msg_not'].'', true, array("?page=alliance&amp;mode=storage", 2));
                }
            }else{
                if($USER[$resource[$resourceID]] < $res[$resourceID]) {
                    $this->printMessage(''.$LNG['al_storage_msg_not'].'', true, array("?page=alliance&amp;mode=storage", 2));
                }
            }
        } 
        
        foreach($working_array as $resourceID)
        {
            if(isset($PLANET[$resource[$resourceID]])){
                $sql	= 'UPDATE %%PLANETS%% SET
                '.$resource[$resourceID].' = '.$resource[$resourceID].' - '.$res[$resourceID].'
                WHERE id = :Id;';
                    
                Database::get()->update($sql, array(
                    ':Id'	=> $PLANET['id']
                ));  
                $PLANET[''.$resource[$resourceID].''] -= $res[$resourceID];
            }else{
                $sql	= 'UPDATE %%USERS%% SET
                '.$resource[$resourceID].' = '.$resource[$resourceID].' - '.$res[$resourceID].'
                WHERE id = :Id;';
                    
                Database::get()->update($sql, array(
                    ':Id'	=> $USER['id']
                ));
                $USER[''.$resource[$resourceID].''] -= $res[$resourceID];
            }
        }
		
        $time = TIMESTAMP + 1;
        
        $sql	= 'UPDATE %%USERS%% SET
        ally_put = :newPost
        WHERE
        id = :userId;';

        Database::get()->update($sql, array(
            ':newPost'	=> $time,
            ':userId'	=> $this->allianceData['id']
        ));

        foreach($working_array as $resourceID)
        {
            $sql	= 'UPDATE %%ALLIANCE%% SET
            '.$resource[$resourceID].' = '.$resource[$resourceID].' + :newPost
            WHERE
            id = :userId;';

            Database::get()->update($sql, array(
                ':newPost'	=> $res[$resourceID],
                ':userId'	=> $this->allianceData['id']
            ));                                    
		}
        
		$this->printMessage(''.$LNG['al_storage_msg_success'].'', true, array("?page=alliance&amp;mode=storage", 2));		
	}
    /*Забрать ресурсы из клана*/
    function vlyat()
	{
		global $USER, $PLANET, $LNG, $reslist, $resource;
        
		if (!$this->rights['BANK'] || $USER['ally_vlyat'] > TIMESTAMP) {
			$this->redirectToHome();
		} 
        
        $resourceStorage	= array();
        $working_array = array_merge($reslist['resstype'][1],$reslist['resstype'][3]);
        
        foreach($working_array as $resourceID)
        {
            $resourceStorage[$resourceID]['name']			    = $resource[$resourceID];
            $resourceStorage[$resourceID]['current']		    = $this->allianceData[$resource[$resourceID]];
        }    

		$max_res = 1000;
		
		$this->tplObj->loadscript("trader_all.js");
		$this->tplObj->assign_vars(array(
            'resourceStorage'		    => $resourceStorage,
        
			'max_res' 					=> $max_res,
		));
		
		$this->display('page.alliance.vlyat.tpl');
	}
    
    function vlyatsend()
	{
		global $USER, $PLANET, $LNG, $reslist, $resource;
		
		if (!$this->rights['BANK'] || $USER['ally_vlyat'] > TIMESTAMP) {
			$this->redirectToHome();
			return;
		} 
        
        $working_array = array_merge($reslist['resstype'][1],$reslist['resstype'][3]);
        $res           = array();
        $total         = 0;
        $max_res       = 1000;
        
        foreach($working_array as $resourceID)
        {
            $res[$resourceID]	= max(0, HTTP::_GP(''.$resourceID.'', 0));
            $total += $res[$resourceID];
        }  
        
        if(($total == 0) || ($total < 0)){
			$this->printMessage(''.$LNG['al_storage_msg_enter'].'', true, array("?page=alliance&amp;mode=storage", 2));
        }

        if($total > $max_res){
			$this->printMessage(''.$LNG['al_storage_msg_much'].'', true, array("?page=alliance&amp;mode=storage", 2));
        }
        
        foreach($working_array as $resourceID)
        {
            if(isset($this->allianceData[$resource[$resourceID]])){
                if($this->allianceData[$resource[$resourceID]] < $res[$resourceID]) {
                    $this->printMessage(''.$LNG['al_storage_msg_not'].'', true, array("?page=alliance&amp;mode=storage", 2));
                }
            }
        }
        
        foreach($working_array as $resourceID)
        {
            if(isset($PLANET[$resource[$resourceID]])){
                $sql	= 'UPDATE %%PLANETS%% SET
                '.$resource[$resourceID].' = '.$resource[$resourceID].' + '.$res[$resourceID].'
                WHERE id = :Id;';
                    
                Database::get()->update($sql, array(
                    ':Id'	=> $PLANET['id']
                ));  
                $PLANET[''.$resource[$resourceID].''] += $res[$resourceID];
            }else{
                $sql	= 'UPDATE %%USERS%% SET
                '.$resource[$resourceID].' = '.$resource[$resourceID].' + '.$res[$resourceID].'
                WHERE id = :Id;';
                    
                Database::get()->update($sql, array(
                    ':Id'	=> $USER['id']
                ));
                $USER[''.$resource[$resourceID].''] += $res[$resourceID];
            }
        }
        
        $time = TIMESTAMP + 1;
        
        $sql	= 'UPDATE %%USERS%% SET
        ally_vlyat = :newPost
        WHERE
        id = :userId;';

        Database::get()->update($sql, array(
            ':newPost'	=> $time,
            ':userId'	=> $this->allianceData['id']
        ));

        foreach($working_array as $resourceID)
        {
            $sql	= 'UPDATE %%ALLIANCE%% SET
            '.$resource[$resourceID].' = '.$resource[$resourceID].' - :newPost
            WHERE
            id = :userId;';

            Database::get()->update($sql, array(
                ':newPost'	=> $res[$resourceID],
                ':userId'	=> $this->allianceData['id']
            ));                                    
		}
        
        $this->printMessage(''.$LNG['al_storage_msg_received'].'', true, array("?page=alliance&amp;mode=storage", 2));		
	}
    /*Выдача ресурсов администратором клана*/
    function issue()
	{
		global $USER, $PLANET, $LNG, $reslist, $resource;
        
		if (!$this->rights['ADMIN']) {
			$this->redirectToHome();
		}
		
		$Userlist	= "";
		
		$UserWhileLogin	= $GLOBALS['DATABASE']->query("SELECT `id`, `username`, `id_planet`, `ally_id` FROM ".USERS." WHERE `ally_id` = ".$USER['ally_id'].";");
		
		while($UserList	= $GLOBALS['DATABASE']->fetch_array($UserWhileLogin))
		{
			$Userlist	.= "<option value=\"".$UserList['id_planet']."\">".$UserList['username']."</option>";
		}

        $resourceStorage	= array();
        $working_array = $reslist['resstype'][1];
        
        foreach($working_array as $resourceID)
        {
            $resourceStorage[$resourceID]['name']			    = $resource[$resourceID];
            $resourceStorage[$resourceID]['current']		    = $this->allianceData[$resource[$resourceID]];
        }		
		
		$this->tplObj->loadscript('filterlist.js');	
		$this->tplObj->loadscript("trader_issue.js");
		$this->tplObj->assign_vars(array(
			'Userlist'					=> $Userlist,
            'resourceStorage'		    => $resourceStorage,
			'ally_metal'				=> $this->allianceData['metal'],
			'ally_crystal'				=> $this->allianceData['crystal'],
			'ally_deuterium'			=> $this->allianceData['deuterium'],
		));
		
		$this->display('page.alliance.issue.tpl');
	}
    
    private function adminissue_send()
	{
		global $USER, $PLANET, $LNG, $reslist, $resource;
		
		if ($this->allianceData['ally_owner'] != $USER['id']) {
			$this->redirectToHome();
		}
        
        $working_array = $reslist['resstype'][1];
        $res           = array();
        $total         = 0;
        $id_p	       = max(0, HTTP::_GP('id_u', 0));
        
        if($id_p == 0){
			$this->printMessage(''.$LNG['al_storage_msg_coordinates'].'', true, array("?page=alliance&amp;mode=issue", 2));
        }
        
        foreach($working_array as $resourceID)
        {
            $res[$resourceID]	= max(0, HTTP::_GP(''.$resourceID.'', 0));
            $total += $res[$resourceID];
        }  
        
        if(($total == 0) || ($total < 0)){
			$this->printMessage(''.$LNG['al_storage_msg_enter'].'', true, array("?page=alliance&amp;mode=storage", 2));
        }
        
        foreach($working_array as $resourceID)
        {
            if(isset($this->allianceData[$resource[$resourceID]])){
                if($this->allianceData[$resource[$resourceID]] < $res[$resourceID]) {
                    $this->printMessage(''.$LNG['al_storage_msg_not'].'', true, array("?page=alliance&amp;mode=storage", 2));
                }
            }
        }
        
        foreach($working_array as $resourceID)
        {
            if(isset($PLANET[$resource[$resourceID]])){
                if($id_p == $PLANET['id'])
                {
                    $PLANET[''.$resource[$resourceID].''] += $res[$resourceID];
                }else{
                    $sql	= 'UPDATE %%PLANETS%% SET
                    '.$resource[$resourceID].' = '.$resource[$resourceID].' + '.$res[$resourceID].'
                    WHERE id = :Id;';
                        
                    Database::get()->update($sql, array(
                        ':Id'	=> $id_p
                    )); 
                }
            }
        }

        foreach($working_array as $resourceID)
        {
            $sql	= 'UPDATE %%ALLIANCE%% SET
            '.$resource[$resourceID].' = '.$resource[$resourceID].' - :newPost
            WHERE
            id = :userId;';

            Database::get()->update($sql, array(
                ':newPost'	=> $res[$resourceID],
                ':userId'	=> $this->allianceData['id']
            ));                                    
		}
        
        $this->printMessage(''.$LNG['al_storage_msg_issued'].'', true, array("?page=alliance&amp;mode=issue", 2));
	}
    /******************************************************************************************************/

	public function admin()
	{
		global $LNG;

		$action		= HTTP::_GP('action', 'overview');
		$methodName	= 'admin'.ucwords($action);

		if(!is_callable(array($this, $methodName))) {
			ShowErrorPage::printError($LNG['page_doesnt_exist']);
		}

		$this->{$methodName}();
	}

	protected function adminOverview()
	{
		global $LNG;
		$send 		= HTTP::_GP('send', 0);
		$textMode  	= HTTP::_GP('textMode', 'external');

		if ($send)
		{
			$db = Database::get();

			$this->allianceData['ally_owner_range'] 		= HTTP::_GP('owner_range', '', true);
			$this->allianceData['ally_web'] 				= filter_var(HTTP::_GP('web', ''), FILTER_VALIDATE_URL);
			$this->allianceData['ally_image'] 				= filter_var(HTTP::_GP('image', ''), FILTER_VALIDATE_URL);
			$this->allianceData['ally_request_notallow'] 	= HTTP::_GP('request_notallow', 0);
			$this->allianceData['ally_max_members'] 		= max(HTTP::_GP('ally_max_members', ''), $this->allianceData['ally_members']);
			$this->allianceData['ally_request_min_points']  = HTTP::_GP('request_min_points', 0);
			$this->allianceData['ally_stats'] 				= HTTP::_GP('stats', 0);
			$this->allianceData['ally_diplo'] 				= HTTP::_GP('diplo', 0);
			$this->allianceData['ally_events'] 				= implode(',', HTTP::_GP('events', array(0)));

			$new_ally_tag 	= HTTP::_GP('ally_tag', $this->allianceData['ally_tag'], UTF8_SUPPORT);
			$new_ally_name	= HTTP::_GP('ally_name', $this->allianceData['ally_name'], UTF8_SUPPORT);

			if(!empty($new_ally_tag) && $this->allianceData['ally_tag'] != $new_ally_tag)
			{
				$sql = "SELECT COUNT(*) as count FROM %%ALLIANCE%% WHERE ally_universe = :universe AND ally_tag = :NewAllianceTag;";
				$allianceCount = $db->selectSingle($sql, array(
					':universe'	        => Universe::current(),
					':NewAllianceTag'   => $new_ally_tag
				), 'count');

				if($allianceCount != 0)
				{
					$this->printMessage(sprintf($LNG['al_already_exists'], $new_ally_tag), array(array(
						'label'	=> $LNG['sys_back'],
						'url'	=> 'game.php?page=alliance&mode=admin'
					)));
				}
				else
				{
					$this->allianceData['ally_tag'] = $new_ally_tag;
				}
			}

			if(!empty($new_ally_name) && $this->allianceData['ally_name'] != $new_ally_name)
			{
				$sql = "SELECT COUNT(*) as count FROM %%ALLIANCE%% WHERE ally_universe = :universe AND ally_name = :NewAllianceName;";
				$allianceCount = $db->selectSingle($sql, array(
					':universe'	        => Universe::current(),
					':NewAllianceName'   => $new_ally_name
				), 'count');

				if($allianceCount != 0)
				{
					$this->printMessage(sprintf($LNG['al_already_exists'], $new_ally_name), array(array(
						'label'	=> $LNG['sys_back'],
						'url'	=> 'game.php?page=alliance&mode=admin'
					)));
				}
				else
				{
					$this->allianceData['ally_name'] = $new_ally_name;
				}
			}

			if ($this->allianceData['ally_request_notallow'] != 0 && $this->allianceData['ally_request_notallow'] != 1) {
				$this->allianceData['ally_request_notallow'] = 0;
			}

			$text 		= HTTP::_GP('text', '', true);
			$textMode  	= HTTP::_GP('textMode', 'external');

			$textSQL	= "";

			switch($textMode)
			{
				case 'external':
					$textSQL	= "ally_description = :text, ";
					break;
				case 'internal':
					$textSQL	= "ally_text = :text, ";
					break;
				case 'apply':
					$textSQL	= "ally_request = :text, ";
					break;
			}

			$sql = "UPDATE %%ALLIANCE%% SET
			".$textSQL."
			ally_tag = :AllianceTag,
			ally_name = :AllianceName,
			ally_owner_range = :AllianceOwnerRange,
			ally_image = :AllianceImage,
			ally_web = :AllianceWeb,
			ally_request_notallow = :AllianceRequestNotAllow,
			ally_max_members = :AllianceMaxMember,
			ally_request_min_points = :AllianceRequestMinPoints,
			ally_stats = :AllianceStats,
			ally_diplo = :AllianceDiplo,
			ally_events = :AllianceEvents
			WHERE id = :AllianceID;";

			$db->update($sql, array(
				':AllianceTag'				=> $this->allianceData['ally_tag'],
				':AllianceName'				=> $this->allianceData['ally_name'],
				':AllianceOwnerRange'		=> $this->allianceData['ally_owner_range'],
				':AllianceImage'			=> $this->allianceData['ally_image'],
				':AllianceWeb'				=> $this->allianceData['ally_web'],
				':AllianceRequestNotAllow'	=> $this->allianceData['ally_request_notallow'],
		    	':AllianceMaxMember'        => $this->allianceData['ally_max_members'],
				':AllianceRequestMinPoints'	=> $this->allianceData['ally_request_min_points'],
				':AllianceStats'			=> $this->allianceData['ally_stats'],
				':AllianceDiplo'			=> $this->allianceData['ally_diplo'],
				':AllianceEvents'			=> $this->allianceData['ally_events'],
				':AllianceID'				=> $this->allianceData['id'],
				':text'						=> $text
			));

		} else {
			switch($textMode)
			{
				case 'internal':
					$text	= $this->allianceData['ally_text'];
					break;
				case 'apply':
					$text	= $this->allianceData['ally_request'];
					break;
				default:
					$text	= $this->allianceData['ally_description'];
					break;
			}
		}

        require_once 'includes/classes/class.FlyingFleetHandler.php';

        $available_events = array();

        foreach(array_keys(FlyingFleetHandler::$missionObjPattern) as $missionId) {
            $available_events[$missionId] = $LNG['type_mission_'.$missionId];
        }

		$this->assign(array(
			'RequestSelector'			=> array(0 => $LNG['al_requests_allowed'], 1 => $LNG['al_requests_not_allowed']),
			'YesNoSelector'				=> array(1 => $LNG['al_go_out_yes'], 0 => $LNG['al_go_out_no']),
			'textMode' 					=> $textMode,
			'text' 						=> $text,
			'ally_tag' 					=> $this->allianceData['ally_tag'],
			'ally_name'					=> $this->allianceData['ally_name'],
			'ally_web' 					=> $this->allianceData['ally_web'],
			'ally_image'				=> $this->allianceData['ally_image'],
			'ally_request_notallow' 	=> $this->allianceData['ally_request_notallow'],
			'ally_members' 				=> $this->allianceData['ally_members'],
			'ally_max_members' 			=> $this->allianceData['ally_max_members'],
			'ally_request_min_points'   => $this->allianceData['ally_request_min_points'],
			'ally_owner_range'			=> $this->allianceData['ally_owner_range'],
			'ally_stats_data'			=> $this->allianceData['ally_stats'],
			'ally_diplo_data'			=> $this->allianceData['ally_diplo'],
			'ally_events'				=> explode(',', $this->allianceData['ally_events']),
			'available_events'			=> $available_events,
		));

		$this->display('page.alliance.admin.overview.tpl');
	}

	protected function adminClose()
	{
		global $USER, $PLANET, $LNG, $reslist, $resource;
		if ($this->allianceData['ally_owner'] == $USER['id']) {
			$db = Database::get();

			$sql = "UPDATE %%USERS%% SET ally_id = '0' WHERE ally_id = :AllianceID;";
			$db->update($sql, array(
				':AllianceID'	=> $this->allianceData['id']
			));

			$sql = "UPDATE %%STATPOINTS%% SET id_ally = '0' WHERE id_ally = :AllianceID;";
			$db->update($sql, array(
				':AllianceID'	=> $this->allianceData['id']
			));

			$sql = "DELETE FROM %%STATPOINTS%% WHERE id_owner = :AllianceID AND stat_type = 2;";
			$db->delete($sql, array(
				':AllianceID'	=> $this->allianceData['id']
			));

			$sql = "DELETE FROM %%ALLIANCE%% WHERE id = :AllianceID;";
			$db->delete($sql, array(
				':AllianceID'	=> $this->allianceData['id']
			));

			$sql = "DELETE FROM %%ALLIANCE_REQUEST%% WHERE allianceId = :AllianceID;";
			$db->delete($sql, array(
				':AllianceID'	=> $this->allianceData['id']
			));

			$sql = "DELETE FROM %%DIPLO%% WHERE owner_1 = :AllianceID OR owner_2 = :AllianceID;";
			$db->delete($sql, array(
				':AllianceID'	=> $this->allianceData['id']
			));
            //Убираем бонусы у игроков
            foreach($reslist['alliance'] as $Element)
            {
                $sql	= 'UPDATE %%USERS%% SET
                '.$resource[$Element].' = :newPost
                WHERE
                ally_id = :id;';

                Database::get()->update($sql, array(
                    ':newPost'	=> 0,
                    ':id'	    => $this->allianceData["id"]
                ));
            }  
		}

		$this->redirectToHome();
	}

	protected function adminTransfer()
	{
		global $USER;

		if($this->allianceData['ally_owner'] != $USER['id'])
		{
			$this->redirectToHome();
		}

		$db	= Database::get();

		$postleader = HTTP::_GP('newleader', 0);
		if (!empty($postleader))
		{
			$sql = "SELECT ally_rank_id FROM %%USERS%% WHERE id = :LeaderID;";
			$Rank = $db->selectSingle($sql, array(
				':LeaderID'	=> $postleader
			));

			$sql = "UPDATE %%USERS%% SET ally_rank_id = :AllyRank WHERE id = :UserID;";
			$db->update($sql, array(
				':UserID'	=> $USER['id'],
				':AllyRank' => $Rank['ally_rank_id']
			));

			$sql = "UPDATE %%USERS%% SET ally_rank_id = 0 WHERE id = :LeaderID;";
			$db->update($sql, array(
				':LeaderID'	=> $postleader
			));

			$sql = "UPDATE %%ALLIANCE%% SET ally_owner = :LeaderID WHERE id = :AllianceID;";
			$db->update($sql, array(
				':LeaderID'	    => $postleader,
				':AllianceID'   => $this->allianceData['id']
			));

			$this->redirectToHome();
		}
		else
		{
			$sql = "SELECT u.id, r.rankName, u.username FROM %%USERS%% u INNER JOIN %%ALLIANCE_RANK%% r ON r.rankID = u.ally_rank_id AND r.TRANSFER = 1 WHERE u.ally_id = :allianceId AND id != :allianceOwner;";
			$transferUserResult = $db->select($sql, array(
				':allianceOwner'    => $this->allianceData['ally_owner'],
				':allianceId'       => $this->allianceData['id']
			));

			$transferUserList	= array();

			foreach ($transferUserResult as $transferUserRow)
			{
				$transferUserList[$transferUserRow['id']]	= $transferUserRow['username']." [".$transferUserRow['rankName']."]";
			}

			$this->assign(array(
				'transferUserList'	=> $transferUserList,
			));

			$this->display('page.alliance.admin.transfer.tpl');
		}
	}

	protected function adminMangeApply()
	{
		global $LNG, $USER;
		if(!$this->rights['SEEAPPLY'] || !$this->rights['MANAGEAPPLY']) {
			$this->redirectToHome();
		}

		$db = Database::get();

		$sql = "SELECT applyID, u.username, r.time FROM %%ALLIANCE_REQUEST%% r INNER JOIN %%USERS%% u ON r.userId = u.id WHERE r.allianceId = :allianceId;";
		$applyResult = $db->select($sql, array(
			':allianceId'	=> $this->allianceData['id']
		));

		$applyList		= array();

		foreach ($applyResult as $applyRow)
		{
			$applyList[]	= array(
				'username'	=> $applyRow['username'],
				'id'		=> $applyRow['applyID'],
				'time' 		=> _date($LNG['php_tdformat'], $applyRow['time'], $USER['timezone']),
			);
		}

		$this->assign(array(
			'applyList'		=> $applyList,
		));

		$this->display('page.alliance.admin.mangeApply.tpl');
	}

	protected function adminDetailApply()
	{
		global $LNG, $USER;
		if(!$this->rights['SEEAPPLY'] || !$this->rights['MANAGEAPPLY']) {
			$this->redirectToHome();
		}

		$id    = HTTP::_GP('id', 0);

		$db = Database::get();

		$sql = 'SELECT
			r.`applyID`,
			r.`time`,
			r.`text`,
            u.`id`,
			u.`username`
		FROM
			%%ALLIANCE_REQUEST%% AS r
		LEFT JOIN
			%%USERS%% AS u ON r.userId = u.id
		WHERE
			applyID = :applyID;';

		$applyDetail = $db->selectSingle($sql, array(
			':applyID'	=> $id
		));

		if(empty($applyDetail)) {
			$this->printMessage($LNG['al_apply_not_exists'], array(array(
				'label'	=> $LNG['sys_back'],
				'url'	=> 'game.php?page=alliance&mode=admin&action=mangeApply'
			)));
		}

		require 'includes/classes/BBCode.class.php';

		$applyDetail['text']    	= BBCode::parse($applyDetail['text']);

		$this->assign(array(
			'applyDetail'	=> $applyDetail,
			'apply_time'    => _date($LNG['php_tdformat'], $applyDetail['time'], $USER['timezone']),
		));

		$this->display('page.alliance.admin.detailApply.tpl');
	}

	protected function adminSendAnswerToApply()
	{
		global $USER, $PLANET, $LNG, $reslist, $resource;
		if (!$this->rights['SEEAPPLY'] || !$this->rights['MANAGEAPPLY']) {
			$this->redirectToHome();
		}

		$db = Database::get();

		$text  		= makebr(HTTP::_GP('text', '', true));
		$answer		= HTTP::_GP('answer', '');
		$applyID	= HTTP::_GP('id', 0);

		$sql = "SELECT userId FROM %%ALLIANCE_REQUEST%% WHERE applyID = :applyID;";
		$userId = $db->selectSingle($sql, array(
			':applyID'	=> $applyID
		), 'userId');

		// only if alliance request still exist
		if ($userId) {
			if ($answer == 'yes') {
				$sql = "DELETE FROM %%ALLIANCE_REQUEST%% WHERE applyID = :applyID";
				$db->delete($sql, array(
					':applyID'	=> $applyID
				));

				$sql = "UPDATE %%USERS%% SET ally_id = :allianceId, ally_register_time = :time, ally_rank_id = 0 WHERE id = :userId;";
				$db->update($sql, array(
					':allianceId'	=> $this->allianceData['id'],
					':time'         => TIMESTAMP,
					':userId'       => $userId
				));

				$sql = "UPDATE %%STATPOINTS%% SET id_ally = :allianceId WHERE id_owner = :userId AND stat_type = 1;";
				$db->update($sql, array(
					':allianceId'	=> $this->allianceData['id'],
					':userId'       => $userId
				));

				$sql = "UPDATE %%ALLIANCE%% SET ally_members = (SELECT COUNT(*) FROM %%USERS%% WHERE ally_id = :allianceId) WHERE id = :allianceId;";
				$db->update($sql, array(
					':allianceId'	=> $this->allianceData['id'],
				));

				$text		= $LNG['al_hi_the_alliance'] . $this->allianceData['ally_name'] . $LNG['al_has_accepted'] . $text;
				$subject	= $LNG['al_you_was_acceted'] . $this->allianceData['ally_name'];
                //Добавляем бонусы к игрокам
                foreach($reslist['alliance'] as $Element)
                {
                    $sql	= 'UPDATE %%USERS%% SET
                    '.$resource[$Element].' = :newPost
                    WHERE
                    ally_id = :id;';

                    Database::get()->update($sql, array(
                        ':newPost'	=> $this->allianceData[$resource[$Element]],
                        ':id'	    => $this->allianceData["id"]
                    ));
                }
			} else {
				$sql = "DELETE FROM %%ALLIANCE_REQUEST%% WHERE applyID = :applyID";
				$db->delete($sql, array(
					':applyID'	=> $applyID
				));

				$text		= $LNG['al_hi_the_alliance'] . $this->allianceData['ally_name'] . $LNG['al_has_declined'] . $text;
				$subject	= $LNG['al_you_was_declined'] . $this->allianceData['ally_name'];
			}

			$senderName	= $LNG['al_the_alliance'] . $this->allianceData['ally_name'] . ' [' . $this->allianceData['ally_tag'] . ']';
			PlayerUtil::sendMessage($userId, $USER['id'], $senderName, 2, $subject, $text, TIMESTAMP);
		}
		$this->redirectTo('game.php?page=alliance&mode=admin&action=mangeApply');
	}

	protected function adminPermissions()
	{
		if(!$this->rights['RANKS']) {
			$this->redirectToHome();
		}

		$sql = "SELECT * FROM %%ALLIANCE_RANK%% WHERE allianceId = :allianceId;";
		$rankResult = Database::get()->select($sql, array(
			':allianceId'	=> $this->allianceData['id']
		));

		$rankList	= array();
		foreach ($rankResult as $rankRow)
		{
			$rankList[$rankRow['rankID']]	= $rankRow;
		}

		$availableRanks	= array();
		foreach($this->availableRanks as $rankId => $rankName)
		{
			if($this->rights[$rankName])
			{
				$availableRanks[$rankId]	= $rankName;
			}
		}

		$this->assign(array(
			'rankList'			=> $rankList,
			'ownRights'			=> $this->rights,
			'availableRanks'	=> $availableRanks,
		));

		$this->display('page.alliance.admin.permissions.tpl');
	}

	protected function adminPermissionsSend()
	{
		global $LNG;
		if(!$this->rights['RANKS']) {
			$this->redirectToHome();
		}

		$newRank	= HTTP::_GP('newrank', array(), true);
		$delete		= HTTP::_GP('deleteRank', 0);
		$rankData	= HTTP::_GP('rank', array());

		$db = Database::get();

		if(!empty($newRank['rankName']))
		{
			if(!PlayerUtil::isNameValid($newRank['rankName']))
			{
				$this->printMessage($LNG['al_invalid_rank_name'], array(array(
					'label'	=> $LNG['sys_back'],
					'url'	=> '?page=alliance&mode=admin&action=permission'
				)));
			}

			$sql = 'INSERT INTO %%ALLIANCE_RANK%% SET rankName = :rankName, allianceID = :allianceID';
			$params	= array(
				':rankName'		=> $newRank['rankName'],
				':allianceID'	=> $this->allianceData['id'],
			);

			unset($newRank['rankName']);

			foreach($newRank as $key => $value)
			{
				if(isset($this->availableRanks[$key]) && $this->rights[$this->availableRanks[$key]])
				{
					$sql .= ', `'.$this->availableRanks[$key].'` = :'.$this->availableRanks[$key];
					$params[':'.$this->availableRanks[$key]]	= $value == 1 ? 1 : 0;
				}
			}

			$db->insert($sql, $params);
		}
		else
		{
			if(!empty($delete))
			{
				$sql = "DELETE FROM %%ALLIANCE_RANK%% WHERE rankID = :rankID AND allianceId = :allianceId;";
				$db->delete($sql, array(
					':allianceId'	=> $this->allianceData['id'],
					':rankID'       => $delete
				));

				$sql = "UPDATE %%USERS%% SET ally_rank_id = 0 WHERE ally_rank_id = :rankID AND ally_id = :allianceId;";
				$db->update($sql, array(
					':allianceId'	=> $this->allianceData['id'],
					':rankID'       => $delete
				));
			}
			else
			{
				foreach ($rankData as $rankId => $rowData)
				{
					$sql = 'UPDATE %%ALLIANCE_RANK%% SET rankName = :rankName';
					$params	= array(
						':rankName'		=> $rowData['rankName'],
						':allianceID'	=> $this->allianceData['id'],
						':rankId'		=> $rankId
					);

					unset($rowData['rankName']);

					foreach($this->availableRanks as $key => $value)
					{
						if(isset($this->availableRanks[$key]) && $this->rights[$this->availableRanks[$key]])
						{
							$sql .= ', `'.$this->availableRanks[$key].'` = :'.$this->availableRanks[$key];
							$params[':'.$this->availableRanks[$key]]	= (isset($rowData[$key])) == 1 ? 1 : 0;
						}
					}

					$sql .= ' WHERE rankID = :rankId AND allianceID = :allianceID';

					$db->update($sql, $params);
				}
			}
		}

		$this->redirectTo('game.php?page=alliance&mode=admin&action=permissions');
	}

	protected function adminMembers()
	{
		global $USER, $LNG;
		if (!$this->rights['MANAGEUSERS']) {
			$this->redirectToHome();
		}

		$db = Database::get();

		$sql = "SELECT rankID, rankName FROM %%ALLIANCE_RANK%% WHERE allianceId = :allianceId;";
		$rankResult = $db->select($sql, array(
			':allianceId'	=> $this->allianceData['id'],
		));

		$rankList		= array($LNG['al_new_member_rank_text']);
		$rankSelectList	= $rankList;

		foreach($rankResult as $rankRow)
		{
			$hasRankRight	= true;
			foreach($this->availableRanks as $rankName)
			{
				if(!$this->rights[$rankName])
				{
					$hasRankRight = false;
					break;
				}
			}

			if($hasRankRight)
			{
				$rankSelectList[$rankRow['rankID']]	= $rankRow['rankName'];
			}

			$rankList[$rankRow['rankID']]	= $rankRow['rankName'];
		}

		$sql = "SELECT DISTINCT u.id, u.username,u.galaxy, u.system, u.planet, u.ally_register_time, u.onlinetime, u.ally_rank_id, s.total_points
		FROM %%USERS%% u
		LEFT JOIN %%STATPOINTS%% as s ON s.stat_type = '1' AND s.id_owner = u.id
		WHERE ally_id = :allianceId;";

		$memberListResult = $db->select($sql, array(
			':allianceId'	=> $this->allianceData['id'],
		));

		$memberList	= array();

		foreach ($memberListResult as $memberListRow)
		{
			if ($this->allianceData['ally_owner'] == $memberListRow['id'])
				$memberListRow['ally_rank_id'] = -1;

			$memberList[$memberListRow['id']]	= array(
				'username'		=> $memberListRow['username'],
				'galaxy'		=> $memberListRow['galaxy'],
				'system'		=> $memberListRow['system'],
				'planet'		=> $memberListRow['planet'],
				'register_time'	=> _date($LNG['php_tdformat'], $memberListRow['ally_register_time'], $USER['timezone']),
				'points'		=> $memberListRow['total_points'],
				'rankID'		=> $memberListRow['ally_rank_id'],
				'onlinetime'	=> floor((TIMESTAMP - $memberListRow['onlinetime']) / 60),
				'kickQuestion'	=> sprintf($LNG['al_kick_player'], $memberListRow['username'])
			);
		}

		$this->assign(array(
			'memberList'	 => $memberList,
			'rankList'		 => $rankList,
			'rankSelectList' => $rankSelectList,
			'founder'		 => empty($this->allianceData['ally_owner_range']) ? $LNG['al_founder_rank_text'] : $this->allianceData['ally_owner_range'],
			'al_users_list'	 => sprintf($LNG['al_users_list'], count($memberList)),
			'canKick'		 => $this->rights['KICK'],
		));

		$this->display('page.alliance.admin.members.tpl');
	}

    protected function adminRank()
    {
        global $LNG;
        if (!$this->rights['MANAGEUSERS']) {
            $this->sendJSON();
        }

		$userRanks	= HTTP::_GP('rank', array());

		$db = Database::get();

		$sql			= 'SELECT rankID, '.implode(', ', $this->availableRanks).' FROM %%ALLIANCE_RANK%% WHERE allianceID = :allianceId;';
		$rankResult		= $db->select($sql, array(
			':allianceId'	=> $this->allianceData['id']
		));
		$rankList		= array();
		$rankList[0]	= array_combine($this->availableRanks, array_fill(0, count($this->availableRanks), true));

		foreach($rankResult as $rankRow)
		{
			$hasRankRight	= true;
			foreach($this->availableRanks as $rankName)
			{
				if(!$this->rights[$rankName])
				{
					$hasRankRight = false;
					break;
				}
			}

			if($hasRankRight)
			{
				$rankList[$rankRow['rankID']]	= $rankRow;
			}
		}

		foreach($userRanks as $userId => $rankId)
		{
			if($userId == $this->allianceData['ally_owner'] || !isset($rankList[$rankId])) {
				continue;
			}

			$sql = 'UPDATE %%USERS%% SET ally_rank_id = :rankID WHERE id = :userId AND ally_id = :allianceId;';
			$db->update($sql, array(
				':allianceId'	=> $this->allianceData['id'],
				':rankID'       => (int) $rankId,
				':userId'       => (int) $userId
			));
		}

		$this->sendJSON($LNG['fl_shortcut_saved']);
	}

	protected function adminMembersKick()
	{
        global $USER, $PLANET, $LNG, $reslist, $resource;
		if (!$this->rights['KICK']) {
			$this->redirectToHome();
		}

		$db = Database::get();

		$id	= HTTP::_GP('id', 0);

        $sql = "SELECT ally_id FROM %%USERS%% WHERE id = :id;";
        $kickUserAllianceId = $db->selectSingle($sql, array(
            ':id'	=> $id
        ), 'ally_id');

        # Check, if user is in alliance, see #205
        if(empty($kickUserAllianceId) || $kickUserAllianceId != $this->allianceData['id']) {
            $this->redirectToHome();
		}

		$sql = "UPDATE %%USERS%% SET ally_id = 0, ally_register_time = 0, ally_rank_id = 0 WHERE id = :id;";
		$db->update($sql, array(
			':id'	=> $id
		));

		$sql = "UPDATE %%STATPOINTS%% SET id_ally = 0 WHERE id_owner = :id AND stat_type = 1;";
		$db->update($sql, array(
			':id'	=> $id
		));

		$sql = "UPDATE %%ALLIANCE%% SET ally_members = (SELECT COUNT(*) FROM %%USERS%% WHERE ally_id = :allianceId) WHERE id = :allianceId;";
		$db->update($sql, array(
			':id'	        => $id,
			':allianceId'   => $this->allianceData['id']
		)); 
        //Убираем бонус у игрока
        foreach($reslist['alliance'] as $Element)
        {
            $sql	= 'UPDATE %%USERS%% SET
            '.$resource[$Element].' = :newPost
            WHERE
            id = :id;';

            Database::get()->update($sql, array(
                ':newPost'	=> 0,
                ':id'	    => $id
            ));
        } 

		$this->redirectTo('game.php?page=alliance&mode=admin&action=members');
	}

	protected function adminDiplomacy()
	{
		if (!$this->rights['DIPLOMATIC']) {
			$this->redirectToHome();
		}

		$db = Database::get();

		$diplomaticList	= array(
			0 => array(
				1 => array(),
				2 => array(),
				3 => array(),
				4 => array(),
				5 => array(),
				6 => array()
			),
			1 => array(
				1 => array(),
				2 => array(),
				3 => array(),
				4 => array(),
				5 => array(),
				6 => array()
			),
			2 => array(
				1 => array(),
				2 => array(),
				3 => array(),
				4 => array(),
				5 => array(),
				6 => array()
			)
		);

		$sql = "SELECT d.id, d.level, d.accept, d.owner_1, d.owner_2, a.ally_name FROM %%DIPLO%% d
		INNER JOIN %%ALLIANCE%% a ON IF(:allianceId = d.owner_1, a.id = d.owner_2, a.id = d.owner_1)
		WHERE owner_1 = :allianceId OR owner_2 = :allianceId;";
		$diplomaticResult =  $db->select($sql, array(
			':allianceId'   => $this->allianceData['id']
		));

		foreach($diplomaticResult as $diplomaticRow) {
			$own	= $diplomaticRow['owner_1'] == $this->allianceData['id'];
			if($diplomaticRow['accept'] == 1) {
				$diplomaticList[0][$diplomaticRow['level']][$diplomaticRow['id']] = $diplomaticRow['ally_name'];
			} elseif($own) {
				$diplomaticList[2][$diplomaticRow['level']][$diplomaticRow['id']] = $diplomaticRow['ally_name'];
			} else {
				$diplomaticList[1][$diplomaticRow['level']][$diplomaticRow['id']] = $diplomaticRow['ally_name'];
			}
		}

		$this->assign(array(
			'diploList'	=> $diplomaticList,
		));

		$this->display('page.alliance.admin.diplomacy.default.tpl');
	}

	protected function adminDiplomacyAccept()
	{
		if (!$this->rights['DIPLOMATIC']) {
			$this->redirectToHome();
		}

		$db = Database::get();

		$sql = "UPDATE %%DIPLO%% SET accept = 1 WHERE id = :id AND owner_2 = :allianceId;";
		$db->update($sql, array(
			':allianceId'   => $this->allianceData['id'],
			':id'           => HTTP::_GP('id', 0)
		));

		$this->redirectTo('game.php?page=alliance&mode=admin&action=diplomacy');
	}

	protected function adminDiplomacyDelete()
	{
		if (!$this->rights['DIPLOMATIC']) {
			$this->redirectToHome();
		}

		$db = Database::get();

		$sql = "DELETE FROM %%DIPLO%% WHERE id = :id AND (owner_1 = :allianceId OR owner_2 = :allianceId);";
		$db->delete($sql, array(
			':allianceId'   => $this->allianceData['id'],
			':id'           => HTTP::_GP('id', 0)
		));

		$this->redirectTo('game.php?page=alliance&mode=admin&action=diplomacy');
	}

	protected function adminDiplomacyCreate()
	{
		global $USER;
		if (!$this->rights['DIPLOMATIC']) {
			$this->redirectToHome();
		}

		$db = Database::get();

		$this->initTemplate();
		$this->setWindow('popup');

		$diplomaticMode	= HTTP::_GP('diploMode', 0);

		$sql = "SELECT ally_tag,ally_name,id FROM %%ALLIANCE%% WHERE id != :allianceId ORDER BY ally_tag ASC;";
		$diplomaticAlly = $db->select($sql, array(
			':allianceId'   => $USER['ally_id']
		));

		$AllyList = array();
		$IdList = array();
		foreach ($diplomaticAlly as $i)
		{
			$IdList[] = $i['id'];
			$AllyList[] = $i['ally_name'];
		}
		$this->assign(array(
			'diploMode'	=> $diplomaticMode,
			'AllyList'	=> $AllyList,
			'IdList'	=> $IdList,
		));

		$this->display('page.alliance.admin.diplomacy.create.tpl');
	}

	protected function adminDiplomacyCreateProcessor()
	{
		global $LNG, $USER;
		if (!$this->rights['DIPLOMATIC']) {
			$this->redirectToHome();
		}

		$db = Database::get();

		$id	= HTTP::_GP('ally_id', '', UTF8_SUPPORT);

		$sql = "SELECT id, ally_name, ally_owner, ally_tag, (SELECT level FROM %%DIPLO%% WHERE (owner_1 = :id AND owner_2 = :allianceId) OR (owner_2 = :id AND owner_1 = :allianceId)) as diplo FROM %%ALLIANCE%% WHERE ally_universe = :universe AND id = :id;";
		$targetAlliance = $db->selectSingle($sql, array(
			':allianceId'   => $USER['ally_id'],
			':id'           => $id,
			':universe'     => Universe::current()
		));

		if(empty($targetAlliance)) {
			$this->sendJSON(array(
				'error'		=> true,
				'message'	=> sprintf($LNG['al_diplo_no_alliance'], $targetAlliance['id']),
			));
		}

		if(!empty($targetAlliance['diplo'])) {
			$this->sendJSON(array(
				'error'		=> true,
				'message'	=> sprintf($LNG['al_diplo_exists'], $targetAlliance['ally_name']),
			));
		}
		if($targetAlliance['id'] == $this->allianceData['id']) {
			$this->sendJSON(array(
				'error'		=> true,
				'message'	=> $LNG['al_diplo_same_alliance'],
			));
		}

		$this->setWindow('ajax');

		$level	= HTTP::_GP('level', 0);
		$text	= HTTP::_GP('text', '', true);

		if($level == 5)
		{
			PlayerUtil::sendMessage($targetAlliance['ally_owner'], $USER['id'], $LNG['al_circular_alliance'].$this->allianceData['ally_tag'], 1, $LNG['al_diplo_war'], sprintf($LNG['al_diplo_war_mes'], "[".$this->allianceData['ally_tag']."] ".$this->allianceData['ally_name'], "[".$targetAlliance['ally_tag']."] ".$targetAlliance['ally_name'], $LNG['al_diplo_level'][$level], $text), TIMESTAMP);
		}
		else
		{
			PlayerUtil::sendMessage($targetAlliance['ally_owner'], $USER['id'], $LNG['al_circular_alliance'].$this->allianceData['ally_tag'], 1, $LNG['al_diplo_war'], sprintf($LNG['al_diplo_ask_mes'], $LNG['al_diplo_level'][$level], "[".$this->allianceData['ally_tag']."] ".$this->allianceData['ally_name'], "[".$targetAlliance['ally_tag']."] ".$targetAlliance['ally_name'], $text), TIMESTAMP);
		}

		$sql = "INSERT INTO %%DIPLO%% SET owner_1 = :allianceId, owner_2 = :allianceTargetID, level	= :level, accept = 0, accept_text = :text, universe	= :universe";
		$db->insert($sql, array(
			':allianceId'   => $USER['ally_id'],
			':allianceTargetID'  => $targetAlliance['id'],
			':level'             => $level,
			':text'           => $text,
			':universe'     => Universe::current()
		));

		$this->sendJSON(array(
			'error'		=> false,
			'message'	=> $LNG['al_diplo_create_done'],
		));
	}
}
