{block name="title" prepend}{$LNG.lm_info}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/information.css">
<body id="information" class="popup" style="overflow-x: hidden;">
    <div id="body">
        <div id="popup_conteirer">
            <div id="content">
                <div id="ally_content" class="conteiner" style="width:auto;">
                    <div class="gray_stripo">
                        <span class="academy_info_text_h">{$LNG.tech.$elementID}</span>         
                    </div> 
                    <div class="info_elements">
                        <div class="content_box ">
                            <div class="image">
                                <img src="{$dpath}gebaeude/{$elementID}.gif" alt="">
                            </div>
                            <div class="prices info_description">
                                <p class="info15">{$LNG.longDescription.$elementID}
                                    {if !empty($Bonus)}
                                    <br><b>{$LNG.in_bonus}</b><br>
                                    {foreach $Bonus as $BonusName => $elementBouns}{if $elementBouns[0] < 0}-{else}+{/if}{if $elementBouns[1] == 0}{abs($elementBouns[0] * 100)}%{else}{floatval($elementBouns[0])}{/if} {$LNG.bonus.$BonusName}<br>{/foreach}
                                    {/if}
                                </p>
                            </div>
                        </div>
                        <div class="clear"></div>
                        {if !empty($productionTable.production)}
                        {include file="shared.information.production.tpl"}
                        {/if}
                        {if !empty($productionTable.storage)}
                        {include file="shared.information.storage.tpl"}
                        {/if}
                        {if !empty($FleetInfo)}
                        {include file="shared.information.shipInfo.tpl"}
                        {/if}
                        {if !empty($gateData)}
                        {include file="shared.information.gate.tpl"}
                        {/if}
                        {if !empty($MissileList)}
                        {include file="shared.information.missiles.tpl"}
                        {/if}
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
{/block}