{block name="title" prepend}{$LNG.nav_password}{/block}
{block name="content"}
<main role="main" class="container">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.nav_password}</h5>
        <div class="card-body">
            <p class="card-text">{$LNG.passwordInfo}</p>
            <form action="index.php?page=lostPassword" method="post" data-action="index.php?page=lostPassword" >
                <input type="hidden" value="send" name="mode">
                <div class="form-group">
                    <label for="universe">{$LNG.universe}</label>
					<select name="uni" id="universe" class="form-control changeAction">{html_options options=$universeSelect selected=$UNI}</select>
				</div>
				<div class="form-group">
					<label for="username">{$LNG.passwordUsername}</label>
					<input type="text" class="form-control" name="username" id="username" placeholder="{$LNG.passwordUsername}">
				</div>
				<div class="form-group">
					<label for="mail">{$LNG.passwordMail}</label>
					<input type="email" class="form-control" name="mail" id="mail" placeholder="{$LNG.passwordMail}">
				</div>
                {if $recaptchaEnable}
				<div class="formRow" id="captchaRow">
					<div>
						<label>{$LNG.registerCaptcha}<p class="captchaButtons"></p></label>
						<div class="g-recaptcha" data-sitekey="{$recaptchaPublicKey}"></div>
					</div>
                    <div class="clear"></div>
				</div>
                {/if}
				<div style="text-align: right;">
					<button type="submit" class="btn btn-danger">{$LNG.passwordSubmit}</button>
                   </div>
			</form>
        </div>
    </div>
</main>
{/block}
{block name="script" append}
{if $recaptchaEnable}
<script type="text/javascript" src="https://www.google.com/recaptcha/api.js?hl={$lang}"></script>
{/if}
{/block}