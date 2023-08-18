{block name="title" prepend}{$LNG.lm_resources}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/resources.css">
<div id="page">
	<div id="content">
        <div id="ally_content" class="conteiner" style="width: 100%;">
            <div class="gray_flettab">
                <span>{$header}</span>
            </div>
             <form action="?page=resources" method="post">
                <input type="hidden" name="mode" value="send">
            <div class="row" style="padding: 7px">
                <div class="col-md-2">
                <div class="valueTest2 mr-1 p-1">
                    <img src="{$dpath}planeten/small/s_{$planetImage}.jpg" class="rexx9">
                    <span class="rexx10">{$planetName}</span>
                    <div class="valueTest rexx2 rexx3" style="margin-top:70px">{$LNG.rs_basic_income}</div>
                    {foreach $productionList as $productionID => $productionRow}
                        {if $productionID != 48}{if $productionID != 54}
                            <div class="valueTest rexx2 rexx3">
                                <a href="#" onclick="return Dialog.info({$productionID})"><img src="{$dpath}gebaeude/{$productionID}.gif" style="margin-right:3px">{$LNG.tech.$productionID} 
                                    <span class="rexx4 tooltip" data-tooltip-content="{if $productionID  > 200}{$LNG.rs_amount}{else}{$LNG.rs_lvl}{/if}">{$productionRow.elementLevel}</span>
                                </a>
                            </div>
                        {/if}{/if}
                    {/foreach}
                    <div class="valueTest rexx2 rexx3">{$LNG.rs_ress_bonus}</div>
                    <div class="valueTest rexx2 rexx3" style="margin-top:12px">{$LNG.rs_storage_capacity}</div>
                    <div class="valueTest rexx2 rexx3" style="margin-top:12px">{$LNG.rs_sum}</div>
                    <div class="valueTest rexx2 rexx3">{$LNG.rs_daily}</div>
                    <div class="valueTest rexx2 rexx3">{$LNG.rs_weekly}</div>
                </div>
                </div>
                {foreach $resstype1 as $res => $id_res}
                <div class="col-md-1">
                    <div class="valueTest2 mr-1 p-1">
                        <span class="rexx8"></span>
                        <div class="valueTest rexx2" style="margin-top:70px"><span class="colore{if $basicProduction.$id_res > 0}{$id_res}{elseif $basicProduction.$id_res < 0}red{else}{/if}">{$basicProduction.$id_res|shortly_number}</span></div>
                        {foreach $productionList as $productionID => $productionRow}
                            {if $productionID != 48}{if $productionID != 54}
                                <div class="valueTest rexx2 colore{if $productionRow.production.$id_res > 0}{$id_res}{elseif $productionRow.production.$id_res < 0}red{else}{/if}">
                                    <span class="">{$productionRow.production.$id_res|shortly_number}</span>
                                </div>	
                            {/if}{/if}
                        {/foreach}
                        <div class="valueTest rexx2"><span class="colore{if $bonusProduction.$id_res > 0}{$id_res}{elseif $bonusProduction.$id_res < 0}red{else}{/if}">{$bonusProduction.$id_res|shortly_number}</span></div>
                        <div class="valueTest rexx2" style="margin-top:12px"><span class="colore{if $storage.$id_res > 0}{$id_res}{elseif $storage.$id_res < 0}red{else}{/if}">{$storage.$id_res|shortly_number}</span></div>
                        <div class="valueTest rexx2" style="margin-top:12px"><span class="colore{if $totalProduction.$id_res > 0}{$id_res}{elseif $totalProduction.$id_res < 0}red{else}{/if}">{$totalProduction.$id_res|shortly_number}</span></div>
                        <div class="valueTest rexx2"><span class="colore{if $dailyProduction.$id_res > 0}{$id_res}{elseif $dailyProduction.$id_res < 0}red{else}{/if}">{$dailyProduction.$id_res|shortly_number}</span></div>
                        <div class="valueTest rexx2"><span class="colore{if $weeklyProduction.$id_res > 0}{$id_res}{elseif $weeklyProduction.$id_res < 0}red{else}{/if}">{$weeklyProduction.$id_res|shortly_number}</span></div>
                    </div>
                </div>
                {/foreach}
                {foreach $resstype2 as $res => $id_res}
                <div class="col-md-1">
                    <div class="valueTest2 mr-1 p-1">
                        <span class="rexx8"></span>
                        <div class="valueTest rexx2" style="margin-top:70px"><span class="colore{if $basicProduction.$id_res > 0}{$id_res}{elseif $basicProduction.$id_res < 0}red{else}{/if}">{$basicProduction.$id_res|shortly_number}</span></div>
                        {foreach $productionList as $productionID => $productionRow}
                            {if $productionID != 48}{if $productionID != 54}
                                <div class="valueTest rexx2 colore{if $productionRow.production.$id_res > 0}{$id_res}{elseif $productionRow.production.$id_res < 0}red{else}{/if}">
                                    <span class="">{$productionRow.production.$id_res|shortly_number}</span>
                                </div>	
                            {/if}{/if}
                        {/foreach}
                        <div class="valueTest rexx2"><span class="colore{if $bonusProduction.$id_res > 0}{$id_res}{elseif $bonusProduction.$id_res < 0}red{else}{/if}">{$bonusProduction.$id_res|shortly_number}</span></div>
                        <div class="valueTest rexx2" style="margin-top:12px">-</div>
                        <div class="valueTest rexx2" style="margin-top:12px"><span class="colore{if $totalProduction.$id_res > 0}{$id_res}{elseif $totalProduction.$id_res < 0}red{else}{/if}">{$totalProduction.$id_res|shortly_number}</span></div>
                        <div class="valueTest rexx2"><span class="colore{if $dailyProduction.$id_res > 0}{$id_res}{elseif $dailyProduction.$id_res < 0}red{else}{/if}">{$dailyProduction.$id_res|shortly_number}</span></div>
                        <div class="valueTest rexx2"><span class="colore{if $weeklyProduction.$id_res > 0}{$id_res}{elseif $weeklyProduction.$id_res < 0}red{else}{/if}">{$weeklyProduction.$id_res|shortly_number}</span></div>
                    </div>
                </div>
                {/foreach}
                <div class="col-md-1">
                    <div class="valueTest2 rexxprocent p-1">
                        <span class="rexx8"></span>
                        <div class="valueTest rexx2" style="margin-top:70px">
                            <select class="rexx5 option"><option value="1" selected="selected" class="rexx5 option">100%</option></select>
                        </div>
                        {foreach $productionList as $productionID => $productionRow}
                            {if $productionID != 48}{if $productionID != 54}
                                <div class="valueTest rexx2">
                                    {html_options class="rexx5 option" name="prod[{$productionID}]" options=$prodSelector selected=$productionRow.prodLevel}
                                </div>	
                            {/if}{/if}
                        {/foreach}
                    <div class="valueTest rexx2">-</div> 
                    <div class="valueTest rexx2" style="margin-top:12px;"><input value="{$LNG.rs_calculate}" type="submit" class="rexx7"></div>
                    <div class="valueTest rexx2" style="margin-top:12px;">-</div>
                    <div class="valueTest rexx2">-</div>
                    <div class="valueTest rexx2">-</div>
                </div>
                </div>
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