{block name="title" prepend}{$LNG.lm_cronjob}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    {if !empty($error_msg)}
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_cronjob}</h5>
        <div class="card-body">
            {foreach from=$error_msg item=error}{$error}<br>{/foreach}
        </div>
    </div>
    {/if}
    <div class="card mb-3">
        <h5 class="card-header">{if $id == 0}{$LNG.cron_new}{else}{$LNG.cron_headline}{$id}{/if}</h5>
        <div class="card-body">
            <form method="POST" action="">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" value="{$id}">
                <table class="table table-dark table-hover">
                    <thead>
                        <tr>
                            <th>{$LNG.status_parameter}</th>
                            <th>{$LNG.status_value}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label for="name">{$LNG.cron_name}</label></td>
                            <td><input type="text" name="name" value="{$name}" class="form-control" id="name"></td>
                        </tr>
                        <tr>
                            <td><label for="min[]">{$LNG.cron_min}</label></td>
                            <td><select name="min[]" multiple="multiple" class="form-control" id="min[]">{html_options values=range(0, 59) output=range(0, 59) selected=$min}</select></td>
                        </tr>
                        <tr>
                            <td colspan='2'>
                                <input class="form-check-label" name="min_all" id="min_all" type="checkbox" value="1" {if $min.0==="*"}checked{/if}>
                                <label class="form-check-label" for="min_all">{$LNG.cron_selectall}</label>
                            </td>
                        </tr>
                        <tr>   
                            <td><label for="hours[]">{$LNG.cron_hours}</label></td>
                            <td><select name="hours[]" multiple="multiple" class="form-control" id="hours[]">{html_options values=range(0, 23) output=range(0, 23) selected=$hours}</select></td>
                        </tr>
                        <tr>
                            <td colspan='2'>
                                <input class="form-check-label" name="hours_all" id="hours_all" type="checkbox" value="1" {if $hours.0==="*"}checked{/if}>
                                <label class="form-check-label" for="hours_all">{$LNG.cron_selectall}</label>
                            </td>
                        </tr>
                        <tr>   
                            <td><label for="dom[]">{$LNG.cron_dom}</label></td>
                            <td><select name="dom[]" multiple="multiple" class="form-control" id="dom[]">{html_options values=range(1, 31) output=range(1, 31) selected=$dom}</select></td>
                        </tr>
                        <tr>
                            <td colspan='2'>                           
                                <input class="form-check-label" name="dom_all" id="dom_all" type="checkbox" value="1" {if $dom.0==="*"}checked{/if}>
                                <label class="form-check-label" for="dom_all">{$LNG.cron_selectall}</label>
                            </td>
                        </tr>
                        <tr>   
                            <td><label for="month[]">{$LNG.cron_month}</label></td>
                            <td><select name="month[]" multiple="multiple" class="form-control" id="month[]">{html_options values=range(1, 12) output=$LNG.months selected=$month}</select></td>
                            
                        </tr>
                        <tr>
                            <td colspan='2'>                                                           
                                <input class="form-check-label" name="month_all" id="month_all" type="checkbox" value="1" {if $month.0==="*"}checked{/if}>
                                <label class="form-check-label" for="month_all">{$LNG.cron_selectall}</label>
                            </td>
                        </tr>
                        <tr>   
                            <td><label for="dow[]">{$LNG.cron_dow}</label></td>
                            <td><select name="dow[]" multiple="multiple" class="form-control" id="dow[]">{html_options values=range(0, 6) output=$LNG.week_day selected=$dow}</select></td>
                        </tr>
                        <tr>
                            <td colspan='2'>                                                            
                                <input class="form-check-label" name="dow_all" id="dow_all" type="checkbox" value="1" {if $dow.0==="*"}checked{/if}>
                                <label class="form-check-label" for="dow_all">{$LNG.cron_selectall}</label>
                            </td>
                        </tr>
                        <tr>                    
                            <td><label for="class">{$LNG.cron_class}</label></td>
                            <td>{html_options name="class" class="form-control" id="class" output=$avalibleCrons values=$avalibleCrons selected=$class}</td>
                        </tr>
                    </tbody>
                </table>
                <input class="btn btn-primary" type="submit" value="{$LNG.button_proceed}">
            </form>
        </div>
    </div>
</main>
{/block}