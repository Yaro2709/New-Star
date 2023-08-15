{block name="title" prepend}{$LNG.lm_fleet}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/fleetTable.css">
<div id="page">
	<div id="content">
<div id="ally_content" class="conteiner">
    <div class="gray_flettab">
    	{$LNG.fl_send_fleet}
		<span class="tornaindietronew"><span class="fleetstep1-16">{$LNG.fl_max_speed} <span id="maxspeed">-</span></span></span>
    </div>
	<form action="game.php?page=fleetStep2" method="post" onsubmit="return CheckTarget()" id="form">
	<input type="hidden" name="token" value="{$token}">
	<input type="hidden" name="fleet_group" value="0">
    <input type="hidden" name="target_mission" value="{$mission}">
    
	
	<div class="fleetstep1-1">
  <div class="gray_ship1"><div class="gray_ship3" style="height:80px">
    	<div class="fleetstep1-14">{$LNG.fl_destiny}
		
				<input type="text" id="galaxy" name="galaxy" size="3" maxlength="2" onchange="updateVars()" value="{$galaxy}" class="fleetstep1-2">
				<input type="text" id="system" name="system" size="3" maxlength="4" onchange="updateVars()" value="{$system}" class="fleetstep1-2">
				<input type="text" id="planet" name="planet" size="3" maxlength="2" onchange="updateVars()" value="{$planet}" class="fleetstep1-2"> 
				<select id="type" name="type" onchange="updateVars()">
                    {html_options options=$typeSelect selected=$type}
				</select>
				</div>
			<div class="fleetstep1-15">{$LNG.fl_fleet_speed}
				<select id="speed" name="speed" onchange="updateVars(false)" size="10" class="fleetstep1select">
                    {html_options options=$speedSelect selected=10}
				</select> %</div>
    </div> </div>
	
	
		  <div class="fleetstep1-3"><img src="{$dpath}img/iconav/distance.png" class="fleetstep1-16">{$LNG.fl_distance} <span id="distance" class="fleetstep1-10">-</span></div>
		  <div class="fleetstep1-4"><img src="{$dpath}img/iconav/time-s.png" class="fleetstep1-16">{$LNG.fl_flying_arrival}<span id="arrival" class="fleetstep1-10">-</span></div>
		  <div class="fleetstep1-5"><img src="{$dpath}img/iconav/consumption.png" class="fleetstep1-16">{$LNG.fl_fuel_consumption} <span id="consumption" class="fleetstep1-10"><span style="color: #3ac96c;text-shadow: 0px 0px 5px hsla(141, 55%, 30%, 0.5);">-</span></span></div>
		  
		  	
				
		  <div class="fleetstep1-6"><span id="storage" class="fleetstep1-11"><span style="color: #3ac96c;text-shadow: 0px 0px 5px hsla(141, 55%, 30%, 0.5);">-</span></span> {$LNG.fl_cargo_capacity} <img src="{$dpath}img/iconav/max.png" class="fleetstep1-17"></div>
	      <div class="fleetstep1-7">{$LNG.fl_flying_time} <span id="duration" class="fleetstep1-11">-</span> <img src="{$dpath}img/iconav/times.png" class="fleetstep1-17"></div>  
		<div class="fleetstep1-9"><span id="return" class="fleetstep1-11">-</span> {$LNG.fl_flying_return} <img src="{$dpath}img/iconav/time-e.png" class="fleetstep1-17"></div>
		</div>
	    
            <div class="tablesorter shortcut">
            <div class="gray_ship1"><div class="gray_ship3">
                {$LNG.fl_shortcut}
                  <a href="#" onclick="EditShortcuts();return false" class="shortcut-link-edit shortcut-link fl_shortcut_link_edition" style="display: inline;">{$LNG.fl_shortcut_edition}</a>
                  <a href="#" onclick="SaveShortcuts();return false" class="shortcut-edit fl_shortcut_link_edition" style="display: none;">{$LNG.fl_shortcut_save}</a>
            </div> </div>
               <div id="shortcut-data" class="clear shortcut-row">
                  {foreach $shortcutList as $shortcutID => $shortcutRow}
                  <div class="shortcut-colum shortcut_block shortcut-isset">
                     <div class="shortcut-link" style="display: block;">      
                        <a href="javascript:setTarget({$shortcutRow.galaxy},{$shortcutRow.system},{$shortcutRow.planet},{$shortcutRow.type});updateVars();">
                            <span class="shortcut_link_name">{$shortcutRow.name}</span>
                            <span class="shortcut_link_kord">{if $shortcutRow.type == 1}{$LNG.fl_planet_shortcut}{elseif $shortcutRow.type == 2}{$LNG.fl_debris_shortcut}{elseif $shortcutRow.type == 3}{$LNG.fl_moon_shortcut}{/if} [{$shortcutRow.galaxy}:{$shortcutRow.system}:{$shortcutRow.planet}]</span>
                        </a>
                     </div>
                     <div class="shortcut-edit" style="display: none;">
                        <input type="text" class="shortcut-input shortcut-input-name" maxlength="32" name="shortcut[{$shortcutID}][name]" value="{$shortcutRow.name}" placeholder="{$shortcutRow.name}">
                        <div class="shortcut-delete" title="{$LNG.fl_dlte_shortcut}"></div>
                     </div>
                     <div class="shortcut-edit" style="display: none;">
                        <input type="text" class="shortcut-input shortcut-input-system" name="shortcut[{$shortcutID}][galaxy]" value="{$shortcutRow.galaxy}" size="3" maxlength="2" placeholder="{$shortcutRow.galaxy}" pattern="[0-9]*">
                        <input type="text" class="shortcut-input shortcut-input-system" name="shortcut[{$shortcutID}][system]" value="{$shortcutRow.system}" size="3" maxlength="4" placeholder="{$shortcutRow.system}" pattern="[0-9]*">
                        <input type="text" class="shortcut-input shortcut-input-system" name="shortcut[{$shortcutID}][planet]" value="{$shortcutRow.planet}" size="3" maxlength="2" placeholder="{$shortcutRow.planet}" pattern="[0-9]*">
                     </div>
                     <div class="shortcut-edit" style="display: none;">
                        <select class="shortcut-input shortcut-input-type" name="shortcut[{$shortcutID}][type]">
                        {html_options selected=$shortcutRow.type options=$typeSelect}
                        </select>
                     </div>
                  </div>
                  {foreachelse}
                  <div class="clear shortcut-none shortcut_block">
                     {$LNG.fl_no_shortcuts}
                  </div>
                  {/foreach}
               </div>
               <div class="shortcut-edit shortcut-new">
                  <div class="shortcut-colum shortcut_block">
                     <div class="shortcut-link" style="display: none;">
                     </div>
                     <div class="shortcut-edit" style="display: none;">
                        <input type="text" class="shortcut-input shortcut-input-name" maxlength="32" name="shortcut[][name]" placeholder="{$LNG.fl_shortcut_name}">
                        <div class="shortcut-delete" title="{$LNG.fl_dlte_shortcut}"></div>
                     </div>
                     <div class="shortcut-edit" style="display: none;">
                        <input type="text" class="shortcut-input shortcut-input-system" name="shortcut[][galaxy]" value="" size="3" maxlength="2" placeholder="{$LNG.gl_galaxy}" pattern="[0-9]*">:
                        <input type="text" class="shortcut-input shortcut-input-system" name="shortcut[][system]" value="" size="3" maxlength="4" placeholder="{$LNG.gl_solar_system}" pattern="[0-9]*">:
                        <input type="text" class="shortcut-input shortcut-input-system" name="shortcut[][planet]" value="" size="3" maxlength="2" placeholder="{$LNG.gl_planet}" pattern="[0-9]*">
                     </div>
                     <div class="shortcut-edit" style="display: none;">
                        <select class="shortcut-input shortcut-input-type" name="shortcut[][type]">
                        {html_options options=$typeSelect}
                        </select>
                     </div>
                  </div>
               </div>
            </div>
            <div class="fleet_my_planet_kord shortcut-edit" style="line-height: 15px; height: 13px; text-align: right; width: 15px; font-size: 30px; font-family: BicubikRegular, Arial, Geneva, sans-serif; text-shadow: rgba(0, 0, 0, 0.55) 1px 2px; color: rgb(9, 29, 46); cursor: pointer; display: none;" onclick="AddShortcuts();return false">        	
                <span>+</span>            
            </div>
	    
    <div class="gray_ship1"><div class="gray_ship3">
    	{$LNG.fl_my_planets}
   </div> </div> 
		
                    {foreach $colonyList as $ColonyRow}
            <div class="fleet_my_planet_kord" onclick="setTarget({$ColonyRow.galaxy},{$ColonyRow.system},{$ColonyRow.planet},{$ColonyRow.type});updateVars();">
            <img src="{$dpath}planeten/planet2d/{$ColonyRow.image}.png" class="fleestep1-13">
               <span class="fleet_my_planet_kord_kord">[{$ColonyRow.galaxy}:{$ColonyRow.system}:{$ColonyRow.planet}]</span>
               <span class="fleet_my_planet_kord_name">{$ColonyRow.name} {if $ColonyRow.type == 3}{$LNG.fl_moon_shortcut}{/if}</span>
            </div>
            {foreachelse}
            {/foreach}			   
            {if $ACSList}
            <table class="tablesorter ally_ranks" style="table-layout: fixed;">
               <tr style="height:20px;">
                  <th colspan="5">{$LNG.fl_acs_title}</th>
               </tr>
               {foreach $ACSList as $ACSRow}
               {if ($ACSRow@iteration % $themeSettings.ACS_ROWS_ON_FLEET1) === 1}
               <tr style="height:20px;">
                  {/if}
                  <td><a href="javascript:setACSTarget({$ACSRow.galaxy},{$ACSRow.system},{$ACSRow.planet},{$ACSRow.planet_type},{$ACSRow.id});">{$ACSRow.name} - [{$ACSRow.galaxy}:{$ACSRow.system}:{$ACSRow.planet}]</a></td>
                  {if $ACSRow@last && ($ACSRow@iteration % $themeSettings.ACS_ROWS_ON_FLEET1) !== 0}
                  {$to = $themeSettings.ACS_ROWS_ON_FLEET1 - ($ACSRow@iteration % $themeSettings.ACS_ROWS_ON_FLEET1)}
                  {for $foo=1 to $to}
                  <td>&nbsp;</td>
                  {/for}
                  {/if}
                  {if ($ACSRow@iteration % $themeSettings.ACS_ROWS_ON_FLEET1) === 0}
               </tr>
               {/if}
               {/foreach}
            </table>
            {/if}
    <div class="fleettab1" style="    height:43px;">
    	<input class="fl_bigbtn_go" type="submit" value="{$LNG.fl_continue}">
    </div>
	</form>
</div>
</div>
</div>
   <script type="text/javascript">
      data			= {$fleetdata|json};
      shortCutRows	= {$themeSettings.SHORTCUT_ROWS_ON_FLEET1};
      fl_no_shortcuts	= '{$LNG.fl_no_shortcuts}';
   </script>
</div>
</div>
<div class="clear"></div>
</div>
{/block}