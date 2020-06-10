{include file="ins_header.tpl"}
{include file="ins_nav.tpl"}
<main role="main" class="container">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.upgrade_header}</h5>
        <div class="card-body">
            <p class="card-text">{if $update}{sprintf($LNG.upgrade_success,$revision)}{else}{sprintf($LNG.upgrade_nothingtodo,$revision)}{/if}</p>
            <a href="../index.php"><button type="button" class="btn btn-primary">{$LNG.back}</button></a> 
        </div>
    </div>
</main>
{include file="ins_footer.tpl"}