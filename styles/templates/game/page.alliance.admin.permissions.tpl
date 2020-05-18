{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner">
         {$countRank = count($availableRanks)}
         <form action="game.php?page=alliance&amp;mode=admin&amp;action=permissionsSend" method="post">
            <input type="hidden" value="1" name="send">
            <div class="gray_stripe" style="padding-right:0;">
               {$LNG.al_configura_ranks}
               <button id="create_new_alliance_rank" class="right_flank">{$LNG.all_create}</button>
            </div>
            <table class="ally_ranks">
               <tr>
                  <td>{$LNG.al_rank_name}</td>
                  {foreach $availableRanks as $rankName}
                  <td><img src="{$dpath}img/alliance/{$rankName}.png" alt="" width="16" height="16"></td>
                  {/foreach}
               </tr>
               {foreach $rankList as $rowId => $rankRow}
               <tr>
                  <td><a href="game.php?page=alliance&amp;mode=admin&amp;action=permissionsSend&amp;deleteRank={$rowId}">X</a> <input type="text" name="rank[{$rowId}][rankName]" value="{$rankRow.rankName}"></td>
                  {foreach $availableRanks as $rankId => $rankName}
                   <td><input type="checkbox" name="rank[{$rowId}][{$rankId}]" value="1"{if $rankRow[$rankName]} checked{/if}{if !$ownRights[$rankName]} disabled{/if}></td>
                  {/foreach}
               </tr>
               {foreachelse}
               <tr>
                  <td colspan="15">{$LNG.al_no_ranks_defined}</td>
               </tr>
               {/foreach}
               <tr>
                  <td colspan="15"><input type="submit" value="{$LNG.al_save}"></td>
               </tr>
            </table>
         </form>
      </div>
      <div class="ally_bottom" style="text-align:left;">
         <a href="game.php?page=alliance&amp;mode=admin">{$LNG.al_back}</a>
      </div>
      <div id="new_alliance_rank" title="{$LNG.al_create_new_rank}" style="display:none;">
            <form action="game.php?page=alliance&amp;mode=admin&amp;action=permissionsSend" method="post">
                <table style="width:740px">
                    <tr>
                        <td><label for="rankName">{$LNG.al_rank_name}</label></td>
                        <td><input type="text" name="newrank[rankName]" size="20" maxlength="32" id="rankName" required></td>
                    </tr>
                    <tr>
                        <th colspan="{$countRank + 2}">&nbsp;</th>
                    </tr>
                    {foreach $availableRanks as $rankId => $rankName}
                    <tr>
                        <td><img src="{$dpath}img/alliance/{$rankName}.png" alt="{$rankName}" width="16" height="16">&nbsp;<label for="rank_{$rankId}">{$LNG.al_rank_desc[$rankName]}</label></td>
                        <td><input type="checkbox" name="newrank[{$rankId}]" value="1" id="rank_{$rankId}" title="{$LNG.al_rank_desc[$rankName]}"></td>
                    </tr>
                    {/foreach}
                    <tr>
                        <td colspan="{$countRank + 2}"><input type="submit" value="{$LNG.al_create}"></td>
                    </tr>
                </table>
            </form>
        </div>
   </div>
</div>
</div>
<div class="clear"></div>
</div>
{/block}