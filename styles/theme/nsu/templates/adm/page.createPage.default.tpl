{block name="title" prepend}{$LNG.lm_create}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="album">
        <div class="row">
            <div class="col-md-4">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/create/user.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.cr_header_user}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.cr_text_user}</p>
                        <div style="text-align: right">
                            <a href="?page=create&amp;class=user">
                                <button type="button" class="btn btn-primary">{$LNG.button_proceed}</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/create/planet.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.cr_header_planet}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.cr_text_planet}</p>
                        <div style="text-align: right">
                            <a href="?page=create&amp;class=planet">
                                <button type="button" class="btn btn-primary">{$LNG.button_proceed}</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/create/moon.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.cr_header_moon}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.cr_text_moon}</p>
                        <div style="text-align: right">
                            <a href="?page=create&amp;class=moon">
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