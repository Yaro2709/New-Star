{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<div id="page">
<div id="content">
   <div id="ally_content" class="conteiner">
      <div class="gray_stripe" style="padding-right:0; margin-bottom:5px;">
         {$LNG.al_diplo_head}
         <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyCreate&amp;diploMode=0" class="right_flank button" onclick="return Dialog.open(this.href, 684, 283);">
         {$LNG.al_diplo_create}</a>
      </div>
      {foreach $diploList.0 as $diploMode => $diploAlliances}	
      <div class="gray_stripe"> 
         {$LNG.al_diplo_level.$diploMode} <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyCreate&amp;diploMode={$diploMode}" onclick="return Dialog.open(this.href, 684, 283);" 
            class="batn_lincks right_flank diplomacy">{$LNG.al_diplo_head}</a>
      </div>
      <div class="ally_contents">
         {foreach $diploAlliances as $diploID => $diploName}
         {$diploName}
         {if $diploMode != 5}
         <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyDelete&amp;id={$diploID}" onclick="return confirm('{$LNG.al_diplo_confirm_delete}');" style="text-decoration:none; font-size:14px;">
         <img src="{$dpath}img/general/false.png" alt="" width="14" height="14"></a>
         {/if}	
         &ensp;&ensp;&ensp;&ensp;
         {foreachelse}
         <span>{$LNG.al_diplo_no_entry}</span>
         {/foreach}
      </div>
      {/foreach}
      <div>
         <div class="left_part">
            <div class="gray_stripe">
               {$LNG.al_diplo_accept}
            </div>
            <div class="ally_contents">
               {if array_filter($diploList.1)}
               {foreach $diploList.1 as $diploMode => $diploAlliances}	
               {if !empty($diploAlliances)}
               {$LNG.al_diplo_level.$diploMode}<br/>
               <ul>
                  {foreach $diploAlliances as $diploID => $diploName}
                  <li>
                     {$diploName}
                     <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyAccept&amp;id={$diploID}" onclick="return confirm('{$LNG.al_diplo_accept_yes_confirm}');">
                     <img src="{$dpath}img/general/true.png" alt="" width="16" height="16"></a>
                     {if $diploMode != 5}
                     <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyDelete&amp;id={$diploID}" onclick="return confirm('{$LNG.al_diplo_accept_no_confirm}');">
                     <img src="{$dpath}img/general/false.png" alt="" width="16" height="16"></a>
                     {/if}
                  </li>
                  {/foreach}
               </ul>
               {/if}
               {/foreach}
               {else}<span>{$LNG.al_diplo_no_accept}</span>{/if}
            </div>
         </div>
         <div class="right_part">
            <div class="gray_stripe">
               {$LNG.al_diplo_accept_send}
            </div>
            <div class="ally_contents">
               {if array_filter($diploList.2)}
               {foreach $diploList.2 as $diploMode => $diploAlliances}	
               {if !empty($diploAlliances)}
               {$LNG.al_diplo_level.$diploMode}<br/>
               <ul>
                  {foreach $diploAlliances as $diploID => $diploName}
                  <li>
                     {$diploName}
                     {if $diploMode != 5}
                     <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyDelete&amp;id={$diploID}" onclick="return confirm('{$LNG.al_diplo_confirm_delete}');">
                     <img src="{$dpath}img/general/false.png" alt="" width="16" height="16"></a>
                     {/if}
                  </li>
                  {/foreach}
               </ul>
               {/if}
               {/foreach}
               {else}
               <span>{$LNG.al_diplo_no_accept}</span>
               {/if} 
            </div>
         </div>
         <div class="clear"></div>
      </div>
   </div>
   <div class="ally_bottom" style="text-align:left;">
      <a href="game.php?page=alliance&amp;mode=admin">{$LNG.al_back}</a>
   </div>
   <div class="clear"></div>
</div>
{/block}