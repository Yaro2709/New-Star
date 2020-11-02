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

require_once('includes/classes/class.GalaxyRows.php');

class ShowGalaxyPage extends AbstractGamePage
{
    public static $requireModule = MODULE_GALAXY;

	function __construct() 
	{
		parent::__construct();
	}
	
	public function show()
	{
		global $USER, $PLANET, $resource, $LNG, $reslist;

		$config			= Config::get();

		$action 		= HTTP::_GP('action', '');
		$galaxyLeft		= HTTP::_GP('galaxyLeft', '');
		$galaxyRight	= HTTP::_GP('galaxyRight', '');
		$systemLeft		= HTTP::_GP('systemLeft', '');
		$systemRight	= HTTP::_GP('systemRight', '');
		$galaxy			= min(max(HTTP::_GP('galaxy', (int) $PLANET['galaxy']), 1), $config->max_galaxy);
		$system			= min(max(HTTP::_GP('system', (int) $PLANET['system']), 1), $config->max_system);
		$planet			= min(max(HTTP::_GP('planet', (int) $PLANET['planet']), 1), $config->max_planets);
		$type			= HTTP::_GP('type', 1);
		$current		= HTTP::_GP('current', 0);
		
        if (!empty($galaxyLeft))
            $galaxy	= max($galaxy - 1, 1);
        elseif (!empty($galaxyRight))
            $galaxy	= min($galaxy + 1, $config->max_galaxy);

        if (!empty($systemLeft))
            $system	= max($system - 1, 1);
        elseif (!empty($systemRight))
            $system	= min($system + 1, $config->max_system);

		if ($galaxy != $PLANET['galaxy'] || $system != $PLANET['system'])
		{
			if($PLANET['deuterium'] < $config->deuterium_cost_galaxy)
			{	
				$this->printMessage($LNG['gl_no_deuterium_to_view_galaxy'], array(array(
					'label'	=> $LNG['sys_back'],
					'url'	=> 'game.php?page=galaxy'
				)));
			} else {
				$PLANET['deuterium']	-= $config->deuterium_cost_galaxy;
            }
		}

        $target             = array_merge($reslist['fleet'], $reslist['defense']);
        $target[]	        = 502;
		$missileSelector[0]	= $LNG['gl_all_defenses'];
		
		foreach($target as $Element)
		{	
			$missileSelector[$Element] = $LNG['tech'][$Element];
		}
		$sql	= 'SELECT total_points
		FROM %%STATPOINTS%%
		WHERE id_owner = :userId AND stat_type = :statType';

		$USER	+= Database::get()->selectSingle($sql, array(
			':userId'	=> $USER['id'],
			':statType'	=> 1
		));

		$galaxyRows	= new GalaxyRows;
		$galaxyRows->setGalaxy($galaxy);
		$galaxyRows->setSystem($system);
		$Result	= $galaxyRows->getGalaxyData();
        require('includes/vars/PlanetData.php');	

        $this->tplObj->loadscript('galaxy.js');
        $this->assign(array(
			'GalaxyRows'				=> $Result,
			'planetcount'				=> (is_array($Result) ? count($Result) : 0),
			'action'					=> $action,
			'galaxy'					=> $galaxy,
			'system'					=> $system,
			'planet'					=> $planet,
			'type'						=> $type,
			'current'					=> $current,
			'maxfleetcount'				=> FleetFunctions::GetCurrentFleets($USER['id']),
			'fleetmax'					=> FleetFunctions::GetMaxFleetSlots($USER),
			'currentmip'				=> $PLANET[$resource[503]],
			'grecyclers'   				=> $PLANET[$resource[219]],
			'recyclers'   				=> $PLANET[$resource[209]],
			'spyprobes'   				=> $PLANET[$resource[210]],
			'missile_count'				=> sprintf($LNG['gl_missil_to_launch'], $PLANET[$resource[503]]),
			'spyShips'					=> array(210 => $USER['spio_anz']),
			'settings_fleetactions'		=> $USER['settings_fleetactions'],
			'current_galaxy'			=> $PLANET['galaxy'],
			'current_system'			=> $PLANET['system'],
			'current_planet'			=> $PLANET['planet'],
			'planet_type' 				=> $PLANET['planet_type'],
            'max_planets'               => $config->max_planets,
            'planet_factor'             => $config->planet_factor,
			'missileSelector'			=> $missileSelector,
            'planetData'				=> $planetData,
			'ShortStatus'				=> array(
				'vacation'					=> $LNG['gl_short_vacation'],
				'banned'					=> $LNG['gl_short_ban'],
				'inactive'					=> $LNG['gl_short_inactive'],
				'longinactive'				=> $LNG['gl_short_long_inactive'],
				'noob'						=> $LNG['gl_short_newbie'],
				'strong'					=> $LNG['gl_short_strong'],
				'enemy'						=> $LNG['gl_short_enemy'],
				'friend'					=> $LNG['gl_short_friend'],
				'member'					=> $LNG['gl_short_member'],
			),
		));
		
		$this->display('page.galaxy.default.tpl');
	}
}