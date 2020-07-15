{block name="title" prepend}{$LNG.lm_module}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_module}</h5>
        <div class="card-body">
            <table class="table table-dark table-hover">
                <thead>
                    <tr>
                        <th>{$LNG.mod_id}</th>
                        <th>{$LNG.mod_name}</th>
                        <th>{$LNG.mod_status}</th>
                        <th>{$LNG.mod_value}</th>
                    </tr>
                </thead>
                <tbody>
                {foreach key=ID item=Info from=$Modules}
                    <tr>
                        <td>{$ID}</td>
                        <td>{$Info.name}</td>
                        {if $Info.state == 1}
                        <td style="color:green"><b>{$LNG.status_active}</b></td>
                        <td><a href="?page=module&amp;act=deaktiv&amp;id={$ID}">{$LNG.button_active}</a></td>
                        {else}
                        <td style="color:red"><b>{$LNG.status_deactive}</b></td>
                        <td><a href="?page=module&amp;act=aktiv&amp;id={$ID}">{$LNG.button_deactive}</a></td>
                        {/if}
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</main>
<body>
{/block}