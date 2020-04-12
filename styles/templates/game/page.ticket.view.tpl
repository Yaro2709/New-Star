{block name="title" prepend}{$LNG.ti_read} - {$LNG.lm_support}{/block}
{block name="content"}
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner">
         <div class="gray_stripe">
            {$LNG.ti_header}
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
            <div class="gray_stripe">
               {$LNG.ti_admin_open}
            </div>
            <textarea placeholder="{$LNG.ti_mess}" class="ticket_message_send_text" id="message" name="message" rows="60" cols="8" style="height:100px;"></textarea>
            <div class="build_band ticket_bottom_band">
               <input class="bottom_band_submit" type="submit" value="{$LNG.ti_submit}">
            </div>
         </form>
         {/if}
         {if $status == 2}
         <div class="build_band" style="padding: 0 10px;">
            {$LNG.ti_admin_close}
         </div>
         {/if}
      </div>
      <div class="ally_bottom">
         <a href="game.php?page=ticket">{$LNG.ti_overview}</a>
      </div>
   </div>
</div>
<div class="clear"></div>
</div>
{/block}
{block name="script" append}
<script>
   $(document).ready(function() {
   	$("#form").validationEngine('attach');
   });
</script>
{/block}