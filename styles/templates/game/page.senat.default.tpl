{block name="title" prepend}{$LNG.lm_senat}{/block}
{block name="content"}
<div id="page">
	<div id="content">
        <div id="market" class="locus">
            <div class="habena">
                {$LNG.lm_senat}
            </div>
            {if isModuleAvailable($smarty.const.MODULE_OFFICIER)}
            <div class="market_element img_officer">
                <a href="game.php?page=officier">
                    <div class="market_title">{$LNG.lm_officiers}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_DMEXTRAS)}
            <div class="market_element img_gubernators">
                <a href="game.php?page=gubernators">
                    <div class="market_title">{$LNG.lm_governors}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_INFO_BONUS)}
            <div class="market_element img_infobonus">
                <a href="game.php?page=infobonus">
                    <div class="market_title">{$LNG.lm_infobonus}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_RACE)}
            <div class="market_element img_race">
                <a href="game.php?page=race">
                    <div class="market_title">{$LNG.lm_race}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_FORMGOVERNMENT)}
            <div class="market_element img_formgovernment">
                <a href="game.php?page=formgovernment">
                    <div class="market_title">{$LNG.lm_formgovernment}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_ETHICS)}
            <div class="market_element img_ethics">
                <a href="game.php?page=ethics">
                    <div class="market_title">{$LNG.lm_ethics}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_PARTY)}
            <div class="market_element img_party">
                <a href="game.php?page=party">
                    <div class="market_title">{$LNG.lm_party}</div>
                </a>
            </div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_IDEOLOGIES)}
            <div class="market_element img_ideologies">
                <a href="game.php?page=ideologies">
                    <div class="market_title">{$LNG.lm_ideologies}</div>
                </a>
            </div>
            {/if}
        </div>
    </div>
</div>
{/block}