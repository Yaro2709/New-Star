{block name="title" prepend}{$LNG.lm_reset}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_reset}</h5>
        <div class="card-body">
            <form action="" method="post" onsubmit="return confirm('{$LNG.re_reset_universe_confirmation}');">
                <table class="table table-dark table-hover">
                    <thead>
                        <tr>
                            <th colspan="2">{$LNG.re_player_and_planets}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label class="form-check-label" for="players">{$LNG.re_reset_player}</label></td>
                            <td><input type="checkbox" name="players" id="players"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="planets">{$LNG.re_reset_planets}</label></td>
                            <td><input type="checkbox" name="planets" id="planets"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="moons">{$LNG.re_reset_moons}</label></td>
                            <td><input type="checkbox" name="moons" id="moons"></td>
                        </tr>
                    </tbody>
                    <thead>
                        <tr>
                            <th colspan="2">{$LNG.re_defenses_and_ships}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label class="form-check-label" for="defenses">{$LNG.re_defenses}</label></td>
                            <td><input type="checkbox" name="defenses" id="defenses"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="ships">{$LNG.re_ships}</label></td>
                            <td><input type="checkbox" name="ships" id="ships"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="h_d">{$LNG.re_reset_hangar}</label></td>
                            <td><input type="checkbox" name="h_d" id="h_d"></td>
                        </tr>
                    </tbody>
                    <thead>
                        <tr>
                            <th colspan="2">{$LNG.re_buldings}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label class="form-check-label" for="edif_p">{$LNG.re_buildings_pl}</label></td>
                            <td><input type="checkbox" name="edif_p" id="edif_p"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="edif_l">{$LNG.re_buildings_lu}</label></td>
                            <td><input type="checkbox" name="edif_l" id="edif_l"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="edif">{$LNG.re_reset_buldings}</label></td>
                            <td><input type="checkbox" name="edif" id="edif"></td>
                        </tr>
                    </tbody>    
                    <thead>
                        <tr>
                            <th colspan="2">{$LNG.re_inve_ofis}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label class="form-check-label" for="ofis">{$LNG.re_ofici}</label></td>
                            <td><input type="checkbox" name="ofis" id="ofis"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="inves">{$LNG.re_investigations}</label></td>
                            <td><input type="checkbox" name="inves" id="inves"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="inves_c">{$LNG.re_reset_invest}</label></td>
                            <td><input type="checkbox" name="inves_c" id="inves_c"></td>
                        </tr>
                    </tbody>
                    <thead>
                        <tr>
                            <th colspan="2">{$LNG.re_resources}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label class="form-check-label" for="dark">{$LNG.re_resources_dark}</label></td>
                            <td><input type="checkbox" name="dark" id="dark"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="resources">{$LNG.re_resources_met_cry}</label></td>
                            <td><input type="checkbox" name="resources" id="resources"></td>
                        </tr>
                    </tbody>
                    <thead>
                        <tr>
                            <th colspan="2">{$LNG.re_general}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label class="form-check-label" for="notes">{$LNG.re_reset_notes}</label></td>
                            <td><input type="checkbox" name="notes" id="notes"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="rw">{$LNG.re_reset_rw}</label></td>
                            <td><input type="checkbox" name="rw" id="rw"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="friends">{$LNG.re_reset_buddies}</label></td>
                            <td><input type="checkbox" name="friends" id="friends"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="alliances">{$LNG.re_reset_allys}</label></td>
                            <td><input type="checkbox" name="alliances" id="alliances"></td>
                        </tr>                    
                        <tr>
                            <td><label class="form-check-label" for="fleets">{$LNG.re_reset_fleets}</label></td>
                            <td><input type="checkbox" name="fleets" id="fleets"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="errors">{$LNG.re_reset_errors}</label></td>
                            <td><input type="checkbox" name="errors" id="errors"></td>
                        </tr>
                        
                        <tr>
                            <td><label class="form-check-label" for="banneds">{$LNG.re_reset_banned}</label></td>
                            <td><input type="checkbox" name="banneds" id="banneds"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="messages">{$LNG.re_reset_messages}</label></td>
                            <td><input type="checkbox" name="messages" id="messages"></td>
                        </tr>
                        <tr>
                            <td><label class="form-check-label" for="statpoints">{$LNG.re_reset_statpoints}</label></td>
                            <td><input type="checkbox" name="statpoints" id="statpoints"></td>
                        </tr>
                    </tbody>
                    <thead>
                        <tr>
                            <th style="text-align:left;">{$LNG.re_reset_all}</th>
                            <th style="width:10px;"><input type="checkbox" name="resetall" onclick="$('input').attr('checked', this.checked ? 'checked' : false)"></th>
                        </tr>
                    </thead>
                </table>
                <input class="btn btn-primary" type="submit" value="{$LNG.button_reset}">
            </form>
        </div>
    </div>
</main>
{/block}