{include file="ins_header.tpl"}
{include file="ins_nav.tpl"}
<main role="main" class="container">
    {if $canUpgrade}      
    <div class="card mb-3">
        <div class="row no-gutters">
            <div class="col-md-2">
                <img src="../styles/resource/images/install/poster/poster_active.jpg" class="card-img img-thumbnail bg-primary border-primary" alt="...">
            </div>
            <div class="col-md-10">
                <div class="card-body">
                    <h5 class="card-title">{$LNG.upgrade_title}</h5>
                    <p class="card-text">{$LNG.upgrade_text}</p>
                    <a href="/index.php?mode=upgrade">
                        <button type="button" class="btn btn-primary">{$LNG.continue}</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
    {else}
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.intro_welcome}</h5>
        <div class="card-body">
            <p class="card-text">{$LNG.intro_text}</p>
            <a href="index.php?mode=install&amp;step=2">
                <button type="button" class="btn btn-primary">{$LNG.continue}</button>
            </a> 
        </div>
    </div>
    {/if}
    <div class="album">
        {include file="ins_carousel.tpl"}
    </div>
</main>
{include file="ins_footer.tpl"}