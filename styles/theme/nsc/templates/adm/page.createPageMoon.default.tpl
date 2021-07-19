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
                    <label for="add_moon">{$LNG.input_id_planet}</label>
                    <input type="text" name="add_moon" class="form-control" id="add_moon">
                </div>
                <div class="form-group">
                    <label for="name">{$LNG.cr_moon_name}</label>
                    <input type="text" value="{$LNG.cr_mo_moon}" name="name" class="form-control" id="name">
                </div>
                <div class="form-group">
                    <label for="diameter">{$LNG.cr_diameter}</label>
                    <input type="text" name="diameter" class="form-control" id="diameter">
                </div>
                <div class="form-group form-check">
                    <input type="checkbox" checked="checked" name="diameter_check" class="form-check-input" id="diameter_check">
                    <label class="form-check-label" for="diameter_check">{$LNG.cr_moon_random}</label>
                </div>
                <div class="form-group">
                    <label for="field_max">{$LNG.cr_fields_max}</label>
                    <input type="text" name="field_max" class="form-control" id="field_max">
                </div>
                <input class="btn btn-primary" type="submit" value="{$LNG.button_add}">
            </form>
        </div>
    </div>
</main>
{/block}