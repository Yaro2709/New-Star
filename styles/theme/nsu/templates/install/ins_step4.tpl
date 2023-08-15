{include file="ins_header.tpl"}
{include file="ins_nav.tpl"}
{nocache}
<main role="main" class="container">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.req_head}</h5>
        <div class="card-body">
            <p class="card-text">{$message}</p>
            {if $class == 'noerror'}
            <a href="index.php?mode=install&step=5"><button type="button" class="btn btn-primary">{$LNG.continue}</button></a> 
            {else}
            <a href="index.php?mode=install&step=3&amp;host={$host}&amp;port={$port}&amp;user={$user}&amp;dbname={$dbname}&amp;prefix={$prefix}"><button type="button" class="btn btn-primary">{$LNG.back}</button></a> 
            {/if}
        </div>
    </div>
</main>
{/nocache}
{include file="ins_footer.tpl"}