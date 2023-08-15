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
                            <th><input name="id" type="text" class="form-control" id="id"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label for="name">{$LNG.ac_pla_edit_name}</label></td>
                            <td><input name="name" type="text" class="form-control" id="name"></td>
                        </tr>
                        <tr>
                            <td><label for="diameter">{$LNG.ac_pla_edit_diameter}</label></td>
                            <td><input name="diameter" type="text" class="form-control" id="diameter"></td>
                        </tr>
                        <tr>
                            <td><label for="fields">{$LNG.ac_pla_edit_fields}</label></td>
                            <td><input name="fields" type="text" class="form-control" id="fields"></td>
                        </tr>
                        <tr>
                            <td><label for="coord">{$LNG.cr_new_coord}</label></td>
                            <td>
                                <div class="input-group">
                                    <input name="g" type="text" class="form-control" id="coord">
                                    <input name="s" type="text" class="form-control">
                                    <input name="p" type="text" class="form-control">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="change_position">{$LNG.ac_pla_change_pp}</label></td>
                            <td><input name="change_position" type="checkbox" class="form-check-input" id="change_position"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="0_buildings">{$LNG.ac_pla_delete_b}</label></td>
                            <td><input name="0_buildings" type="checkbox" class="form-check-input" id="0_buildings"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="0_ships">{$LNG.ac_pla_delete_s}</label></td>
                            <td><input name="0_ships" type="checkbox" class="form-check-input" id="0_ships"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="0_defenses">{$LNG.ac_pla_delete_d}</label></td>
                            <td><input name="0_defenses" type="checkbox" class="form-check-input" id="0_defenses"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="0_c_hangar">{$LNG.ac_pla_delete_hd}</label></td>
                            <td><input name="0_c_hangar" type="checkbox" class="form-check-input" id="0_c_hangar"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="0_c_buildings">{$LNG.ac_pla_delete_cb}</label></td>
                            <td><input name="0_c_buildings" type="checkbox" class="form-check-input" id="0_c_buildings"></td>
                        </tr>
                    </tbody>
                </table>
                <input class="btn btn-primary" type="submit" value="{$LNG.button_submit}">
                <input class="btn btn-primary" type="reset" value="{$LNG.button_reset}">
            </form>
        </div>
    </div>
</main>
{/block}