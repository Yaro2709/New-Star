{block name="title" prepend}{$LNG.lm_search}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="album">
        <div class="row">
            <div class="col-md-4">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/accounteditor/buildings.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.ac_header_buildings}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.ac_text_buildings}</p>
                        <div style="text-align: right">
                            <a href="?page=search&amp;search=online&amp;minimize=on">
                                <button type="button" class="btn btn-primary">{$LNG.button_proceed}</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/accounteditor/ships.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.ac_header_ships}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.ac_text_ships}</p>
                        <div style="text-align: right">
                            <a href="?page=search&amp;search=p_connect&amp;minimize=on">
                                <button type="button" class="btn btn-primary">{$LNG.button_proceed}</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/accounteditor/defenses.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.ac_header_defenses}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.ac_text_defenses}</p>
                        <div style="text-align: right">
                            <a href="?page=search&amp;search=users&amp;minimize=on">
                                <button type="button" class="btn btn-primary">{$LNG.button_proceed}</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/accounteditor/researchs.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.ac_header_researchs}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.ac_text_researchs}</p>
                        <div style="text-align: right">
                            <a href="?page=search&amp;search=planet&amp;minimize=on">
                                <button type="button" class="btn btn-primary">{$LNG.button_proceed}</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/accounteditor/officiers.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.ac_header_officiers}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.ac_text_officiers}</p>
                        <div style="text-align: right">
                            <a href="?page=search&amp;search=moon&amp;minimize=on">
                                <button type="button" class="btn btn-primary">{$LNG.button_proceed}</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mb-4 shadow-sm">
                    <img src="./styles/resource/images/admin/accounteditor/resources.jpg" class="card-img img-thumbnail bg-primary border-primary">
                    <div class="card-body">
                        <h5 class="card-title">{$LNG.ac_header_resources}</h5>
                        <p class="card-text overflow-auto" style="max-width: 1000px; max-height: 150px;">{$LNG.ac_text_resources}</p>
                        <div style="text-align: right">
                            <a href="?page=search">
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