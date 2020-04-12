{block name="title" prepend}{$LNG.lm_notes}{/block}
{block name="content"}
<div id="ally_content" class="conteiner" style="width:auto;">
   <div class="gray_stripe">
      {if $noteDetail.id == 0}{$LNG.nt_create_note}{else}{$LNG.nt_edit_note}{/if}        
      <span style="float:right; color:#8e9394;">(<span id="cntChars">0</span>&nbsp;/&nbsp;5.000&nbsp;{$LNG.nt_characters})</span>
   </div>
   <form action="?page=notes&amp;mode=insert" method="post">
      <input type="hidden" name="id" value="{$noteDetail.id}">
      <table class="ally_ranks gray_stripe_th td_border_bottom">
         <tbody>
            <tr>
               <td style="text-align:left;">
                  <label for="priority">{$LNG.nt_priority}:</label>
                  {html_options id=priority name=priority options=$PriorityList selected=$noteDetail.priority}
               </td>
               <td>
                  <label>{$LNG.nt_subject_note}:</label>
                  <input id="title" placeholder="{$LNG.nt_title}" name="title" size="30" maxlength="30" value="{$noteDetail.title}" type="text">
               </td>
            </tr>
            <tr>
               <td colspan="2">
                  <textarea name="text" placeholder="{$LNG.nt_text}" id="text" cols="60" rows="10" onkeyup="$('#cntChars').text($(this).val().length);">{$noteDetail.text}</textarea>
               </td>
            </tr>
            <tr>
               <td colspan="2" style="text-align:center;">
                  <input value="{$LNG.nt_reset}" type="reset">
                  <input value="{$LNG.nt_save}" type="submit">
                  <a style="float:right;" href="game.php?page=notes">{$LNG.nt_back}</a>
               </td>
            </tr>
         </tbody>
      </table>
   </form>
</div>
{/block}