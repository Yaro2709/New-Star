{block name="title" prepend}{$LNG.lm_reduceresources}{/block}
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
   });
</script>

<div id="ally_content" class="conteiner">
<form action="game.php?page=reduceResources&amp;mode=reduce" method="post" id="form">
   <input type="hidden" />
   <div class="gray_stripe">
      {$LNG.rd_select_palet_res}
      <span class="tornaindietro">
      <span class="all_true" style="color:#6C9; cursor:pointer;" onclick="planet_select_all();">{$LNG.rd_select_all}</span> |
      <span class="all_false" style="color:#F96; cursor:pointer;" onclick="planet_reset_all();">{$LNG.rd_reset_all}</span>
      </span>
   </div>
   {if $ACSList}
   {foreach $ACSList as $ACSRow}
   {if ($ACSRow.small_count + $ACSRow.big_count + $ACSRow.ev_count == 0) || ($ACSRow.deuterium < $ACSRow.consumption_fleet && $ACSRow.consumption_fleet !=0) || ($ACSRow.sumcapacity < $ACSRow.consumption_fleet && $ACSRow.consumption_fleet !=0 && $ACSRow.sumcapacity !=0)}
   <div class="rd_planet_row">
      {else}
      <div id="prow_{$ACSRow.id}" class="rd_planet_row rd_planet_row_select" onclick="planet_select({$ACSRow.id});">
         <input class="rd_checkbox" id="p{$ACSRow.id}" name="palanets[]" type="checkbox" value="{$ACSRow.id}">
         {/if}
         <div class="rd_planet_img"><img title="{$ACSRow.name} [{$ACSRow.galaxy}:{$ACSRow.system}:{$ACSRow.planet}]" src="{$dpath}planeten/small/s_{$ACSRow.image}.jpg" alt=""></div>
         <div class="rd_planet_data_name">
            <span style="color:#CC6;">{$ACSRow.name}</span><br>            
            <span style="color:#CCC;">[{$ACSRow.galaxy}:{$ACSRow.system}:{$ACSRow.planet}]</span><br>
            <span style="color:#09F;">{$ACSRow.time_fleet|time} </span>        
         </div>
         <div class="rd_planet_resours">
            <div class="imper_block_td">
               <div class="occupancy occupancy_901" style="width:{$ACSRow.metal/$ACSRow.metal_max*100}%"></div>
               <div class="text_res tooltip" data-tooltip-content="<span class='p_res'>{$LNG.tech.901}</span> <span style='color:#999'>({$ACSRow.name} [{$ACSRow.galaxy}:{$ACSRow.system}:{$ACSRow.planet}])</span> <div style='border-bottom:1px dashed #666; margin:7px 0 4px 0;'></div> <span style='color:#999'>{$ACSRow.metal|number} / {$ACSRow.metal_max|number}</span>"><span>{$LNG.tech.901}:</span> {$ACSRow.metal|number}</div>
            </div>
            <div class="imper_block_td">
               <div class="occupancy occupancy_902" style="width:{$ACSRow.crystal/$ACSRow.crystal_max*100}%"></div>
               <div class="text_res tooltip" data-tooltip-content="<span class='p_res'>{$LNG.tech.902}</span> <span style='color:#999'>({$ACSRow.name} [{$ACSRow.galaxy}:{$ACSRow.system}:{$ACSRow.planet}])</span> <div style='border-bottom:1px dashed #666; margin:7px 0 4px 0;'></div> <span style='color:#999'>{$ACSRow.crystal|number} / {$ACSRow.crystal_max|number}</span>"> <span>{$LNG.tech.902}:</span> {$ACSRow.crystal|number}</div>
            </div>
            <div class="imper_block_td">
               <div class="occupancy occupancy_903" style="width:{$ACSRow.deuterium/$ACSRow.deuterium_max*100}%"></div>
               <div class="text_res tooltip" data-tooltip-content="<span class='p_res'>{$LNG.tech.903}</span> <span style='color:#999'>({$ACSRow.name} [{$ACSRow.galaxy}:{$ACSRow.system}:{$ACSRow.planet}])</span> <div style='border-bottom:1px dashed #666; margin:7px 0 4px 0;'></div> <span style='color:#999'>{$ACSRow.deuterium|number} / {$ACSRow.deuterium_max|number}</span>"><span>{$LNG.tech.903}:</span> {$ACSRow.deuterium|number}</div>
            </div>
         </div>
         {*
         <div class="rd_planet_status">
            {if $ACSRow.small_count != 0 }	{$LNG.tech.202}: {$ACSRow.small_count|number}<br />{/if}
            {if $ACSRow.big_count != 0 }	{$LNG.tech.203}: {$ACSRow.big_count|number}<br />{/if}
            {if $ACSRow.ev_count != 0 }		{$LNG.tech.217}: {$ACSRow.ev_count|number}{/if}
            {if $ACSRow.small_count + $ACSRow.big_count + $ACSRow.ev_count == 0 }
            <span style="color:#F00;">{$LNG.rd_not_nid_fleet}</span>
            {/if}
            {if $ACSRow.deuterium < $ACSRow.consumption_fleet && $ACSRow.consumption_fleet !=0}	
            <span style="color:#3C0;">{$LNG.rd_not_deiterium}</span>
            {/if}
            {if $ACSRow.sumcapacity < $ACSRow.consumption_fleet && $ACSRow.consumption_fleet !=0 && $ACSRow.sumcapacity !=0}	
            <span style="color:#FC0;">{$LNG.rd_not_conpustion}</span>
            {/if}                                                           
         </div>
         *}
         <div class="clear"></div>
      </div>
      {/foreach}
      <div class="clear"></div>
      <div class="build_band2 ticket_bottom_band" style="padding-left:20px;">    
         <input class="bottom_band_submit" type="submit" value="{$LNG.fl_continue}">
      </div>
      {else}
      <div class="ally_contents">{$LNG.rd_planet_no_fleet} </div>
      {/if}
</form>
</div>

{/block}