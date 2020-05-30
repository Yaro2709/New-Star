{block name="title" prepend}{$LNG.lm_blackmarket}{/block}
{block name="content"}
<div id="page">
	<div id="content">
        <div id="market" class="locus">
            <div class="habena">
                {$LNG.lm_blackmarket}
            </div>
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