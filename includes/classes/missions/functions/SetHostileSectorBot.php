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

class SetHostileSectorBot extends HostileSector
{
	const ENEMY1    = 1;
	const ENEMY2    = 2;
	const ENEMY3    = 3;
    const BOT_FACTOR = array('AttackA', 'DefensiveA', 'ShieldA', 'AttackD', 'DefensiveD', 'ShieldD', 'Attack', 'AttackSlaser', 'AttackSion', 'AttackSplasma', 'AttackSgravity', 'Defensive', 'DefensiveSlight', 'DefensiveSmedium', 'DefensiveSheavy', 'Shield', 'ShieldSlight', 'ShieldSmedium', 'ShieldSheavy', 'DoubleAttack', 'DoubleShield', 'DoubleDefensive', 'DoubleAttackBonus', 'DoubleShieldBonus', 'DoubleDefensiveBonus', 'DefRecovery');

	/**
	 * SetSectorHostileEnemies constructor.
	 */
	public function __construct()
	{
		parent::__construct();
	}

	/**
	 * @brief bot creator
	 * @param int $sectorNumber
	 * @param array $playerData
	 * @param string $BotName
	 * @return void
	 */
	public function CreateBot($sectorNumber, $playerData, $BotName)
	{
		switch($sectorNumber)
		{
			case $this::ENEMY1:
				$this->SetENEMY1($playerData, $BotName);
				break;
			case $this::ENEMY2:
				$this->SetENEMY2($playerData, $BotName);
				break;
			case $this::ENEMY3:
				$this->SetENEMY3($playerData, $BotName);
				break;
		}
	}

	/**
	 * @brief ENEMY1 settings
	 * @param array $playerData
	 * @param string $BotName
	 * @return void
	 */
	private function SetENEMY1($playerData, $BotName)
	{
		$this->fleetComposition      = $this->ComposeFleet($this::ENEMY1);
		$this->minBotFleetPoints     = 100;
		$this->factorUserFleetPoints = mt_rand(60, 70) / 100;
          
        $this->botFactor = array();
        foreach($this::BOT_FACTOR as $factor_name){
            $this->botFactor += array(
                $factor_name   => mt_rand(60, 70) / 100 * ($playerData['factor'][$factor_name]),
            );
        }

		$this->botInfoTechs = array(
			'id'               => 0,
			'username'         => $BotName,
		);
		$this->botAcademy      = array();

		$this->maxBattlePoints = 2500;
		$this->botDebris       = 1;

		$this->upgradeChance   = 10;
		$this->upgradesList    = array(2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010);
		$this->dmChance        = 30;
		$this->dmCount         = mt_rand(1,5);

		$this->isBotSet        = true;
	}

	/**
	 * @brief ENEMY2 settings
	 * @param array $playerData
	 * @param string $BotName
	 * @return void
	 */
	private function SetENEMY2($playerData, $BotName)
	{
		$this->fleetComposition      = $this->ComposeFleet($this::ENEMY2);
		$this->minBotFleetPoints     = 250;
		$this->factorUserFleetPoints = mt_rand(70, 80) / 100;

		$this->botFactor = array();
        foreach($this::BOT_FACTOR as $factor_name){
            $this->botFactor += array(
                $factor_name   => mt_rand(70, 80) / 100 * ($playerData['factor'][$factor_name]),
            );
        }
        
		$this->botInfoTechs = array(
			'id'               => 0,
			'username'         => $BotName,
		);
		$this->botAcademy      = array();

		$this->maxBattlePoints = 15000;
		$this->botDebris       = 2;

		$this->upgradeChance   = 10;
		$this->upgradesList    = array(2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010);
		$this->dmChance        = 30;
		$this->dmCount         = mt_rand(1,10);

		$this->isBotSet        = true;
	}

	/**
	 * @brief ENEMY3 settings
	 * @param array $playerData
	 * @param string $BotName
	 * @return void
	 */
	private function SetENEMY3($playerData, $BotName)
	{
		$this->fleetComposition      = $this->ComposeFleet($this::ENEMY3);
		$this->minBotFleetPoints     = 500;
		$this->factorUserFleetPoints = mt_rand(80, 90) / 100;

		$this->botFactor = array();
        foreach($this::BOT_FACTOR as $factor_name){
            $this->botFactor += array(
                $factor_name   => mt_rand(80, 90) / 100 * ($playerData['factor'][$factor_name]),
            );
        }
        
		$this->botInfoTechs = array(
			'id'               => 0,
			'username'         => $BotName,
		);
		$this->botAcademy      = array();

		$this->maxBattlePoints = 25000;
		$this->botDebris       = 3;

		$this->upgradeChance   = 10;
		$this->upgradesList    = array(2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010);
		$this->dmChance        = 30;
		$this->dmCount         = mt_rand(1,15);

		$this->isBotSet        = true;
	}

	/**
	 * @brief fleet composer
	 * @param int $sectorNumber
	 * @return array
	 */
	private function ComposeFleet($sectorNumber)
	{
		$Bots = array(
			$this::ENEMY1 => array(
				array(204 => 70, 205 => 30),
				array(227 => 10, 225 => 90),
				array(230 => 50, 222 => 50),
				array(234 => 80, 235 => 5, 209 => 15),
				array(229 => 100),
				array(204 => 30, 205 => 10, 229 => 15, 206 => 12, 207 => 17, 215 => 6, 213 => 7, 224 => 3),
				array(229 => 15, 224 => 3),
			),

			$this::ENEMY2    => array(
				array(204 => 40, 205 => 20, 229 => 15, 206 => 12, 207 => 13),
				array(204 => 80, 205 => 20),
				array(206 => 40, 205 => 60),
				array(204 => 59, 205 => 17, 229 => 1, 209 => 20, 229 => 3),
			),

			$this::ENEMY3     => array(
				array(204 => 30, 205 => 10, 229 => 15, 206 => 12, 207 => 17, 215 => 6, 213 => 7, 224 => 3),
			),
		);

		$Compositions = $Bots[$sectorNumber];
		return $Compositions[mt_rand(0, count($Compositions)-1)];
	}
}
