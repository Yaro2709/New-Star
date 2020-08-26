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

class ShowControlPage extends AbstractGamePage
{
	public static $requireModule = MODULE_CONTROL;

	function __construct() 
	{
		parent::__construct();
	}

	function show()
	{
		global $USER, $PLANET, $resource, $reslist;

        $db = Database::get();

		switch($USER['planet_sort'])
		{
			case 2:
				$orderBy = 'name';
				break;
			case 1:
				$orderBy = 'galaxy, system, planet, planet_type';
				break;
			default:
				$orderBy = 'id';
				break;
		}
		
		$orderBy .= ' '.($USER['planet_sort_order'] == 1) ? 'DESC' : 'ASC';

        $sql = "SELECT * FROM %%PLANETS%% WHERE id != :planetID AND id_owner = :userID AND destruyed = '0' ORDER BY :order;";
        $PlanetsRAW = $db->select($sql, array(
            ':planetID' => $PLANET['id'],
            ':userID'   => $USER['id'],
            ':order'    => $orderBy,
        ));

        $PLANETS	= array($PLANET);
		
		$PlanetRess	= new ResourceUpdate();
		
		foreach ($PlanetsRAW as $CPLANET)
		{
            list($USER, $CPLANET)	= $PlanetRess->CalcResource($USER, $CPLANET, true);
			
			$PLANETS[]	= $CPLANET;
			unset($CPLANET);
		}

        $planetList	= array();

		foreach($PLANETS as $Planet)
		{
			$planetList['name'][$Planet['id']]					= $Planet['name'];
			$planetList['image'][$Planet['id']]					= $Planet['image'];
            
            $planetList['coords'][$Planet['id']]['planet_type']	= $Planet['planet_type'];
            
			$planetList['coords'][$Planet['id']]['galaxy']		= $Planet['galaxy'];
			$planetList['coords'][$Planet['id']]['system']		= $Planet['system'];
			$planetList['coords'][$Planet['id']]['planet']		= $Planet['planet'];
			
			$planetList['field'][$Planet['id']]['current']		= $Planet['field_current'];
			$planetList['field'][$Planet['id']]['max']			= CalculateMaxPlanetFields($Planet);
            //НЕ ИСПОЛЬЗУЕТСЯ
            foreach($reslist['resstype'][2] as $elementID) {
				$planetList[''.$resource[$elementID].'_used'][$Planet['id']]	= $Planet[''.$resource[$elementID].''] + $Planet[''.$resource[$elementID].'_used'];
			}
            //НЕ ИСПОЛЬЗУЕТСЯ
            foreach(array_merge($reslist['resstype'][1], $reslist['resstype'][2]) as $elementID) {
				$planetList['resource'][$elementID][$Planet['id']]	= $Planet[$resource[$elementID]];
			}
            foreach($reslist['resstype'][1] as $elementID) {
                $planetList['res'][$elementID][$Planet['id']]	    = $Planet[$resource[$elementID].'_perhour'];
			}
            
			foreach($reslist['build'] as $elementID) {
				$planetList['build'][$elementID][$Planet['id']]	= $Planet[$resource[$elementID]];
			}
			
			foreach($reslist['fleet'] as $elementID) {
				$planetList['fleet'][$elementID][$Planet['id']]	= $Planet[$resource[$elementID]];
			}
			
			foreach($reslist['defense'] as $elementID) {
				$planetList['defense'][$elementID][$Planet['id']]	= $Planet[$resource[$elementID]];
			}
		}

		foreach($reslist['tech'] as $elementID){
			$planetList['tech'][$elementID]	= $USER[$resource[$elementID]];
		}
         
        $sql		= 'SELECT COUNT(*) as count FROM %%PLANETS%% WHERE id_owner = :userID AND destruyed = 0;';
		$AllCount		= $db->selectSingle($sql, array(
			':userID'	=> $USER['id'],
		));
		
		$sql		= 'SELECT COUNT(*) as count FROM %%PLANETS%% WHERE id_owner = :userID AND destruyed = 0 AND planet_type = "3";';
		$MoonCount		= $db->selectSingle($sql, array(
			':userID'	=> $USER['id'],
		));
		
		$sql		= 'SELECT COUNT(*) as count FROM %%PLANETS%% WHERE id_owner = :userID AND destruyed = 0 AND planet_type = "1";';
		$PlanetCount		= $db->selectSingle($sql, array(
			':userID'	=> $USER['id'],
		));
        
		$MaxPlanets		= PlayerUtil::maxPlanetCount($USER);
        
		$this->tplObj->loadscript("empire.js");
		$this->assign(array(
			'colspan'		=> count($PLANETS) + 2,
            'PlanetCount'	=> $PlanetCount['count'],
			'MoonCount'		=> $MoonCount['count'],
			'AllCount'		=> $AllCount['count'],
			'MaxPlanets'	=> $MaxPlanets,
			'planetList'	=> $planetList,
		));

		$this->display('page.control.default.tpl');
	}
}