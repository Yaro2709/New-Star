<head>
    <title>{$LNG.lm_login}</title>
</head>
{include file="main.header.tpl"}
<main role="main" class="container p-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_login}</h5>
        <div class="card-body">
            <form action="" method="POST">
            <input type="hidden" name="post" value="1">
                <div class="mb-3">  
                    <div class="form-group">
                        <label for="username">{$LNG.ln_username}</label>
                        <input type="text" name="username" value="{$username}" class="form-control" id="username">
                    </div>
                    <div class="form-group">
                        <label for="password">{$LNG.ln_password}</label>
                        <input type="password" name="admin_pw" value="" class="form-control" id="password">
                    </div>
                </div>
                <button type="submit" name="next" class="btn btn-primary">{$LNG.button_proceed}</button>
            </form>
        </div>
    </div>
</main>
{include file="main.footer.tpl"}