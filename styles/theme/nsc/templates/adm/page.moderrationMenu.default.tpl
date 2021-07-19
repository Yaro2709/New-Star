{block name="title" prepend}{$LNG.lm_rights}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="album">
        <div class="row">
            <div class="col-md-6">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/rights/rights.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.rh_header_rights}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.rh_text_rights}</p>
                        <div style="text-align: right">
                            <a href="?page=rights&key=rights">
                                <button type="button" class="btn btn-primary">{$LNG.button_proceed}</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/rights/users.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.rh_header_users}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.rh_text_users}</p>
                        <div style="text-align: right">
                            <a href="?page=rights&key=users">
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