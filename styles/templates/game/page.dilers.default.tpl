{block name="title" prepend}{$LNG.lm_dilers}{/block}
{block name="content"}
<div id="page">
	<div id="content">
        <div id="market" class="locus">
            <div class="habena">
                {$LNG.lm_dilers}
            </div>
            {if isModuleAvailable($smarty.const.MODULE_TRADER)}
            <div class="market_element img_resourcetrader">
                <a href="game.php?page=trader">
                    <div class="market_title">{$LNG.lm_trader}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_FLEET_TRADER)}
            <div class="market_element img_fleettrader">
                <a href="game.php?page=fleetdealer">
                    <div class="market_title">{$LNG.lm_fleettrader}</div>
                </a>
            </div>
            {/if}
        </div>
    </div>
</div>
{/block}