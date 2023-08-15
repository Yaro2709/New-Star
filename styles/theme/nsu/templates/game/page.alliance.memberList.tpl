{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner">
         <div class="gray_stripo" style="margin-bottom:5px;">
            {$al_users_list}
            <div class="tornaindietro"> <a href="game.php?page=alliance">{$LNG.al_back}</a></div>
        </div> 
         <table id="memberList" class="tablesorter ally_ranks gray_stripe_th">
            <thead>
               <tr>
                  <th style="border-left:0; padding-left:15px; text-align:left;">{$LNG.al_member}</th>
                  <th></th>
                  <th>{$LNG.al_position}</th>
                  <th>{$LNG.al_points}</th>
                  <th>{$LNG.al_coords}</th>
                  <th>{$LNG.al_member_since}</th>
                  <th>{$LNG.al_estate}</th>
               </tr>
            </thead>
            <tbody>
               {foreach $memberList as $userID => $memberListRow}
               <tr class="alleanza62">
                  <td style="text-align:left; padding-left:15px;"><a href="#" onclick="return Dialog.Playercard({$userID}, '{$memberListRow.username}');">{$memberListRow.username}</a></td>
                  <td style="text-align:center;"><a href="#" onclick="return Dialog.PM({$userID});" class="batn_lincks mesages" style="height:15px; float:none; padding-left:15px; margin-left:5px;"></a></td>
                  <td>{$memberListRow.rankName}</td>
                  <td>{shortly_number($memberListRow.points)}</td>
                  <td><a href="game.php?page=galaxy&amp;galaxy={$memberListRow.galaxy}&amp;system={$memberListRow.system}">[{$memberListRow.galaxy}:{$memberListRow.system}:{$memberListRow.planet}]</a></td>
                  <td>{$memberListRow.register_time}</td>
                  <td>
                     {if $rights.ONLINESTATE}{if $memberListRow.onlinetime < 4}
                     <span style="color:#009e4a">{$LNG.al_memberlist_on}</span>
                     {elseif $memberListRow.onlinetime <= 15}<span style="color:yellow">{$memberListRow.onlinetime} {$LNG.al_memberlist_min}</span>
                     {else}<span style="color:#c34e4e">{$LNG.al_memberlist_off}</span>{/if}{else}-{/if}
                  </td>
               </tr>
               {/foreach}
            </tbody>
         </table>
      </div>
   </div>
</div>
<div class="clear"></div>
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