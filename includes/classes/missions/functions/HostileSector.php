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

class HostileSector
{
	/**
	 * @brief composition of bot fleet
	 * @var array
	 */
	protected $fleetComposition;

	/**
	 * @brief minimal points of bot fleet
	 * @var int
	 */
	protected $minBotFleetPoints;

	/**
	 * @brief factor of user fleet points
	 * @var float
	 */
	protected $factorUserFleetPoints;

	/**
	 * @brief bot factor (Attack, Shield, Defensive)
	 * @var array
	 */
	protected $botFactor;

	/**
	 * @brief bot id, name and technologies
	 * @var array
	 */
	protected $botInfoTechs;

	/**
	 * @brief academy skills of bot
	 * @var array
	 */
	protected $botAcademy;

	/**
	 * @brief array of bot fleet
	 * @var array
	 */
	protected $botFleetArray = array();

	/**
	 * @brief maximal quantity of combat points
	 * @var int
	 */
	protected $maxBattlePoints;

	/**
	 * @brief bot debris to shipment (percents)
	 * @var int
	 */
	protected $botDebris;

	/**
	 * @brief chance to find upgrade after win
	 * @var int
	 */
	protected $upgradeChance;

	/**
	 * @brief list of upgrades to find after win
	 * @var array
	 */
	protected $upgradesList;

	/**
	 * @brief chance to find dark matter after win
	 * @var int
	 */
	protected $dmChance;

	/**
	 * @brief range of dark matter quantity
	 * @var int
	 */
	protected $dmCount;

	/**
	 * @brief verify status of bot
	 * @var bool
	 */
	protected $isBotSet = false;

	/**
	 * @brief points of the fleet units
	 * @var array
	 */
	protected $fleetPointsPerUnit;

	/**
	 * EnemiesGenerator constructor.
	 */
	public function __construct()
	{
		$this->setFleetPointsPerUnit();
	}

	/**
	 * @return void
	 */
	public function setFleetPointsPerUnit()
	{
		global $reslist, $pricelist;

		$this->fleetPointsPerUnit = array();

		foreach($reslist['fleet'] as $ID)
		{
			$this->fleetPointsPerUnit[$ID]	= ($pricelist[$ID]['cost'][901] + $pricelist[$ID]['cost'][902] + $pricelist[$ID]['cost'][903]);
		}
	}

	/**
	 * @brief method of fleet generation
	 * @param int $userFleetPoints
	 * @return void
	 */
	public function setBotFleetArray($userFleetPoints)
	{
		if(!$this->isBotSet)
			return;

		$leftPoints = $needPoints = max($this->minBotFleetPoints, $userFleetPoints*$this->factorUserFleetPoints);

		do
		{
			$random_unit_id      = $this->getUnitID();
			$points_on_iteration = min(ceil($needPoints * 0.005), $leftPoints);
			$generated_units     = ceil($points_on_iteration / $this->fleetPointsPerUnit[$random_unit_id]);

			if($generated_units < 1)
				continue;

			$used_points  = $generated_units * $this->fleetPointsPerUnit[$random_unit_id];
			$leftPoints  -= $used_points;

			if(isset($this->botFleetArray[$random_unit_id]))
				$this->botFleetArray[$random_unit_id] += $generated_units;
			else
				$this->botFleetArray[$random_unit_id] = $generated_units;
		}
		while($leftPoints > 0);
	}

	/**
	 * @return array
	 */
	public function getBotFactor()
	{
		return $this->botFactor;
	}

	/**
	 * @return array
	 */
	public function getBotInfo()
	{
		return array_merge($this->botInfoTechs, $this->botAcademy);
	}

	/**
	 * @return array
	 */
	public function getBotFleetArray()
	{
		return $this->botFleetArray;
	}

	/**
	 * @param array $resultDebris
	 * @return array
	 */
	public function getDebris($resultDebris)
	{
		return array(
			901 => $resultDebris['attacker'][901] + ($this->botDebris / 100) * $resultDebris['defender'][901],
			902 => $resultDebris['attacker'][902] + ($this->botDebris / 100) * $resultDebris['defender'][902],
		);
	}

	/**
	 * @return bool|string
	 */
	public function SearchForUpgrade()
	{
		$lastUpgradePosInArray = count($this->upgradesList)-1;
		$randomUpgradeType     = mt_rand(0, $lastUpgradePosInArray);
		$RandomNumber          = mt_rand(1, 100);

		if($RandomNumber <= $this->upgradeChance)
			return $this->upgradesList[$randomUpgradeType];
		else
			return false;
	}

	/**
	 * @return bool|float
	 */
	public function SearchForDarkMatter()
	{
		$RandomNumber = mt_rand(1, 100);

		if($RandomNumber <= $this->dmChance)
			return $this->dmCount;
		else
			return false;
	}

	/**
	 * @brief method for random select of unit ID from fleet composition
	 * @return int
	 */
	private function getUnitID()
	{
		$WBR    = mt_rand(1, 100);
		$Ranges = array(0, 0);

		foreach($this->fleetComposition as $ID => $Chances)
		{
			$Ranges = array(
				$Ranges[1] + 1,
				$Ranges[1] + $Chances
			);

			if($Ranges[0] <= $WBR && $WBR <= $Ranges[1])
				return $ID;
		}
		return 204; // as default return M-19 id
	}
}
