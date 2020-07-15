{block name="title" prepend}{$LNG.lm_log}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_log}</h5>
        <div class="card-body">
            <table class="table table-dark table-hover mb-3">
                <thead>
                    <tr>
                        <th>{$LNG.log_admin}</th>
                        <th>{$LNG.log_universe}</th>
                        <th>{$LNG.log_time}</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>{$admin}</td>
                        <td>{$target}</td>
                        <td>{$time}</td>
                    </tr>
                </tbody>
            </table>
            <table class="table table-dark table-hover">
                <thead>
                    <tr>
                        <th>{$LNG.log_element}</th>
                        <th>{$LNG.log_old}</th>
                        <th>{$LNG.log_new}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach item=LogInfo from=$LogArray}
                    {if ($LogInfo.old <> $LogInfo.new)}
                    <tr>
                        <td>{$LogInfo.Element}</td>
                        <td>{$LogInfo.old}</td>
                        <td>{$LogInfo.new}</td>
                    </tr>
                    {/if}
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</main>
{/block}