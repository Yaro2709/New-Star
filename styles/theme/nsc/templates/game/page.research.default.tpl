{block name="title" prepend}{$LNG.lm_research}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/building.css">
<div id="page">
    <div id="content">
        {if !empty($Queue)}
        <div style="overflow-y:hidden;">
            <div id="buildlist" class="buildlist">
                <div class="buildtitle">
                    <div id="build_process" class="ric4era">
                    {foreach $Queue as $List}
                    {$ID = $List.element}
                        <div class="element_row {if $List@first}active_row{/if}" style="background:url({$dpath}gebaeude/{$ID}.gif)">
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
            {if $IsLabinBuild}
            <table width="100%" id="infobox" style="border: 2px solid red; text-align:center;background:transparent">
                <tr>
                    <td>{$LNG.bd_building_lab}</td>
                </tr>
            </table>
            <br><br>
            {/if}
            <div id="build_content" class="conteiner ship_build">
                <div id="fildes_band">
                    <div class="gray_stripe" style="height:0px; padding-right: 0; padding: 0;">
                        {*<a href="#" id="arrow_question" onclick="return Dialog.manualinfo(3)" class="interrogation manual">?</a>*}
                        {if isModuleAvailable($smarty.const.MODULE_ARSENAL)}
                        <a href="game.php?page=arsenal" class="palanetarium_linck ars tooltip" data-tooltip-content="{$LNG.lm_ars}"></a>
                        {/if}
                        <div style="float:left">{$LNG.lm_research}</div>
                        <span class="record_btn ico_star record_btn_active" onclick="tech();"></span>
                        <span class="record_btn ico_tech_1" onclick="tech1();"></span>
                        <span class="record_btn ico_tech_2" onclick="tech2();"></span>
                        <span class="record_btn ico_tech_3" onclick="tech3();"></span>
                        <span class="record_btn ico_tech_4" onclick="tech4();"></span>
                        {if isModuleAvailable($smarty.const.MODULE_BUY_TECH)}
                        <a href="game.php?page=buyTech" class="right_flank button" style="margin-left: 10px;">{$LNG.lm_buytech}</a>
                        {/if}
                    </div>
                </div>
                <div id="build_elements">
                    {foreach $ResearchList as $ID => $Element} 
                    <div class="build_elements">
                        <div id="research_{$ID}" class="build_box {if $ID == in_array($ID, $reslist.spec_tech.1)}tech1{elseif $ID == in_array($ID, $reslist.spec_tech.2)}tech2{elseif $ID == in_array($ID, $reslist.spec_tech.3)}tech3{elseif $ID == in_array($ID, $reslist.spec_tech.4)}tech4{/if} {if !$Element.techacc}required{/if}">
                            <div class="head">
                                <a href="#" onclick="return Dialog.info({$ID})" class="interrogation">?</a>                
                                <a href="#" onclick="return Dialog.info({$ID})" class="title">{$LNG.tech.{$ID}}</a> 
                                {if $Element.level != 0} ({$LNG.bd_lvl} {$Element.level}{if $Element.maxLevel != 255}/{$Element.maxLevel}{/if}){/if}
                            </div>
                            <div class="content_box">
                                <div class="image">
                                    <a href="#" onclick="return Dialog.info({$ID})"><img src="./{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" /></a>
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
                                        <div class="text " data-tooltip-content="">{$RessAmount|number}</div>
                                    </div>
                                    {/foreach}                   
                                </div>
                                {if !empty($Element.elementBonus)}
                                <div class="res_global_info">
                                    {foreach $Element.elementBonus as $BonusName => $Bonus}
                                    <div class="res_info info_res_901"><a class="tooltip" data-tooltip-content="
                                        <table class='reducefleet_table'>
                                            <tr>
                                                <td class='reducefleet_img_ship'><img src='{$dpath}gebaeude/bonus/{$BonusName}.gif'></td>
                                                <td class='reducefleet_name_ship'><span class='reducefleet_count_ship'>{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{abs($Bonus[0] * 100)}%{else}{floatval($Bonus[0])}{/if}</span> {$LNG.bonus.$BonusName}</td>
                                            </tr>
                                        </table>"><img height="15" width="15" src="{$dpath}gebaeude/bonus/{$BonusName}.gif"></a>
                                    </div>
                                    {/foreach}
                                </div>
                                {/if}
                                {/if}
                                <div class="clear"></div>
                                <div class="time_build">
                                    {if !$Element.techacc}{elseif $Element.elementTime == 0}{else}
                                    <span class="time_build_text"><img src="{$dpath}img/iconav/time.png" style="height: 12px; top: -1.4px;position: relative;"> <span class="time_build_edit">{$Element.elementTime|time}</span></span>
                                    {/if}              
                                </div>
                                {if !$Element.techacc}{elseif $Element.maxLevel == $Element.levelToBuild}
                                <div class="btn_build_border">
                                    <span class="btn_build red">{$LNG.bd_maxlevel}</span>
                                </div>
                                {elseif $IsLabinBuild || $IsFullQueue || !$Element.buyable}
                                <div class="btn_build_border">
                                    <span class="btn_build red">{if $Element.level == 0}{$LNG.bd_build_next_level}{else}{$LNG.bd_tech_next_level}{$Element.levelToBuild + 1}{/if}</span>
                                </div>
                                {else}
                                <div class="btn_build_border">
                                    <form class="build_form" method="post" action="game.php?page=research">
                                        <input type="hidden" value="insert" name="cmd"></input>
                                        <input type="hidden" value="{$ID}" name="tech"></input>
                                        <input type="hidden" value="{$Element.levelToBuild}" name="levelToBuildInFo"></input>	
                                        <input type="hidden" value="{$Element.level}" name="lvlup1"></input>
                                        <input id="b_input_{$ID}" class="build_number" type="number" value="{$Element.levelToBuild + 1}" min="{$Element.levelToBuild + 1}" maxlength="3" size="3" name="lvlup" onchange="counting('{$ID}');"></input>
                                        <button class="btn_build_part_left" type="submit">{$LNG.bd_build_next_level}</button>
                                    </form>
                                </div>
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
</div>
{/block}