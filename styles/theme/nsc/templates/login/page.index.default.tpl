{block name="title" prepend}{$LNG.nav_index}{/block}
{block name="content"}
<main role="main" class="container">
    <div class="jumbotron mb-3">
        <h1>{$descHeader}</h1>
        <p class="lead">{$descText}</p>
        <a class="btn btn-lg btn-primary" href="/index.php?page=register" role="button">{$LNG.buttonRegister}</a>
    </div>
    <div class="row">
        <div class="col-md-4">
            <div class="card mb-4 shadow-sm">
                <div class="card-body">
                    <form id="login" name="login" action="index.php?page=login" data-action="index.php?page=login" method="post">
                        <div class="form-group">
                            <label for="universe">{$LNG.universe}</label>
                            <select name="uni" id="universe" class="form-control changeAction">{html_options options=$universeSelect selected=$UNI}</select>
                        </div>
                        <div class="form-group">
                            <label for="username">{$LNG.loginUsername}</label>
                            <input type="text" class="form-control" name="username" id="username" placeholder="{$LNG.loginUsername}">
                        </div>
                        <div class="form-group">
                            <label for="password">{$LNG.loginPassword}</label>
                            <input type="password" class="form-control" name="password" id="password" placeholder="{$LNG.loginPassword}">
                        </div>
                        <div style="text-align: right;">
                            <button type="submit" class="btn btn-primary">{$LNG.loginButton}</button>
                        </div>
                    </form>
                    {if $facebookEnable}<a href="#" data-href="index.php?page=externalAuth&method=facebook" class="fb_login"><img src="./styles/resource/images/facebook/fb-connect-large.png" alt=""></a>{/if}<!-- http://b.static.ak.fbcdn.net/rsrc.php/zB6N8/hash/4li2k73z.gif -->
				    <div style="text-align: center">
						<a href="index.php?page=register">{$LNG.buttonRegister}</a> {if $mailEnable}- <a href="index.php?page=lostPassword">{$LNG.buttonLostPassword}</a>{/if}
						<br>
						<span class="small">{$loginInfo}</span>
					</div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card mb-4 shadow-sm">
                <div id="carousel_1" class="carousel slide carousel-fade img-thumbnail bg-primary border border-primary" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <li data-target="#carousel_1" data-slide-to="0" class="active"></li>
                        <li data-target="#carousel_1" data-slide-to="1"></li>
                        <li data-target="#carousel_1" data-slide-to="2"></li>
                        <li data-target="#carousel_1" data-slide-to="3"></li>
                    </ol>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="./styles/resource/images/login/carousel/1.jpg" class="d-block w-100" alt="...">
                        </div>
                        <div class="carousel-item">
                            <img src="./styles/resource/images/login/carousel/2.jpg" class="d-block w-100" alt="...">
                        </div>
                        <div class="carousel-item">
                            <img src="./styles/resource/images/login/carousel/3.jpg" class="d-block w-100" alt="...">
                        </div>
                        <div class="carousel-item">
                            <img src="./styles/resource/images/login/carousel/4.jpg" class="d-block w-100" alt="...">
                        </div>
                    </div>
                    <a class="carousel-control-prev" href="#carousel_1" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">{$LNG.previous_s}</span>
                    </a>
                    <a class="carousel-control-next" href="#carousel_1" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">{$LNG.next_s}</span>
                    </a>
                </div>
                <div class="card-body">
                    <h5 class="card-title">{$LNG.nav_screens}</h5>
                    <p class="card-text">{$LNG.loginScreens}</p>
                    <div style="text-align: right">
                        <a href="/index.php?page=screens">
                            <button type="button" class="btn btn-success">{$LNG.nav_screens}</button>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card mb-4 shadow-sm">
                <div id="carousel_2" class="carousel slide carousel-fade img-thumbnail bg-primary border border-primary" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <li data-target="#carousel_2" data-slide-to="0" class="active"></li>
                        <li data-target="#carousel_2" data-slide-to="1"></li>
                        <li data-target="#carousel_2" data-slide-to="2"></li>
                        <li data-target="#carousel_2" data-slide-to="3"></li>
                    </ol>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="./styles/resource/images/login/carousel/5.jpg" class="d-block w-100" alt="...">
                        </div>
                        <div class="carousel-item">
                            <img src="./styles/resource/images/login/carousel/6.jpg" class="d-block w-100" alt="...">
                        </div>
                        <div class="carousel-item">
                            <img src="./styles/resource/images/login/carousel/7.jpg" class="d-block w-100" alt="...">
                        </div>
                        <div class="carousel-item">
                            <img src="./styles/resource/images/login/carousel/8.jpg" class="d-block w-100" alt="...">
                        </div>
                    </div>
                    <a class="carousel-control-prev" href="#carousel_2" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">{$LNG.previous_s}</span>
                    </a>
                    <a class="carousel-control-next" href="#carousel_2" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">{$LNG.next_s}</span>
                    </a>
                </div>
                <div class="card-body">
                    <h5 class="card-title">{$LNG.nav_news}</h5>
                    {if $is_news}<p class="card-text">{$news}</p>{/if}
                    <div style="text-align: right">
                        <a href="/index.php?page=news">
                            <button type="button" class="btn btn-success">{$LNG.nav_news}</button>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
{/block}
{block name="script" append}
<script>{if $code}alert({$code|json});{/if}</script>
{/block}