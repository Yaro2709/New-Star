{block name="title" prepend}{$LNG.lm_race}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/building.css">
<div id="page">
    <div id="content">
    {if $RaceList}
        <div id="ally_content" class="conteiner">
            <div class="gray_flettab" style="padding-right:0;color:#6ccdce;">
                <strong>{$LNG.tech.{$name}}</strong>  
                <a href="game.php?page=overview" class="tornaindietroa">{$LNG.lm_overview}</a> 
            </div>
            <div id="build_elements" class="race_elements">
                {foreach $RaceList as $ID => $Element}
                <div id="ofic_{$ID}" class="build_box">
                    <div class="head">              
                        <a style="color:#6ccdce;"><strong>{$LNG.tech.{$ID}}</strong></a>
                    </div>
                    <div class="content_box">
                        <img style="float:right;margin-bottom:5px" src="{$dpath}gebaeude/race/{$ID}.png" />
                        <div class="prices_mini" style="margin-left: 7px;margin-bottom: 5px;">
                            <font style="color:#6ccdce;"><strong>{$LNG.in_bonus}</strong></font><br>
                            <font color="#6ccdce">{foreach $Element.elementBonus as $BonusName => $Bonus}{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{abs($Bonus[0] * 100)}%{else}{floatval($Bonus[0])}{/if} {$LNG.bonus.$BonusName}<br>{/foreach}</font>
                        </div>
                        <div class="clear"></div>
                        <div class="btn_build_border" style="height:29px;width:101%;">
                        {if $Element.maxLevel <= $Element.level}
                            <span class="btn_build red">{$LNG.race_yes}</span>
                        {elseif $Element.buyable}
                            <form action="game.php?page=race" method="post" class="build_form">
                                <input type="hidden" name="id" value="{$ID}">
                                <button type="submit" class="btn_build">{$LNG.race_one} {foreach $Element.costResources as $RessID => $RessAmount} {$LNG.tech.{$RessID}} <span style="color:{if $Element.costOverflow[$RessID] == 0}lime{else}red{/if}">{$RessAmount|number}</span>{/foreach}</button>
                            </form>
                        {else}
                            <span class="btn_build red">{$LNG.race_one} {foreach $Element.costResources as $RessID => $RessAmount} {$LNG.tech.{$RessID}} <span style="color:{if $Element.costOverflow[$RessID] == 0}lime{else}#666666{/if}">{$RessAmount|number}{/foreach}</span></span>
                        {/if}
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