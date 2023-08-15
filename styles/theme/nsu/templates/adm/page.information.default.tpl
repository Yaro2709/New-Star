{block name="title" prepend}{$LNG.lm_information}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_information}</h5>
        <div class="card-body">
            <p class="card-text">
                {$LNG.in_text_server} {$info}
                {$LNG.in_text_version_php} {$vPHP} ({$vAPI})<br> 
                {$LNG.in_text_json} {$json}<br> 
                {$LNG.in_text_bcmath} {$bcmath}<br> 
                {$LNG.in_text_curl} {$curl}<br> 
                {$LNG.in_text_safemode} {$safemode}<br> 
                {$LNG.in_text_memorylimit} {$memory}<br> 
                {$LNG.in_text_mysql_client} {$vMySQLc}<br> 
                {$LNG.in_text_mysql} {$vMySQLs}<br> 
                {$LNG.in_text_error_log} {$errorlog} ({$errorloglines}, {$log_errors})<br> 
                {$LNG.in_text_timezone} {$php_tz} / {$conf_tz} / {$user_tz}<br> 
                {$LNG.in_text_suhosin} {$suhosin}<br>  
            </p>
            <p class="card-text">
                {$LNG.in_text_game_version} {$vGame}<br> 
                {$LNG.in_text_bd_version} {$dbVersion}<br>
                {$LNG.in_text_game_adresse} http://{$root}/<br> 
                {$LNG.in_text_game_pfad} http://{$gameroot}/index.php<br>
            </p>
        </div>
    </div>
</main>
{/block}