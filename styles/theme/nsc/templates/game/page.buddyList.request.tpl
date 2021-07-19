{block name="title" prepend}{$LNG.hnav_friends}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/statistics.css">
<div id="popup_conteirer">
<div id="content">
   <div id="ally_content" class="conteiner" style="width:auto">
      <div class="gray_stripe">
         {$LNG.bu_request_message} <span style="float:right; color:#8e9394;">(<span id="cntChars">0</span> / 5000 {$LNG.bu_characters})</span>
      </div>
      <form name="buddy" id="buddy" action="game.php?page=buddyList&amp;mode=send&amp;ajax=1" method="post">
         <input type="hidden" name="id" value="{$id}">
         <table class="ally_ranks gray_stripe_th td_border_bottom">
            <tbody>
               <tr>
                  <td style="text-align:left;">{$LNG.bu_player}: <input type="text" value="{$username} [{$galaxy}:{$system}:{$planet}]" size="40" readonly></td>
               </tr>
               <tr>
                  <td><textarea name="text" id="text" cols="40" rows="10" size="100" onkeyup="$('#cntChars').text($(this).val().length);"></textarea></td>
               </tr>
               <tr>
                  <td><input value="{$LNG.bu_send}" type="submit"></td>
               </tr>
            </tbody>
         </table>
      </form>
   </div>
</div>
{/block}