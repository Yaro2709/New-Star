{block name="title" prepend}{$LNG.lm_officiers}{/block}
{block name="script"}
<script type="text/javascript" src="./scripts/game/price.js?v=6"></script>
{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/building.css">
<div id="page">
    <div id="content">
    {if $officierList}
        <div id="ally_content" class="conteiner" style="width: 100%;">
            <div class="gray_stripe">
                {$LNG.lm_officiers} 
            </div>
            <div id="build_elements" class="officier_elements gov2">
                {foreach $officierList as $ID => $Element}
                <div id="ofic_{$ID}" class="build_box {if !$Element.techacc}required{/if}">
                    <div class="head">               
                        <a href="#" onclick="return Dialog.info({$ID})">{$LNG.tech.{$ID}}</a> 
                        <font class="gov6">({$LNG.bd_lvl} {$Element.level}/{$Element.maxLevel})</font>
                    </div>
                    <div class="content_box">
                        <div class="image_mini">
                            <a href="#" onclick="return Dialog.info({$ID})"><img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" /></a>
                        </div>
                        {if !$Element.techacc}
                        <div class="prices_mini" style="height: 80px;">
                            <div class="necccos" style="left: 75px;">{$LNG.bd_needed_tech}</div>
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
                        <div class="prices_mini">
                            <font color="#096">{foreach $Element.elementBonus as $BonusName => $Bonus}{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{abs($Bonus[0] * 100)}%{else}{floatval($Bonus[0])}{/if} {$LNG.bonus.$BonusName}<br>{/foreach}</font>
                        </div>
                        <div class="clear"></div>
                        <form action="game.php?page=officier" method="post" class="build_form" id="Gov">
                            <div class="time_build_mini">
                                {foreach $Element.costResources as $RessID => $RessAmount}{$LNG.tech.{$RessID}}: 
                                <b><span id="price{$ID}" style="color:{if $Element.costOverflow[$RessID] == 0}lime{else}red{/if}">{$RessAmount|number}</span></b>
                                {/foreach}
                            </div>
                            <div class="clear"></div>
                            <div class="btn_build_border">
                                {if $Element.maxLevel <= $Element.level}
                                <span class="btn_build red">{$LNG.bd_maxlevel}</span>
                                {elseif $Element.buyable}
                                <form action="game.php?page=officier" method="post" class="build_form">
                                    <div class="clear"></div>
                                    <input name="id" value="{$ID}" type="hidden">      
                                    <div class="btn_build_border btn_build_border_left dm_btn_build_border_left">
                                        <label class="max_btn_ship">{$LNG.bd_lvl_up}</label>
                                        <div class="div_text count_ships_dots">
                                            {foreach $Element.costResources as $RessID => $RessAmount}
                                            <input id="amount{$ID}" class="text" onchange="Price{$RessID}('{$ID}', {$RessAmount});" name="amount" max="{$Element.maxLevel}" min="1" value="1" type="number">
                                            {/foreach}
                                        </div>
                                    </div>
                                    <div class="btn_build_border btn_build_border_right dm_btn_build_border_right">
                                        <button class="btn_build gubernators_form_submit" type="submit">{$LNG.bd_buy}</button>  
                                    </div>                  
                                </form>
                                {else}
                                <span class="btn_build red">{$LNG.bd_notres}</span>
                                {/if}
                            </div>
                        </form>
                        {/if} 
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