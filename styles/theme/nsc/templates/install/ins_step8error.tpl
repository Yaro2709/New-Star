{include file="ins_header.tpl"}
{include file="ins_nav.tpl"}
<main role="main" class="container">
    <div class="card mb-3">
        <h5 class="card-header"></h5>
        <div class="card-body">
            <p class="card-text">{$message}</p>
            <a href="index.php?mode=install&step=7&amp;username={$username}&amp;email={$mail}"><button type="button" class="btn btn-primary">{$LNG.back}</button></a> 
        </div>
    </div>
</main>
{include file="ins_footer.tpl"}