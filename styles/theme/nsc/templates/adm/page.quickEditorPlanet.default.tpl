{block name="title" prepend}{$LNG.lm_accounteditor}{/block}
{block name="script" append}{/block}
{block name="content"}
<script type="text/javascript">
function check(){
	$.post('?page=qeditor&edit=planet&id={$id}&action=send', $('#userform').serialize(), function(data){
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
                            <td>{$LNG.qe_id}:</td>
                            <td>{$id}</td>
                        </tr>
                        <tr>
                            <td><label for="name">{$LNG.qe_planetname}:</label></td>
                            <td><input name="name" type="text" size="15" value="{$name}" id="name" class="form-control"></td>
                        </tr>
                        <tr>
                            <td>{$LNG.qe_coords}:</td>
                            <td>[{$galaxy}:{$system}:{$planet}]</td>
                        </tr>
                        <tr>
                            <td>{$LNG.input_id_user}:</td>
                            <td>{$ownername} ({$ownerid})</td>
                        </tr>
                        <tr>
                            <td><label for="field_max">{$LNG.qe_fields}:</label></td>
                            <td>{$field_min} / <input name="field_max" type="text" size="3" value="{$field_max}" id="field_max" class="form-control"></td>
                        </tr>
                        <tr>
                            <td>{$LNG.qe_temp}:</td>
                            <td>{$temp_min} / {$temp_max}</td>
                        </tr>
                    </tbody>
                </table>
                <table class="table table-dark table-hover mb-3">
                    <thead>
                        <tr>
                            <th colspan="3">{$LNG.tech.900}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label for="metal">{$LNG.tech.901}:</label></td>
                            <td><label for="metal">{$metal_c}</label></td>
                            <td><input name="metal" type="text" value="{$metal}" class="form-control" id="metal"></td>
                        </tr>
                        <tr>
                            <td><label for="crystal">{$LNG.tech.902}:</label></td>
                            <td><label for="crystal">{$crystal_c}</label></td>
                            <td><input name="crystal" type="text" value="{$crystal}" class="form-control" id="crystal"></td>
                        </tr>
                        <tr>
                            <td><label for="deuterium">{$LNG.tech.903}:</label></td>
                            <td><label for="deuterium">{$deuterium_c}</label></td>
                            <td><input name="deuterium" type="text" value="{$deuterium}" class="form-control" id="deuterium"></td>
                        </tr>
                    </tbody>
                </table>
                <table class="table table-dark table-hover mb-3">
                    <thead>
                        <tr>
                            <th colspan="3">{$LNG.tech.0}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach item=Element from=$build}
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
                            <th colspan="3">{$LNG.tech.200}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach item=Element from=$fleet}
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
                            <th colspan="3">{$LNG.tech.400}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach item=Element from=$defense}
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