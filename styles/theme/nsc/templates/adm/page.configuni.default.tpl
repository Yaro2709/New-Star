{block name="title" prepend}{$LNG.lm_configuni}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <form action="" method="post">
    <input type="hidden" name="opt_save" value="1">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_configuni}</h5>
        <div class="card-body">
            <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                {foreach $config as $v1 => $name_list} 
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="pills-{$v1}-tab" data-toggle="pill" href="#pills-{$v1}" role="tab" aria-controls="pills-{$v1}" aria-selected="false">{$LNG["cu_class_{$v1}"]}</a>
                </li>
                {/foreach}
            </ul>
            <div class="tab-content" id="pills-tabContent">
                {foreach $config as $v1 => $name_list}
                <div class="tab-pane fade show" id="pills-{$v1}" role="tabpanel" aria-labelledby="pills-{$v1}-tab">
                    <table class="table table-dark table-hover">
                        <thead>
                            <tr>
                                <th>{$LNG.status_parameter}</th>
                                <th>{$LNG.status_value}</th>
                            </tr>
                        </thead>
                        <tbody>
                        {foreach $name_list as $v2 => $name_config}
                            <tr>
                                <td><label for="{$name_config}">{$LNG["cu_{$name_config}"]} ({$name_config})</label></td>
                                <td><input name="{$name_config}" value="{$config_before.$name_config}" type="text" class="form-control" id="{$name_config}"></td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                    <input class="btn btn-primary" type="submit" value="{$LNG.button_submit}">
                </div>
                {/foreach}
            </div>
        </div>
    </div>
    </form>
</main>
{/block}