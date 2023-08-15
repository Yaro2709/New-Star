{block name="title" prepend}{$LNG.fcm_info}{/block}
{block name="content"}
<main role="main" class="container">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.fcm_info}</h5>
        <div class="card-body">
            <p class="card-text">{$message}</p>
            {if !empty($redirectButtons)} {foreach $redirectButtons as $button}
                <a href="{$button.url}">
                    <button type="button" class="btn btn-primary">{$button.label}</button>
                </a>
            {/foreach}{/if}
        </div>
    </div>
</main>
{/block}