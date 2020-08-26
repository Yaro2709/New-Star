{block name="title" prepend}{$LNG.lm_buytech}{/block}
{block name="content"}
<div id="page">
<div id="content">
<div id="ally_content" class="conteiner">
    <div class="gray_stripe" style="padding-right: 0;">
        <span id="traderHead">{$LNG.lm_buytech}</span>  
        {if isModuleAvailable($smarty.const.MODULE_RESEARCH)}
        <a href="game.php?page=buildings" class="right_flank button">{$LNG.lm_research}</a>
        {/if}
    </div>
    <form action="game.php?page=buytech" method="post">
        <input type="hidden" name="mode" value="send">
        <input type="hidden" id="Element" name="Element" value="">
        <table class="tablesorter ally_ranks gray_stripe_th">
            <tr>
                <td rowspan="4" style="width:121px; height:126px;">
                    <img class="buyres" style="width:120px; height:120px" id="img" alt="" data-src="{$dpath}gebaeude/" src="./styles/theme/gow/gebaeude/undefined.gif"/>
                </td>
            </tr>
            <tr>
                <td>
                    {$LNG.bd_lvl_up} <input min="0" type="number" onchange="Total();" type="text" id="count" name="count" onkeyup="Total();">
                </td>
            </tr>
            <tr>
                <td>
                    {$LNG.bd_the_initial_cost} {$LNG.tech.$buy_instantly}: <span id="price" style="font-weight:bold;"></span> 			
                </td>
            </tr>
            <tr>
                <td>
                    {$LNG.bd_total} {$LNG.tech.$buy_instantly}: <span id="total_price_factor" style="font-weight:bold;"></span>
                </td>
            </tr>
            <tr>
                <th colspan="2" style="text-align:center;  border-left:0;">
                    <input style="display:none;" id="batn" type="submit" value="{$LNG.bd_buy}" style="width:70px; margin:0 auto;">
                </th>
            </tr>
            <tr>
                <td colspan="2" style="text-align:left; height:auto; border-top:1px solid #000;">
                    {foreach $Elements as $Element}
                    <img class="buyres element" onclick="updateVars({$Element})" src="{$dpath}gebaeude/{$Element}.gif" />
                    {/foreach}
                </td>
            </tr>
        </table>
    </form>
</div>
{/block}
{block name="script" append}
<script type="text/javascript">
   var CostInfo = {$CostInfos|json};
</script>
{/block}