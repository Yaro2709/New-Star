{block name="title" prepend}{$LNG.lm_createmoon}{/block}
{block name="content"}
<div id="page">
	<div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_stripo">
                <span class="titolosinistra">{$LNG.lm_createmoon}</span>
                <span class="tornaindietro">{$LNG.crm_war}</span>
            </div>
            <div class="ally_img">
                <table class="no_visible">
                    <tbody>
                        <tr>
                            <td>
                                <img src="{$dpath}img/title/createMoon.jpg" alt="*">
                                <span class="designation">
                                    <span>{$LNG.lm_createmoon}</span><br>
                                </span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div> 
            <div class="clear"></div>
            <div class="build_band2 ticket_bottom_band" style="padding-left:20px;">    
                <span style="font-weight:bold;">{$LNG.crm_value}</span>
                {if $buy_moon_res_user < $buy_moon_price}
                <span style="font-weight:bold;margin-right: 4px;float: right;">{$LNG.tech.$buy_moon_res} {$buy_moon_price|pretty_number}</span>
                {else}
                <form action="game.php?page=createMoon" method="post" style="display: contents;">
                    <input type="hidden" name="mode" value="buy"> 
                    <input class="bottom_band_submit" value="{$LNG.tech.$buy_moon_res} {$buy_moon_price|pretty_number}" type="submit">
                </form>
                {/if}
            </div>
        </div>
    </div>
</div>
{/block}