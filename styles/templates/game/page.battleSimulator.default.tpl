{block name="title" prepend}{$LNG.lm_battlesim}{/block}
{block name="content"}
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner">
         <form id="form" name="battlesim">
            <input type="hidden" name="slots" id="slots" value="{$Slots + 1}">
            <div class="gray_flettab" style="padding-right:0;">
               {$LNG.lm_battlesim}
            </div>
            <div class="fleettab9" style="margin-bottom:0;"></div>
            <div class="battlesim_ress">
               <span>{$LNG.bs_steal} </span>
               <input type="text" size="10" value="{if isset($battleinput.0.1.901)}{$battleinput.0.1.901}{else}0{/if}" name="battleinput[0][1][901]" 
               class="colore901 rexx24 tooltip" data-tooltip-content="{$LNG.tech.901}" style="background-image:url({$dpath}img/resources/901f.png)"> 
               <input type="text" size="10" value="{if isset($battleinput.0.1.902)}{$battleinput.0.1.902}{else}0{/if}" name="battleinput[0][1][902]"
               class="colore902 rexx24 tooltip" data-tooltip-content="{$LNG.tech.902}" style="background-image:url({$dpath}img/resources/902f.png)">  
               <input type="text" size="10" value="{if isset($battleinput.0.1.903)}{$battleinput.0.1.903}{else}0{/if}" name="battleinput[0][1][903]"
               class="colore903 rexx24 tooltip" data-tooltip-content="{$LNG.tech.903}" style="background-image:url({$dpath}img/resources/903f.png)">
            </div>
            <div id="tabs">
               <ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
                  {section name=tab start=0 loop=$Slots}
                  <li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active"><a href="#tabs-{$smarty.section.tab.index}">{$LNG.bs_acs_slot} {$smarty.section.tab.index + 1}</a></li>
                  {/section}
                  <input type="button" class="rexx25 tooltip" data-tooltip-content="{$LNG.bs_wait}" onclick="return add();" value="+">
               </ul>
            <div class="clear"></div>
               {section name=content start=0 loop=$Slots}
               <div id="tabs-{$smarty.section.content.index}" class="ui-tabs-panel ui-widget-content ui-corner-bottom">
                <div class="rexx14" style="padding-bottom: 14px;"> 
                    <div class="rexx19">
                        <span class="rexx21">{$LNG.bs_techno}</span>
                        <span class="rexx20">{$LNG.bs_reset}</span>
                        <span class="rexx20">{$LNG.bs_reset}</span>
                    </div>
                    <div class="rexx16">
                        <img src="{$dpath}gebaeude/109.gif" alt="{$LNG.tech.109}">
                        <span>{$LNG.tech.109}</span>
                        <input type="text" size="10" value="{if isset($battleinput.{$smarty.section.content.index}.1.109)}{$battleinput.{$smarty.section.content.index}.1.109}{else}0{/if}" name="battleinput[{$smarty.section.content.index}][1][109]" class="rexx18" name="battleinput[{$smarty.section.content.index}][1][109]">
                        <input type="text" size="10" value="{if isset($battleinput.{$smarty.section.content.index}.0.109)}{$battleinput.{$smarty.section.content.index}.0.109}{else}0{/if}" name="battleinput[{$smarty.section.content.index}][0][109]" class="rexx17" name="battleinput[{$smarty.section.content.index}][0][109]">
                    </div>
                    <div class="rexx16">
                        <img src="{$dpath}gebaeude/110.gif" alt="{$LNG.tech.110}">
                        <span>{$LNG.tech.110}</span>
                        <input type="text" size="10" value="{if isset($battleinput.{$smarty.section.content.index}.1.110)}{$battleinput.{$smarty.section.content.index}.1.110}{else}0{/if}" name="battleinput[{$smarty.section.content.index}][1][110]" class="rexx18" name="battleinput[{$smarty.section.content.index}][1][110]">
                        <input type="text" size="10" value="{if isset($battleinput.{$smarty.section.content.index}.0.110)}{$battleinput.{$smarty.section.content.index}.0.110}{else}0{/if}" name="battleinput[{$smarty.section.content.index}][0][110]" class="rexx17" name="battleinput[{$smarty.section.content.index}][0][110]">
                    </div>
                    <div class="rexx16">
                        <img src="{$dpath}gebaeude/111.gif" alt="{$LNG.tech.111}">
                        <span>{$LNG.tech.111}</span>
                        <input type="text" size="10" value="{if isset($battleinput.{$smarty.section.content.index}.1.111)}{$battleinput.{$smarty.section.content.index}.1.111}{else}0{/if}" name="battleinput[{$smarty.section.content.index}][1][111]" class="rexx18" name="battleinput[{$smarty.section.content.index}][1][111]">
                        <input type="text" size="10" value="{if isset($battleinput.{$smarty.section.content.index}.0.111)}{$battleinput.{$smarty.section.content.index}.0.111}{else}0{/if}" name="battleinput[{$smarty.section.content.index}][0][111]" class="rexx17" name="battleinput[{$smarty.section.content.index}][0][111]">
                    </div>
                </div>
                <div class="rexx14">
                    <div class="rexx19">
                        <span class="rexx21">{$LNG.tech.600}</span>
                        <span class="rexx20">{$LNG.bs_reset}</span>
                        <span class="rexx20">{$LNG.bs_reset}</span>
                    </div>

                    <div class="rexx16">
                        <img src="{$dpath}gebaeude/602.jpg" alt="{$LNG.tech.602}">
                        <span>{$LNG.tech.602}</span>
                        <input type="text" size="10" value="{if isset($battleinput.{$smarty.section.content.index}.1.602)}{$battleinput.{$smarty.section.content.index}.1.602}{else}0{/if}" name="battleinput[{$smarty.section.content.index}][1][602]" class="rexx18" name="battleinput[{$smarty.section.content.index}][1][602]">
                        <input type="text" size="10" value="{if isset($battleinput.{$smarty.section.content.index}.0.602)}{$battleinput.{$smarty.section.content.index}.0.602}{else}0{/if}" name="battleinput[{$smarty.section.content.index}][0][602]" class="rexx17" name="battleinput[{$smarty.section.content.index}][0][602]">
                    </div>
                    {*<div class="rexx16 battlesim_skils_hiden">
                        <img src="./battleSimulator_files/#.jpg" alt="lngtext">
                        <span>lngtext</span>
                        <input type="text" size="10" value="0" class="rexx18" name="battleinput[0][1][#]">
                        <input type="text" size="10" value="0" class="rexx17" name="battleinput[0][0][#]">
                    </div>
                    <span class="rexx22 tooltip" data-tooltip-content="Еще" onclick="$(&#39;.battlesim_skils_hiden&#39;).toggle();">• • •</span>*}
                </div>
                <div class="clear"></div>
                  <div class="clear"></div>
                  <div class="rexx15">
                  <div class="rexx19">
                    <span class="rexx21">{$LNG.tech.200}</span>
                    <span class="rexx20">{$LNG.bs_reset}</span>
                    <span class="rexx20">{$LNG.bs_reset}</span>
                  </div>
                     {foreach $fleetList as $id}
                     <div class="rexx16">
                        <a href="#" onclick="return Dialog.info({$id})"><img src="{$dpath}gebaeude/{$id}.gif" alt="{$LNG.tech.$id}" /></a>
                        <span>{$LNG.tech.$id}</span>
                        <input class="fleetAttCountBS rexx18" type="text" size="10" value="{if isset($battleinput.{$smarty.section.content.index}.1.$id)}{$battleinput.{$smarty.section.content.index}.1.$id}{else}0{/if}" name="battleinput[{$smarty.section.content.index}][1][{$id}]">
                        <input class="fleetDefCountBS rexx17" type="text" size="10" value="{if isset($battleinput.{$smarty.section.content.index}.0.$id)}{$battleinput.{$smarty.section.content.index}.0.$id}{else}0{/if}" name="battleinput[{$smarty.section.content.index}][0][{$id}]">
                    </div>
                     {/foreach} 
                  </div>
                  {if $smarty.section.content.index == 0}											
                    <div class="rexx15">
                    <div class="rexx19">
                        <span class="rexx21">{$LNG.tech.400}</span>
                        <span class="rexx20">{$LNG.bs_reset}</span>
                    </div>
                     {foreach $defensiveList as $id}
                     <div class="rexx16">
                        <a href="#" onclick="return Dialog.info({$id})"><img src="{$dpath}gebaeude/{$id}.gif" alt="{$LNG.tech.$id}" /></a>
                        <span>{$LNG.tech.$id}</span>
                        <input class="fleetDefCountBS rexx18" type="text" size="10" value="{if isset($battleinput.{$smarty.section.content.index}.1.$id)}{$battleinput.{$smarty.section.content.index}.1.$id}{else}0{/if}" name="battleinput[{$smarty.section.content.index}][1][{$id}]">
                    </div>
                     {/foreach}    
                    </div>
                  {/if}
                  <div class="clear"></div>
               </div>
               {/section}
            </div>
            <div class="alleanza57" style="margin-top: 5px;"></div>
            <div class="fleettab1" style="height: 47px;"> 
            <div id="submit" class="fl_bigbtn_go" onclick="return check();" style="line-height: 29px;">{$LNG.bs_send}</div>
            <div id="wait" style="display:none;">
               {$LNG.bs_wait}
            </div>
            </div>
         </form>
      </div>
   </div>
</div>
<div class="clear"></div>
</div>
{/block}