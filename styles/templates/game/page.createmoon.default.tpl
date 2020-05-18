{block name="title" prepend}{$LNG.lm_createmoon}{/block}
{block name="content"}
<div id="page">
	<div id="content">
        <div id="ally_content" class="conteiner" style="width: 360px">
            <div class="gray_stripo">
                <span class="titolosinistra">{$LNG.lm_createmoon}</span>
            </div>
            <div class="crealuneco">
                <div class="boxxo">
                    <div class="contento">
                        <span class="crem55">{$LNG.lm_createmoon}</span>
                        <p class="crem4">{$LNG.crm_value}</p>
                        <div class="crem2">{$LNG.crm_war}</div>
                        {if $buy_moon_res_user < $buy_moon_price}
                        <div class="gov23 gov24_{$buy_moon_res} tooltip" style="opacity:0.7;cursor: no-drop;" data-tooltip-content="Не хватает ресурсов">
                            <span class="crem5">{$buy_moon_price|pretty_number}</span>
                        </div>
                        {else}
                        <div class="gov23 gov24_{$buy_moon_res} tooltip" data-tooltip-content="{$LNG.tech.$buy_moon_res} {$buy_moon_price|pretty_number}">
                            <form action="game.php?page=createMoon" method="post">
                                <input type="hidden" name="mode" value="buy"> 
                                <input value="{$buy_moon_price|pretty_number}" type="submit" class="crem5">
                            </form>
                        </div>
                        {/if}
                    </div>
                </div>
            </div>
        <div class="clear"></div>
        </div>
    </div>
</div>
{/block}