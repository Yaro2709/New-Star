{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner" style="width:450px;">
         <form action="game.php?page=alliance&amp;mode=create&amp;action=send" method="POST">
            <div class="gray_stripe">
               <div class="left_part">	
                  {$LNG.al_make_alliance}  
               </div>
            </div>
            <div class="ally_contents" style="padding-bottom:10px;">
               <label class="left_label">{$LNG.al_make_ally_tag_required}</label> 
               <input type="text" class="big_seting_text" name="atag" value="" size="8" maxlength="8" style="width:175px; width:175px; text-align:left;">
               <div class="clear"></div>
               <label class="left_label">{$LNG.al_make_ally_name_required}</label>
               <input type="text" class="big_seting_text" name="aname" value="" size="20" maxlength="30" style="width:175px; text-align:left;">
               <div class="clear"></div>
               <input type="submit" value="{$LNG.al_make_submit}" style="display:block; margin:0 auto; padding:3px 15px;">
            </div>
         </form>
      </div>
   </div>
</div>
<div class="clear"></div>
</div>
{/block}