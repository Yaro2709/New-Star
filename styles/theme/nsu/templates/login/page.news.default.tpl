{block name="title" prepend}{$LNG.nav_news}{/block}
{block name="content"}
<main role="main" class="container">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.nav_news}</h5>
        <div class="card-body">
            <p class="card-text">{foreach $newsList as $newsRow}<a href="#{$newsRow.id}">{$newsRow.title} </a>{foreachelse}{$LNG.news_does_not_exist}{/foreach}</p>
        </div>
    </div>
    <div class="row">
        {foreach $newsList as $newsRow}
            <div id="{$newsRow.id}" class="col-md-4">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/login/news/{$newsRow.id}.jpg" class="card-img img-thumbnail bg-primary border-primary" alt="{$newsRow.title}">
                    <div class="card-body">
                        <h5 class="card-title">{$newsRow.title}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$newsRow.text}</p>
                        <p class="card-text"><small class="text-muted">{$newsRow.from}</small></p>
                    </div>
                </div>
            </div>
        {foreachelse}
        {/foreach}
    </div>
</main>
{/block}