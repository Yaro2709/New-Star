{block name="title" prepend}{$LNG.lm_blackmarket}{/block}
{block name="content"}
<div id="page">
	<div id="content">
        <div id="market" class="locus">
            <div class="habena">
                {$LNG.lm_blackmarket}
            </div>
            {if isModuleAvailable($smarty.const.MODULE_BUY_BUILD)}
            <div class="market_element img_buybuild">
                <a href="game.php?page=buybuild">
                    <div class="market_title">{$LNG.lm_buybuild}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_BUY_TECH)}
            <div class="market_element img_buytech">
                <a href="game.php?page=buytech">
                    <div class="market_title">{$LNG.lm_buytech}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_BUY_FLEET)}
            <div class="market_element img_buyfleet">
                <a href="game.php?page=buyfleet">
                    <div class="market_title">{$LNG.lm_buyfleet}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_BUY_DEFENSE)}
            <div class="market_element img_buydefense">
                <a href="game.php?page=buydefense">
                    <div class="market_title">{$LNG.lm_buydefense}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_ARSENAL)}
            <div class="market_element img_arsenal">
                <a href="game.php?page=arsenal">
                    <div class="market_title">{$LNG.lm_ars}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_CONTAINER)}
            <div class="market_element img_conteiner">
                <a href="game.php?page=conteiner">
                    <div class="market_title">{$LNG.lm_container}</div>
                </a>
            </div>
            {/if}
        </div>
    </div>
</div>
{/block}