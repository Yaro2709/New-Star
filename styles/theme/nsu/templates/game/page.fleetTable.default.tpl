{block name="title" prepend}{$LNG.lm_fleet}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/fleetTable.css">
<div id="page">
    <div id="content">
        <div id="ally_content" class="conteinership" style="margin-bottom: 15px;">
        {if !empty($acsData)}
        {include file="shared.fleetTable.acsTable.tpl"}
        {/if}
            <div class="fleettab7"> 
                {if isModuleAvailable($smarty.const.MODULE_REDUCE_RESOURCES)}
                <a href="game.php?page=reduceResources" class="fleet_reduce ico_reduceresources tooltip" data-tooltip-content="{$LNG.lm_reduceresources}"></a>
                {/if}
                {if isModuleAvailable($smarty.const.MODULE_REDUCE_FLEET)}
                <a href="game.php?page=reduceFleet" class="fleet_reduce ico_reducefleet tooltip" data-tooltip-content="{$LNG.lm_reducefleet}"></a>
                {/if}
                {if isModuleAvailable($smarty.const.MODULE_DELIVERY)}
                <a href="game.php?page=delivery" class="fleet_reduce ico_deliveryres tooltip" data-tooltip-content="{$LNG.lm_delivery}"></a>
                {/if}
                {if isModuleAvailable($smarty.const.MODULE_FLEET_TRADER)}
                <a href="game.php?page=fleetDealer" class="fleet_reduce ico_trader tooltip" data-tooltip-content="{$LNG.lm_fleettrader}"></a>
                {/if}
                {if isModuleAvailable($smarty.const.MODULE_FIND_DEBRIS)}
                <a href="game.php?page=findDebris" class="fleet_reduce ico_finddebris tooltip" data-tooltip-content="{$LNG.lm_finddebris}"></a>
                {/if}
            </div>
            <div class="fleettab8" style="margin-bottom:0"></div>
            <span class="puntiflotta1">{$LNG.fl_fleet_points}</span>
            <span class="totalFleetPoints puntiflotta2">0</span>
            {if !empty($mission)}
            <span class="missionefleetta">{$LNG.fl_mission}</span>
            <span class="missionefleettamiss">{$LNG["type_mission_{$mission}"]}</span>
            {/if}
            <form action="?page=fleetStep1" method="post" name="glav" class="getRead">
                <input type="hidden" name="galaxy" value="{$targetGalaxy}">
                <input type="hidden" name="system" value="{$targetSystem}">
                <input type="hidden" name="planet" value="{$targetPlanet}">
                <input type="hidden" name="type" value="{$targetType}">
                <input type="hidden" name="target_mission" value="{$targetMission}">
                <div id="build_elements" style=" margin:0">
                    <div class="gray_ship1">
                        {foreach $elementListM as $ID => $Element}
                        {if $Element@first}{$Element.name}{/if}
                        {include file="page.fleetTable.item.tpl"}
                        {/foreach}
                        
                        {foreach $elementListP as $ID => $Element}
                        {if $Element@first}{$Element.name}{/if}
                        {include file="page.fleetTable.item.tpl"}
                        {/foreach}
                        
                        {foreach $elementListO as $ID => $Element}
                        {if $Element@first}{$Element.name}{/if}
                        {include file="page.fleetTable.item.tpl"}
                        {/foreach}
                        
                        {foreach $elementListD as $ID => $Element}
                        {if $Element@first}{$Element.name}{/if}
                        {include file="page.fleetTable.item.tpl"}
                        {/foreach}
                    </div>
                </div>  
                <div class="alleanza57"></div>
                <div class="fleettab1" style="    height: 65px;">
                    <div style="display:none;" class="fleettab12" id="save">
                        <span style="text-align:right; color:#888;font-size: 11px;">{$LNG.fl_new_name_grops}</span>
                        <input name="save_groop" size="15" maxlength="13" style="width:170px;height: 11px;" autofocus="">
                    </div> 
                    <table class="tablesorter ally_ranks">
                        <tbody>
                            <tr>     
                                <th class="menubassoshi" style="text-align:left" colspan="2"><a href="javascript:noShips();" class="menubassoshil">{$LNG.fl_remove_all_ships}</a></th>
                                <th class="menubassoshi" style="text-align:center" colspan="2"><a href="javascript:onSave();" class="menubassoshil">{$LNG.fl_new_grops}</a></th>
                                <th class="menubassoshi" colspan="2"><a href="javascript:maxShips();" class="menubassoshil">{$LNG.fl_select_all_ships}</a></th>
                            </tr>
                            {if $maxFleetSlots != $activeFleetSlots}
                            <tr>
                                <td colspan="6" style="padding:0;    border: 0;">
                                    <input class="fl_bigbtn_go" type="submit" value="{$LNG.fl_continue}">
                                </td>
                            </tr>
                            {/if} 
                        </tbody>
                    </table>	
                </div>    
            </form>
        </div>
    {if !empty($fleetGroopName)}
    <div id="ally_content" class="conteinership" style="margin-bottom: 15px;">
       <div class="fleettab10"></div>
      <div class="gray_flettab">
     {$LNG.fl_fleet_grops}
        </div> <div class="fleettab9" style="margin-bottom:0"></div>
        <div style="margin: 7px;position: relative; width: 700px;height: auto;float: left;">
      {for $i = 1; $i <= count($fleetGroopName); $i = $i + 4}
      {if !empty($fleetGroopName[$i-1])}
      <div class="fl_groop_link_name"  onclick="GroopShips({$i-1});">{$fleetGroopName[$i-1]}</div>
      <a class="fl_groop_link_del" title="{$LNG.fl_dlte_shortcut}" href="?page=fleetTable&amp;mode=delgroop&amp;id={$i-1}">×</a>	
      {/if}
      {if !empty($fleetGroopName[$i])}  
      <div class="fl_groop_link_name"  onclick="GroopShips({$i});">{$fleetGroopName[$i]}</div>
      <a class="fl_groop_link_del" title="{$LNG.fl_dlte_shortcut}" href="?page=fleetTable&amp;mode=delgroop&amp;id={$i}">×</a>	
      {/if}
      {if !empty($fleetGroopName[$i+1])}
      <div class="fl_groop_link_name"  onclick="GroopShips({$i+1});">{$fleetGroopName[$i+1]}</div>
      <a class="fl_groop_link_del" title="{$LNG.fl_dlte_shortcut}" href="?page=fleetTable&amp;mode=delgroop&amp;id={$i+1}">×</a>	
      {/if}
      {if !empty($fleetGroopName[$i+2])}
      <div class="fl_groop_link_name"  onclick="GroopShips({$i+2});">{$fleetGroopName[$i+2]}</div>
      <a class="fl_groop_link_del" title="{$LNG.fl_dlte_shortcut}" href="?page=fleetTable&amp;mode=delgroop&amp;id={$i+2}">×</a>	
      {/if}
      {/for} 	
      </div>
    <div class="clear"></div>
	</div>
    {/if}
    
    <div id="ally_content" class="conteinership">
 <div class="fleettab10"></div>   
<div class="gray_flettab">
        <div class="transparent">
        	{$LNG.fl_fleets} {$activeFleetSlots} / {$maxFleetSlots}
            <div class="transparent" style="text-align:right; float:right;color: #b1b1b1;font-size: 13px;">
                <span style="color: #8b99b0;font-weight: bold;">{$activeExpedition} / {$maxExpedition} {$LNG.fl_expeditions}</span>
            </div> 
        </div>
    </div> 
          <table class="tablesorter ally_ranks">
         <tr>
            <td>{$LNG.fl_number}</td>
            <td>{$LNG.fl_mission}</td>
            <td>{$LNG.fl_ammount}</td>
            <td>{$LNG.fl_beginning}</td>
            <td>{$LNG.fl_departure}</td>
            <td>{$LNG.fl_destiny}</td>
            <td>{$LNG.fl_objective}</td>
            <td>{$LNG.fl_arrival}</td>
            <td>{$LNG.fl_order}</td>
         </tr>
         {foreach name=FlyingFleets item=FlyingFleetRow from=$FlyingFleetList}
         <tr>
            <td>{$smarty.foreach.FlyingFleets.iteration}</td>
            <td>{$LNG["type_mission_{$FlyingFleetRow.mission}"]}
               {if $FlyingFleetRow.state == 1}
               <br><a title="{$LNG.fl_returning}">{$LNG.fl_r}</a>
               {else}
               <br><a title="{$LNG.fl_onway}">{$LNG.fl_a}</a>
               {/if}
            </td>
            <td><a class="tooltip" data-tooltip-content="<table width='100%'><tr><th colspan='2' style='text-align:center;'>{$LNG.fl_info_detail}</th></tr>{foreach $FlyingFleetRow.FleetList as $shipID => $shipCount}<tr><td class='transparent'>{$LNG.tech.{$shipID}}:</td><td class='transparent'>{$shipCount}</td></tr>{/foreach}</table>">{$FlyingFleetRow.amount}</a></td>
            <td><a href="game.php?page=galaxy&amp;galaxy={$FlyingFleetRow.startGalaxy}&amp;system={$FlyingFleetRow.startSystem}">[{$FlyingFleetRow.startGalaxy}:{$FlyingFleetRow.startSystem}:{$FlyingFleetRow.startPlanet}]</a></td>
            <td>{$FlyingFleetRow.startTime}</td>
            <td><a href="game.php?page=galaxy&amp;galaxy={$FlyingFleetRow.endGalaxy}&amp;system={$FlyingFleetRow.endSystem}">[{$FlyingFleetRow.endGalaxy}:{$FlyingFleetRow.endSystem}:{$FlyingFleetRow.endPlanet}]</a></td>
            {if $FlyingFleetRow.mission == 4}
            <td>-</td>
            <td style="color:lime">-</td>
            {else}
            <td>{$FlyingFleetRow.endTime}</td>
            <td style="color:lime">{$FlyingFleetRow.backin}</td>
            {/if}
            <td>
               {if !$isVacation && $FlyingFleetRow.state != 1}
               <form action="game.php?page=fleetTable&amp;action=sendfleetback" method="post">
                  <input name="fleetID" value="{$FlyingFleetRow.id}" type="hidden">
                  <input value="{$LNG.fl_send_back}" type="submit">
               </form>
               {if $FlyingFleetRow.mission == 1}
               <form action="game.php?page=fleetTable&amp;action=acs" method="post">
                  <input name="fleetID" value="{$FlyingFleetRow.id}" type="hidden">
                  <input value="{$LNG.fl_acs}" type="submit">
               </form>
               {/if}
               {else}
               &nbsp;-&nbsp;
               {/if}
            </td>
         </tr>
         {foreachelse}
         <tr>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
         </tr>
         {/foreach}
         {if $maxFleetSlots == $activeFleetSlots}
         <tr>
            <td colspan="9">{$LNG.fl_no_more_slots}</td>
         </tr>
         {/if}
      </table>		
</div>    
<script type="text/javascript">
    fleetGroopShip  = {$fleetGroopShip|json};
    var pointsPrice = {$pointsPrice|json};
</script>
</div>
{/block}
{block name="script" append}<script src="scripts/game/fleetTable.js"></script>{/block}