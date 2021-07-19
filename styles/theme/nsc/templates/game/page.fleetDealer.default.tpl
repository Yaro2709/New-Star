{block name="title" prepend}{$LNG.ft_head}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/byRes.css">
<div id="page">
    <div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_stripe" style="padding-right: 0;">
                <span>{$LNG.ft_head}</span>  
                <a onclick="MaxShips();return false;" class="right_flank button">{$LNG.ft_max}</a>
            </div>
            <form action="game.php?page=fleetDealer" method="post">
                <input type="hidden" name="mode" value="send">
                <input type="hidden" id="shipID" name="shipID" value="">                                                    
                <div class="buy_content">
                    <div class="buy_sector fleetdealer">        
                        <div class="buy_id">
                            <img class="buy_img" id="img" alt="" data-src="{$dpath}gebaeude/" src="{$dpath}gebaeude/undefined.gif"/>
                            <div class="buy_img_text tooltip" data-tooltip-content="{$LNG.ft_charge}">{$Charge}%</div>
                        </div>
                        <div id="count_calculator">
                            <input class="buy_number" min="0" onchange="Total();" type="text" id="count" name="count" onkeyup="Total();">
                        </div>
                        <span class="buy_title" id="traderHead">{$LNG.ft_head}</span> 
                        <span class="buy_cost">
                            <div class="prices">
                                <div class="price res901 ">
                                    <div class="ico"></div>
                                    <div class="text" id="total_metal">0</div>
                                </div>
                                <div class="price res902 ">
                                    <div class="ico"></div>
                                    <div class="text" id="total_crystal">0</div>
                                </div>
                                <div class="price res903 ">
                                    <div class="ico"></div>
                                    <div class="text" id="total_deuterium">0</div>
                                </div>
                                <div class="price res921 ">
                                    <div class="ico"></div>
                                    <div class="text" id="total_darkmatter">0</div>
                                </div>
                            </div>
                        </span> 
                        <span class="buy_outcome"></span>
                        <span class="buy_quantity">{$LNG.ft_count}</span>	
                        <input class="buy_res_btn" id="batn" type="submit" value="{$LNG.ft_absenden}">
                        <div class="clear"></div>
                    </div>
                    <div class="buy_res_content">
                    {foreach $shipIDs as $Element}
                        <img class="buy_res" onclick="updateVars({$Element})" src="{$dpath}gebaeude/{$Element}.gif" />
                    {/foreach}
                    </div>
                    <div class="clear"></div>
                </div>
            </form>
        <div class="clear"></div>   
        </div>         
    </div> 
</div>
{/block}
{block name="script" append}
<script type="text/javascript">
   var CostInfo = {$CostInfos|json};
   var Charge = {$Charge};
</script>
{/block}