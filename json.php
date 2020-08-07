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

define('MODE', 'JSON');
define('ROOT_PATH', str_replace('\\', '/',dirname(__FILE__)).'/');

require(ROOT_PATH.'includes/common.php');

$AJAX = array();

$sql	= "SELECT COUNT(*) as count FROM %%FLEETS%% WHERE fleet_start_time > :time AND fleet_mission = :missionId AND fleet_mess = 0 AND fleet_owner <> :userId AND fleet_target_owner = :userId;";
$total	= Database::get()->selectSingle($sql, array(
	':userId'	    => $USER['id'],
    ':time'	        => TIMESTAMP,
    ':missionId'	=> 1
    
));
$AJAX['ataks'] = $total['count'];

$sql	= "SELECT COUNT(*) as count FROM %%FLEETS%% WHERE fleet_start_time > :time AND fleet_mission = :missionId AND fleet_mess = 0 AND fleet_owner <> :userId AND fleet_target_owner = :userId;";
$total	= Database::get()->selectSingle($sql, array(
	':userId'	    => $USER['id'],
    ':time'	        => TIMESTAMP,
    ':missionId'	=> 6
    
));
$AJAX['spio'] = $total['count'];

$sql	= "SELECT COUNT(*) as count FROM %%FLEETS%% WHERE fleet_start_time > :time AND fleet_mission = :missionId AND fleet_mess = 0 AND fleet_owner <> :userId AND fleet_target_owner = :userId;";
$total	= Database::get()->selectSingle($sql, array(
	':userId'	    => $USER['id'],
    ':time'	        => TIMESTAMP,
    ':missionId'	=> 9
    
));
$AJAX['unic'] = $total['count'];

$sql	= "SELECT COUNT(*) as count FROM %%FLEETS%% WHERE fleet_start_time > :time AND fleet_mission = :missionId AND fleet_mess = 0 AND fleet_owner <> :userId AND fleet_target_owner = :userId;";
$total	= Database::get()->selectSingle($sql, array(
	':userId'	    => $USER['id'],
    ':time'	        => TIMESTAMP,
    ':missionId'	=> 10
    
));
$AJAX['rakets'] = $total['count'];

if($AJAX['ataks'] > 0)
	$AJAX['ICOFLEET']	='<div id="attack" class="indicator active_indicator">';
else
	$AJAX['ICOFLEET']	='<div id="attack" class="indicator">';

$AJAX['ICOFLEET']	.='<div class="icoi"></div>';	
$AJAX['ICOFLEET']	.='</div>';

if($AJAX['spio'] > 0)
	$AJAX['ICOFLEET']	.='<div id="espionage" class="indicator active_indicator">';
else
	$AJAX['ICOFLEET']	.='<div id="espionage" class="indicator">';

$AJAX['ICOFLEET']	.='<div class="icoi"></div>';
$AJAX['ICOFLEET']	.='</div>';

if($AJAX['unic'] > 0)
	$AJAX['ICOFLEET']	.='<div id="destruction" class="indicator active_indicator">';
else
	$AJAX['ICOFLEET']	.='<div id="destruction" class="indicator">';

$AJAX['ICOFLEET']	.='<div class="icoi"></div>';
$AJAX['ICOFLEET']	.='</div>';

if($AJAX['rakets'] > 0)
	$AJAX['ICOFLEET']	.='<div id="rocket" class="indicator active_indicator">';
else
	$AJAX['ICOFLEET']	.='<div id="rocket" class="indicator">';

$AJAX['ICOFLEET']	.='<div class="icoi"></div>';
$AJAX['ICOFLEET']	.='</div>';

$AJAX['SOUNDATAKS']	= false;
if($USER['sound_ataks'] != 0)
{
	if($AJAX['SOUNDATAKS'] == false)
	$AJAX['SOUNDATAKS']	= HTTP::_GP('ataks', 0) < $AJAX['ataks'] ? true : false;
	
	if($AJAX['SOUNDATAKS'] == false)
	$AJAX['SOUNDATAKS']	= HTTP::_GP('unic', 0) < $AJAX['unic'] ? true : false;
	
	if($AJAX['SOUNDATAKS'] == false)
	$AJAX['SOUNDATAKS']	= HTTP::_GP('rakets', 0) < $AJAX['rakets'] ? true : false;
}

$AJAX['NEWMSG']		= $USER['messages'] == 0 ? '' : ("+".$USER['messages']);

$AJAX['SOUNDMSG']	= false;
if($USER['setting_msg'] != 0)
{
    $AJAX['SOUNDMSG']	= true;
}

$AJAX['msg']		= $USER['messages'];

echo json_encode($AJAX);
?>