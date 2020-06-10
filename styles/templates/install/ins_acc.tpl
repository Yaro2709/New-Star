{include file="ins_header.tpl"}
{include file="ins_nav.tpl"}
<main role="main" class="container">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.step4_head}</h5>
        <div class="card-body">
            <p class="card-text">{$LNG.step4_text}</p>
            <form action="index.php?mode=install&step=8" method="post"> 
            <input type="hidden" name="post" value="1">
                <div class="mb-3">  
                    <div class="form-group">
                        <label for="username">{$LNG.step4_admin_name}</label>
                        <input type="text" name="username" value="{$name}" class="form-control" id="username">
                        <small id="username" class="form-text text-muted">{$LNG.step4_admin_name_desc}</small>
                    </div>
                    <div class="form-group">
                        <label for="password">{$LNG.step4_admin_pass}</label>
                        <input type="password" name="password" value="{$password}" class="form-control" id="password">
                        <small id="password" class="form-text text-muted">{$LNG.step4_admin_pass_desc}</small>
                    </div>
                    <div class="form-group">
                        <label for="email">{$LNG.step4_admin_mail}</label>
                        <input type="text" name="email" value="{$mail}" class="form-control" id="email">
                    </div>
                </div>
                <button type="submit" name="next" class="btn btn-primary">{$LNG.continue}</button>
            </form>
        </div>
    </div>
</main>
{include file="ins_footer.tpl"}