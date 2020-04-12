{block name="title" prepend}{$LNG.lm_research}{/block}
{block name="content"}
<div id="page">
   <div id="content">
      {if !empty($Queue)}
      <div style="overflow-y:hidden;">
         <div id="buildlist" class="buildlist">
            <div class="buildtitle">
                <div id="build_process" class="ric4era">
                  {foreach $Queue as $List}
                  {$ID = $List.element}
                   <div class="element_row {if $List@first}active_row{/if}" style="background:url(./styles/theme/gow/gebaeude/{$ID}.gif)">
                     <div class="right_hand">
                        {if $List@first}
                        <span class="onlistretit">{$LNG.tech.{$ID}}</span>
                        <form action="game.php?page=research" method="post" class="build_form">
                           <input type="hidden" name="cmd" value="cancel">
                           <button type="submit" class="del"></button>
                        </form>
                        <form action="game.php?page=research" method="post" class="build_form">
                           <input type="hidden" name="queuetype" value="1">
                           <input type="hidden" name="cmd" value="fast">
                           <button type="submit" class="build_submit onlist tooltip" data-tooltip-content="{$LNG.cost} {if $need_dm<10}{10}{else}{pretty_number($need_dm)}{/if} {$LNG.tech.921}"  style="float: right; line-height: 43px;">
                           <img src="{$dpath}img/iconav/up.png" alt="" width="16" height="16">
                           </button>
                        </form>
                        {else}
                        <form action="game.php?page=research" method="post" class="build_form">
                           <input type="hidden" name="cmd" value="remove">
                           <input type="hidden" name="listid" value="{$List@iteration}">
                           <button type="submit" class="del"></button>
                        </form>
                        {/if}
                        {if $List@first}
                        <div id="time" data-time="{$List.time}"></div>
                        <span class="data_scad">{$List.display}</span>
                        {/if}
                        <span class="onlistrenum">{$List@iteration}</span>
                        <span class="onlistremov ">{$List.level}</span>
                     </div>
                     <div class="band_process" {if $List@first} id="progressbar" data-time="{$List.resttime}"{/if}>          
                  </div>
               </div>
               {/foreach}
               <div class="element_row">
                    <a href="game.php?page=premium"><div class="pluscos">+</div></a>
                </div>
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
                  {foreach $Element.AllTech as $elementID => $requireList}
                    {foreach $requireList as $requireID => $NeedLevel}
                    <div class="required_block required_smal_text">
                        <a href="#" onclick="return Dialog.info({$requireID})" class="tooltip" data-tooltip-content="<span style='color:{if $NeedLevel.own < $NeedLevel.count}red{else}lime{/if};'>{$LNG.tech.$requireID} {$LNG.tt_lvl}  {$NeedLevel.count} ({$NeedLevel.own}/{$NeedLevel.count})</span>">
                        <img src="{$dpath}gebaeude/{$requireID}.{if $requireID >=600 && $requireID <= 699}jpg{else}gif{/if}" alt="{$LNG.tech.$requireID}" />
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
                        <div class="text " data-tooltip-content="">{$RessAmount|number}</div>
                     </div>
                     {/foreach}
                     <br>                       
                  </div>
                  {/if}
                  <div class="clear"></div>
                  <div class="time_build">
                     {if !$Element.techacc}{elseif $Element.elementTime == 0}{else}
                     <span class="time_build_text">{$Element.elementTime|time} </span> 
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
                        {$LNG.bd_research}
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
DatatList		= {
	{foreach $ResearchList as $ID => $Element}
	"{$ID}":{ "id":"{$ID}","elvl":"0 ","level":"{$Element.level}","maxLevel":"{$Element.maxLevel}","factor":"{$Element.factor}","costRessources":{ {foreach $Element.costResources as $RessID => $RessAmount}"{$RessID}":{$RessAmount}{if !$RessAmount@last},{/if}{/foreach} },"costOverflow":{ {foreach $Element.costOverflow as $RessID => $RessAmount}"{$RessID}":{$RessAmount}{if !$RessAmount@last},{/if}{/foreach} },"elementTime":{$Element.elementTime},"buyable":true }{if !$Element@last},{/if}
	{/foreach}
	
	};
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
{/block}