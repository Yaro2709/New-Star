{block name="title" prepend}{$LNG.write_message}{/block}
{block name="content"}
<div id="ally_content" class="conteiner" style="width:auto">
   <div class="gray_stripe">
      {$LNG.mg_to}: <span class="message_recipient_name">{$OwnerRecord.username} [{$OwnerRecord.galaxy}:{$OwnerRecord.system}:{$OwnerRecord.planet}]</span> 
      <span style="float:right; color:#8e9394;">({$LNG.mg_characters} <span id="cntChars">0</span>/5.000)</span>
   </div>
   <form name="message" id="message" action="">
      <div class="statbarsup1" style="margin: 7px 7px 7px 7px;">
          <input class="message_subject" name="subject" id="subject" size="40" maxlength="40" placeholder="Title" value="{if !empty($subject)}{$subject}{else}{$LNG.mg_no_subject}{/if}" type="text">
          <div class="clear" style="border-bottom:1px solid #000;"></div>
          <textarea class="message_text_message" placeholder="{$LNG.mg_text}" name="text" id="text" cols="40" rows="10" onkeyup="$('#cntChars').text($(this).val().length); keyUp(event);" onkeydown="keyDown(event)"></textarea>
      </div>
      <div class="build_band2" style="padding-right:0;">       		
         <input class="bottom_band_submit message_check_message" id="submit" onclick="check();" name="button" value="{$LNG.mg_send}" type="button"> 
         <span style="color:#999; float:right; margin-right:10px;">[ctrl + enter]</span>
      </div>
   </form>
</div>
{/block}
{block name="script" append}
<script type="text/javascript">
   function check(){
   	if($('#text').val().length == 0) {
   		alert('{$LNG.mg_empty_text}');
   		return false;
   	} else {
   		$('submit').attr('disabled','disabled');
   		$.post('game.php?page=messages&mode=send&id={$id}&ajax=1', $('#message').serialize(), function(data) {
   			alert(data);
   			parent.$.fancybox.close();
   			return true;
   		}, 'json');
   	}
   }
</script>
{/block}