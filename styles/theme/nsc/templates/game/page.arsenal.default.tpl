{block name="title" prepend}{$LNG.lm_ars}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/building.css">
<div id="page">
    <div id="content">
    {if $arsList}
        <div id="ally_content" class="conteiner" style="width: 100%;">
            <div class="gray_stripe">
                <div style="float:left">{$LNG.lm_ars}</div>
                <span class="record_btn ico_star record_btn_active" onclick="ars();"></span>
                <span class="record_btn ico_fleet" onclick="ars1();"></span>
                <span class="record_btn ico_shield" onclick="ars2();"></span>
            </div>
            <div id="build_elements" class="ars_elements gov2">
                {foreach $arsList as $ID => $Element}
                <div id="ars_{$ID}" class="build_box {if $ID == in_array($ID, $reslist.spec_ars.1)}ars1{elseif $ID == in_array($ID, $reslist.spec_ars.2)}ars2{/if}">
                    <div class="head">               
                        {$LNG.tech.{$ID}}
                        <font class="gov6">({$LNG.bd_lvl} {$Element.level|number})</font>
                    </div>
                    <div class="content_box">
                        <div class="image_mini">
                            <img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" />
                        </div>
                        <div class="prices_mini">
                            <font color="#096">{foreach $Element.elementBonus as $BonusName => $Bonus}{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{round(abs($Bonus[0] * 100) * {sqrt($Element.level)}, 2)}%{else}{round(floatval($Bonus[0]) * {sqrt($Element.level)}, 2)}{/if} {$LNG.bonus.$BonusName}<br>{/foreach}</font>
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