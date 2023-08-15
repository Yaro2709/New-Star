{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
   <div id="content">
      <form action="game.php?page=alliance&amp;mode=admin&amp;action=membersSave" method="post">
         <div id="ally_content" class="conteiner">
         <div class="gray_stripo" style="margin-bottom:5px;">
            {$al_users_list}
            <div class="tornaindietro"> <a href="game.php?page=alliance&amp;mode=admin">{$LNG.al_back}</a></div>
        </div>   
            <table id="memberList" class="tablesorter ally_ranks gray_stripe_th">
               <thead>
                  <tr>
                     <th style="border-left:0; padding-left:15px; text-align:left;">
                     {$LNG.al_member}</th>
                     <th></th>
                     <th>{$LNG.al_position}</th>
                     <th>{$LNG.al_points}</th>
                     <th>{$LNG.al_coords}</th>
                     <th>{$LNG.al_member_since}</th>
                     <th>{$LNG.al_estate}</th>
                     <th>{$LNG.al_actions}</th>
                  </tr>
               </thead>
               <tbody>
                {foreach $memberList as $userID => $memberListRow}
                    <tr class="alleanza62">
                        <td><a href="#" onclick="return Dialog.Playercard({$userID},'{$memberListRow.username}');">{$memberListRow.username}</a></td>
                        <td><a href="#" onclick="return Dialog.PM({$userID});"><img src="{$dpath}img/iconav/mesages.png" border="0" title="{$LNG.write_message}"></a></td>
                        <td>{if $memberListRow.rankID == -1}{$founder}{elseif !empty($rankSelectList)}{html_options class="rankSelect" name="rank[{$userID}]" options=$rankSelectList selected=$memberListRow.rankID}{else}{$rankList[$memberListRow.rankID]}{/if}</td>
                        <td><span title="{$memberListRow.points|number}">{shortly_number($memberListRow.points)}</span></td>
                        <td><a href="game.php?page=galaxy&amp;galaxy={$memberListRow.galaxy}&amp;system={$memberListRow.system}">[{$memberListRow.galaxy}:{$memberListRow.system}:{$memberListRow.planet}]</a></td>
                        <td>{$memberListRow.register_time}</td>
                        <td>{if $rights.ONLINESTATE}{if $memberListRow.onlinetime < 4}<span style="color:#009e4a">{$LNG.al_memberlist_on}</span>{elseif $memberListRow.onlinetime >= 4 && $memberListRow.onlinetime <= 15}<span style="color:yellow">{$memberListRow.onlinetime} {$LNG.al_memberlist_min}</span>{else}<span style="color:#c34e4e">{$LNG.al_memberlist_off}</span>{/if}{else}-{/if}</td>
                        <td>{if $memberListRow.rankID != -1}
                        {if $canKick}<a href="game.php?page=alliance&amp;mode=admin&amp;action=membersKick&amp;id={$userID}" onclick="return confirm('{$memberListRow.kickQuestion}');" style="border: 1px solid #212121;vertical-align:top;width:16px;height:16px;display:inline-block;margin:2px;"><img src="{$dpath}img/general/false.png" border="0" alt=""></a>{/if}{else}-{/if}</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
         </div>
      </form>
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
                    3: { sorter: false } ,
                    9: { sorter: false }
                },
                debug: false
            });

            $('.rankSelect').on('change', function () {
                $.post('game.php?page=alliance&mode=admin&action=rank&ajax=1', $(this).serialize(), function (data) {
                    //NotifyBox(data);
                }, 'json');
            });
        });
    </script>
{/block}