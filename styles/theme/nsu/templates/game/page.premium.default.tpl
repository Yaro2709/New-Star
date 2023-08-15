{block name="title" prepend}{$LNG.lm_premium}{/block}
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
                {$LNG.lm_premium}               
            </div>
            {include file="main.res.tpl"}
            <div id="build_elements" class="p-2">
                {foreach $premiumList as $ID => $Element}
                <div id="premium_{$ID}" class="build_box br-1 mr-2 mt-2 valueTest2 shadow-block">
                    <div class="head valueTest4">
                        {$LNG.tech.{$ID}}
                        {if $Element.timeLeft > 0}<span style="float:right; color:#CCC;">{$LNG.bd_active} <span id="time_{$ID}">-</span></span>{/if}
                    </div>
                    <div class="content_box">
                        <div class="image_mini mt-1 valueTest2">
                            <img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}">
                        </div>
                        <div class="prices_mini pt-2 overflow-auto">
                            <font class="c-bonus">
                                {foreach $Element.elementBonus as $BonusName => $Bonus}{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{abs($Bonus[0] * 100)}%{else}{floatval($Bonus[0])}{/if} {$LNG.bonus.$BonusName}<br>{/foreach}
                            </font>
                        </div>
                        <div class="time_build">
                            {foreach $Element.costResources as $RessID => $RessAmount}{$LNG.tech.{$RessID}}: 
                                <span id="price{$ID}" style="color:{if $Element.costOverflow[$RessID] == 0}lime{else}red{/if}">{$RessAmount|number}</span>
                            {/foreach}
                        </div>
                        <div class="btn_build_border">
                        {if $Element.buyable}
                            <form action="game.php?page=premium" method="post" class="build_form">
                                <input name="id" value="{$ID}" type="hidden">      
                                <div class="btn_build_border_left dm_btn_build_border_left">
                                    <label class="max_btn_ship">{$LNG.bd_time_day}</label>
                                    <div class="div_text count_ships_dots">
                                        {foreach $Element.costResources as $RessID => $RessAmount}
                                            <input id="amount{$ID}" class="text" onchange="Price{$RessID}('{$ID}', {$RessAmount});" name="amount" max="{$Element.maxLevel}" min="1" value="1" type="number">
                                        {/foreach}
                                    </div>
                                </div>
                                <div class="btn_build_border_right dm_btn_build_border_right "> 
                                    <button type="button" class="btn btn_build valueTest2">{$LNG.bd_buy}</button>
                                </div>                  
                            </form>
                        {else}
                            <span class="btn_build red valueTest6">{$LNG.bd_notres}</span>
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