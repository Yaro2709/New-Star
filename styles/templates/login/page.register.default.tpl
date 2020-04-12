{block name="title" prepend}{$LNG.siteTitleRegister}{/block}
{block name="content"}

	<div class="container" style="margin-top: 80px;">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">{$LNG.siteTitleRegister}</div>
                    <div class="panel-body">
						<form id="registerForm" method="post" action="index.php?page=register" data-action="index.php?page=register">
							<input type="hidden" value="send" name="mode">
							<input type="hidden" value="{$externalAuth.account}" name="externalAuth[account]">
							<input type="hidden" value="{$externalAuth.method}" name="externalAuth[method]">
							<input type="hidden" value="{$referralData.id}" name="referralID">
							<div class="form-group">
								<label for="universe">{$LNG.chose_a_uni}</label>
								<select name="uni" id="universe" class="form-control changeAction">{html_options options=$universeSelect selected=$UNI}</select>
								{if !empty($error.uni)}<span class="error errorUni"></span>{/if}
							</div>
							<div class="form-group">
								<label for="username">{$LNG.registerUsername}</label>
								<input type="text" class="form-control" name="username" id="username" placeholder="{$LNG.registerUsername}">
								{if !empty($error.username)}<span class="error errorUsername"></span>{/if}
								<span class="inputDesc"><small>{$LNG.registerUsernameDesc}</small></span>
							</div>
							<div class="form-group">
								<label for="password">{$LNG.registerPassword}</label>
								<input type="password" class="form-control" name="password" id="password" placeholder="{$LNG.registerPassword}">
								{if !empty($error.password)}<span class="error errorPassword"></span>{/if}
								<span class="inputDesc"><small>{$LNG.registerPasswordDesc}</small></span>
							</div>
							<div class="form-group">
								<label for="passwordReplay">{$LNG.registerPasswordReplay}</label>
								<input type="password" class="form-control" name="passwordReplay" id="passwordReplay" placeholder="{$LNG.registerPasswordReplay}">
								{if !empty($error.passwordReplay)}<span class="error errorPasswordReplay"></span>{/if}
								<span class="inputDesc"><small>{$LNG.registerPasswordReplayDesc}</small></span>
							</div>
							<div class="form-group">
								<label for="email">{$LNG.registerEmail}</label>
								<input type="email" class="form-control" name="email" id="email" placeholder="{$LNG.registerEmail}">
								{if !empty($error.password)}<span class="error errorEmail"></span>{/if}
								<span class="inputDesc"><small>{$LNG.registerEmailDesc}</small></span>
							</div>
							<div class="form-group">
								<label for="emailReplay">{$LNG.registerEmailReplay}</label>
								<input type="email" class="form-control" name="emailReplay" id="emailReplay" placeholder="{$LNG.registerEmailReplay}">
								{if !empty($error.emailReplay)}<span class="error errorEmailReplay"></span>{/if}
								<span class="inputDesc"><small>{$LNG.registerEmailReplayDesc}</small></span>
							</div>
							{if count($languages) > 1}
								<div class="form-group">
									<label for="language">{$LNG.registerLanguage}</label>
									<select name="lang" id="language" class="form-control">{html_options options=$languages selected=$lang}</select>
									{if !empty($error.language)}<span class="error errorLanguage"></span>{/if}
								</div>
							{/if}
							{if !empty($referralData.name)}
							<div class="form-group">
								<label for="username">{$LNG.registerReferral}</label>
								<span class="inputDesc">{$referralData.name}</span>
							</div>
							{/if}
							{if $recaptchaEnable}
								<div class="rowForm" id="captchaRow">
									<div>
										<label>{$LNG.registerCaptcha}</label>
										<!--<span class="inputDesc">{$LNG.registerCaptchaDesc}</span>-->
										<div class="g-recaptcha" data-sitekey="{$recaptchaPublicKey}"></div>
									</div>
								</div>
							{/if}
							<div class="form-group checkbox">
								<input type="checkbox" name="rules" id="rules" value="1"> {$registerRulesDesc}
								{if !empty($error.rules)}<span class="error errorRules"></span>{/if}
							</div>
							<div style="text-align: right;">
								<button type="submit" class="btn btn-danger">{$LNG.buttonRegister}</button>
							</div>
						</form>
					</div>
                </div>
            </div>
        </div>
    </div>
{/block}
{block name="script" append}
{if $recaptchaEnable}
<script type="text/javascript" src="https://www.google.com/recaptcha/api.js?hl={$lang}"></script>
{/if}
<script type="text/javascript" src="scripts/login/register.js"></script>
{/block}
