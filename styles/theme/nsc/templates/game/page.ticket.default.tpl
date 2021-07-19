{block name="title" prepend}{$LNG.lm_support}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/ticket.css">
<div id="page">
   <div id="content">
        <div id="ally_content" class="conteiner" style="padding-bottom:2px;">
            <div class="gray_flettab" style="padding-right:0;">{$LNG.ti_header}
                <a href="game.php?page=ticket&amp;mode=create" class="tornaindietroa">{$LNG.ti_new}</a>
            </div>
            <div class="fleettab8" style="margin-bottom: 0;"></div>
            {foreach $ticketList as $TicketID => $TicketInfo}	
            <a href="game.php?page=ticket&amp;mode=view&amp;id={$TicketID}" class="ticket_row_linck">
                <span class="ticket_row_linck_id">#{$TicketID}</span>
                <span class="ticket_row_linck_subject">{$TicketInfo.subject}</span>
                <span class="ticket_row_linck_time">{$TicketInfo.time}</span>
                {if $TicketInfo.status == 0}
                <span class="ticket_row_linck_status" style="color:green">{$LNG.ti_status_open}</span>
                {elseif $TicketInfo.status == 1}<span class="ticket_row_linck_status" style="color:orange">{$LNG.ti_status_answer}</span>{elseif $TicketInfo.status == 2}<span class="ticket_row_linck_status" style="color:red">{$LNG.ti_status_closed}</span>
                {/if}
                <span class="clear"></span>
            </a>    
            {foreachelse}
            {/foreach}
        </div>
    </div>
</div>
{/block}