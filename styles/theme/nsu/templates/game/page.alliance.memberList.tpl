{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/statistics.css">
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteinership">
         <div class="gray_stripo" style="margin-bottom:5px;">
            {$al_users_list}
            <div class="tornaindietro"> <a href="game.php?page=alliance">{$LNG.al_back}</a></div>
        </div> 
        <table class="tablesorter ally_ranks tabstatistica">
            <tbody class="row" style="padding: 7px;">
                <tr class="row col-12 barraclass">
                    <th class="col-2">{$LNG.al_member}</th>
                    <th class="col-1">{$LNG.al_position}</th>
                    <th class="col-2">{$LNG.al_points}</th>
                    <th class="col-2">{$LNG.al_coords}</th>
                    <th class="col-3">{$LNG.al_member_since}</th>
                    <th class="col-2">{$LNG.al_estate}</th>
                </tr>
                {foreach $memberList as $userID => $memberListRow}
                <tr class="row col-12 mt-1 classificabarra">
                    <td class="col-2">
                        <a href="#" onclick="return Dialog.Playercard({$userID}, '{$memberListRow.username}');">{$memberListRow.username}</a>
                    </td>
                    <td class="col-1">{$memberListRow.rankName}</td>
                    <td class="col-2">{shortly_number($memberListRow.points)}</td>
                    <td class="col-2">
                        <a href="game.php?page=galaxy&amp;galaxy={$memberListRow.galaxy}&amp;system={$memberListRow.system}">               
                            [{$memberListRow.galaxy}:{$memberListRow.system}:{$memberListRow.planet}]
                        </a>
                    </td>
                    <td class="col-3">{$memberListRow.register_time}</td>
                    <td class="col-2">
                        {if $rights.ONLINESTATE}
                            {if $memberListRow.onlinetime < 4}
                                <span style="color:#009e4a">{$LNG.al_memberlist_on}</span>
                            {elseif $memberListRow.onlinetime <= 15}
                                <span style="color:yellow">{$memberListRow.onlinetime} {$LNG.al_memberlist_min}</span>
                            {else}
                                <span style="color:#c34e4e">{$LNG.al_memberlist_off}</span>
                            {/if}
                        {else}
                            -
                        {/if}
                    </td>
                </tr>
                {/foreach}
            </tbody>
        </table>
      </div>
   </div>
</div>

{/block}
{block name="script" append}
<script src="scripts/base/jquery.tablesorter.js"></script>
<script>$(function() {
    $("#memberList").tablesorter({
		headers: { 
			0: { sorter: false } ,
			3: { sorter: false } 
		},
		debug: false
	}); 
});</script>
{/block}