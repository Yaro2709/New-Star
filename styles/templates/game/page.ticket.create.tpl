{block name="title" prepend}{$LNG.ti_create_head} - {$LNG.lm_support}{/block}
{block name="content"}
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner">
         <div class="gray_stripe">
            {$LNG.ti_create_head}
         </div>
         <div class="ticket_create_info">
            <p>{$LNG.ti_create_info}</p>
         </div>
         <form action="game.php?page=ticket&mode=send" method="post" id="form">
            <input type="hidden" name="id" value="0">
            <div class="gray_stripe">
               <label for="category">{$LNG.ti_category}:</label> 
               <select id="category" name="category">
                  <option></option>
                  <option>{$LNG.ti_category_error}</option>
                  <option>{$LNG.ti_category_bug}</option>
                  <option>{$LNG.ti_category_language}</option>
               </select>
               <label for="subject" style="margin-left:20px;">{$LNG.ti_subject}:</label> <input type="text" id="subject" name="subject" size="40" maxlength="255">
            </div>
            <textarea placeholder="{$LNG.ti_mess}" class="ticket_message_send_text" id="message" name="message" row="60" cols="8" style="height:100px;"></textarea>
            <div class="build_band ticket_bottom_band">
               <input class="bottom_band_submit" type="submit" value="{$LNG.ti_submit}">
            </div>
         </form>
      </div>
      <div class="ally_bottom">
         <a href="game.php?page=ticket">{$LNG.ti_overview}</a>
      </div>
   </div>
</div>
<div class="clear"></div>
</div>
{/block}
