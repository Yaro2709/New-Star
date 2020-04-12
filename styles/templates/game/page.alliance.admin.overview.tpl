{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner">
         <div class="gray_stripe">
            <div class="left_part">	
               {$LNG.al_manage_alliance}
            </div>
            <a href="game.php?page=alliance" class="batn_lincks right_flank over">{$LNG.all_status}</a>                       
         </div>
         <div class="dis_img">
            <table class="no_visible">
               <tr>
                  <td>
                     {if $ally_image}
                     <img src="{$ally_image}" />   {/if}
                     <span class="designation">
                     <span>{$ally_name} [{$ally_tag}]</span><br/>
                     </span>
                  </td>
               </tr>
            </table>
         </div>
         <div class="gray_stripe">
            <div class="left_part">
               <a href="game.php?page=alliance&amp;mode=admin&amp;action=permissions" class="batn_lincks ranks">{$LNG.al_manage_ranks}</a>
               <div class="clear"></div>
            </div>
            <div class="right_part">
               <a href="game.php?page=alliance&amp;mode=admin&amp;action=members" class="batn_lincks right_flank entry">{$LNG.al_manage_members}</a>
               <div class="clear"></div>
            </div>
         </div>
         <div class="ally_contents"></div>
         <form action="game.php?page=alliance&mode=admin" method="post">
            <input type="hidden" name="textMode" value="{$textMode}">
            <input type="hidden" name="send" value="1">
            <div class="gray_stripe">
               {$LNG.al_texts}
            </div>
            <div class="ally_contents">
               <a href="game.php?page=alliance&amp;mode=admin&amp;textMode=external" class="batn_editing {if $textMode == "external"}batn_editing_active{else}{/if}" >{$LNG.al_outside_text}</a>
               <a href="game.php?page=alliance&amp;mode=admin&amp;textMode=internal" class="batn_editing {if $textMode == "internal"}batn_editing_active{else}{/if}">{$LNG.al_inside_text}</a> 
               <a href="game.php?page=alliance&amp;mode=admin&amp;textMode=apply" class="batn_editing {if $textMode == "apply"}batn_editing_active{else}{/if}">{$LNG.al_request_text}</a>
               <div class="clear"></div>
               <textarea name="text" id="text" cols="70" rows="15" class="tinymce">{$text}</textarea>
               <div class="clear" style="margin-bottom:12px;"></div>
               <div class="left_part">
                  <input type="reset" class="right_flank" value="{$LNG.al_circular_reset}"> 
               </div>
               <div class="right_part">
                  <input type="submit" value="{$LNG.al_save}">
               </div>
               <div class="clear"></div>
            </div>
            <div class="gray_stripe">
               {$LNG.al_manage_options}
            </div>
            <div class="ally_contents">
               <label class="left_label">{$LNG.al_tag}</label>
               <input type="text" class="big_seting_text" name="ally_tag" value="{$ally_tag}" size="8" maxlength="8" required>
               <div class="clear"></div>
               <label class="left_label">{$LNG.al_name}</label>
               <input type="text" class="big_seting_text" name="ally_name" value="{$ally_name}" size="20" maxlength="30" required>
               <div class="clear"></div>
               <label class="left_label">{$LNG.al_manage_founder_rank}</label>
               <input type="text" class="big_seting_text" name="owner_range" value="{$ally_owner_range}" size="30">
               <div class="clear"></div>
               <label class="left_label">{$LNG.al_web_site}</label>
               <input type="text" class="big_seting_text" name="web" value="{$ally_image}" size="70">
               <div class="clear"></div>
               <label class="left_label">{$LNG.al_manage_image} (682px на 215px)</label>
               <input type="text" class="big_seting_text" name="image" value="{$ally_image}"" size="70">
               <div class="clear"></div>
               <label class="left_label">{$LNG.all_info}</label>
               <td>{$LNG.al_view_stats}</td>
               <td>{html_options name=stats options=$YesNoSelector selected=$ally_stats_data}</td>
               </tr>
               <tr>
                  <td>{$LNG.al_view_diplo}</td>
                  <td>{html_options name=diplo options=$YesNoSelector selected=$ally_diplo_data}</td>
                  <div class="clear"></div>
                  <label class="left_label">{$LNG.al_view_events}</label>		
                  <select name="events[]" size="{$available_events|@count}" multiple>
                    {foreach $available_events as $id => $mission}
                        {foreach $ally_events as $selected_events}
                            {if $selected_events == $id}
                                {assign var=selected value=selected}
                                {break}
                            {else}
                                {assign var=selected value=''}
                            {/if}
                        {/foreach}
                        <option value="{$id}" {$selected}>{$mission}</option>
                    {/foreach}
                </select>
                  <div class="clear"></div>
            </div>
            <div class="gray_stripe">
            {$LNG.all_appl}
            </div> 
            <div class="ally_contents">
            <label class="left_label">{$LNG.al_manage_requests}</label>	
            {html_options name=request_notallow options=$RequestSelector selected=$ally_request_notallow}
            <div class="clear"></div> 
            <label class="left_label">{$LNG.al_set_max_members}</label>	
            <input class="big_seting_text" type="number" min="1" name="ally_max_members" value="{$ally_max_members}" size="8">
            <div class="clear"></div> 
            <label class="left_label">{$LNG.al_manage_request_min_points}</label>	
            <input type="number" class="big_seting_text" min="0" name="request_min_points" value="{$ally_request_min_points}" size="30">
            <div class="clear"></div>       
            <input type="submit" value="{$LNG.al_save}" style="line-height:27px; width:100px; display:block; margin:0 auto; margin-top:30px;">
            </div>	
         </form>
      </div>
      <!--/ally-->
      {if $AllianceOwner}
      <div class="ally_bottom">
      <a href="game.php?page=alliance&amp;mode=admin&amp;action=close" onclick="return confirm('Are you sure you want to delete the alliance?');">{$LNG.al_disolve_alliance}</a>
      <a href="game.php?page=alliance&amp;mode=admin&amp;action=transfer">{$LNG.al_transfer_alliance}</a>
      </div>
      {/if}
   </div>
</div>
<div class="clear"></div>            
</div>
{/block}
{block name="script" append}
<script type="text/javascript" src="scripts/base/tinymce/tiny_mce_gzip.js"></script>
<script type="text/javascript">
$(function() {
	tinyMCE_GZ.init({
		plugins : 'bbcode,fullscreen',
		themes : 'advanced',
		languages : '{$lang}',
		disk_cache : true,
		debug : false
	}, function() {
		tinyMCE.init({
			language : '{$lang}',
			script_url : 'scripts/base/tinymce/tiny_mce.js',
			theme : "advanced",
			mode : "textareas",
			plugins : "bbcode,fullscreen",
			theme_advanced_buttons1 : "bold,italic,underline,undo,redo,link,unlink,image,forecolor,styleselect,removeformat,cleanup,code,fullscreen",
			theme_advanced_buttons2 : "",
			theme_advanced_buttons3 : "",
			theme_advanced_toolbar_location : "bottom",
			theme_advanced_toolbar_align : "center",
			theme_advanced_styles : "Code=codeStyle;Quote=quoteStyle",
			content_css : "{$dpath}formate.css",
			entity_encoding : "raw",
			add_unload_trigger : false,
			remove_linebreaks : false,
			fullscreen_new_window : false,
			fullscreen_settings : {
				theme_advanced_path_location : "top"
			}
		});
	});
});
</script>
{/block}