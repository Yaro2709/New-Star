{block name="title" prepend}{$LNG.lm_create}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_create}</h5>
        <div class="card-body">
            <form action="" method="post">
            <input type="hidden" name="class" value="agregar">
                <div class="form-group">
                    <label for="id">{$LNG.input_id_user}</label>
                    <input name="id" type="text" class="form-control" id="id">
                </div>
                <div class="form-group">
                    <label for="coord">{$LNG.cr_new_coord}</label>
                    <div class="input-group">
                        <input name="galaxy" type="text" class="form-control" id="coord">
                        <input name="system" type="text" class="form-control">
                        <input name="planet" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label for="name">{$LNG.cr_name_planet}</label>
                    <input name="name" type="text" class="form-control" id="name">
                </div>
                <div class="form-group">
                    <label for="field_max">{$LNG.cr_fields_max}</label>
                    <input name="field_max" type="text" class="form-control" id="field_max">
                </div>
                <input class="btn btn-primary" type="submit" value="{$LNG.button_add}">
            </form>
        </div>
    </div>
</main>
{/block}