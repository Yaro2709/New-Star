{block name="title" prepend}{$LNG.lm_support}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <form action="admin.php?page=support&mode=send" method="post" id="form">
    <input type="hidden" name="id" value="{$ticketID}">
        <div class="card mb-3">
            <h5 class="card-header"><a href="admin.php?page=support">{$LNG.lm_support}</a></h5>
            <div class="card-body">
                {foreach $answerList as $answerID => $answerRow}
                <div class="media">
                    <img style="width:64px" src="../styles/resource/images/install/poster.jpg" class="mr-3" alt="...">
                    <div class="media-body">
                        <h5 class="mt-0">{$answerRow.subject} {$categoryList[$answerRow.categoryID]}</h5>
                        {$answerRow.message}
                        <p>
                            <small class="text-muted">{$answerRow.ownerName}: {$answerRow.time}</small>
                        </p>
                    </div>
                </div>
                {/foreach}
                <div class="form-group">
                    <label for="message">{$LNG.ti_answer}</label>
                    <textarea class="form-control validate[required]" id="message" name="message" row="60" cols="8"></textarea>
                </div>
                <div class="form-group form-check">
                    <input type="checkbox" class="form-check-input" name="change_status" value="1" id="Check">
                    <label class="form-check-label" for="Check">{if $ticket_status < 2}{$LNG.ti_close}{else}{$LNG.ti_open}{/if}</label>
                </div>
                <button type="submit" class="btn btn-primary">{$LNG.ti_submit}</button>
            </div>
        </div>
    </form>
</main>
{/block}