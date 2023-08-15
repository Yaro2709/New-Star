{block name="title" prepend}{$LNG.lm_accounteditor}{/block}
{block name="script" append}{/block}
{block name="content"}
<script type="text/javascript">
function check(){
	$.post('?page=qeditor&edit=player&id={$id}&action=send', $('#userform').serialize(), function(data){
		Dialog.alert(data, function() {
			opener.location.reload();
			window.close();
		});
	});
	return false;
}
</script>
<main role="main">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_accounteditor}</h5>
        <div class="card-body">
            <form method="post" id="userform" action="" onsubmit="return check();">
                <table class="table table-dark table-hover mb-3">
                    <thead>
                        <tr>
                            <th colspan="3">{$LNG.qe_info}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>{$LNG.input_id_user}:</td>
                            <td>{$id}</td>
                        </tr>
                        <tr>
                            <td><label for="{$id}">{$LNG.qe_username}:</label></td>
                            <td><input name="name" type="text" size="15" value="{$name}" autocomplete="off" class="form-control" id="{$id}"></td>
                        </tr>
                        <tr>
                            <td>{$LNG.qe_hpcoords}:</td>
                            <td>{$planetname} [{$galaxy}:{$system}:{$planet}] ({$planetid})</td>
                        </tr>
                        {*if $authlevel != $smarty.const.AUTH_USER}
                            <tr>
                                <td>{$LNG.qe_authattack}:</td>
                                <td><input type="checkbox" name="authattack"{if $authattack != 0} checked{/if} class="form-control"></td>
                            </tr>
                        {/if*}
                        {if $ChangePW}
                            <tr>
                                <td>{$LNG.qe_password}:</td>
                                <td><a href="#" onclick="$('#password').css('display', '');$(this).css('display', 'none');return false">{$LNG.button_proceed}</a><input style="display:none;" id="password" name="password" type="password" size="15" value="" autocomplete="off" class="form-control"></td>
                            </tr>
                        {/if}
                        {if $ChangePW}
                            <tr>
                                <td><label for="multi">{$LNG.qe_allowmulti}:</label></td>
                                <td>{html_options name="multi" options=$yesorno selected=$multi class="form-control" id="multi"}</td>
                            </tr>
                        {/if}
                    </tbody>
                </table>
                <table class="table table-dark table-hover mb-3">
                    <thead>
                        <tr>
                            <th colspan="3">{$LNG.qe_resources}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label for="darkmatter">{$LNG.tech.921}:</label></td>
                            <td><label for="darkmatter">{$darkmatter_c}</label></td>
                            <td><input name="darkmatter" type="text" value="{$darkmatter}" class="form-control" id="darkmatter"></td>
                        </tr>
                    </tbody>
                </table>
                <table class="table table-dark table-hover mb-3">
                    <thead>
                        <tr>
                            <th colspan="3">{$LNG.tech.100}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach item=Element from=$tech}
                        <tr>
                            <td><label for="{$Element.type}">{$Element.name}:</label></td>
                            <td><label for="{$Element.type}">{$Element.count}</label></td>
                            <td><input name="{$Element.type}" type="text" value="{$Element.input}" class="form-control" id="{$Element.type}"></td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
                <table class="table table-dark table-hover mb-3">
                    <thead>
                        <tr>
                            <th colspan="3">{$LNG.tech.600}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach item=Element from=$officier}
                        <tr>
                            <td><label for="{$Element.type}">{$Element.name}:</label></td>
                            <td><label for="{$Element.type}">{$Element.count}</label></td>
                            <td><input name="{$Element.type}" type="text" value="{$Element.input}" class="form-control" id="{$Element.type}"></td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
                <input class="btn btn-primary" type="submit" value="{$LNG.button_submit}"> 
                <input class="btn btn-primary" type="reset" value="{$LNG.button_reset}">
            </form>
        </div>
    </div>
</main>
{/block}