{block name="title" prepend}{$LNG.lm_rights}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_rights}</h5>
        <div class="card-body">
            <form action="" method="post">
            <input name="action" type="hidden" value="send">
            <input name="id_1" type="hidden" value="{$id}">
                <table class="table table-dark table-hover">
                    <thead>
                        <tr>
                            <th>{$Username}</th>
                            <th><a href="javascript:;" onclick="$('.yes').attr('checked', 'checked');">{$yesorno.1}</a> <a href="javascript:;" onclick="$('.no').attr('checked', 'checked');">{$yesorno.0}</a></th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach item=File from=$Files}
                        <tr>
                            <td>{$File}</td>
                            <td>{$yesorno.1} <input class="yes" name="rights[{$File}]" type="radio"{if $Rights.$File == 1} checked="checked"{/if} value="1"> {$yesorno.0} <input class="no" name="rights[{$File}]" type="radio"{if $Rights.$File != 1} checked="checked"{/if} value="0"></td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
                <input class="btn btn-primary" type="submit" value="{$LNG.button_submit}">
            </form>
        </div>
    </div>
</main>
{/block}