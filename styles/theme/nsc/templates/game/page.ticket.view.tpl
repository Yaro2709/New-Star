{block name="title" prepend}{$LNG.ti_read} - {$LNG.lm_support}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/ticket.css">
<div id="page">
    <div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_flettab" style="padding-right:0;">{if $status != 2}{$LNG.ti_admin_open}{elseif $status == 2}{$LNG.ti_admin_close}{/if}
                <a href="game.php?page=ticket" class="tornaindietroa">{$LNG.nt_back}</a> 
            </div>
            {foreach $answerList as $answerID => $answerRow}
            <div class="ticket_message {if $answerRow.ownerID == $userID}ticket_message_owner{/if}">
                <div class="ticket_message_head">
                    <span class="ticket_message_head_name">{$answerRow.ownerName}</span> 
                    [{$answerRow.time}]
                </div>
                <div class="ticket_message_text">
                    {$answerRow.message}
                </div>
            </div>
            {/foreach}
            <div class="clear"></div>
            {if $status != 2}
            <form action="game.php?page=ticket&mode=send" method="post" id="form">
            <input type="hidden" name="id" value="{$ticketID}">
                <div class="statbarsup1" style="margin: 0px 0px 7px 7px;">
                    <table class="tablesorter ally_ranks">
                        <tbody>
                            <tr>
                                <td colspan="2">
                                    <textarea placeholder="{$LNG.ti_mess}" class="ticket_message_send_text" id="message" name="message" rows="60" cols="8" style="height:100px;"></textarea>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            {/if}
            {if $status != 2}
            <div class="fleettab1" style="height: 32px;"> 
                <button type="submit" class="rexx12">{$LNG.ti_submit}</button>
            </div>
            {/if}
            </form>
        </div>
    </div>
</div>
{/block}
{block name="script" append}
<script>
   $(document).ready(function() {
   	$("#form").validationEngine('attach');
   });
</script>
{/block}