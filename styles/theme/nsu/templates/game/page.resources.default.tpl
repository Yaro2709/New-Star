{block name="title" prepend}{$LNG.lm_resources}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/resources.css">
<div id="page">
	<div id="content">
        <div id="ally_content" class="conteiner" style="width: 100%;">
            <div class="gray_flettab">
                <span>{$header}</span>
            </div>
            <div class="fleettab9" style="margin-bottom:0;"></div>
            <form action="?page=resources" method="post">
                <input type="hidden" name="mode" value="send">
                <div class="rexx1" style="width: 25%;">
                    <img src="{$dpath}planeten/small/s_{$planetImage}.jpg" class="rexx9">
                    <span class="rexx10">{$planetName}</span>
                    <div class="rexx2 rexx3" style="margin-top:70px">{$LNG.rs_basic_income}</div>
                    {foreach $productionList as $productionID => $productionRow}
                        {if $productionID != 48}{if $productionID != 54}
                            <div class="rexx2 rexx3">
                                <a href="#" onclick="return Dialog.info({$productionID})"><img src="{$dpath}gebaeude/{$productionID}.gif" style="margin-right:3px">{$LNG.tech.$productionID} 
                                    <span class="rexx4 tooltip" data-tooltip-content="{if $productionID  > 200}{$LNG.rs_amount}{else}{$LNG.rs_lvl}{/if}">{$productionRow.elementLevel}</span>
                                </a>
                            </div>
                        {/if}{/if}
                    {/foreach}
                    <div class="rexx2 rexx3">{$LNG.rs_ress_bonus}</div>
                    <div class="rexx2 rexx3" style="margin-top:12px">{$LNG.rs_storage_capacity}</div>
                    <div class="rexx2 rexx3" style="margin-top:12px">{$LNG.rs_sum}</div>
                    <div class="rexx2 rexx3">{$LNG.rs_daily}</div>
                    <div class="rexx2 rexx3">{$LNG.rs_weekly}</div>
                </div>
                {foreach $resstype1 as $res => $id_res}
                    <div class="rexx1 rexx{$id_res}">
                        <span class="rexx8"></span>
                        <div class="rexx2" style="margin-top:70px"><span class="colore{if $basicProduction.$id_res > 0}{$id_res}{elseif $basicProduction.$id_res < 0}red{else}{/if}">{$basicProduction.$id_res|shortly_number}</span></div>
                        {foreach $productionList as $productionID => $productionRow}
                            {if $productionID != 48}{if $productionID != 54}
                                <div class="rexx2 colore{if $productionRow.production.$id_res > 0}{$id_res}{elseif $productionRow.production.$id_res < 0}red{else}{/if}">
                                    <span class="">{$productionRow.production.$id_res|shortly_number}</span>
                                </div>	
                            {/if}{/if}
                        {/foreach}
                        <div class="rexx2"><span class="colore{if $bonusProduction.$id_res > 0}{$id_res}{elseif $bonusProduction.$id_res < 0}red{else}{/if}">{$bonusProduction.$id_res|shortly_number}</span></div>
                        <div class="rexx2" style="margin-top:12px"><span class="colore{if $storage.$id_res > 0}{$id_res}{elseif $storage.$id_res < 0}red{else}{/if}">{$storage.$id_res|shortly_number}</span></div>
                        <div class="rexx2" style="margin-top:12px"><span class="colore{if $totalProduction.$id_res > 0}{$id_res}{elseif $totalProduction.$id_res < 0}red{else}{/if}">{$totalProduction.$id_res|shortly_number}</span></div>
                        <div class="rexx2"><span class="colore{if $dailyProduction.$id_res > 0}{$id_res}{elseif $dailyProduction.$id_res < 0}red{else}{/if}">{$dailyProduction.$id_res|shortly_number}</span></div>
                        <div class="rexx2"><span class="colore{if $weeklyProduction.$id_res > 0}{$id_res}{elseif $weeklyProduction.$id_res < 0}red{else}{/if}">{$weeklyProduction.$id_res|shortly_number}</span></div>
                    </div>
                {/foreach}
                {foreach $resstype2 as $res => $id_res}
                    <div class="rexx1 rexx{$id_res}">
                        <span class="rexx8"></span>
                        <div class="rexx2" style="margin-top:70px"><span class="colore{if $basicProduction.$id_res > 0}{$id_res}{elseif $basicProduction.$id_res < 0}red{else}{/if}">{$basicProduction.$id_res|shortly_number}</span></div>
                        {foreach $productionList as $productionID => $productionRow}
                            {if $productionID != 48}{if $productionID != 54}
                                <div class="rexx2 colore{if $productionRow.production.$id_res > 0}{$id_res}{elseif $productionRow.production.$id_res < 0}red{else}{/if}">
                                    <span class="">{$productionRow.production.$id_res|shortly_number}</span>
                                </div>	
                            {/if}{/if}
                        {/foreach}
                        <div class="rexx2"><span class="colore{if $bonusProduction.$id_res > 0}{$id_res}{elseif $bonusProduction.$id_res < 0}red{else}{/if}">{$bonusProduction.$id_res|shortly_number}</span></div>
                        <div class="rexx2" style="margin-top:12px">-</div>
                        <div class="rexx2" style="margin-top:12px"><span class="colore{if $totalProduction.$id_res > 0}{$id_res}{elseif $totalProduction.$id_res < 0}red{else}{/if}">{$totalProduction.$id_res|shortly_number}</span></div>
                        <div class="rexx2"><span class="colore{if $dailyProduction.$id_res > 0}{$id_res}{elseif $dailyProduction.$id_res < 0}red{else}{/if}">{$dailyProduction.$id_res|shortly_number}</span></div>
                        <div class="rexx2"><span class="colore{if $weeklyProduction.$id_res > 0}{$id_res}{elseif $weeklyProduction.$id_res < 0}red{else}{/if}">{$weeklyProduction.$id_res|shortly_number}</span></div>
                    </div>
                {/foreach}
                <div class="rexx1 rexxprocent">
                    <div class="rexx6">
                        <select class="rexx5 option"><option value="1" selected="selected" class="rexx5 option option">100%</option></select>
                        {foreach $productionList as $productionID => $productionRow}
                            {if $productionID != 48}{if $productionID != 54}
                                {html_options class="rexx5 option" name="prod[{$productionID}]" options=$prodSelector selected=$productionRow.prodLevel}
                            {/if}{/if}
                        {/foreach}
                    </div>
                    <div class="rexx2"style="margin-top:0px">-</div> 
                    <div class="rexx2" style="margin-top:12px;"><input value="{$LNG.rs_calculate}" type="submit" class="rexx7"></div>
                    <div class="rexx2" style="margin-top:12px;">-</div>
                    <div class="rexx2">-</div>
                    <div class="rexx2">-</div>
                </div>
            </form>
            <div class="alleanza57" style="margin-top: 5px;"></div>
            <div class="fleettab1" style="height: 32px;"> 
                <form action="?page=resources" method="post">
                    <input type="hidden" name="mode" value="AllPlanets">
                    <input type="hidden" name="action" value="off">
                    <button type="submit" class="rexx13">{$LNG.res_disable}</button>
                </form>
                <form action="?page=resources" method="post">
                    <input type="hidden" name="mode" value="AllPlanets">
                    <input type="hidden" name="action" value="on">
                    <button type="submit" class="rexx12">{$LNG.res_activate}</button>
                </form>
            </div>		
        </div>
    </div>
</div>
{/block}