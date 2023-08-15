{block name="title" prepend}{$LNG.lm_technology}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/records.css">
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner">
         <div class="gray_stripe">
            <div style="float:left">{$LNG.lm_technology}:</div>
            <span class="record_btn ico_star record_btn_active" title="{$LNG.all}" onclick="allopen();"></span>
            <span class="record_btn ico_builds" title="{$LNG.tech.0}" onclick="buildsopen();"></span>
            <span class="record_btn ico_tech" title="{$LNG.tech.100}" onclick="techopen();"></span>
            <span class="record_btn ico_fleet" title="{$LNG.tech.200}" onclick="fleetopen();"></span>
            <span class="record_btn ico_shield" title="{$LNG.tech.400}" onclick="defopen();"></span>    
            <span class="record_btn ico_oficer" title="{$LNG.tech.600}" onclick="oficopen();"></span>  
         </div>
            {foreach $TechTreeList as $elementID => $requireList}
            <div {if in_array($elementID, $elementID1)}class="u0"
            {elseif in_array($elementID, $elementID2)}class="u100"
            {elseif in_array($elementID, $elementID3)}class="u200"
            {elseif in_array($elementID, $elementID4)}class="u400"
            {elseif in_array($elementID, $elementID5)}class="u600"
            {/if}>
            {if !is_array($requireList)}
            <div class="record_header">
               {$LNG.tech.$requireList}
               <div class="record_header_top_line"></div>
               <div class="record_header_bottom_line"></div>
               <div style="color:#999; font-weight:lighter; float:right; width:53%;">{$LNG.tt_requirements}</div>
            </div>
            {else}
            <div class="record_rows">
               <div class="record_img_utits">
                  <a href="#" onclick="return Dialog.info({$elementID})">
                  <img alt="" src="{$dpath}gebaeude/{$elementID}.gif">
                  </a>
               </div>
               <div class="record_name_utits">
                  <a href="#" onclick="return Dialog.info({$elementID})">{$LNG.tech.$elementID}</a></td>
               </div>
               <div class="required_blocks">
                  {if $requireList}
                  {foreach $requireList as $requireID => $NeedLevel}
                  <div class="required_block required_smal_text" style="top: 1px;">
                     <a href="#" onclick="return Dialog.info({$requireID})" class="tooltip" data-tooltip-content="<span style='color:{if $NeedLevel.own < $NeedLevel.count}red{else}lime{/if};'>{$LNG.tech.$requireID} ({$LNG.tt_lvl} {min($NeedLevel.count, $NeedLevel.own)}/{$NeedLevel.count})</span>">
                        <img src="{$dpath}gebaeude/{$requireID}.gif" alt="{$LNG.tech.$requireID}" />
                        <div class="text" style="color:{if $NeedLevel.own < $NeedLevel.count}red{else}lime{/if};">{$NeedLevel.count}</div>
                     </a>
                  </div>
                  {/foreach}
                  {/if}           
               </div>
            </div>
            {/if}
            </div>
            {/foreach}
      </div>
   </div>
   <div class="clear"></div>
</div>
{/block}