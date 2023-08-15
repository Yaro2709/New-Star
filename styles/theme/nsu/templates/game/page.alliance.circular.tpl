{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="ally_content" class="conteiner">
   <div class="gray_stripe">
      {$LNG.al_message}
      <span style="float:right; color:#8e9394;">({$LNG.mg_characters} <span id="cntChars">0</span>/5.000)</span>
   </div>
   <form name="message" id="message">
      <div class="statbarsup1" style="margin: 7px;">
      <table class="tablesorter ally_ranks">
         <tbody>
            <tr>
               <td>{$LNG.al_receiver} 
                  {html_options name=rankID options=$RangeList}
               </td>
               <td>
                  <label for="subject">{$LNG.nt_subject_note}:</label> 
                  <input name="subject" id="subject" size="40" placeholder="{$LNG.nt_title}" maxlength="40" type="text">
               </td>
            </tr>
            <tr>
               <td colspan="2">
                  <textarea placeholder="{$LNG.ti_mess}" name="text" cols="60" rows="10" onkeyup="$('#cntChars').text($(this).val().length);"></textarea>
               </td>
            </tr>
         </tbody>
      </table>
      </div>
      <div class="fleettab1" style="height: 32px;"> 
            <button type="reset" class="rexx13">{$LNG.al_circular_reset}</button>
            <button onclick="return check();" name="button" class="rexx12">{$LNG.al_circular_send_submit}</button>
      </div>
   </form>
</div>
{/block}
{block name="script" append}
<script type="text/javascript">
function check(){
	if(document.message.text.value == '') {
		alert('{$LNG.mg_empty_text}');
		return false;
	} else {
		$.post('game.php?page=alliance&mode=circular&action=send&ajax=1', $('#message').serialize(), function(data){
			data = $.parseJSON(data);
			alert(data.message);
			if(!data.error) {
				parent.$.fancybox.close();
			}
		});
		return true;
	}
}
</script>
{/block}