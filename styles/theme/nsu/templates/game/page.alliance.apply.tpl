{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
<div id="content">
<div id="ally_content" class="conteiner">
   <div class="gray_stripe">
      {$al_write_request}
   </div>
   <form action="game.php?page=alliance&amp;mode=apply&amp;id={$allyid}" method="post">
      <div class="statbarsup1" style="margin: 7px;">
      <table class="tablesorter ally_ranks">
         <tbody>
            <tr>
               <td colspan="2">
                  <textarea name="text" cols="40" rows="10" class="tinymce" id="message">{$applytext}</textarea>
               </td>
            </tr>
         </tbody>
      </table>
      </div>
      <div class="fleettab1" style="height: 32px;"> 
            <button type="reset" class="rexx13">{$LNG.al_circular_reset}</button>
            <button onclick="return check();" name="button" class="rexx12">{$LNG.al_applyform_send}</button>
      </div>
   </form>
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