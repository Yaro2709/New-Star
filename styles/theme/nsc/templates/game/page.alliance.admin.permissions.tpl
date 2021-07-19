{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<style>
    
    .ui-dialog {
    display: block;
    z-index: 1002;
    outline: 0px;
    height: auto;
    width: 760px;
    top: 189px;
    left: 122px;
}
</style>
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner">
         {$countRank = count($availableRanks)}
         <form action="game.php?page=alliance&amp;mode=admin&amp;action=permissionsSend" method="post">
            <input type="hidden" value="1" name="send">
            {*<div class="gray_stripe" style="padding-right:0;">
               {$LNG.al_configura_ranks}
               <button id="create_new_alliance_rank" class="right_flank">{$LNG.all_create}</button>
            </div>*}
            <div class="gray_stripo" style="padding-right:0;">
                {$LNG.al_configura_ranks}
                <div class="tornaindietro">  <a href="game.php?page=alliance&amp;mode=admin">{$LNG.al_back}</a></div>
            </div>
            <table class="ally_ranks">
               <tr style="background: #000813;height: 25px;">
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
               <tr style="height: 40px;">
                    <td colspan="15">{$LNG.al_no_ranks_defined}</td>
                </tr>
               {/foreach}
               <tr style="background: #000813;height:35px;">
                    <td colspan="7" style="border-top:1px solid rgba(163, 163, 163, 0.07) !important"><input type="submit" value="{$LNG.al_save}" class="alleanza63"></td>
                    <td colspan="8" style="border-top:1px solid rgba(163, 163, 163, 0.07) !important"> <button id="create_new_alliance_rank" class="alleanza63">{$LNG.all_create}</button></td>
                </tr>
            </table>
         </form>
      </div>
      <div id="new_alliance_rank" title="{$LNG.al_create_new_rank}" style="display:none;">
            <form action="game.php?page=alliance&amp;mode=admin&amp;action=permissionsSend" method="post">
                <table class="ally_ranks">
                    <tbody>
                    <tr style="background: #000813;height: 25px;">
                        <td style="border-bottom:1px solid rgba(163, 163, 163, 0.07) !important;"><label for="rankName">{$LNG.al_rank_name}</label></td>
                        <td colspan="2" style="border-bottom:1px solid rgba(163, 163, 163, 0.07) !important;"><input style="width:96%" type="text" name="newrank[rankName]" size="20" maxlength="32" id="rankName"></td>
                    </tr>
                    <tr>
                        <th colspan="{$countRank + 2}">&nbsp;</th>
                    </tr>
                    {foreach $availableRanks as $rankId => $rankName}
                    <tr class="alleanza62">
                        <td style="text-align:right;">{$LNG.al_rank_desc[$rankName]}</td>
                        <td><input type="checkbox" name="newrank[{$rankId}]" value="1" title="{$LNG.al_rank_desc[$rankName]}"></td>
                        <td><img src="{$dpath}img/alliance/{$rankName}.png" alt="{$rankName}" width="16" height="16"></td>
                    </tr>
                    {/foreach}
                    <tr>
                        <td colspan="{$countRank + 2}" style="height: 25px;background: #000813;padding: 7px;border-top: 1px solid rgba(163, 163, 163, 0.07) !important;"><input type="submit" value="{$LNG.al_create}"></td>
                    </tr>
                    </tbody>
                </table>
            </form>
        </div>
   </div>
</div>
</div>
<div class="clear"></div>
</div>
{/block}