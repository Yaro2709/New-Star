{block name="title" prepend}{$LNG.alm_reseach}{/block}
{block name="content"}
<div id="page">
   <div id="content">
      {if !empty($Queue)}
      <div style="overflow-y:hidden;">
         <div id="buildlist" class="buildlist">
            <div class="buildtitle">
               <div style=""; id="build_process">
                  {foreach $Queue as $List}
                  {$ID = $List.element}
                  <div class="element_row {if $List@first}active_row{/if}">
                     <div class="right_hand">
                        {if $List@first}
                        <form action="game.php?page=research" method="post" class="build_form">
                           <input type="hidden" name="cmd" value="cancel">
                           <button type="submit" class="del"></button>
                        </form>
                        <form action="game.php?page=research" method="post" class="build_form">
                           <input type="hidden" name="queuetype" value="1">
                           <input type="hidden" name="cmd" value="fast">
                           <button type="submit" class="build_submit onlist tooltip" data-tooltip-content="{$LNG.cost} {if $need_dm<10}{10}{else}{pretty_number($need_dm)}{/if} {$LNG.am}"  style="float: right; line-height: 18px; margin-right: 13px;">
                           <img src="{$dpath}img/general/up.png" alt="" width="16" height="16">
                           </button>
                        </form>
                        {else}
                        <form action="game.php?page=research" method="post" class="build_form">
                           <input type="hidden" name="cmd" value="remove">
                           <input type="hidden" name="listid" value="{$List@iteration}">
                           <button type="submit" class="del"></button>
                        </form>
                        {/if}
                        <div id="time" data-time="{$List.time}"></div>
                     </div>
                     <div class="band_process" {if $List@first} id="progressbar" data-time="{$List.resttime}"{/if}>          
                     <div class="left_part">
                        <span>{$List@iteration}. </span>
                        {$LNG.tech.{$ID}} {$List.level} {if $List.destroy}{$LNG.bd_dismantle}{/if}
                     </div>
                     <div class="right_part">
                        {$List.display}
                     </div>
                  </div>
               </div>
               {/foreach}
            </div>
         </div>
      </div>
      {/if}	
      {if $IsLabinBuild}
      <table width="100%" id="infobox" style="border: 2px solid red; text-align:center;background:transparent">
         <tr>
            <td>{$LNG.bd_building_lab}</td>
         </tr>
      </table>
      <br><br>{/if}
      <div id="build_content" class="conteiner">
         <div id="fildes_band">
	<a class="bd_dm_buy" href="game.php?page=dmtech">{$LNG.DM_buy}</a>
         </div>
         <div id="build_elements">
            {foreach $ResearchList as $ID => $Element}   
            <div id="research_{$ID}" class="build_box {if !$Element.techacc}required{/if}">
               <div class="head">
                  <a href="#" onclick="return Dialog.info({$ID})" class="interrogation">?</a>                
                  <a href="#" onclick="return Dialog.info({$ID})" class="title">
                  {$LNG.tech.{$ID}}                 </a> {if $Element.level != 0} ({$LNG.bd_lvl} {$Element.level}{if $Element.maxLevel != 255}/{$Element.maxLevel}{/if}){/if}
               </div>
               <div class="content_box">
                  <div class="image">
                     <a href="#" onclick="return Dialog.info({$ID})"><img src="./{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" /></a>
                  </div>
                  {if !$Element.techacc}
                  <div class="prices">
                     <div class="price"> {$LNG.NFTC}
                     </div>
                     {foreach from=$Element.AllTech item=i key=k}
                     <div class="required_block  required_smal_text">
                        <a href="#" onclick="return Dialog.info({$i.requireID})" class="tooltip" data-tooltip-content="{$LNG.tech.{$i.requireID}} {$LNG.ach_lvl} {$i.rlevel}/{$i.requireLevel} ">
                           <img src="{$dpath}gebaeude/{$i.requireID}.{if $i.requireID >=600 && $i.requireID <= 699}jpg{else}gif{/if}" alt="{$LNG.tech.{$i.requireID}}">
                           <div class="text" style="{if $i.rlevel < $i.requireLevel}color:red; {else} color:green; {/if}"> {$i.rlevel}/{$i.requireLevel}</div>
                        </a>
                     </div>
                     {/foreach}
                  </div>
                  {else}	
                  <div class="prices">
                     {foreach $Element.costResources as $RessID => $RessAmount}
                     <div class="price res{$RessID} {if $Element.costOverflow[$RessID] == 0}{else}required{/if}">
                        <div class="ico"></div>
                        <div class="text " data-tooltip-content="">{$RessAmount|number}</div>
                     </div>
                     {/foreach}
                     <br>                       
                  </div>
                  {/if}
                  <div class="clear"></div>
                  <div class="time_build">
                     {if !$Element.techacc}{elseif $Element.elementTime == 0}{else}
                     {$LNG.fgf_time} <span class="time_build_text">{$Element.elementTime|time} </span> 
                     {/if}              
                  </div>
                  {if !$Element.techacc}{elseif $Element.maxLevel == $Element.levelToBuild}
                  <div class="btn_build_border">
                     <span class="btn_build red">{$LNG.bd_maxlevel}</span>
                  </div>
                  {elseif $IsLabinBuild || $IsFullQueue || !$Element.buyable}
                  <div class="btn_build_border">
                     <span class="btn_build red">{if $Element.level == 0}{$LNG.bd_tech}{else}{$LNG.bd_tech_next_level}{$Element.levelToBuild + 1}{/if}</span>
                  </div>
                  {else}
                  <div class="btn_build_border">
                     <form class="build_form" method="post" action="game.php?page=research">
                        <input type="hidden" value="insert" name="cmd"></input>
                        <input type="hidden" value="{$ID}" name="tech"></input>
                        <input type="hidden" value="{$Element.level}" name="lvlup1"></input>
                        <input id="b_input_{$ID}" class="build_number" type="number" value="{$Element.levelToBuild + 1}" min="{$Element.levelToBuild + 1}" maxlength="3" size="3" name="lvlup" onchange="counting('{$ID}');"></input>
                        <button class="btn_build_part_left" type="submit">
                        {$LNG.BTNL}
                        </button>
                     </form>
                  </div>
                  {/if}
               </div>
            </div>
            {/foreach}  
         </div>
         <!--/build-->
      </div>
   </div>
   <div class="clear"></div>
</div>
<script type="text/javascript">
DatatList		= {literal}{{/literal}
{foreach $ResearchList as $ID => $Element}
{literal}
"{/literal}{$ID}{literal}":{"id":"{/literal}{$ID}{literal}",
"elvl":"0",
"level":"{/literal}{$Element.level}{literal}",
"maxLevel":"{/literal}{$Element.maxLevel}{literal}",
"factor":"{/literal}{$Element.factor}{literal}",
"costResources":{{/literal}{foreach $Element.costResources as $RessID => $RessAmount}{literal}"{/literal}{$RessID}{literal}":{/literal}{$RessAmount}{literal},{/literal}{/foreach}{literal}},
"costOverflow":{{/literal}{foreach $Element.costOverflow as $RessID => $RessAmount}{literal}"{/literal}{$RessID}{literal}":{/literal}{$RessAmount}{literal},{/literal}{/foreach}{literal}},
"elementTime":{/literal}{$Element.elementTime}{literal},
"buyable":true},
{/literal}
{/foreach}
{literal}};{/literal}
    bd_operating	= '(busy)'; 
    LNGning			= '{$LNG.not_enough}';
    LNGtech901		= '{$LNG.met}';
    LNGtech902		= '{$LNG.cry}';
    LNGtech903		= '{$LNG.det}';
    LNGtech911		= '{$LNG.energ}';
    LNGtech921		= '{$LNG.dm}';
    LNGtech922		= '{$LNG.am}';
    short_day 		= '{$LNG.short_day}';
    short_hour 		= '{$LNG.short_hour}';
	short_minute 	= '{$LNG.short_minute}';
	short_second 	= '{$LNG.short_second}';
	
</script>
{/block}