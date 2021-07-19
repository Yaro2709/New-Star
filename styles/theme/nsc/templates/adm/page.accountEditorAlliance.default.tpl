{block name="title" prepend}{$LNG.lm_accounteditor}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_accounteditor}</h5>
        <div class="card-body">
            <form action="" method="post">
                <table class="table table-dark table-hover">
                    <thead>
                        <tr>
                            <th><label for="id">{$LNG.input_id_ally}</label></th>
                            <th><input name="id" type="text" class="form-control" id="id"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label for="changeleader">{$LNG.ac_ally_change_id}</label></td>
                            <td><input name="changeleader" type="text" class="form-control" id="changeleader"></td>
                        </tr>
                        <tr>
                            <td><label for="name">{$LNG.ac_ally_name}</label></td>
                            <td><input name="name" type="text" class="form-control" id="name"></td>
                        </tr>
                        <tr>
                            <td><label for="tag">{$LNG.ac_ally_tag}</label></td>
                            <td><input name="tag" type="text" class="form-control" id="tag"></td>
                        </tr>
                        <tr>
                            <td><label for="delete_u">{$LNG.ac_ally_delete_u}</label></td>
                            <td><input name="delete_u" type="text" class="form-control" id="delete_u"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="delete">{$LNG.ac_ally_delete}</label></td>
                            <td><input name="delete" type="checkbox" class="form-check-input" id="delete"></td>
                        </tr>
                        <tr>
                            <td><label for="externo">{$LNG.ac_ally_text1}</label></td>
                            <td><textarea name="externo" type="text" class="form-control" id="externo"></textarea></td>
                        </tr>
                        <tr>
                            <td><label for="interno">{$LNG.ac_ally_text2}</label></td>
                            <td><textarea name="interno" type="text" class="form-control" id="interno"></textarea></td>
                        </tr>
                        <tr>
                            <td><label for="solicitud">{$LNG.ac_ally_text3}</label></td>
                            <td><textarea name="solicitud" type="text" class="form-control" id="solicitud"></textarea></td>
                        </tr>
                    </tbody>
                </table>
                <input class="btn btn-primary" type="submit" value="{$LNG.button_submit}">
            </form>
        </div>
    </div>
</main>
{/block}