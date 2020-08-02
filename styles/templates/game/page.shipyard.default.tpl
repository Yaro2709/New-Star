{block name="title" prepend}{if $mode == "defense"}{$LNG.lm_defenses}{else}{$LNG.lm_shipshard}{/if}{/block}
{block name="content"}
<div id="page">
<div id="content">
   {if !$NotBuilding}
   <table width="70%" id="infobox" style="border: 2px solid red; text-align:center;background:transparent">
      <tr>
         <td>{$LNG.bd_building_shipyard}</td>
      </tr>
   </table>
   <br><br>{/if}
   {if !empty($BuildList)}
   <div id="ship_build_list">
      <div id="bx" class="z"></div>
      <form action="game.php?page=shipyard&amp;mode={$mode}" method="post">
         <input type="hidden" name="action" value="delete">
         <div class="multiple_ship">
            <select name="auftr[]" id="auftr" size="10" multiple>
               <option>&nbsp;</option>
            </select>
         </div>
         <input type="submit" class="btn_del" value="{$LNG.bd_cancel_send}">
         <span class="text_del">{$LNG.bd_cancel_warning}</span>
         <span id="timeleft"></span>
      </form>
   </div>
   {/if}
<form action="game.php?page=shipyard&amp;mode={$mode}" method="post">
<div id="build_content" class="conteiner ship_build">
    <div id="fildes_band">
    {if $mode == "defense"}
        <div class="gray_stripe">
            <div style="float:left">{$LNG.lm_defenses}</div>
            <span class="record_btn ico_star record_btn_active" onclick="rank();"></span>
            <span class="record_btn ico_rank_0" onclick="rank0();"></span>
            <span class="record_btn ico_rank_1" onclick="rank1();"></span>
            <span class="record_btn ico_rank_2" onclick="rank2();"></span>
            <span class="record_btn ico_rank_3" onclick="rank3();"></span>
        </div>
    {else}
        <div class="gray_stripe">
            <div style="float:left">{$LNG.lm_shipshard}</div>
            <span class="record_btn ico_star record_btn_active" onclick="rank();"></span>
            <span class="record_btn ico_rank_0" onclick="rank0();"></span>
            <span class="record_btn ico_rank_1" onclick="rank1();"></span>
            <span class="record_btn ico_rank_2" onclick="rank2();"></span>
            <span class="record_btn ico_rank_3" onclick="rank3();"></span>
        </div>
    {/if}
    </div>
    <div id="build_elements">
    {foreach $elementList as $ID => $Element}
        <div class="build_elements">
            <div id="s_{$ID}" class="build_box {if $mode == 'defense'}{if $ID == in_array($ID, $reslist.spec_defense.1)}rank0{elseif $ID == in_array($ID, $reslist.spec_defense.2)}rank1{elseif $ID == in_array($ID, $reslist.spec_defense.3)}rank2{elseif $ID == in_array($ID, $reslist.spec_defense.4)}rank3{/if}{else}{if $ID == in_array($ID, $reslist.spec_fleet.1)}rank0{elseif $ID == in_array($ID, $reslist.spec_fleet.2)}rank1{elseif $ID == in_array($ID, $reslist.spec_fleet.3)}rank2{elseif $ID == in_array($ID, $reslist.spec_fleet.4)}rank3{/if}{/if} {if !$Element.techacc}required{/if}">
                <div class="head">
                    <a href="#" onclick="return Dialog.info({$ID})" class="interrogation">?</a>                
                    <a href="#" onclick="return Dialog.info({$ID})" class="title">{$LNG.tech.{$ID}} </a> 
                    <span class="tooltip available" data-tooltip-content="{$LNG.bd_available}">
                    <span id="val_{$ID}">{if $Element.available != 0} ({$Element.available|number}){/if}</span>    
                </div>
                <div class="content_box">
                    <div class="image">
                        <a href="#" onclick="return Dialog.info({$ID})"><img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" /></a>
                    </div>
                    {if !$Element.techacc}
                    <div class="prices">
                    {foreach $Element.AllTech as $elementID => $requireList}
                        {foreach $requireList as $requireID => $NeedLevel}
                        <div class="required_block required_smal_text">
                            <a href="#" onclick="return Dialog.info({$requireID})" class="tooltip" data-tooltip-content="<span style='color:{if $NeedLevel.own < $NeedLevel.count}red{else}lime{/if};'>{$LNG.tech.$requireID} {$LNG.tt_lvl}  {$NeedLevel.count} ({$NeedLevel.own}/{$NeedLevel.count})</span>">
                            <img src="{$dpath}gebaeude/{$requireID}.gif" alt="{$LNG.tech.$requireID}" />
                            <div class="text" style="color:{if $NeedLevel.own < $NeedLevel.count}red{else}lime{/if};">{$NeedLevel.own}/{$NeedLevel.count}</div></a>            
                        </div>
                        {/foreach}
                    {/foreach}
                    </div>     
                    {else}
                    <div class="prices">
                        {foreach $Element.costResources as $RessID => $RessAmount}
                        <div class="price res{$RessID} {if $Element.costOverflow[$RessID] == 0}{else}required{/if}">
                            <div class="ico"></div>
                            <div class="text" data-tooltip-content="">{$RessAmount|number}</div>                                        
                        </div>
                        {/foreach}   
					</div>        
                    {/if}			
                    <div class="clear"></div>
                    <div class="time_build">
                    {if !$Element.techacc}{else}
                        {if $Element.elementTime >= 1} 
                        <span class="time_build_text">{$Element.elementTime|time}</span>
                        {else}
                        <span class="time_build_text">{$Element.elementTime|time}</span>
                        {$LNG.build_conv} <span>{round(1 / $Element.elementTime)} {$LNG.sec_conv}</span>
                        {/if} 
                    {/if}
                    </div>
                    {if $NotBuilding && $Element.buyable && $Element.techacc && $Element.maxBuildable}
                    <div class="btn_build_border">  
                        <input id="input_{$ID}" type="text" name="fmenge[{$ID}]" size="7" maxlength="30" value="0" class="text" tabindex="{$smarty.foreach.FleetList.iteration}" onkeyup="counting('{$ID}');">
                        <input class="input_btn" type="button" value="{$LNG.bd_max_ships}" onclick="$('#input_{$ID}').val('{$Element.maxBuildable}'); counting('{$ID}');">
                    </div>
                    {elseif !$Element.techacc}
                    {else}
                    <div class="btn_build_border">
                        <span class="btn_build red">{$LNG.bd_notres}</span>
                    </div>
                    {/if}
                </div>
            </div>              
        </div>   
    {/foreach} 			
	<div class="clear"></div>				
    </div>
</div>    
<div class="build_band" style="text-align:center;">
    <input type="submit" value="{$LNG.bd_build_ships}">       
</div>
</div>
</form>

<script src="scripts/base/bcmath.js"></script>
<script src="scripts/game/shipyard.js"></script>
<script type="text/javascript">
$(function() {
    ShipyardInit();
});
</script>
<script type="text/javascript">
data			= {$BuildList|json};
bd_operating	= '{$LNG.bd_operating}';
bd_available	= '{$LNG.bd_available}';

	
	
	DatatList		= {literal}{{/literal}
	{foreach $elementList as $ID => $Element}
	{literal}
	"{/literal}{$ID}{literal}":{"id":"{/literal}{$ID}{literal}","available":"{/literal}{$Element.available|number}{literal}","costResources":{{/literal}{foreach $Element.costResources as $RessID => $RessAmount}{literal}"{/literal}{$RessID}{literal}":{/literal}{$RessAmount}{literal},{/literal}{/foreach}{literal}},"elementTime":{/literal}{$Element.elementTime}{literal},"buyable":true,"maxBuildable":"{/literal}{$Element.maxBuildable}{literal}","AlreadyBuild":false,"AlreadyBuildOne":false},
	{/literal}
	{/foreach}
	
	{literal}};{/literal}
	
	
	MaxCount		= '{$max}';
	bd_operating	= '(busy)';
   	LNGning			= '{$LNG.bd_remaining}';
   	LNGtech901		= '{$LNG.tech.901}';
   	LNGtech902		= '{$LNG.tech.902}';
   	LNGtech903		= '{$LNG.tech.903}';
   	LNGtech911		= '{$LNG.tech.911}';
   	LNGtech921		= '{$LNG.tech.921}';
   	short_day 		= '{$LNG.short_day}';
   	short_hour 		= '{$LNG.short_hour}';
   	short_minute 	= '{$LNG.short_minute}';
   	short_second 	= '{$LNG.short_second}';
</script>
</div>
</div>
<div class="clear"></div>            
</div>
{/block}