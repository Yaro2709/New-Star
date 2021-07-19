{block name="title" prepend}{$LNG.lm_ban}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <form action="" method="post" name="countt">
    {nocache}{if isset($name)}
        <div class="card mb-3">
            <h5 class="card-header">{$LNG.lm_ban}</h5>
            <div class="card-body">
                <table class="table table-dark table-hover">
                    <thead>
                        <tr>
                            <th colspan="2">{$bantitle}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label for="ban_name">{$LNG.bo_username}</label></td>
                            <td><input name="ban_name" type="text" value="{$name}" class="form-control" id="ban_name"></td>
                        </tr>
                        <tr>
                            <td><label for="why">{$LNG.bo_reason}</label></td>
                            <td>
                                <textarea id="why" class="form-control" name="why" maxlength="50" onkeyup="$('#result2').val(50 - parseInt($(this).val().length));">{$reas} {$timesus}</textarea>
                            </td>
                        </tr>
                        <tr>
                            <td><label for="result2">{$LNG.bo_characters_1}</label></td>
                            <td><input class="form-control" id="result2" value="50" size="2" class="character"></td>
                        </tr>
                    </tbody>
                    <thead>
                        <tr>
                            <th colspan="2">{$changedate}</th> {$changedate_advert}
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label class="form-check-label" for="permanent">{$LNG.bo_permanent}</label></td>
                            <td><input name="permanent" type="checkbox" class="form-check-input" id="permanent"></td>
                        </tr>
                        <tr>
                            <td><label for="days">{$LNG.time_days}</label></td>
                            <td><input name="days" type="text" value="0" class="form-control" id="days"></td>
                        </tr>
                        <tr>
                            <td><label for="hour">{$LNG.time_hours}</label></td>
                            <td><input name="hour" type="text" value="0" class="form-control" id="hour"></td>
                        </tr>
                        <tr>
                            <td><label for="mins">{$LNG.time_minutes}</label></td>
                            <td><input name="mins" type="text" value="0" class="form-control" id="mins"></td>
                        </tr>
                        <tr>
                            <td><label for="secs">{$LNG.time_seconds}</label></td>
                            <td><input name="secs" type="text" value="0" class="form-control" id="secs"></td>
                        </tr>
                    </tbody>
                    <thead>
                        <tr>
                            <th colspan="2">{$LNG.bo_vacaations}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label class="form-check-label" for="vacation">{$LNG.bo_vacation_mode}</label></td>
                            <td><input name="vacat" type="checkbox"{if $vacation} checked = "checked"{/if} class="form-check-input" id="vacation"></td>
                        </tr>
                    </tbody>
                </table>
                <input class="btn btn-primary" type="submit" value="{$LNG.button_submit}" name="bannow">
            </div>
        </div>
    {/if}{/nocache}
    </form>
    <div class="album">
        <div class="row">
            <div class="col-md-6">
                <div class="card mb-4 shadow-sm">
                    <h5 class="card-header">{$LNG.bo_ban_player}</h5>
                    <div class="card-body">
                        <form action="" method="POST" name="users">
                            <select class="form-control mb-3" name="ban_name" size="10">
                                {$UserSelect.List}
                            </select>
                            <script TYPE="text/javascript">
                                var UserList = new filterlist(document.getElementsByName('ban_name')[0]);
                            </script>
                            <div class="btn-group mb-3" role="group">
                                <a href="?page=ban">
                                    <button type="button" class="btn btn-secondary">{$LNG.bo_order_username}</button>
                                </a>
                                <a href="?page=ban&amp;order=id">
                                    <button type="button" class="btn btn-secondary">{$LNG.bo_order_id}</button>
                                </a>
                                <a href="?page=ban&amp;view=bana">
                                    <button type="button" class="btn btn-secondary">{$LNG.bo_order_banned}</button>
                                </a>
                            </div>
                            <input class="form-control mb-3" name="regexp" onKeyUp="UserList.set(this.value)">    
                            <input class="btn btn-primary" type="submit" value="{$LNG.bo_ban}" name="panel">       
                            <input class="btn btn-primary" type="button" onClick="UserList.set(this.form.regexp.value)" value="{$LNG.button_filter}">
                            <input class="btn btn-primary" type="button" onClick="UserList.reset();this.form.regexp.value=''" value="{$LNG.button_deselect}">
                            <input class="btn btn-primary" type="button" onClick="UserList.reset();this.form.regexp.value=''" value="{$LNG.button_reset}">
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mb-4 shadow-sm">
                    <h5 class="card-header">{$LNG.bo_unban_player}</h5>
                    <div class="card-body">
                        <form action="" method="POST" name="userban">
                            <select class="form-control mb-3" name="unban_name" size="10">
                                {$UserSelect.ListBan}
                            </select>
                            <script TYPE="text/javascript">
                                var UsersBan = new filterlist(document.getElementsByName('unban_name')[0]);
                            </script>
                            <div class="btn-group mb-3" role="group">
                                <a href="?page=ban">
                                    <button type="button" class="btn btn-secondary">{$LNG.bo_order_username}</button>
                                </a>
                                <a href="?page=ban&amp;order2=id">
                                    <button type="button" class="btn btn-secondary">{$LNG.bo_order_id}</button>
                                </a>
                            </div>
                            <input class="form-control mb-3" name="regexp" onKeyUp="UsersBan.set(this.value)">
                            <input class="btn btn-primary" value="{$LNG.bo_unban}" type="submit">
                            <input class="btn btn-primary" type="button" onClick="UsersBan.set(this.form.regexp.value)" value="{$LNG.button_filter}">
                            <input class="btn btn-primary" type="button" onClick="UsersBan.set(this.form.regexp.value)" value="{$LNG.button_deselect}">
                            <input class="btn btn-primary" type="button" onClick="UsersBan.reset();this.form.regexp.value=''" value="{$LNG.button_reset}">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>    
</main>
{/block}