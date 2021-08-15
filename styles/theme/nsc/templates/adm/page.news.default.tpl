{block name="title" prepend}{$LNG.lm_news}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_news}</h5>
        <div class="card-body">
            {nocache}
            {if isset($key)}
            <form method="POST" action="?page=news&amp;action=send&amp;key={$key}" class="mb-3">
                {if $news_id}
                <input name="id" type="hidden" value="{$news_id}">
                {/if}
                <table class="table table-dark table-hover">
                    <thead>
                        <tr>
                            <th colspan="2">{$nws_head}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><label for="title">{$LNG.nws_title}</label></td>
                            <td><input name="title" type="text" value="{$news_title}" class="form-control" id="title"></td>
                        </tr>
                        <tr>
                            <td><label for="text">{$LNG.nws_content}</label></td>
                            <td><textarea cols="70" rows="10" name="text" type="text" class="form-control" id="text">{$news_text}</textarea></td>
                        </tr>
                    </tbody>
                </table>
                <button type="submit" name="Submit" class="btn btn-primary">{$LNG.button_submit}</button>
            </form>
            {/if}
            {/nocache}
            <table class="table table-dark table-hover">
                <thead>
                    <tr>
                        <th>{$LNG.input_id}</th>
                        <th>{$LNG.nws_title}</th>
                        <th>{$LNG.nws_date}</th>
                        <th>{$LNG.nws_from}</th>
                        <th>{$LNG.nws_del}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $NewsList as $NewsRow}
                    <tr>
                        <td><a href="?page=news&amp;action=edit&amp;id={$NewsRow.id}">{$NewsRow.id}</a></td>
                        <td><a href="?page=news&amp;action=edit&amp;id={$NewsRow.id}">{$NewsRow.title}</a></td>
                        <td><a href="?page=news&amp;action=edit&amp;id={$NewsRow.id}">{$NewsRow.date}</a></td>
                        <td><a href="?page=news&amp;action=edit&amp;id={$NewsRow.id}">{$NewsRow.user}</a></td>
                        <td><a href="?page=news&amp;action=delete&amp;id={$NewsRow.id}" onclick="return confirm('{$NewsRow.confirm}');"><img border="0" src="./styles/resource/images/alliance/CLOSE.png" width="16" height="16"></a></td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
        <div class="card-footer text-center">
            <p class="card-text"><a href="?page=news&amp;action=create">{$LNG.nws_create}</a></p>
        </div>
    </div>
</main>
{/block}