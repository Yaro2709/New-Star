<nav class="navbar navbar-expand-md  fixed-top bg-dark navbar-dark">
    <div class="container-xl">
        <a class="navbar-brand" href="#">
            <img src="./styles/resource/images/icons/192.png" alt="" width="30" height="30" class="d-inline-block align-text-top">
            {$gameName}
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample07XL" aria-controls="navbarsExample07XL" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarsExample07XL">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.php">{$LNG.nav_index}</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.php?page=board">{$LNG.nav_forum}</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.php?page=news">{$LNG.nav_news}</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.php?page=rules">{$LNG.nav_rules}</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.php?page=battleHall">{$LNG.nav_battlehall}</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.php?page=banList">{$LNG.nav_banlist}</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.php?page=disclamer">{$LNG.nav_disclamer}</a>
                </li>
                {if count($languages) > 1}
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="dropdown07XL" data-toggle="dropdown" aria-expanded="false">{$LNG.language}</a>
                    <div class="dropdown-menu" aria-labelledby="dropdown07XL">
                    {foreach $languages as $langKey => $langName}
                        <a class="dropdown-item" href="?lang={$langKey}" rel="alternate" hreflang="{$langKey}" title="{$langName}">{$langName}</a>
                    {/foreach}
                    </div>
                </li>
                {/if}
            </ul>
        </div>
    </div>
</nav>