{block name="title" prepend}{$LNG.lm_rights}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_rights}</h5>
        <div class="card-body">
            <form action="" method="post" name="users">
                <select class="form-control mb-3" name="id_1" size="10">
                    {$UserList}
                </select>
                <script type="text/javascript">
                    var UserList = new filterlist(document.getElementsByName('id_1')[0]);
                </script>
                <div class="btn-group mb-3" role="group">
                    <a href="?page=rights&amp;key=users&amp;sid={$sid}&amp;get=adm">
                        <button type="button" class="btn btn-secondary">{$LNG.rh_authlevel_aa}</button>
                    </a>
                    <a href="?page=rights&amp;key=users&amp;sid={$sid}&amp;get=ope">
                        <button type="button" class="btn btn-secondary">{$LNG.rh_authlevel_oo}</button>
                    </a>
                    <a href="?page=rights&amp;key=users&amp;sid={$sid}&amp;get=mod">
                        <button type="button" class="btn btn-secondary">{$LNG.rh_authlevel_mm}</button>
                    </a>
                    <a href="?page=rights&amp;key=users&amp;sid={$sid}&amp;get=pla">
                        <button type="button" class="btn btn-secondary">{$LNG.rh_authlevel_jj}</button>
                    </a>
                    <a href="?page=rights&amp;key=users&amp;sid={$sid}">
                        <button type="button" class="btn btn-secondary">{$LNG.rh_authlevel_tt}</button>
                    </a>
                </div>
                <div class="form-group">
                    <label for="1">{$LNG.rh_authlevel_insert_id}</label>
                    <input class="form-control" name="id_2" type="text" id="1">
                </div>
                <div class="form-group">
                    <label for="2">{$LNG.rh_authlevel_auth}</label>
                    {html_options class="form-control" id="2" name=authlevel options=$Selector}
                </div>
                <input class="form-control mb-3" NAME="regexp" onKeyUp="UserList.set(this.value)">
                <input class="btn btn-primary" type="button" onClick="UserList.set(this.form.regexp.value)" value="{$LNG.button_filter}">
                <input class="btn btn-primary" type="button" onClick="UserList.reset();this.form.regexp.value=''" value="{$LNG.button_deselect}">
                <input class="btn btn-primary" type="submit" value="{$LNG.button_submit}">
            </form>
        </div>
    </div>
</main>
{/block}