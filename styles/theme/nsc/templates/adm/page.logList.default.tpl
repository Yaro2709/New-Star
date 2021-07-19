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
                        <th>{$LNG.input_id}</th>
                        <th>{$LNG.log_admin}</th>
                        <th>{$LNG.log_universe}</th>
                        <th>{$log_target}</th>
                        <th>{$LNG.log_time}</th>
                        <th>{$LNG.log_log}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach item=LogInfo from=$LogArray}
                    <tr>
                        <td>{$LogInfo.id}</td>
                        <td>{$LogInfo.admin}</td>
                        <td>{$LogInfo.target_uni}</td>
                        <td>{$LogInfo.target}</td>
                        <td>{$LogInfo.time}</td>
                        <td><a href='?page=log&type=detail&id={$LogInfo.id}'>{$LNG.button_view}</a></td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</main>
{/block}