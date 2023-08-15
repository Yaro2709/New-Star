{block name="title" prepend}{$LNG.lm_fleet}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/fleetTable.css">
<div id="page">
	<div id="content">
<div id="ally_content" class="conteiner">
    <div class="gray_stripo">
    	{$LNG.fl_fleet_sended}
    </div><div class="fleettab11" style="margin-top: 6px;"></div>
		<div class="fleettab16">
	  <div class="fleetstep1-3" style="top:41px;"><img src="{$dpath}img/iconav/7-o.png" class="fleetstep1-16">{$LNG.fl_mission} <span class="fleetstep1-10">{$LNG["type_mission_{$targetMission}"]}</span></div>
		  <div class="fleetstep1-4" style="top:71px;"><img src="{$dpath}img/iconav/time-s.png" class="fleetstep1-16">{$LNG.fl_arrival_time}<span class="fleetstep1-10">{$fleetStartTime}</span></div>
		  <div class="fleetstep1-5" style="top:101px;"><img src="{$dpath}img/iconav/consumption.png" class="fleetstep1-16">{$LNG.fl_fuel_consumption} <span class="fleetstep1-10">{$consumption|number}</span></div>
		   <div class="fleetstep1-5" style="top:132px"><img src="{$dpath}img/iconav/location.png" class="fleetstep1-16">{$LNG.fl_from} <span class="fleetstep1-10">{$from}</span></div>
		  	
				
		  <div class="fleetstep1-6" style="top:41px;"><span class="fleetstep1-11">{$MaxFleetSpeed|number}</span> {$LNG.fl_fleet_speed} <img src="{$dpath}img/iconav/max.png" class="fleetstep1-17"></div>
	      <div class="fleetstep1-7" style="top:71px;">{$LNG.fl_arrival_time} <span class="fleetstep1-11">{$fleetEndTime}</span> <img src="{$dpath}img/iconav/distance.png" class="fleetstep1-17"></div>  
		<div class="fleetstep1-9" style="top:101px;"><span class="fleetstep1-11">{$distance|number}</span> {$LNG.fl_distance} <img src="{$dpath}img/iconav/time-e.png" class="fleetstep1-17"></div>
		<div class="fleetstep1-9" style="top:132px"><span class="fleetstep1-11">{$destination}</span> {$LNG.fl_destiny} <img src="{$dpath}img/iconav/location.png" class="fleetstep1-17"></div>
		</div>
        
        {foreach $FleetList as $ShipID => $ShipCount}       
        <div class="alleanza1" style="width: 168px; height: 50px;margin-right: 0;">
        	<img src="{$dpath}gebaeude/{$ShipID}.gif" alt="{$LNG.tech.$ShipID}" width="44" height="44" class="fleettab13"><br>
            <span class="fleettab14">{$LNG.tech.{$ShipID}}</span>
            <span class="fleettab15">{$ShipCount|number}</span>
        </div>
        {/foreach}
        
</div>
</div>
</div>
{/block}