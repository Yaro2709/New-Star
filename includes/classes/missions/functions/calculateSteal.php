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

function calculateSteal($attackFleets, $defenderPlanet, $simulate = false)
{	
	// See: http://www.owiki.de/Beute
	global $pricelist, $resource;
	
	$firstResource	= 901;
	$secondResource	= 902;
	$thirdResource	= 903;
	
	$SortFleets 	= array();
	$capacity  	= 0;
	
	$stealResource	= array(
		$firstResource => 0,
		$secondResource => 0,
		$thirdResource => 0
	);
	
	foreach($attackFleets as $FleetID => $Attacker)
	{
		$SortFleets[$FleetID]		= 0;
		
		foreach($Attacker['unit'] as $Element => $amount)	
		{
			$SortFleets[$FleetID]		+= $pricelist[$Element]['capacity'] * $amount;
		}
		
		$SortFleets[$FleetID]	*= (1 + $Attacker['player']['factor']['ShipStorage']);
		
		$SortFleets[$FleetID]	-= $Attacker['fleetDetail']['fleet_resource_metal'];
		$SortFleets[$FleetID]	-= $Attacker['fleetDetail']['fleet_resource_crystal'];
		$SortFleets[$FleetID]	-= $Attacker['fleetDetail']['fleet_resource_deuterium'];
		$capacity				+= $SortFleets[$FleetID];
	}
	
	$AllCapacity		= $capacity;
	if($AllCapacity <= 0)
	{
		return $stealResource;
	}
	
	// Step 1
	$stealResource[$firstResource]		= min($capacity / 3, $defenderPlanet[$resource[$firstResource]] / 2);
	$capacity	-= $stealResource[$firstResource];
	 
	// Step 2
	$stealResource[$secondResource] 	= min($capacity / 2, $defenderPlanet[$resource[$secondResource]] / 2);
	$capacity	-= $stealResource[$secondResource];
	 
	// Step 3
	$stealResource[$thirdResource] 		= min($capacity, $defenderPlanet[$resource[$thirdResource]] / 2);
	$capacity	-= $stealResource[$thirdResource];
		 
	// Step 4
	$oldMetalBooty  					= $stealResource[$firstResource];
	$stealResource[$firstResource] 		+= min($capacity / 2, $defenderPlanet[$resource[$firstResource]] / 2 - $stealResource[$firstResource]);
	$capacity	-= $stealResource[$firstResource] - $oldMetalBooty;
		 
	// Step 5
	$stealResource[$secondResource] 	+= min($capacity, $defenderPlanet[$resource[$secondResource]] / 2 - $stealResource[$secondResource]);
			
	if($simulate)
	{
		return $stealResource;
	}
	
	$db	= Database::get();

	foreach($SortFleets as $FleetID => $Capacity)
	{
		$slotFactor	= $Capacity / $AllCapacity;
		
		$sql	= "UPDATE %%FLEETS%% SET
		`fleet_resource_metal` = `fleet_resource_metal` + '".($stealResource[$firstResource] * $slotFactor)."',
		`fleet_resource_crystal` = `fleet_resource_crystal` + '".($stealResource[$secondResource] * $slotFactor)."',
		`fleet_resource_deuterium` = `fleet_resource_deuterium` + '".($stealResource[$thirdResource] * $slotFactor)."'
		WHERE fleet_id = :fleetId;";

		$db->update($sql, array(
			':fleetId'	=> $FleetID,
	  	));
	}
	
	return $stealResource;
}
	