{block name="title" prepend}{$LNG.lm_prime}{/block}
{block name="script"}
<script type="text/javascript" src="./scripts/game/price.js?v=6"></script>
{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/building.css">
<div id="page">
    <div id="content">
    {if !empty($premiumList)}
        <div id="ally_content" class="conteiner" style="width: 100%;">
            <div class="gray_stripe valueTest4">
                {$LNG.lm_prime}               
            </div>
            {include file="main.res.tpl"}
            <div id="build_elements" class="officier_elements gov2" style="padding-top:10px; padding-bottom:5px;">
                {foreach $premiumList as $ID => $Element}
                <div id="ofic_{$ID}" class="build_box valueTest2">
                    <div class="head valueTest4">
                        {$LNG.tech.{$ID}}
                        {if $Element.timeLeft > 0}(<span style="color:#CCC;"><span id="time_{$ID}">-</span></span>){/if}
                        <font class="gov6">(X<span id="factor{$ID}" name="factor">{$Element.factor}</span>)</font>
                    </div>
                    <div class="content_box">
                        <div class="image_mini valueTest2">
                            <img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}">
                        </div>
                        <div class="prices_mini">
                            {if $Element.timeLeft >= 0}
                            <font color="#096">{foreach $Element.elementBonus as $BonusName => $Bonus}{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{abs($Bonus[0] * 100)}%{else}{floatval($Bonus[0])}{/if} {$LNG.bonus.$BonusName}<br>{/foreach}</font>
                            {/if}
                            {if $Element.timeLeft > 0}
                            <font color="#096">{foreach $Element.elementBonus as $BonusName => $Bonus}{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{abs($Bonus[0] * 100 * $Element.lvl)}%{else}{floatval($Bonus[0]) * $Element.lvl}{/if} {$LNG.bonus.$BonusName}<br>{/foreach}</font>
                            {/if}
                        </div>
                        <div class="clear"></div>
                        <form action="game.php?page=prime" method="post" class="build_form">
                            <div class="time_build">
                                {foreach $Element.costResources as $RessID => $RessAmount}{$LNG.tech.{$RessID}}: 
                                    <b><span id="price{$ID}" style="color:{if $Element.costOverflow[$RessID] == 0}lime{else}red{/if}">{$RessAmount}</span></b>
                                {/foreach}
                            </div>
                            <div class="clear"></div>
                            <div class="btn_build_border">
                            {if $Element.buyable && $Element.timeLeft == 0}
                                <form action="game.php?page=prime" method="post" class="build_form">
                                    <div class="clear"></div>
                                    <input name="id" value="{$ID}" type="hidden">  
                                     <div class="btn_build_border btn_build_border_left dm_btn_build_border_left2">
                                        <label class="max_btn_ship">Х</label>
                                        <div class="div_text count_ships_dots">
                                            {foreach $Element.costResources as $RessID => $RessAmount}
                                            <input id="level{$ID}" class="text" onchange="PriceAdd{$RessID}('{$ID}', {$RessAmount});" name="level" max="{$Element.maxLevel}" min="1" value="1" type="number">
                                            {/foreach}
                                        </div>
                                    </div>
                                    <div class="btn_build_border btn_build_border_left dm_btn_build_border_left2">
                                        <label class="max_btn_ship">{$LNG.bd_time_day}</label>
                                        <div class="div_text count_ships_dots">
                                            {foreach $Element.costResources as $RessID => $RessAmount}
                                            <input id="amount{$ID}" class="text" onchange="PriceAdd{$RessID}('{$ID}', {$RessAmount});" name="amount" max="{$Element.maxLevel}" min="1" value="1" type="number">
                                            {/foreach}
                                        </div>
                                    </div>
                                    <div class="btn_build_border btn_build_border_right dm_btn_build_border_right">
                                        <button class="btn_build valueTest2" type="submit">{$LNG.bd_buy}</button>  
                                    </div>                  
                                </form>
                            {elseif $Element.timeLeft > 0}
                                <span class="btn_build red valueTest6">{$LNG.bd_notres}</span>
                            {else}
                                <span class="btn_build red valueTest6">{$LNG.bd_notres}</span>
                            {/if}
                            </div>
                        </form>
                        <div class="clear"></div>
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