{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="ally_content" class="conteiner">
   <div class="gray_stripe">
      {$LNG.al_diplo_text}
      <span style="float:right; color:#8e9394;">({$LNG.mg_characters} <span id="cntChars">0</span>/5.000)</span>
   </div>
   <form name="message" id="message">
      <div class="statbarsup1" style="margin: 7px;">
          <table class="tablesorter ally_ranks">
             <tbody>
                <tr>
                   <td>{$LNG.al_diplo_ally} {html_options name="ally_id" values=$IdList output=$AllyList}</td>
                   <td>{$LNG.al_diplo_level_des} {html_options name="level" values=range(1,6) output=$LNG.al_diplo_level selected=$diploMode}</td>
                </tr>
                <tr>
                   <td colspan="2">
                      <textarea placeholder="{$LNG.nt_text}" name="text" cols="60" rows="10" onkeyup="$('#cntChars').text($(this).val().length);"></textarea>
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
		$.getJSON('game.php?page=alliance&mode=admin&action=diplomacyCreateProcessor&ajax=1&'+$('#message').serialize(), function(data) {
			alert(data.message);
			if(!data.error) {
				parent.location.reload();
			}
		});
		return true;
	}
}

$(function() {	
	$('#name').autocomplete({
		source: "game.php?page=search&mode=autocomplete&type=allyname",
		minLength: 0,
		select: function(event, ui) {
			$(event.target).val(ui.item.label.replace(/<\/?b>/gim, ''));
			return false;
		}
	});
});
</script>
{/block}