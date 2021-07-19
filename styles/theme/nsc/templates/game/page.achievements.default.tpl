{block name="title" prepend}{$LNG.lm_achievements}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/building.css">
<div id="page">
    <div id="content">
    {if $achievementsList}
        <div id="ally_content" class="conteiner" style="width: 100%;">
            <div class="gray_stripe">
                {$LNG.lm_achievements}              
            </div>
            <div id="build_elements" class="ars_elements gov2">
                {foreach $achievementsList as $ID => $Element}
                <div id="ofic_{$ID}" class="build_box">
                    <div class="head">               
                        <a href="#" onclick="return Dialog.info({$ID})">{$LNG.tech.{$ID}}</a> 
                        <font class="gov6">({$LNG.bd_lvl} {$Element.level}/{$Element.maxLevel})</font>
                    </div>
                    <div class="content_box">
                        <div class="image_mini">
                            <a href="#" onclick="return Dialog.info({$ID})"><img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" /></a>
                        </div>
                        <div class="prices_mini">
                            {foreach $Element.AllTech as $elementID => $requireList}
                                {foreach $requireList as $requireID => $NeedLevel}
                                    <font color="{if $NeedLevel.own < $NeedLevel.count}#808080{else}#096{/if}">
                                        {$LNG.tech.$requireID} {$NeedLevel.count|number}<br>
                                    </font>
                                {/foreach}
                            {/foreach}
                            <span class="achievement4 tooltip" data-tooltip-content="
                            <span style='color:#3CF; font-weight:bold;'>{$LNG.ach_remaining}</span> <br>
                            {foreach $Element.AllTech as $elementID => $requireList}
                                {foreach $requireList as $requireID => $NeedLevel}
                                    {if $NeedLevel.own < $NeedLevel.count}{$LNG.tech.$requireID} {($NeedLevel.count - $NeedLevel.own)|number}<br>{/if}
                                {/foreach}
                            {/foreach}
                            <br><span style='color:#F90; font-weight:bold;'>{$LNG.ach_next_upg}</span><br>
                            {foreach $Element.elementBonus as $BonusName => $Bonus}{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{abs($Bonus[0] * 100)}%{else}{floatval($Bonus[0])}{/if} {$LNG.bonus.$BonusName}<br>{/foreach}
                            ">?</span>
                        </div>
                    </div>
                </div>
                {/foreach}
                <div class="clear"></div>
            </div>
        </div>
    {/if}
    </div>
</div>
{/block}