{block name="title" prepend}{$LNG.lm_buildings}{/block}
{block name="content"} 
<link rel="stylesheet" type="text/css" href="{$dpath}css/building.css">
<div id="page">
    <div id="content">
        {if !empty($Queue)}
        <div style="overflow-y:hidden;">
            <div id="buildlist" class="buildlist">
                <div class="buildtitle">
                    <div id="build_process" class="bui4era">
                    {foreach $Queue as $List}
                    {$ID = $List.element}
                        <div class="element_row {if $List@first}active_row{/if}" style="background:url({$dpath}gebaeude/{$ID}.gif)">
                            <div class="right_hand">
                            {if $List@first}
                                <span class="onlistretit">{$LNG.tech.{$ID}}</span>
                                <form action="game.php?page=buildings" method="post" class="build_form">
                                    <input type="hidden" name="cmd" value="cancel">
                                    <button type="submit" class="del"></button>
                                </form>
                                <form action="game.php?page=buildings" method="post" class="build_form">
                                    <input type="hidden" name="queuetype" value="1">
                                    <input type="hidden" name="cmd" value="fast">
                                    <button type="submit" class="build_submit onlist tooltip" data-tooltip-content="{$LNG.cost} {if $need_dm<10}{10}{else}{pretty_number($need_dm)}{/if} {$LNG.tech.921}"  style="float: right; line-height: 43px;">
                                        <img src="{$dpath}img/iconav/up.png" alt="" width="16" height="16">
                                    </button>
                                </form>
                            {else}
                                <form action="game.php?page=buildings" method="post" class="build_form">
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
                            <div class="band_process" {if $List@first} id="progressbar" data-time="{$List.resttime}"{/if}></div>
                        </div>
                    {/foreach}
                        {if isModuleAvailable($smarty.const.MODULE_STORE)}
                        <div class="element_row">
                            <a href="game.php?page=store"><div class="pluscos">+</div></a>
                        </div>
                        {/if}
                    </div>
                </div>
            </div>
        {/if}	
            <div id="build_content" class="conteiner ship_build">
                <div id="fildes_band">
                    <div id="fildes_band_proc" style="width:{$field_percent}%;"></div>
                    <div class="gray_stripe" style="height:0px; padding-right: 0; padding: 0;">
                        {if isModuleAvailable($smarty.const.MODULE_PLANET)}
                        <a href="game.php?page=planet" class="palanetarium_linck seting2 tooltip" data-tooltip-content="{$LNG.lm_planet}"></a>
                        {/if}
                        <div style="float:left;">{$LNG.lm_buildings}</div>
                        <span class="record_btn ico_star record_btn_active" onclick="build();"></span>
                        <span class="record_btn ico_build_1" onclick="build1();"></span>
                        <span class="record_btn ico_build_2" onclick="build2();"></span>
                        <span class="record_btn ico_build_3" onclick="build3();"></span>
                        <span class="record_btn ico_build_4" onclick="build4();"></span>
                        {if isModuleAvailable($smarty.const.MODULE_BUY_BUILD)}
                        <a href="game.php?page=buyBuild" class="right_flank button" style="margin-left: 10px;">{$LNG.lm_buybuild}</a>
                        {/if}	
                    </div>
                    <div class="fildes_band_text">
                        {$LNG.bd_em_field} <span>{$field_used}</span> {$LNG.bd_of_field} <span>{$field_max}</span>
                        {$LNG.bd_free_field} <span>{$field_left}</span>
                    </div>
                </div>
                <div id="build_elements">
                    {foreach $BuildInfoList as $ID => $Element}
                    <div class="build_elements">
                        <div id="build_{$ID}" class="build_box {if $ID == in_array($ID, $reslist.spec_build.1)}build1{elseif $ID == in_array($ID, $reslist.spec_build.2)}build2{elseif $ID == in_array($ID, $reslist.spec_build.3)}build3{elseif $ID == in_array($ID, $reslist.spec_build.4)}build4{/if} {if !$Element.techacc}required{/if}">
                            <div class="head">
                                <a href="#" onclick="return Dialog.info({$ID})" class="interrogation">?</a>                
                                <a href="#" onclick="return Dialog.info({$ID})">{if $ID == in_array($ID, $reslist.decline_in_battle)}<span style="color:#cc6510">{$LNG.tech.{$ID}}</span>{else}{$LNG.tech.{$ID}}{/if}</a>
                                {if $Element.level > 0} ({$LNG.bd_lvl} {$Element.level}{if $Element.maxLevel != 255}/{$Element.maxLevel}{/if}){/if}
                            </div>
                            <div class="content_box">
                                <div class="image">
                                    <a href="#" onclick="return Dialog.info({$ID})"><img src="{$dpath}gebaeude/{$ID}.gif" alt="" /></a>
                                </div>
                                {if !$Element.techacc}
                                <div class="prices">
                                    <div class="necccos">{$LNG.bd_needed_tech}</div>
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
                                        <div class="text">{$RessAmount|number}</div>
                                    </div>
                                    {/foreach}    
                                </div>  
                                <div class="res_global_info">
                                {foreach $Element.ressources as $res}
                                    {if !empty($Element.{$res + $Element.class_production})}
                                    <div class="res_info info_res_{$res}"><a class="tooltip" data-tooltip-content="
                                        <table class='reducefleet_table'>
                                            <tr>
                                                <td class='reducefleet_img_ship'><img src='{$dpath}img/resources/{$res}f.png'></td>
                                                <td class='reducefleet_name_ship'>{$LNG.tech.{$res}} <span class='reducefleet_count_ship'>{$Element.{$res + $Element.class_production}|number}</span></td>
                                            </tr>
                                        </table>"><img height="15" width="15" src="{$dpath}img/resources/{$res}f.png"></a>
                                    </div>   
                                    {/if}
                                {/foreach}
                                {foreach $Element.storage as $res}
                                    {if !empty($Element.{$res + $Element.class_storage})}
                                    <div class="res_info info_res_{$res}"><a class="tooltip" data-tooltip-content="
                                        <table class='reducefleet_table'>
                                            <tr>
                                                <td class='reducefleet_img_ship'><img src='{$dpath}img/resources/{$res}f.png'></td>
                                                <td class='reducefleet_name_ship'>{$LNG.tech.{$res}} <span class='reducefleet_count_ship'>{$Element.{$res + $Element.class_storage}|number}</span></td>
                                            </tr>
                                        </table>"><img height="15" width="15" src="{$dpath}img/resources/{$res}f.png"></a>
                                    </div>   
                                    {/if}
                                {/foreach}
                                </div>               
                                {/if}
                                <div class="clear"></div>
                                <div class="time_build">
                                    {if !$Element.techacc}{elseif $Element.elementTime == 0}{else}
                                    <span class="time_build_text"><img src="{$dpath}img/iconav/time.png" style="height: 12px; top: -1.4px;position: relative;"> <span class="time_build_edit">{$Element.elementTime|time}</span></span>
                                    {/if}
                                </div>
                                {if $Element.level > 0 && (($ID == 44 && 0==$HaveMissiles) ||  $ID != 44)}
                                <div class="break_build tooltip_sticky" data-tooltip-content="
                                    <table class='tooltip_class_table'>
                                        <tbody>
                                            <tr>
                                                <th colspan='2'>
                                                    <span style='color:#00FF00'>{$LNG.bd_price_for_destroy}</span><br> {$LNG.tech.{$ID}} {$Element.level}
                                                </th>
                                            </tr>
                                            <tr>
                                                <td class='tooltip_class_td_img'>
                                                    <img src='{$dpath}gebaeude/{$ID}.gif' alt='{$LNG.tech.{$ID}}'>
                                                </td>
                                                <td class='tooltip_class_table_text_left'>
                                                    {foreach $Element.destroyResources as $ResType => $ResCount}
                                                    <span>{$LNG.tech.{$ResType}}</span> <span class='tooltip_class_{$ResType}'>{$ResCount|number}</span><br>
                                                    {/foreach}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan='2' class='tooltip_class_table_text_left'>
                                                    <form action='game.php?page=buildings' method='post' class='build_form'>
                                                    <input type='hidden' name='cmd' value='destroy'>
                                                    <input type='hidden' name='building' value='{$ID}'>
                                                    <button type='submit' class='build_submit onlist tooltip_class_a_bigbtn'>{$LNG.bd_dismantle}</button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>">x
                                </div>
                                {/if}
                                {if !$Element.techacc}{elseif $Element.maxLevel == $Element.levelToBuild}
                                <div class="btn_build_border">
                                    <span class="btn_build red">{$LNG.bd_maxlevel}</span>
                                </div>
                                {elseif ($isBusy.research && ($ID == in_array($ID, $reslist.lab))) || ($isBusy.shipyard && ($ID == in_array($ID, $reslist.shipyard)))}
                                <div class="btn_build_border">
                                    <span class="btn_build red">{$LNG.bd_working}</span>
                                </div>
                                {else}
                                {if $RoomIsOk}
                                {if $CanBuildElement && $Element.buyable}
                                <div class="btn_build_border">
                                    <form class="build_form" method="post" action="game.php?page=buildings">
                                        <input type="hidden" value="insert" name="cmd"></input>
                                        <input type="hidden" value="{$ID}" name="building"></input>
                                        <input type="hidden" value="{$Element.level}" name="lvlup1"></input>
                                        <input type="hidden" value="{$Element.levelToBuild}" name="levelToBuildInFo"></input>	
                                        <input id="b_input_{$ID}" class="build_number" type="number" value="{$Element.levelToBuild + 1}" min="{$Element.levelToBuild + 1}" maxlength="3" size="3" name="lvlup" onchange="counting('{$ID}');"></input>
                                        <button class="btn_build_part_left" type="submit">{$LNG.bd_build_next_level}</button>
                                    </form>
                                </div>
                                {else}
                                <div class="btn_build_border">
                                    <span class="btn_build red"> {if $Element.level == 0}{$LNG.bd_build_next_level}{else}{$LNG.bd_build_next_level}{$Element.levelToBuild + 1}{/if}</span>
                                </div>
                                {/if}
                                {else}
                                <div class="btn_build_border">
                                    <span class="btn_build red">{$LNG.bd_no_more_fields}</span>
                                </div>
                                {/if}
                                {/if}    
                            </div>
                        </div>
                    </div>
                    {/foreach}
                    <div class="clear"></div>
                </div>
            </div>
        </div>
    </div>
    <script async type="text/javascript">
    DatatList		= {literal}{{/literal}
   	{foreach $BuildInfoList as $ID => $Element}
   	{literal}
   
       "{/literal}{$ID}{literal}":{
       "level":"{/literal}{$Element.level}{literal}",
       "maxLevel":"{/literal}{$Element.maxLevel}{literal}",
       "factor":"{/literal}{$Element.factor}{literal}",
       "costResources":{{/literal}{foreach $Element.costResources as $RessID => $RessAmount}{literal}"{/literal}{$RessID}{literal}":{/literal}{$RessAmount}{literal},{/literal}{/foreach}{literal}},
       "costOverflow":{{/literal}{foreach $Element.costOverflow as $RessID => $RessAmount}{literal}"{/literal}{$RessID}{literal}":{/literal}{$RessAmount}{literal},{/literal}{/foreach}{literal}},
       "elementTime":{/literal}{$Element.elementTime}{literal},
       "destroyResources":{{/literal}{foreach $Element.destroyResources as $RessID => $RessAmount}{literal}"{/literal}{$RessID}{literal}":{/literal}{$RessAmount}{literal},{/literal}{/foreach}{literal}},
       "destroyTime":{/literal}{$Element.destroyTime}{literal},
       "buyable":true },
       {/literal}
       {/foreach}
       {literal}};{/literal}
   	
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
{/block}