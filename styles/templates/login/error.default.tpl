{block name="title" prepend}{$LNG.fcm_info}{/block}
{block name="content"}
<main role="main" class="container">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.fcm_info}</h5>
        <div class="card-body">
            <p class="card-text">{$message} {if !empty($redirectButtons)} {foreach $redirectButtons as $button}<a href="{$button.url}"><button class="btn btn-default">{$button.label}</button></a>{/foreach}{/if}</p>
        </div>
    </div>
</main>
{/block}