{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
   <div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_flettab">
             {$LNG.al_manage_alliance} <a href="game.php?page=alliance" class="tornaindietroa">{$LNG.all_status}</a>      
            </div>             
            <div class="fleettab8" style="margin-bottom: 0;"></div>   
            <div class="ally_img" {if $ally_image}style="background-image:url({$ally_image})"{/if}>
                <div class="designation">
                    <span class="">{$ally_name} [{$ally_tag}]</span><br>
                    {$ally_members} {$LNG.all_member} {$LNG.all_of} {$ally_max_members}
                </div>      
            </div>
            <div class="alleanza1" style="height:36px;width: 698px;">
                <a href="game.php?page=alliance&amp;mode=admin&amp;action=permissions" class="ranks alleanza61">{$LNG.al_manage_ranks}</a>
                <a href="game.php?page=alliance&amp;mode=admin&amp;action=members" class="entry alleanza61">{$LNG.al_manage_members}</a>
                <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacy" class="diplomacy alleanza61">{$LNG.al_diplo}</a>
                <a {*href="game.php?page=alliance&amp;mode=admin&amp;action=planets"*} class="planets alleanza61 alleanza620">{$LNG.al_ally_planets}</a>
            </div>   
            <form action="game.php?page=alliance&mode=admin" method="post">
                <input type="hidden" name="textMode" value="{$textMode}">
                <input type="hidden" name="send" value="1">    
                <div class="alleanza1" style="height:330px;width: 698px;">
                    <div class="alleanza5">{$LNG.al_texts}</div> 
                    <div style="position: relative;float: left;margin-top:20px;width: 685px;padding: 7px;">	
                        <a href="game.php?page=alliance&amp;mode=admin&amp;textMode=external" class="batn_editing {if $textMode == "external"}batn_editing_active{else}{/if}" >{$LNG.al_outside_text}</a>
                        <a href="game.php?page=alliance&amp;mode=admin&amp;textMode=internal" class="batn_editing {if $textMode == "internal"}batn_editing_active{else}{/if}">{$LNG.al_inside_text}</a> 
                        <a href="game.php?page=alliance&amp;mode=admin&amp;textMode=apply" class="batn_editing {if $textMode == "apply"}batn_editing_active{else}{/if}">{$LNG.al_request_text}</a>
                    <div class="clear"></div>
                    <textarea name="text" id="text" cols="70" rows="15" class="tinymce">{$text}</textarea>
                    <div class="clear" style="margin-bottom:7px;"></div>
                    <div class="left_part">
                        <input type="reset" class="rexx13" style="margin:0" value="{$LNG.al_circular_reset}"> 
                    </div>
                    <div class="right_part">
                        <input type="submit" class="rexx12" style="margin:0" value="{$LNG.al_save}">
                    </div>
                    <div class="clear"></div>
                </div>
        </div>
        <div class="alleanzas">
            <div class="alleanza1" style="height: 263px;width: 433px;">
                <span class="alleanza5">{$LNG.al_manage_options}</span>
                <div class="alleanza50" style="margin-top:35px">
                    <label class="alleanza49">{$LNG.al_tag}</label>
                    <input type="text" class="alleanza48" name="ally_tag" value="{$ally_tag}" size="8" maxlength="8">
                    <div class="clear"></div> 
                 </div>
                <div class="alleanza50">
                    <label class="alleanza49">{$LNG.al_name}</label>
                    <input type="text" class="alleanza48" name="ally_name" value="{$ally_name}" size="20" maxlength="30">
                    <div class="clear"></div>
                </div>
                <div class="alleanza50">
                    <label class="alleanza49">{$LNG.al_manage_founder_rank}</label>
                    <input type="text" class="alleanza48" name="owner_range" value="{$ally_owner_range}" size="30">
                    <div class="clear"></div> 
                </div>
                <div class="alleanza50">
                    <label class="alleanza49">{$LNG.al_web_site}</label>
                    <input type="text" class="alleanza48" name="web" value="{$ally_web}" size="70">
                    <div class="clear"></div> 
                </div>
                <div class="alleanza50">
                    <label class="alleanza49">{$LNG.al_manage_image} (714px на 215px)</label>
                    <input type="text" class="alleanza48" name="image" value="{$ally_image}" size="70">
                    <div class="clear"></div> 
                </div>
                <div class="alleanza50">
                    <label class="alleanza49">{$LNG.al_view_stats}</label>
                    {html_options name=stats options=$YesNoSelector selected=$ally_stats_data class="alleanza48" id="statsmostr"}
                    <div class="clear"></div> 
                </div>
                <div class="alleanza50">
                    <label class="alleanza49">{$LNG.al_view_diplo}</label>
                    {html_options name=diplo options=$YesNoSelector selected=$ally_diplo_data class="alleanza48" id="statsmostr"}
                    <div class="clear"></div> 
                </div>
            </div>	
        </div>    	
        <div class="alleanzad" style="width:242px">
            <div class="alleanza1" style="height: 263px;width: 255px;float: right;">
                <span class="alleanza5">{$LNG.al_view_events}</span>	
                <select name="events[]" size="{$available_events|@count}" class="alleanza51" style="height: 220px;" multiple>
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
        </div>                            
        <div class="alleanza1" style="width: 698px;height: 125px;margin-bottom:7px">
            <span class="alleanza5">{$LNG.all_appl}</span>
            <div class="alleanza54" style="margin-top: 35px;">
                <label class="alleanza53">{$LNG.al_manage_requests}</label>	
                {html_options name=request_notallow options=$RequestSelector selected=$ally_request_notallow class="alleanza52" id="reqall"}
                <div class="clear"></div> 
            </div>
            <div class="alleanza54">		
                <label class="alleanza53">{$LNG.al_set_max_members}</label>	
                <input class="alleanza52" type="number" min="1" name="ally_max_members" value="{$ally_max_members}" size="8">
                <div class="clear"></div> 
            </div> 
            <div class="alleanza54">
                <label class="alleanza53">{$LNG.al_manage_request_min_points}</label>	
                <input type="number" class="alleanza52" min="0" name="request_min_points" value="{$ally_request_min_points}" size="30">
                <div class="clear"></div>
            </div>        
        </div>
        <div class="alleanza57"></div>
        <div class="alleanza56"><input type="submit" value="{$LNG.al_save}" class="alleanza55"></div>
	</form>     
    <div class="alleanza58" style="top: 160px;">
        <a href="game.php?page=alliance&amp;mode=admin&amp;action=transfer" class="alleanza59">{$LNG.al_transfer_alliance}</a>
        <a href="game.php?page=alliance&amp;mode=admin&amp;action=close" onclick="return confirm('{$LNG.al_leave_ally}');" class="alleanza60">{$LNG.al_disolve_alliance}</a>
	</div>
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
			content_css : "{$dpath}css/general.css",
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