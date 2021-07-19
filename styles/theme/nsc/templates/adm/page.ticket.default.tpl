{block name="title" prepend}{$LNG.lm_support}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_support}</h5>
        <div class="card-body">
            <table class="table table-dark table-hover">
                <thead>
                    <tr>
                        <th>{$LNG.ti_id}</td>
                        <th>{$LNG.ti_username}</td>
                        <th>{$LNG.ti_subject}</td>
                        <th>{$LNG.ti_answers}</td>
                        <th>{$LNG.ti_date}</td>
                        <th>{$LNG.ti_status}</td>
                    </tr>
                </thead>
                <tbody>
                    {foreach $ticketList as $TicketID => $TicketInfo}	
                    {if $TicketInfo.status < 2}
                    <tr>
                        <td><a href="admin.php?page=support&amp;mode=view&amp;id={$TicketID}">#{$TicketID}</a></td>
                        <td><a href="admin.php?page=support&amp;mode=view&amp;id={$TicketID}">{$TicketInfo.username}</a></td>
                        <td><a href="admin.php?page=support&amp;mode=view&amp;id={$TicketID}">{$TicketInfo.subject}</a></td>
                        <td>{$TicketInfo.answer - 1}</td>
                        <td>{$TicketInfo.time}</td>
                        <td>{if $TicketInfo.status == 0}<span style="color:green">{$LNG.ti_status_open}</span>{elseif $TicketInfo.status == 1}<span style="color:orange">{$LNG.ti_status_answer}</span>{/if}</td>
                    </tr>
                    {/if}
                    {/foreach}
                </tbody>
                <thead>
                    <tr>
                        <th>{$LNG.ti_id}</td>
                        <th>{$LNG.ti_username}</td>
                        <th>{$LNG.ti_subject}</td>
                        <th>{$LNG.ti_answers}</td>
                        <th>{$LNG.ti_date}</td>
                        <th>{$LNG.ti_status}</td>
                    </tr>
                </thead>
                <tbody>
                    {foreach $ticketList as $TicketID => $TicketInfo}	
                    {if $TicketInfo.status == 2}
                    <tr>
                        <td><a href="admin.php?page=support&amp;mode=view&amp;id={$TicketID}">#{$TicketID}</a></td>
                        <td><a href="admin.php?page=support&amp;mode=view&amp;id={$TicketID}">{$TicketInfo.username}</a></td>
                        <td><a href="admin.php?page=support&amp;mode=view&amp;id={$TicketID}">{$TicketInfo.subject}</a></td>
                        <td>{$TicketInfo.answer - 1}</td>
                        <td>{$TicketInfo.time}</td>
                        <td><span style="color:red">{$LNG.ti_status_closed}</span></td>
                    </tr>
                    {/if}
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</main>
{/block}