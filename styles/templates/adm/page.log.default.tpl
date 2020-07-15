{block name="title" prepend}{$LNG.lm_log}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="album">
        <div class="row">
            <div class="col-md-6">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/log/planet.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.log_planet}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.log_text_planet}</p>
                        <div style="text-align: right">
                            <a href="?page=log&amp;type=planet">
                                <button type="button" class="btn btn-primary">{$LNG.button_proceed}</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/log/player.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.log_player}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.log_text_player}</p>
                        <div style="text-align: right">
                            <a href="?page=log&amp;type=player">
                                <button type="button" class="btn btn-primary">{$LNG.button_proceed}</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/log/settings.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.log_settings}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.log_text_settings}</p>
                        <div style="text-align: right">
                            <a href="?page=log&amp;type=settings">
                                <button type="button" class="btn btn-primary">{$LNG.button_proceed}</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/log/present.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.log_present}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.log_text_present}</p>
                        <div style="text-align: right">
                            <a href="?page=log&amp;type=present">
                                <button type="button" class="btn btn-primary">{$LNG.button_proceed}</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
{/block}