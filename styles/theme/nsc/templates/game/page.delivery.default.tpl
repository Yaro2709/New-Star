{block name="title" prepend}{$LNG.lm_delivery}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/reduce.css">
<div id="page">
<div id="content">

<script type="text/javascript" src="./scripts/game/delivery.js"></script>
<div id="ally_content" class="conteiner">
   <form action="game.php?page=delivery&amp;mode=delivery" method="post" id="form" onSubmit="return CheckArg();">
      <div class="gray_stripe">
         {$LNG.rd_select_palet_res}
                  <span class="tornaindietro">
         <span class="all_true" style="color:#6C9; cursor:pointer;" onclick="planet_select_all();">{$LNG.rd_select_all}</span> |
         <span class="all_false" style="color:#F96; cursor:pointer;" onclick="planet_reset_all();">{$LNG.rd_reset_all}</span>
         </span>
      </div>
    <div class="delivress6">
    {*<div class="delivress9 tooltip" data-tooltip-content="Доступно"> 4543</div>*}
        <div class="delivress7"></div> 
            <input name="r901" id="r901" value="0" class="colore901 delivress2" style="background-image:url({$dpath}img/resources/901f.png)" data-cip-id="r901">
            <input name="r902" id="r902" value="0" class="colore902 delivress3" style="background-image:url({$dpath}img/resources/902f.png)" data-cip-id="r902">
			<input name="r903" id="r903" value="0" class="colore903 delivress4" style="background-image:url({$dpath}img/resources/903f.png)" data-cip-id="r903">
		
            <div class="delivress8">
                <label for="r901" class="colore901"><img src="{$dpath}img/resources/901f.png">{$LNG.tech.901}</label>
                <span id="s901" class="colore901" style="color: rgb(164, 125, 122);">0</span>
            </div>			
            <div class="delivress10">
                <label for="r902" class="colore902"><img src="{$dpath}img/resources/902f.png">{$LNG.tech.902}</label>
                <span id="s902" class="colore902" style="color: rgb(92, 166, 170);">0</span>
            </div>     
            <div class="delivress11">
                <label for="r903" class="colore903"><img src="{$dpath}img/resources/903f.png">{$LNG.tech.903}</label>
                <span id="s903" class="colore903" style="color: rgb(51, 153, 102);">0</span>
             </div>				
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
      <div class="build_band2 ticket_bottom_band" style="padding-left:20px;">    
         <span style="font-weight:bold;">{$LNG.rd_sell}</span>
         <span id="cost" style="font-weight: bold; margin-left: 5px; color: rgb(118, 196, 0);">0</span>
         <span>{$LNG.tech.922}</span>
         <input class="bottom_band_submit" value="{$LNG.fl_continue}" onclick="delivery_send();" type="submit">    
      </div>
      {else}
      <div class="clear"></div>
      <div class="build_band2 ticket_bottom_band" style="padding-left:20px;">    
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