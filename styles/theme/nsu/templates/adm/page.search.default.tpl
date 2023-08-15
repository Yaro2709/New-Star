{block name="title" prepend}{$LNG.lm_search}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <form action="" method="POST">
        <div class="card mb-3">
            <h5 class="card-header">{$LNG.lm_search}</h5>
            <div class="card-body">
                <div id="seeker">
                <table class="table table-dark">
                    <thead>
                        <tr>
                            <th>{$se_intro}</th>
                            <th>{$se_type_typee}</th>
                            <th>{$se_search_in}</th>
                            <th>{$se_filter_title}</th>
                            <th>{$se_limit}</th>
                            <th>{$se_asc_desc}</th>
                            {if $OrderBYParse}
                                <th>{$se_search_order}</th>
                            {/if}
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <input type="text" name="key_user" value="{$search}" class="form-control">
                            </td>
                            <td>{html_options name=search options=$Selector.list selected=$SearchFile class="form-control"}</td>
                            <td>{html_options name=search_in options=$Selector.search selected=$SearchFor class="form-control"}</td>
                            <td>{html_options name=fucki options=$Selector.filter selected=$SearchMethod class="form-control"}</td>
                            <td>{html_options name=limit options=$Selector.limit selected=$limit class="form-control"}</td>
                            <td>{html_options name=key_acc options=$Selector.order selected=$OrderBY class="form-control"}</td>
                            {if $OrderBYParse}
                                <td>{html_options name=key_order options=$OrderBYParse selected=$Order class="form-control"}</td>
                            {/if}
                            <td>
                                <input class="btn btn-primary" type="submit" value="{$se_search}">
                            </td>
                        </tr>
                        {if !empty($error)}
                        <div class="alert alert-primary" role="alert">
                            {$error}
                        </div>
                        {/if}
                    </tbody>
                </table>
                
                <table class="table table-dark table-hover">
                    {$PAGES}
                </table>
                {$LIST}

                <table class="table table-dark table-hover">
                    {$PAGES}
                </table>
                
                </div>
            </div>
        </div>
    </form>
</main>
{/block}