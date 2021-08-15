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
                            <th><label for="id">{$LNG.input_id_p_m}</label></th>
                            <th><input name="id" value="0" type="text" class="form-control" id="id"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label for="901">{$LNG.tech.901}</label></td>
                            <td><input name="metal" value="0" type="text" class="form-control" id="901"></td>
                        </tr>
                        <tr>
                            <td><label for="902">{$LNG.tech.902}</label></td>
                            <td><input name="cristal" value="0" type="text" class="form-control" id="902"></td>
                        </tr>
                        <tr>
                            <td><label for="903">{$LNG.tech.903}</label></td>
                            <td><input name="deut" value="0" type="text" class="form-control" id="903"></td>
                        </tr>
                    </tbody>
                </table>
                <table class="table table-dark table-hover">
                    <thead>
                        <tr>
                            <th><label for="id_dark">{$LNG.input_id_user}</label></th>
                            <th><input name="id_dark" value="0" type="text" class="form-control" id="id_dark"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label for="921">{$LNG.tech.921}</label></td>
                            <td><input name="dark" value="0" type="text" class="form-control" id="921"></td>
                        </tr>
                    </tbody>
                </table>
                <input class="btn btn-primary" type="reset" value="{$LNG.button_reset}">
                <input class="btn btn-primary" type="submit" value="{$LNG.button_add}" name="add">
                <input class="btn btn-primary" type="submit" value="{$LNG.button_delete}" name="delete">
            </form>
        </div>
    </div>
</main>
{/block}