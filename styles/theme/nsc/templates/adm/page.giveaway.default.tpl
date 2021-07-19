{block name="title" prepend}{$LNG.lm_giveaway}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_giveaway}</h5>
        <div class="card-body">
            <form method="post">
            <input type="hidden" name="action" value="send">
                <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" id="pills-900-tab" data-toggle="pill" href="#pills-900" role="tab" aria-controls="pills-900" aria-selected="false">{$LNG.tech.900}</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" id="pills-0-tab" data-toggle="pill" href="#pills-0" role="tab" aria-controls="pills-0" aria-selected="false">{$LNG.tech.0}</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" id="pills-100-tab" data-toggle="pill" href="#pills-100" role="tab" aria-controls="pills-100" aria-selected="false">{$LNG.tech.100}</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" id="pills-200-tab" data-toggle="pill" href="#pills-200" role="tab" aria-controls="pills-200" aria-selected="false">{$LNG.tech.200}</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" id="pills-400-tab" data-toggle="pill" href="#pills-400" role="tab" aria-controls="pills-400" aria-selected="false">{$LNG.tech.400}</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" id="pills-600-tab" data-toggle="pill" href="#pills-600" role="tab" aria-controls="pills-600" aria-selected="false">{$LNG.tech.600}</a>
                    </li>
                </ul>
                <div class="form-group form-check">
                    <input name="planet" value="1" checked type="checkbox" class="form-check-input" id="planet">
                    <label class="form-check-label" for="planet">{$LNG.fcm_planet}</label>
                </div>
                <div class="form-group form-check">
                    <input name="moon" value="1" checked type="checkbox" class="form-check-input" id="moon">
                    <label class="form-check-label" for="moon">{$LNG.fcm_moon}</label>
                </div>
                <div class="form-group form-check">
                    <input name="mainplanet" value="1" checked type="checkbox" class="form-check-input" id="mainplanet">
                    <label class="form-check-label" for="mainplanet">{$LNG.gi_homecoordinates}</label>
                </div>
                <div class="form-group form-check">
                    <input name="no_inactive" value="1" checked type="checkbox" class="form-check-input" id="no_inactive">
                    <label class="form-check-label" for="no_inactive">{$LNG.gi_no_inactives}</label>
                </div>
                <div class="tab-content" id="pills-tabContent">
                    <div class="tab-pane fade show" id="pills-900" role="tabpanel" aria-labelledby="pills-900-tab">
                        <table class="table table-dark table-hover">
                            <thead>
                                <tr>
                                    <th colspan="2">{$LNG.tech.900}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach item=Element from=$reslist.resstype.1}
                                <tr>
                                    <td><label for="{$Element}">{$LNG.tech.{$Element}}</label></td>
                                    <td><input name="element_{$Element}" value="0" type="text" class="form-control" id="{$Element}" pattern="[0-9]*"></td>
                                </tr>
                                {/foreach}
                                {foreach item=Element from=$reslist.resstype.3}
                                <tr>
                                    <td><label for="{$Element}">{$LNG.tech.{$Element}}</label></td>
                                    <td><input name="element_{$Element}" value="0" type="text" class="form-control" id="{$Element}" pattern="[0-9]*"></td>
                                </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div> 
                    <div class="tab-pane fade show" id="pills-0" role="tabpanel" aria-labelledby="pills-0-tab">
                        <table class="table table-dark table-hover">
                            <thead>
                                <tr>
                                    <th colspan="2">{$LNG.tech.0}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach item=Element from=$reslist.build}
                                <tr>
                                    <td><label for="{$Element}">{$LNG.tech.{$Element}}</label></td>
                                    <td><input name="element_{$Element}" value="0" type="text" class="form-control" id="{$Element}" pattern="[0-9]*"></td>
                                </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade show" id="pills-100" role="tabpanel" aria-labelledby="pills-100-tab">
                        <table class="table table-dark table-hover">
                            <thead>
                                <tr>
                                    <th colspan="2">{$LNG.tech.100}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach item=Element from=$reslist.tech}
                                <tr>
                                    <td><label for="{$Element}">{$LNG.tech.{$Element}}</label></td>
                                    <td><input name="element_{$Element}" value="0" type="text" class="form-control" id="{$Element}" pattern="[0-9]*"></td>
                                </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade show" id="pills-200" role="tabpanel" aria-labelledby="pills-200-tab">
                        <table class="table table-dark table-hover">
                            <thead>
                                <tr>
                                    <th colspan="2">{$LNG.tech.200}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach item=Element from=$reslist.fleet}
                                <tr>
                                    <td><label for="{$Element}">{$LNG.tech.{$Element}}</label></td>
                                    <td><input name="element_{$Element}" value="0" type="text" class="form-control" id="{$Element}" pattern="[0-9]*"></td>
                                </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade show" id="pills-400" role="tabpanel" aria-labelledby="pills-400-tab">
                        <table class="table table-dark table-hover">
                            <thead>
                                <tr>
                                    <th colspan="2">{$LNG.tech.400}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach item=Element from=$reslist.defense}
                                <tr>
                                    <td><label for="{$Element}">{$LNG.tech.{$Element}}</label></td>
                                    <td><input name="element_{$Element}" value="0" type="text" class="form-control" id="{$Element}" pattern="[0-9]*"></td>
                                </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade show" id="pills-600" role="tabpanel" aria-labelledby="pills-600-tab">
                        <table class="table table-dark table-hover">
                            <thead>
                                <tr>
                                    <th colspan="2">{$LNG.tech.600}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach item=Element from=$reslist.officier}
                                <tr>
                                    <td><label for="{$Element}">{$LNG.tech.{$Element}}</label></td>
                                    <td><input name="element_{$Element}" value="0" type="text" class="form-control" id="{$Element}" pattern="[0-9]*"></td>
                                </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
                <input class="btn btn-primary" type="submit" value="{$LNG.button_add}">
            </form>
        </div>
    </div>
</main>
{/block}