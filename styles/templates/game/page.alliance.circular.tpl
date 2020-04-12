{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<div id="ally_content" class="conteiner">
   <div class="gray_stripe">
      {$LNG.al_message} <span style="float:right; color:#8e9394;">(<span id="cntChars">0</span> / 5000 {$LNG.symbol})</span>
   </div>
   <form name="message" id="message">
      <table class="ally_ranks gray_stripe_th td_border_bottom">
         <tbody>
            <tr>
               <td>{$LNG.al_receiver} 
                  {html_options name=rankID options=$RangeList}
               </td>
               <td>
                  <input name="subject" id="subject" size="40" placeholder="{$LNG.nt_title}" maxlength="40" type="text">
               </td>
            </tr>
            <tr>
               <td colspan="2">
                  <textarea placeholder="{$LNG.ti_mess}" name="text" cols="60" rows="10" onkeyup="$('#cntChars').text($(this).val().length);"></textarea>
               </td>
            </tr>
            <tr>
               <td colspan="2" style="text-align:center; border-bottom:0;">
                  <input type="reset" value="{$LNG.al_circular_reset}">
                  <input onclick="return check();" name="button" value="{$LNG.al_circular_send_submit}" type="button">
               </td>
            </tr>
         </tbody>
      </table>
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