{block name="title" prepend}{$LNG.lm_password}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_password}</h5>
        <div class="card-body">
            <p class="card-text">
                <form method="post" action="">
                    <div class="form-group">
                        <label for="md5q">{$LNG.et_pass}</label>
                        <input class="form-control" type="text" name="md5q" size="80" value="{$md5_md5}" id="md5q">
                    </div>
                    <div class="form-group">
                        <label for="pass">{$LNG.et_result}</label>
                        <input class="form-control" type="text" name="md5w" size="80" value="{$md5_enc}" id="pass">
                    </div>
                    <button class="btn btn-primary btn-lg btn-block" type="submit" value="{$LNG.et_encript}">{$LNG.et_encript}</button>
                </form>
            </p>
        </div>
    </div>
</main>
{/block}