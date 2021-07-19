{block name="title" prepend}{$LNG.lm_cronjob}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_cronjob}</h5>
        <div class="card-body">
            <table class="table table-dark table-hover">
                <thead>
                    <tr>
                        <th>{$LNG.cron_id}</th>
                        <th>{$LNG.cron_name}</th>
                        <th>{$LNG.cron_min}</th>
                        <th>{$LNG.cron_hours}</th>
                        <th>{$LNG.cron_dom}</th>
                        <th>{$LNG.cron_month}</th>
                        <th>{$LNG.cron_dow}</th>
                        <th>{$LNG.cron_class}</th>
                        <th>{$LNG.cron_next_time}</th>
                        <th>{$LNG.cron_in_active}</th>
                        <th>{$LNG.cron_lock}</th>
                        <th>{$LNG.cron_edit}</th>
                        <th>{$LNG.cron_delete}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach item=CronjobInfo from=$CronjobArray}
                    <tr>
                        <td>{$CronjobInfo.id}</td>
                        <td>{$LNG["cron_name_{$CronjobInfo.name}"]}</td>
                        <td>{$CronjobInfo.min}</td>
                        <td>{$CronjobInfo.hours}</td>
                        <td>{$CronjobInfo.dom}</td>
                        <td>{if $CronjobInfo.month == '*'}{$CronjobInfo.month}{else}{foreach item=month from=$CronjobInfo.month}{$LNG.months.{$month-1}}{/foreach}{/if}</td>
                        <td>{if $CronjobInfo.dow == '*'}{$CronjobInfo.dow}{else}{foreach item=d from=$CronjobInfo.dow}{$LNG.week_day.{$d}} {/foreach}{/if}</td>
                        <td>{$CronjobInfo.class}</td>
                        <td>{if $CronjobInfo.isActive}{date($LNG.php_tdformat, $CronjobInfo.nextTime)}{else}-{/if}</td>
                        <td><a href="admin.php?page=cronjob&amp;action=enable&amp;id={$CronjobInfo.id}&amp;enable={if $CronjobInfo.isActive}0" style="color:lime">{$LNG.status_yes}{else}1" style="color:red">{$LNG.status_no}{/if}</a></td>
                        <td><a href="admin.php?page=cronjob&amp;id={$CronjobInfo.id}&amp;action={if $CronjobInfo.lock}unlock" style="color:red">{$LNG.status_yes}{else}lock" style="color:lime">{$LNG.status_no}{/if}</a></td>
                        <td><a href="admin.php?page=cronjob&amp;action=detail&amp;id={$CronjobInfo.id}"><img src="./styles/resource/images/admin/GO.png"></a></td>
                        <td><a href="admin.php?page=cronjob&amp;action=delete&amp;id={$CronjobInfo.id}"><img src="./styles/resource/images/false.png" width="16" height="16"></a></td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
        <div class="card-footer text-center">
            <p class="card-text"><a href="admin.php?page=cronjob&amp;action=detail">{$LNG.cron_new}</a></p>
        </div>
    </div>
</main>
{/block}