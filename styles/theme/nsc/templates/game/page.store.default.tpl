{block name="title" prepend}{$LNG.lm_store}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/store.css">
<div id="page">
	<div id="content">
        <div id="market" class="locus">
            <div class="habena">
                {$LNG.lm_store}
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
            {if isModuleAvailable($smarty.const.MODULE_BAND)}
            <div class="market_element img_band">
                <a href="game.php?page=band">
                    <div class="market_title">{$LNG.lm_band}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_BON)}
            <div class="market_element img_bon">
                <a href="game.php?page=bon">
                    <div class="market_title">{$LNG.lm_bon}</div>
                </a>
            </div>
            {/if}           
            {if isModuleAvailable($smarty.const.MODULE_DMEXTRAS)}
            <div class="market_element img_blueprints">
                <a href="game.php?page=blueprints">
                    <div class="market_title">{$LNG.lm_blueprints}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_PREMIUM)}
            <div class="market_element img_premium">
                <a href="game.php?page=premium">
                    <div class="market_title">{$LNG.lm_premium}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_FAIR)}
            <div class="market_element img_fair">
                <a href="game.php?page=fair">
                    <div class="market_title">{$LNG.lm_fair}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_AUCTION)}
            <div class="market_element img_auction">
                <a href="game.php?page=auction">
                    <div class="market_title">{$LNG.lm_auction}</div>
                </a>
            </div>
            {/if}
        </div>
    </div>
</div>
{/block}