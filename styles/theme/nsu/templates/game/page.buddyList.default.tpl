{block name="title" prepend}{$LNG.lm_buddylist}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/statistics.css">
<div id="page">
	<div id="content">
        <div id="ally_content" class="conteinership">
            <div class="gray_flettab" style="padding-right:0;">{$LNG.bu_partners}
                {if isModuleAvailable($smarty.const.MODULE_BANLIST)}
                <a href="game.php?page=banList" class="tornaindietroa">{$LNG.lm_banned}</a>
                {/if}
            </div>
            <table class="tablesorter ally_ranks tabstatistica">
                <tbody class="row" style="padding: 7px;">
                    {if !empty($otherRequestList)}
                    <tr class="row col-12">
                        <th class="col-12" style="text-align:center;margin-top:7px;height: 8px;line-height: 9px;">{$LNG.bu_partners}</th>
                    </tr>
                    <tr class="row col-12 barraclass">
                        <th class="col-3">{$LNG.bu_player}</th>
                        <th class="col-3">{$LNG.bu_alliance}</th>
                        <th class="col-2">{$LNG.bu_coords}</th>
                        <th class="col-2">{$LNG.bu_online}</th>
                        <th class="col-2">{$LNG.bu_action}</th>
                    </tr>
                    {foreach $otherRequestList as $otherRequestID => $otherRequestRow}
                    <tr class="row col-12 mt-1 classificabarra">
                        <td class="col-3">
                            <a href="#" onclick="return Dialog.PM({$otherRequestRow.id});">{$otherRequestRow.username}</a>
                        </td>
                        <td class="col-3">
                            {if {$otherRequestRow.ally_name}}
                                <a href="game.php?page=alliance&amp;mode=info&amp;id={$otherRequestRow.ally_id}">{$otherRequestRow.ally_name}</a>
                            {else}
                                -
                            {/if}
                        </td>
                        <td class="col-2">
                            <a href="game.php?page=galaxy&amp;galaxy={$otherRequestRow.galaxy}&amp;system={$otherRequestRow.system}">
                                [{$otherRequestRow.galaxy}:{$otherRequestRow.system}:{$otherRequestRow.planet}]
                            </a>
                        </td>
                        <td class="col-2"></td>
                        <td class="col-2">
                            <a href="game.php?page=buddyList&amp;mode=accept&amp;id={$otherRequestID}">
                                <img src="{$dpath}img/general/true.png" alt="{$LNG.bu_accept}" title="{$LNG.bu_accept}">
                            </a>
                            <a href="game.php?page=buddyList&amp;mode=delete&amp;id={$otherRequestID}">
                                <img src="{$dpath}img/general/false.png" alt="{$LNG.bu_decline}" title="{$LNG.bu_decline}">
                            </a>
                        </td>
                    </tr>
                    {foreachelse}
                    <tr class="row col-12 classificabarra">
                        <td class="col-12">{$LNG.bu_no_request}</td>
                    </tr>
                    {/foreach}
                    {/if}
                    {if !empty($myRequestList)}
                    <tr class="row col-12">
                        <th class="col-12" style="text-align:center;margin-top:7px;height: 8px;line-height: 9px;">{$LNG.bu_my_requests}</th>
                    </tr>
                    <tr class="row col-12 barraclass">
                        <th class="col-3">{$LNG.bu_player}</th>
                        <th class="col-3">{$LNG.bu_alliance}</th>
                        <th class="col-2">{$LNG.bu_coords}</th>
                        <th class="col-2">{$LNG.bu_online}</th>
                        <th class="col-2">{$LNG.bu_action}</th>
                    </tr>
                    {foreach $myRequestList as $myRequestID => $myRequestRow}
                    <tr class="row col-12 mt-1 classificabarra">
                        <td class="col-3">
                            <a href="#" onclick="return Dialog.PM({$myRequestRow.id});">{$myRequestRow.username}</a>
                        </td>
                        <td class="col-3">
                            {if {$myRequestRow.ally_name}}
                                <a href="game.php?page=alliance&amp;mode=info&amp;id={$myRequestRow.ally_id}">{$myRequestRow.ally_name}</a>
                            {else}
                                -
                            {/if}
                        </td>
                        <td class="col-2">
                            <a href="game.php?page=galaxy&amp;galaxy={$myRequestRow.galaxy}&amp;system={$myRequestRow.system}"> 
                                [{$myRequestRow.galaxy}:{$myRequestRow.system}:{$myRequestRow.planet}]
                            </a>
                        </td>
                        <td class="col-2"></td>
                        <td class="col-2">
                            <a href="game.php?page=buddyList&amp;mode=delete&amp;id={$myRequestID}">
                                <img src="{$dpath}img/general/false.png" alt="{$LNG.bu_cancel_request}" title="{$LNG.bu_cancel_request}">
                            </a>
                        </td>
                    </tr>
                    {foreachelse}                    
                    <tr class="row col-12 classificabarra">
                        <td class="col-12">{$LNG.bu_no_request}</td>
                    </tr>
                    {/foreach}
                    {/if}
                    <tr class="row col-12">
                        <th class="col-12" style="text-align:center;margin-top:7px;height: 8px;line-height: 9px;">{$LNG.bu_partners}</th>
                    </tr>
                    <tr class="row col-12 barraclass">
                        <th class="col-3">{$LNG.bu_player}</th>
                        <th class="col-3">{$LNG.bu_alliance}</th>
                        <th class="col-2">{$LNG.bu_coords}</th>
                        <th class="col-2">{$LNG.bu_online}</th>
                        <th class="col-2">{$LNG.bu_action}</th>
                    </tr>
                    {foreach $myBuddyList as $myBuddyID => $myBuddyRow}
                    <tr class="row col-12 mt-1 classificabarra">
                        <td class="col-3">
                            <a href="#" onclick="return Dialog.PM({$myBuddyRow.id});">{$myBuddyRow.username}</a>
                        </td>
                        <td class="col-3">
                            {if {$myBuddyRow.ally_name}}
                                <a href="game.php?page=alliance&amp;mode=info&amp;id={$myBuddyRow.ally_id}">{$myBuddyRow.ally_name}</a>
                            {else}
                                -
                            {/if}
                        </td>
                        <td class="col-2">
                            <a href="game.php?page=galaxy&amp;galaxy={$myBuddyRow.galaxy}&amp;system={$myBuddyRow.system}">
                                [{$myBuddyRow.galaxy}:{$myBuddyRow.system}:{$myBuddyRow.planet}]
                            </a>
                        </td>
                        <td class="col-2">
                            {if $myBuddyRow.onlinetime < 4}
                                <span style="color:lime">{$LNG.bu_connected}</span>
                            {elseif $myBuddyRow.onlinetime >= 4 && $myBuddyRow.onlinetime <= 15}
                                <span style="color:yellow">{$myBuddyRow.onlinetime} {$LNG.bu_minutes}</span>
                            {else}
                                <span style="color:red">{$LNG.bu_disconnected}</span>
                            {/if}
                        </td>
                        <td class="col-2">
                            <a href="game.php?page=buddyList&amp;mode=delete&amp;id={$myBuddyID}">
                                <img src="{$dpath}img/general/false.png" alt="{$LNG.bu_delete}" title="{$LNG.bu_delete}">
                            </a>
                        </td>
                    </tr>
                    {foreachelse}
                    <tr class="row col-12 classificabarra">
                        <td class="col-12">{$LNG.bu_no_buddys}</td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
            <div class="alleanza57"></div>
            <div class="fleettab1" style="height:21px;">
                {if isModuleAvailable($smarty.const.MODULE_NOTICE)}
                <a href="javascript:OpenPopup('?page=notes', 'notes', 1300, 300);" class="tornaindietroa" style="left: 0;border-radius: 0px 0px 0px 4px;moz-border-radius: 0px 0px 0px 4px;-webkit-border-radius: 0px 0px 0px 4px;right: auto;">{$LNG.lm_notes}</a>
                {/if}
                {if isModuleAvailable($smarty.const.MODULE_SEARCH)}
                <a href="game.php?page=search" class="tornaindietroa" style="border-radius: 0px 0px 4px 0px;moz-border-radius: 0px 0px 4px 0px;-webkit-border-radius: 0px 0px 4px 0px">{$LNG.lm_search}</a>
                {/if}
            </div>
        </div>
    </div>
</div>
{/block}