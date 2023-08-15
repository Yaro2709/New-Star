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
                            <th><label for="id">{$LNG.input_id_user}</label></th>
                            <th><input name="id" value="0" type="text" class="form-control" id="id"></th>
                        </tr>
                    </thead>
                </table>
                <table class="table table-dark table-hover">
                    <thead>
                        <tr>
                            <th>{$LNG.input_id}</th>
                            <th>{$LNG.class_name}</th>
                            <th>{$LNG.class_lvl}</th>
                        </tr>
                    </thead>
                    <tbody>
                    {foreach key=id item=input from=$inputlist}
                        <tr>
                            <td><label for="{$id}">{$id}</label></td>
                            <td><label for="{$id}">{$LNG.tech.{$id}}</label></td>
                            <td><input name="{$input.type}" value="0" type="text" class="form-control" id="{$id}"></td>
                        </tr>
                    {/foreach}
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