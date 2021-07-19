{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
    <div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_flettab" style="padding-right:0;">{$LNG.lm_alliance}
                <a href="game.php?page=alliance&amp;mode=create" class="tornaindietroa">{$LNG.al_alliance_make}</a>
            </div>
            <div class="ally_img">
                <table class="no_visible">
                    <tr>
                        <td>
                            <img src="{$dpath}img/title/al.jpg" alt="*" />
                            <span class="designation">
                                <span>{$LNG.lm_alliance}</span><br/>
                            </span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="fleettab1" style="height:21px;">
                {if isModuleAvailable($smarty.const.MODULE_STATISTICS)}
                <a href="game.php?page=statistics" class="tornaindietroa" style="left: 0;border-radius: 0px 0px 0px 4px;moz-border-radius: 0px 0px 0px 4px;-webkit-border-radius: 0px 0px 0px 4px;right: auto;">{$LNG.lm_statistics}</a>
                {/if}
                {if isModuleAvailable($smarty.const.MODULE_SEARCH)}
                <a href="game.php?page=search" class="tornaindietroa" style="border-radius: 0px 0px 4px 0px;moz-border-radius: 0px 0px 4px 0px;-webkit-border-radius: 0px 0px 4px 0px">{$LNG.lm_search}</a>
                {/if}
            </div>
        </div>
    </div>
</div>
{/block}