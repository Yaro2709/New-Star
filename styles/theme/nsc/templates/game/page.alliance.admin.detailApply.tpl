{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
    <div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_stripo">
                <div class="titolosinistra">	
                    {sprintf($LNG.al_request_from,$applyDetail.username)} {$apply_time}
                </div>
                <div class="tornaindietro"><a href="game.php?page=alliance&mode=admin&action=mangeApply">{$LNG.al_back} </a> </div>                     
            </div>
            {if !empty($applyDetail.text)}
            <div class="alleanza3" style="width: auto; float: none; height: auto; margin-top: 5px;"> 
                <span class="alleanza5">{$LNG.al_message}</span>
                <div class="alleanza36" style="width: auto;height: auto;">{$applyDetail.text}</div>
                <div class="clear"></div>
            </div>
            {/if}
        </div>
        <br>
        <div id="ally_content" class="conteiner">
           <div class="gray_stripo">
                <div class="titolosinistra">	
                     {$LNG.al_reply_to_request}
                </div>
                <div class="tornaindietro"><a onclick="return Dialog.Playercard({$applyDetail.id}, '{$applyDetail.username}');">{$LNG.lm_playercard}</a></div>         
            </div>
           <form action="game.php?page=alliance&amp;mode=admin&amp;action=sendAnswerToApply&amp;id={$applyDetail.applyID}" method="post">
              <div class="statbarsup1" style="margin: 7px;">
              <table class="tablesorter ally_ranks">
                 <tbody>
                    <tr>
                       <td colspan="2">
                          <textarea name="text" cols="40" rows="10" class="tinymce" id="message"></textarea>
                       </td>
                    </tr>
                 </tbody>
              </table>
              </div>
              <div class="fleettab1" style="height: 32px;"> 
                    <button type="submit" class="rexx12" name="answer" value="yes">{$LNG.al_acept_request}</button>
                    <button type="submit" class="rexx13" name="answer" value="no">{$LNG.al_decline_request}</button>
              </div>
           </form>
        </div>
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
			script_url : 'scripts/base/tinymce/tiny_mce.js',
			theme : "advanced",
			mode : "textareas",
			plugins : "bbcode,fullscreen",
			theme_advanced_buttons1 : "bold,italic,underline,undo,redo,link,unlink,image,forecolor,removeformat,cleanup,code,fullscreen",
			theme_advanced_buttons2 : "",
			theme_advanced_buttons3 : "",
			theme_advanced_toolbar_location : "top",
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