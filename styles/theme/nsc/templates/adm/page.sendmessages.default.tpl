{block name="title" prepend}{$LNG.lm_sendmessages}{/block}
{block name="script" append}{/block}
{block name="content"}
<script type="text/javascript">
function check(){
	if($('#text').val().length == 0) {
		Dialog.alert('{$LNG.mg_empty_text}');
		return false;
	} else {
		$.post('admin.php?page=sendMessages&action=send&ajax=1', $('#message').serialize(), function(data) {
			Dialog.alert(data, function() {
				location.reload();
			});
		});
		return true;
	}
}
</script>
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_sendmessages}</h5>
        <div class="card-body">
            <form name="message" id="message" action="admin.php?page=sendMessages&action=send&ajax=1">
                <div class="form-group">
                    <label for="1">{$LNG.ma_mode}</label>
                    {html_options class="form-control" id="1" name=key options=$modes}
                </div>
                <div class="form-group">
                    <label for="2">{$LNG.cu_lang}</label>
                    {html_options class="form-control" id="2" name=globalmessagelang options=$langSelector}
                </div>
                <div class="form-group">
                    <label for="subject">{$LNG.ma_mode}</label>
                    <input value="{$LNG.ma_none}" name="subject" size="40" maxlength="40" type="text" class="form-control" id="subject">
                </div>
                <div class="form-group">
                    <label for="text">{$LNG.ma_message} (<span id="cntChars">0</span> / 5000 {$LNG.ma_characters})</label>
                    <textarea name="text" id="text" cols="40" rows="10" onkeyup="$('#cntChars').text($('#text').val().length);" class="form-control"></textarea>
                </div>
                <button type="button" onclick="check();" class="btn btn-primary">{$LNG.button_submit}</button>
            </form>
        </div>
    </div>
</main>
{/block}