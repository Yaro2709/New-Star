{block name="title" prepend}{$LNG.lm_piratemarket}{/block}
{block name="content"}
<div id="page">
	<div id="content">
        <div id="market" class="locus">
            <div class="habena">
                {$LNG.lm_piratemarket}
            </div>
            {if isModuleAvailable($smarty.const.MODULE_ARTIFACT)}
            <div class="market_element img_artifact">
                <a href="game.php?page=artifact">
                    <div class="market_title">{$LNG.lm_artifact}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_DEVELOPMENT)}
            <div class="market_element img_development">
                <a href="game.php?page=development">
                    <div class="market_title">{$LNG.lm_development}</div>
                </a>
            </div>
            {/if}
        </div>
    </div>
</div>
{/block}