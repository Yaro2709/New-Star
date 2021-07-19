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
                            <th><input name="id" type="text" class="form-control" id="id"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label for="username">{$LNG.ac_personal_name}</label></td>
                            <td><input name="username" type="text" class="form-control" id="username"></td>
                        </tr>
                        <tr>
                            <td><label for="password">{$LNG.ac_personal_pass}</label></td>
                            <td><input name="password" type="text" class="form-control" id="password"></td>
                        </tr>
                        <tr>
                            <td><label for="email">{$LNG.ac_personal_email}</label></td>
                            <td><input name="email" type="text" class="form-control" id="email"></td>
                        </tr>
                        <tr>
                            <td><label for="email_2">{$LNG.ac_personal_email2}</label></td>
                            <td><input name="email_2" type="text" class="form-control" id="email_2"></td>
                        </tr>
                        <tr>
                            <td><label for="vacat">{$LNG.ac_personal_vacat}</label></td>
                            <td>{html_options name=vacation options=$Selector class="form-control" id="vacat"}</td>
                        </tr>
                        <tr>
                            <td><label for="d">{$LNG.time_days}</label></td>
                            <td><input name="d" type="text" class="form-control" id="d"></td>
                        </tr>
                        <tr>
                            <td><label for="h">{$LNG.time_hours}</label></td>
                            <td><input name="h" type="text" class="form-control" id="h"></td>
                        </tr>
                        <tr>
                            <td><label for="m">{$LNG.time_minutes}</label></td>
                            <td><input name="m" type="text" class="form-control" id="m"></td>
                        </tr>
                        <tr>
                            <td><label for="s">{$LNG.time_seconds}</label></td>
                            <td><input name="s" type="text" class="form-control" id="s"></td>
                        </tr>
                    </tbody>
                </table>
                <input class="btn btn-primary" type="submit" value="{$LNG.button_submit}">
            </form>
        </div>
    </div>
</main>
{/block}