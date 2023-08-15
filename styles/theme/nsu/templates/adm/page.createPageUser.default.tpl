{block name="title" prepend}{$LNG.lm_create}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_create}</h5>
        <div class="card-body">
            <form action="" method="post">
                <div class="form-group">
                    <label for="name">{$LNG.cr_new_name}</label>
                    <input type="text" name="name" class="form-control" id="name">
                </div>
                <div class="form-group">
                    <label for="password">{$LNG.cr_new_pass_1}</label>
                    <input type="password" name="password" class="form-control" id="password">
                </div>
                <div class="form-group">
                    <label for="password2">{$LNG.cr_new_pass_2}</label>
                    <input type="password" name="password2" class="form-control" id="password2">
                </div>
                <div class="form-group">
                    <label for="email">{$LNG.cr_new_email_1}</label>
                    <input type="text" name="email" class="form-control" id="email">
                </div>
                <div class="form-group">
                    <label for="email2">{$LNG.cr_new_email_2}</label>
                    <input type="text" name="email2" class="form-control" id="email2">
                </div>
                <div class="form-group">
                    <label for="range">{$LNG.cr_new_range}</label>
                    {html_options name=authlevel class="form-control" id="range" options=$Selector.auth}
                </div>
                <div class="form-group">
                    <label for="lang">{$LNG.cr_new_lang}</label>
                    {html_options name=lang class="form-control" id="lang" options=$Selector.lang}
                </div>
                <div class="form-group">
                    <label for="coord">{$LNG.cr_new_coord}</label>
                    <div class="input-group">
                        <input type="text" name="galaxy" class="form-control" id="coord">
                        <input type="text" name="system" class="form-control">
                        <input type="text" name="planet" class="form-control">
                    </div>
                </div>
                <input class="btn btn-primary" type="submit" value="{$LNG.button_add}">
            </form>
        </div>
    </div>
</main>
{/block}