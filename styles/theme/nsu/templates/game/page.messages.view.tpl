{block name="content"}
<div class="messagestable">
<form action="game.php?page=messages" method="post">
   <input type="hidden" name="mode" value="action">
   <input type="hidden" name="ajax" value="1">
   <input type="hidden" name="messcat" value="{$MessID}">
   <input type="hidden" name="side" value="{$page}">
        <div class="message_page_navigation" style="color: #ccc;">{$LNG.mg_page}: 
            {if $page != 1}<a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page - 1});return false;">&laquo;</a>&nbsp;{/if}
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, 1);return false;">{if 1 == $page}<span class="active_page">1</span>{else}1{/if}</a>
            {if $page - 4 > 1} ... {/if}   
            {if $page - 3 > 1}
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page - 3});return false;">{if $page - 3 == $page}<span class="active_page">{$page - 3}</span>
            {else}{$page - 3}{/if}</a>{/if} 
            {if $page - 2 > 1}
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page - 2});return false;">{if $page - 2 == $page}<span class="active_page">{$page - 2}</span>
            {else}{$page - 2}{/if}</a>{/if}   
            {if $page - 1 > 1}
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page - 1});return false;">{if $page - 1 == $page}<span class="active_page">{$page - 1}</span>
            {else}{$page - 1}{/if}</a>{/if}
            {if $page     > 1}
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page    });return false;">{if $page     == $page}<span class="active_page">{$page    }</span>
            {else}{$page   }{/if}</a>{/if}
            {if $page + 1 <= $maxPage}            
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page + 1});return false;">{if $page + 1 == $page}<span class="active_page">{$page + 1}</span>
            {else}{$page + 1}{/if}</a>{/if}
            {if $page + 2 <= $maxPage}            
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page + 2});return false;">{if $page + 2 == $page}<span class="active_page">{$page + 2}</span>
            {else}{$page + 2}{/if}</a>{/if}
            {if $page + 3 <= $maxPage}            
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page + 3});return false;">{if $page + 3 == $page}<span class="active_page">{$page + 3}</span>
            {else}{$page + 3}{/if}</a>{/if}  
            {if $page + 4 < $maxPage} ... {/if}   
            {if $page + 4 <= $maxPage}
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$maxPage});return false;">{if $maxPage == $page}<span class="active_page">{$maxPage}</span>{else}{$maxPage} {/if}</a>
            {/if}      
            {if $page != $maxPage}&nbsp;<a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page + 1});return false;">&raquo;</a>{/if}
        </div>
      {foreach $MessageList as $Message}
    <div class="head_row_msg">
        <div id="message_{$Message.id}" class="message_head{if $MessID != 999 && $Message.unread == 1} mes_unread{/if}">
            <div class="message_time">{$Message.time}</div>
            <div class="message_sender">
                {if $Message.type == 1 && $MessID != 999}
                <a href="#" onclick="return Dialog.Buddy({$Message.sender})" title="{$LNG.mg_fre}"><img height="13px" class="messagesnew4" src="{$dpath}img/iconav/mes_friendd.png"></a> 
                {*<a href="?page=EnnemiesList&mode=send&id={$Message.sender}" title="{$LNG.mg_ene}"><img height="13px" class="messagesnew4" src="{$dpath}img/iconav/mes_enemiess.png" style="height:20px;"></a>*}
                <a href="#" onclick="return Dialog.PM({$Message.sender}, Message.CreateAnswer('{$Message.subject}'));" title="{$LNG.mg_answer_to} {strip_tags($Message.from)}"><img height="13px" class="messagesnew4" src="{$dpath}img/iconav/mes_messages.png" border="0"></a>
                {*<a href="#" onclick="return Dialog.complPM({$Message.id})" title="{$LNG.mg_rep}"><img height="13px" class="messagesnew4" src="{$dpath}img/iconav/mes_complaint.png" height="16px"></a>*}
                {/if}
                <a href="#" onclick="msgArchive({$Message.id}, {$Message.type}); Message.getMessages({$Message.type}); return false;" title="{$LNG.mg_arh}"><img height="13px" class="messagesnew4" src="{$dpath}img/iconav/mes_inarchive.png"></a>
                <a href="#" onclick="msgDel({$Message.id}, {$Message.type}); Message.getMessages({$Message.type}); return false;" title="{$LNG.mg_del}"><img height="13px" class="messagesnew4" src="{$dpath}img/iconav/mes_delmsg.png"></a>
                <div class="message_check">
                    {if $MessID != 999}<input name="messageID[{$Message.id}]" value="1" type="checkbox">{/if}                    
                </div>
            </div>
            <div class="message_title">
                <span class="message_recipient_name">{$Message.from}</span>
            </div>
        </div>
        <div class="messages_body">
            <div colspan="4" class="left" style="padding:0;">
                <div class="message_text">{$Message.text}</div>
            </div>
        </div>
	</div>
      {/foreach}
      <div class="message_page_navigation" style="color: #ccc;">{$LNG.mg_page}: 
            {if $page != 1}<a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page - 1});return false;">&laquo;</a>&nbsp;{/if}
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, 1);return false;">{if 1 == $page}<span class="active_page">1</span>{else}1{/if}</a>
            {if $page - 4 > 1} ... {/if}   
            {if $page - 3 > 1}
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page - 3});return false;">{if $page - 3 == $page}<span class="active_page">{$page - 3}</span>
            {else}{$page - 3}{/if}</a>{/if} 
            {if $page - 2 > 1}
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page - 2});return false;">{if $page - 2 == $page}<span class="active_page">{$page - 2}</span>
            {else}{$page - 2}{/if}</a>{/if}   
            {if $page - 1 > 1}
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page - 1});return false;">{if $page - 1 == $page}<span class="active_page">{$page - 1}</span>
            {else}{$page - 1}{/if}</a>{/if}
            {if $page     > 1}
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page    });return false;">{if $page     == $page}<span class="active_page">{$page    }</span>
            {else}{$page   }{/if}</a>{/if}
            {if $page + 1 <= $maxPage}            
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page + 1});return false;">{if $page + 1 == $page}<span class="active_page">{$page + 1}</span>
            {else}{$page + 1}{/if}</a>{/if}
            {if $page + 2 <= $maxPage}            
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page + 2});return false;">{if $page + 2 == $page}<span class="active_page">{$page + 2}</span>
            {else}{$page + 2}{/if}</a>{/if}
            {if $page + 3 <= $maxPage}            
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page + 3});return false;">{if $page + 3 == $page}<span class="active_page">{$page + 3}</span>
            {else}{$page + 3}{/if}</a>{/if}  
            {if $page + 4 < $maxPage} ... {/if}   
            {if $page + 4 <= $maxPage}
            <a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$maxPage});return false;">{if $maxPage == $page}<span class="active_page">{$maxPage}</span>{else}{$maxPage} {/if}</a>
            {/if}      
            {if $page != $maxPage}&nbsp;<a href="#" class="messagesnew2 messagesnew3" onclick="Message.getMessages({$MessID}, {$page + 1});return false;">&raquo;</a>{/if}
        </div>
      {if $MessID != 999}
      <div class="build_band2" style="padding-right:0;">         
       <input class="bottom_band_submit" value="{$LNG.mg_confirm}" type="submit" name="submitBottom">
        <select class="bottom_band_select" name="actionBottom">
               <option value="readmarked">{$LNG.mg_read_marked}</option>
				<option value="readtypeall">{$LNG.mg_read_type_all}</option>
				<option value="readall">{$LNG.mg_read_all}</option>
				<option value="deletemarked">{$LNG.mg_delete_marked}</option>
				<option value="deleteunmarked">{$LNG.mg_delete_unmarked}</option>
				<option value="deletetypeall">{$LNG.mg_delete_type_all}</option>
				<option value="deleteall">{$LNG.mg_delete_all}</option>
               <option value="archivemarked">{$LNG.mg_arh_mess}</option>
        </select>
      </div>
      {/if}
</form>

</div>

			</div>
		</div>
	</div>
</div>
</div>
</div>
{/block}