{block name="title" prepend}{$LNG.lm_delivery}{/block}
{block name="content"}
<div id="page">
<div id="content">

<script type="text/javascript" src="./scripts/game/delivery.js"></script>
<div id="ally_content" class="conteiner">
   <form action="game.php?page=delivery&amp;mode=delivery" method="post" id="form" onSubmit="return CheckArg();">
      <div class="gray_stripe">
         {$LNG.rd_select_palet_res}
      </div>
      <table class="tablesorter ally_ranks">
         <tbody>
            <tr>
               <td>
                  <label for="r901">{$LNG.tech.901}</label> <input name="r901" id="r901" value="0">
               </td>
               <td>
                  <label for="r902">{$LNG.tech.902}</label> <input name="r902" id="r902" value="0">
               </td>
               <td>
                  <label for="r903">{$LNG.tech.903}</label> <input name="r903" id="r903" value="0">
               </td>
            </tr>
            <tr>
               <td>
                  <span style="color: rgb(164, 125, 122);" id="s901">0</span>
               </td>
               <td>
                  <span style="color: rgb(92, 166, 170);" id="s902">0</span>
               </td>
               <td>
                  <span style="color: rgb(51, 153, 102);" id="s903">0</span>
               </td>
            </tr>
         </tbody>
      </table>
      <div class="gray_stripe">
         <span style="float:right;">
         <span class="all_true" style="color:#6C9; cursor:pointer;" onclick="planet_select_all();">{$LNG.rd_select_all}</span> |
         <span class="all_false" style="color:#F96; cursor:pointer;" onclick="planet_reset_all();">{$LNG.rd_reset_all}</span>
         </span>
      </div>
      {if $ACSList}
      {foreach $ACSList as $ACSRow}		
      <div id="prow_{$ACSRow.id}" class="rd_planet_row td_planet_delivery rd_planet_row_select" onclick="planet_select({$ACSRow.id});">
         <input class="rd_checkbox" id="p{$ACSRow.id}" name="palanets[]" value="{$ACSRow.id}" type="checkbox">                
         <div class="rd_planet_img">
            <img title="{$ACSRow.name} [{$ACSRow.galaxy}:{$ACSRow.system}:{$ACSRow.planet}]" src="{$dpath}planeten/small/s_{$ACSRow.image}.jpg" alt="">
         </div>
         <div class="rd_planet_data_name">
            <span style="color:#CC6;">{$ACSRow.name}</span><br>            
            <span style="color:#CCC;">[{$ACSRow.galaxy}:{$ACSRow.system}:{$ACSRow.planet}]</span><br>
            <span style="color:#09F;">{$ACSRow.time_fleet|time}</span>    
         </div>
         <div class="rd_planet_resours">
            <div class="imper_block_td">
               <div class="occupancy occupancy_901" style="width:{$ACSRow.metal/$ACSRow.metal_max*100}%"></div>
               <div class="text_res tooltip" data-tooltip-content="<span class='p_res'>{$LNG.tech.901}:</span> <span style='color:#999'>({$ACSRow.name} [{$ACSRow.galaxy}:{$ACSRow.system}:{$ACSRow.planet}])</span> <div style='border-bottom:1px dashed #666; margin:7px 0 4px 0;'></div> <span style='color:#999'>{$ACSRow.metal|number} / {$ACSRow.metal_max|number}</span>"><span> {$LNG.tech.901}:</span> {$ACSRow.metal|number}</div>
            </div>
            <div class="imper_block_td">
               <div class="occupancy occupancy_902" style="width:{$ACSRow.crystal/$ACSRow.crystal_max*100}%"></div>
               <div class="text_res tooltip" data-tooltip-content="<span class='p_res'>{$LNG.tech.902}:</span> <span style='color:#999'>({$ACSRow.name} [{$ACSRow.galaxy}:{$ACSRow.system}:{$ACSRow.planet}])</span> <div style='border-bottom:1px dashed #666; margin:7px 0 4px 0;'></div> <span style='color:#999'>{$ACSRow.crystal|number} / {$ACSRow.crystal_max|number}</span>"> <span> {$LNG.tech.902}:</span> {$ACSRow.crystal|number}</div>
            </div>
            <div class="imper_block_td">
               <div class="occupancy occupancy_903" style="width:{$ACSRow.deuterium/$ACSRow.deuterium_max*100}%"></div>
               <div class="text_res tooltip" data-tooltip-content="<span class='p_res'>{$LNG.tech.903}:</span> <span style='color:#999'>({$ACSRow.name} [{$ACSRow.galaxy}:{$ACSRow.system}:{$ACSRow.planet}])</span> <div style='border-bottom:1px dashed #666; margin:7px 0 4px 0;'></div> <span style='color:#999'>{$ACSRow.deuterium|number} / {$ACSRow.deuterium_max|number}</span>"><span> {$LNG.tech.903}:</span> {$ACSRow.deuterium|number}</div>
            </div>
         </div>
      </div>
      {/foreach}
      <div class="clear"></div>
      <div class="build_band ticket_bottom_band" style="padding-left:20px;">    
         <span style="font-weight:bold;">{$LNG.rd_sell}</span>
         <span id="cost" style="font-weight: bold; margin-left: 5px; color: rgb(118, 196, 0);">0</span>
         <span>{$LNG.tech.922}</span>
         <input class="bottom_band_submit" value="{$LNG.fl_continue}" onclick="delivery_send();" type="submit">    
      </div>
      {else}
      <div class="clear"></div>
      <div class="build_band ticket_bottom_band" style="padding-left:20px;">    
         <span style="font-weight:bold;">{$LNG.rd_sell}</span>
         <span id="cost" style="font-weight: bold; margin-left: 5px; color: rgb(118, 196, 0);">0</span>
         <span>{$LNG.tech.922}</span>
         <input class="bottom_band_submit" value="{$LNG.fl_continue}" onclick="delivery_send();" type="reset">    
      </div>
      {/if}
   </form>
</div>
<script type="text/javascript">
   var MaxPlanet 	= {$countPL};
   var CostOne 	= {$CostOne};
</script>
<div class="clear"></div>
	
{/block}