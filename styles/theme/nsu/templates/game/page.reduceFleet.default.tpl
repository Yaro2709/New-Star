{block name="title" prepend}{$LNG.lm_reducefleet}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/reduce.css">
<div id="page">
<div id="content">

<script type="text/javascript" src="./scripts/game/reduce.js"></script>
<script type="text/javascript">
   $(document).ready(function(){
       $('span.all_true').click(function() {
           $(':checkbox').attr('checked',true);
       });
   	$('span.all_false').click(function() {
           $(':checkbox').attr('checked',false);
       });
   	$('#speed').on('change', function() {
   		document.location = '?'+queryString+'&speed='+$(this).val();
   	});
   });
</script>
<div id="ally_content" class="conteiner">
<form action="game.php?page=reduceFleet&amp;mode=reduce" method="post" id="form">
   <input type="hidden" />
   <div class="gray_stripe">
      {$LNG.rd_select_palet_fleet}
      <span class="tornaindietro">
      <span class="all_true" style="color:#6C9; cursor:pointer;" onclick="planet_select_all();">{$LNG.rd_select_all}</span> |
      <span class="all_false" style="color:#F96; cursor:pointer;" onclick="planet_reset_all();">{$LNG.rd_reset_all}</span>
      </span>       
   </div>
   {if $ACSList}
   {foreach $ACSList as $ACSRow}	
   {if ($ACSRow.deuterium < $ACSRow.consumption_fleet && $ACSRow.consumption_fleet !=0) || ($ACSRow.sumcapacity < $ACSRow.consumption_fleet && $ACSRow.consumption_fleet !=0 && $ACSRow.sumcapacity !=0)}
   <div class="rd_planet_row">
      {else}
      <div id="prow_{$ACSRow.id}" class="rd_planet_row rd_planet_row_select" onclick="planet_select({$ACSRow.id});">
         <input class="rd_checkbox" id="p{$ACSRow.id}" name="palanets[]" type="checkbox" value="{$ACSRow.id}">
         {/if}
         <div class="rd_planet_img">
            <img title="{$ACSRow.name} [{$ACSRow.galaxy}:{$ACSRow.system}:{$ACSRow.planet}]" src="{$dpath}planeten/small/s_{$ACSRow.image}.jpg" alt="">
         </div>
         <div class="rd_planet_data_name">
            <span style="color:#CC6;">{$ACSRow.name}</span><br>            
            <span style="color:#CCC;">[{$ACSRow.galaxy}:{$ACSRow.system}:{$ACSRow.planet}]</span><br>
            <span style="color:#09F;">{$ACSRow.time_fleet|time} </span>
         </div>

         <div class="rd_planet_fleets tooltip" data-tooltip-content="
            <table class='reducefleet_table'>       
            {foreach $reducefleet as $ship}
            {if $ACSRow.{$ship} != 0}
            <tr>
            <td class='reducefleet_img_ship'> <img src='{$dpath}gebaeude/{$ship}.gif' alt='' /></td>
            <td class='reducefleet_name_ship'>                      {$LNG.tech.{$ship}}: <span class='reducefleet_count_ship'>{$ACSRow.{$ship}|number}</span></td>
            </tr>
            {/if}
            {/foreach}
            </table>"> 
            <span style="color:#0CC;">  {($ACSRow.sum)|number} </span>         
         </div>
         <div class="rd_planet_statuto">
            {if $ACSRow.deuterium < $ACSRow.consumption_fleet && $ACSRow.consumption_fleet !=0}	
            <span style="color:#3C0;">{$LNG.rd_not_deiterium} ({($ACSRow.consumption_fleet - $ACSRow.deuterium)|number})</span>
            {elseif $ACSRow.sumcapacity < $ACSRow.consumption_fleet && $ACSRow.consumption_fleet !=0 && $ACSRow.sumcapacity !=0}	
            <span style="color:#FC0;">{$LNG.rd_not_conpustion}</span>
            {else}
            <span style="color:#ccc;">{$LNG.rd_compustion}:</span> <font color="#0C3">{($ACSRow.consumption_fleet)|number}</font>
            {/if}         
         </div>
         <div class="clear"></div>
      </div>
      {/foreach} 
      <div class="clear"></div>
      <div class="build_band2 ticket_bottom_band" style="padding-left:20px;">
         <span style="float:left;">
         {$LNG.fl_fleet_speed}            
         <select id="speed" name="speed">
         {html_options options=$speedSelect selected=$speed}
         </select> %
         </span> 
         <input class="bottom_band_submit" type="submit" value="{$LNG.fl_continue}">
      </div>
      {else}
      <div class="ally_contents">{$LNG.rd_planet_no_fleet} </div>
      {/if}	
</form>
</div>

{/block}