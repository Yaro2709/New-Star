{block name="title" prepend}{$LNG.lm_banned}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/statistics.css">
<div id="page">
	<div id="content">
        <div id="ally_content" class="conteinership">
            <div class="gray_flettab" style="padding-right:0;">{$LNG.bn_players_banned_list}
            <span class="tornaindietro" style="height: 14px;line-height: 14px;">{$LNG.bn_exists}{$banCount|number}{$LNG.bn_players_banned}</span>
            </div>
            <div class="fleettab8" style="margin-bottom: 0;"></div>
            <table class="tablesorter ally_ranks tabstatistica" style="margin-bottom: 5px;">
                <tbody>
                    <tr class="torneo4">
                        <th style="width:170px;min-width:170px;">{$LNG.bn_from}</th>
                        <th style="width:155px;min-width:155px;">{$LNG.bn_until}</th>
                        <th style="width:110px;min-width:110px;text-align: left;">{$LNG.bn_player}</th>
                        <th style="width:125px;min-width:125px;text-align: left;">{$LNG.bn_by}</th>
                        <th style="width:75px;min-width:75px;">{$LNG.bn_reason}</th>
                    </tr>
                    {if $banCount}
                    {foreach $banList as $banRow}
                    <tr class="classificabarra">
                        <td class="classstat3" style="text-align: left;width: 160px;max-width: 160px;min-width: 160px;">{$banRow.from}</td>
                        <td class="classstat8" style="text-align: left;width: 160px;max-width: 160px;min-width: 160px;">{$banRow.to}</td>
                        <td class="classstat8" style="text-align: left;width: 110px;max-width: 110px;min-width: 110px;">{$banRow.player}</td>
                        <td class="classstat8" style="text-align: left;width: 110px;max-width: 110px;min-width: 110px;overflow: hidden; white-space: nowrap;"><a href="mailto:{$banRow.mail}" title="{$banRow.info}">{$banRow.admin}</a></td>
                        <td class="classstat8" style="text-align: right;width: 100px;max-width: 100px;min-width: 65px;">{$banRow.theme}</td>
                    </tr>
                    {/foreach}
                    {else}
                    <tr class="classificabarra">
                        <td colspan="5" style="width: 670px; min-width: 670px;" class="classstat3">{$LNG.bn_no_players_banned}</td>
                    </tr>
                    {/if}
                </tbody>
            </table>
            <div class="alleanza57"></div>
            <div class="fleettab1" style="height:21px;">
                {if $banCount}
                <div class="message_page_navigation" style="color: #ccc; padding: 4px 6px;">{$LNG.mg_page}: 
                    {if $page != 1}<a class="messagesnew2 messagesnew3" href="game.php?page=banList&amp;side={$page - 1}">&laquo;</a>&nbsp;{/if}
                    <a class="messagesnew2 messagesnew3" href="game.php?page=banList&amp;side=1">{if 1 == $page}<span class="active_page">1</span>{else}1{/if}</a>
                    {if $page - 4 > 1} ... {/if}   
                    {if $page - 3 > 1}
                    <a class="messagesnew2 messagesnew3" href="game.php?page=banList&amp;side={$page - 3}">{if $page - 3 == $page}<span class="active_page">{$page - 3}</span>
                    {else}{$page - 3}{/if}</a>{/if} 
                    {if $page - 2 > 1}
                    <a class="messagesnew2 messagesnew3" href="game.php?page=banList&amp;side={$page - 2}">{if $page - 2 == $page}<span class="active_page">{$page - 2}</span>
                    {else}{$page - 2}{/if}</a>{/if}   
                    {if $page - 1 > 1}
                    <a class="messagesnew2 messagesnew3" href="game.php?page=banList&amp;side={$page - 1}">{if $page - 1 == $page}<span class="active_page">{$page - 1}</span>
                    {else}{$page - 1}{/if}</a>{/if}
                    {if $page     > 1}
                    <a class="messagesnew2 messagesnew3" href="game.php?page=banList&amp;side={$page    }">{if $page     == $page}<span class="active_page">{$page    }</span>
                    {else}{$page   }{/if}</a>{/if}
                    {if $page + 1 <= $maxPage}            
                    <a class="messagesnew2 messagesnew3" href="game.php?page=banList&amp;side={$page + 1}">{if $page + 1 == $page}<span class="active_page">{$page + 1}</span>
                    {else}{$page + 1}{/if}</a>{/if}
                    {if $page + 2 <= $maxPage}            
                    <a class="messagesnew2 messagesnew3" href="game.php?page=banList&amp;side={$page + 2}">{if $page + 2 == $page}<span class="active_page">{$page + 2}</span>
                    {else}{$page + 2}{/if}</a>{/if}
                    {if $page + 3 <= $maxPage}            
                    <a class="messagesnew2 messagesnew3" href="game.php?page=banList&amp;side={$page + 3}">{if $page + 3 == $page}<span class="active_page">{$page + 3}</span>
                    {else}{$page + 3}{/if}</a>{/if}  
                    {if $page + 4 < $maxPage} ... {/if}   
                    {if $page + 4 <= $maxPage}
                    <a class="messagesnew2 messagesnew3" href="game.php?page=banList&amp;side={$maxPage}">{if $maxPage == $page}<span class="active_page">{$maxPage}</span>{else}{$maxPage} {/if}</a>
                    {/if}      
                    {if $page != $maxPage}&nbsp;<a class="messagesnew2 messagesnew3" href="game.php?page=banList&amp;side={$page + 1}">&raquo;</a>{/if}
                </div>
                {/if}
                {if isModuleAvailable($smarty.const.MODULE_BUDDYLIST)}
                <a href="game.php?page=buddylist" class="tornaindietroa" style="left: 0;border-radius: 0px 0px 0px 4px;moz-border-radius: 0px 0px 0px 4px;-webkit-border-radius: 0px 0px 0px 4px;right: auto;">{$LNG.lm_buddylist}</a>
                {/if}
            </div>
        </div>
    </div>
</div>
{/block}