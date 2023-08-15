{block name="title" prepend}{$LNG.lm_buybuild}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/byRes.css">
<div id="page">
    <div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_stripe" style="padding-right: 0;">
                <span>{$LNG.lm_buybuild}</span>  
                {if isModuleAvailable($smarty.const.MODULE_BUILDING)}
                    <a href="game.php?page=buildings" class="right_flank button">{$LNG.lm_buildings}</a>
                {/if}
            </div>
            <form action="game.php?page=buyBuild" method="post">
                <input type="hidden" name="mode" value="send">
                <input type="hidden" id="Element" name="Element" value="">                                                    
                <div class="buy_content">
                    <div class="buy_sector buybuild">        
                        <div class="buy_id">
                            <img class="buy_img" id="img" alt="" data-src="{$dpath}gebaeude/" src="{$dpath}gebaeude/undefined.gif"/>
                        </div>
                        <div id="count_calculator">
                            <input class="buy_number" min="0" onchange="Total();" type="text" id="count" name="count" onkeyup="Total();">
                        </div>
                        <span class="buy_title" id="traderHead">{$LNG.lm_buybuild}</span> 
                        <span class="buy_cost">{$LNG.bd_the_initial_cost} {$LNG.tech.$buy_instantly}: <span id="price" class="colore{$buy_instantly}"></span> 	</span> 
                        <span class="buy_outcome">{$LNG.bd_total} {$LNG.tech.$buy_instantly}: <span id="total_price_factor" class="colore{$buy_instantly}"></span></span>
                        <span class="buy_quantity">{$LNG.bd_lvl_up} </span>	
                        <input class="buy_res_btn" id="batn" type="submit" value="{$LNG.bd_buy}">
                        <div class="clear"></div>
                    </div>
                    <div class="buy_res_content">
                    {foreach $Elements as $Element}
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
</script>
{/block}