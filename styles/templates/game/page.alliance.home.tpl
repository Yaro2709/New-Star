{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner">
         <div class="gray_stripe">
            {if $rights.ADMIN}
            <a href="?page=alliance&amp;mode=admin" class="batn_lincks right_flank office">{$LNG.al_manage_alliance}</a> {/if}       
               {$LNG.al_rank}: {$rankName}
         </div>
         <div class="dis_img">
            <table class="no_visible">
               <tr>
                  <td>
                     {if $ally_image} <img src="{$ally_image}" />  {/if} 
                     <span class="designation">
                     <span>{$ally_name} [{$ally_tag}]</span><br/>
                     {if $rights.MEMBERLIST} <a href="?page=alliance&amp;mode=memberList">{$ally_members} {$LNG.all_member}</a> {$LNG.all_of} {$ally_max_members}{else}{$ally_members} {$LNG.MOA} {$ally_max_members}{/if}
                     {if $rights.SEEAPPLY && $applyCount > 0}		
                     <a href="?page=alliance&amp;mode=admin&amp;action=mangeApply">{$requests}</a>
                     {/if}	
                     </span>
                  </td>
               </tr>
            </table>
         </div>
         <div class="gray_stripe">
            <div class="left_part">	
               {if $rights.ROUNDMAIL}
               <a href="game.php?page=alliance&mode=circular" onclick="return Dialog.open(this.href, 650, 300);" class="batn_lincks {*right_flank*} mesages">{$LNG.al_circular_message}</a>
               {/if}
            </div>
            <div class="right_part">
               <a href="game.php?page=chat&chat=ally"
                  class="batn_lincks right_flank chat">{$LNG.al_goto_chat}</a>
            </div>
         </div>
         <div class="ally_contents">
            {if $ally_description}{$ally_description}{else}{$LNG.al_description_message}{/if}   
         </div>
         {if $rights.EVENTS}
         <div class="gray_stripe">
            {$LNG.al_events}
         </div>
         <div class="ally_contents">
            {if $ally_events}	
            <span>
               {foreach $ally_events as $member => $events}
               
               <tr>
                  <td colspan="2">{$member}</td>
               </tr>
               {foreach $events as $index => $fleet}
               <tr>
                  <br> <span class="fleets"data-fleet-time="{$fleet.resttime}">-</span> 
                  <td colspan="2">{$fleet.text}</td>
               </tr>
               {/foreach}
               <br> 
               {/foreach}
               {else}
               <tr>
                  <td colspan="2">{$LNG.al_no_events}</td>
               </tr>
            </span>
            {/if}           
         </div>
         {/if}
         <div class="gray_stripe">
            {$LNG.al_inside_section}
         </div>
         <div class="ally_contents">
            {$ally_text}
         </div>
         <div>
            <div class="left_part">
               <div class="gray_stripe">
                  {$LNG.al_diplo}
                  {if $rights.DIPLOMATIC}<a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacy" class="batn_lincks right_flank diplomacy">{$LNG.al_diplo}</a>{/if}
               </div>
               <div class="ally_contents">
                  {if $DiploInfo}
                  {if !empty($DiploInfo.0)}{$LNG.al_diplo_level.0}<br/>
                  <ul>
                     {foreach item=PaktInfo from=$DiploInfo.0}
                     <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                     {/foreach}
                  </ul>
                  {/if}
                  {if !empty($DiploInfo.1)}{$LNG.al_diplo_level.1}<br/>
                  <ul>
                     {foreach item=PaktInfo from=$DiploInfo.1}
                     <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                     {/foreach}
                  </ul>
                  {/if}
                  {if !empty($DiploInfo.2)}{$LNG.al_diplo_level.2}<br/>
                  <ul>
                     {foreach item=PaktInfo from=$DiploInfo.2}
                     <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                     {/foreach}
                  </ul>
                  {/if}
                  {if !empty($DiploInfo.3)}{$LNG.al_diplo_level.3}<br/>
                  <ul>
                     {foreach item=PaktInfo from=$DiploInfo.3}
                     <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                     {/foreach}
                  </ul>
                  {/if}
                  {if !empty($DiploInfo.4)}{$LNG.al_diplo_level.4}<br/>
                  <ul>
                     {foreach item=PaktInfo from=$DiploInfo.4}
                     <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                     {/foreach}
                  </ul>
                  {/if}
                  {if !empty($DiploInfo.5)}{$LNG.al_diplo_level.5}<br/>
                  <ul>
                     {foreach item=PaktInfo from=$DiploInfo.5}
                     <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a><br>{/foreach}
                  </ul>
                  {/if}
                  {else}
                  <span>{$LNG.al_no_diplo}</span>
                  {/if}
               </div>
            </div>
            <div class="right_part">
               <div class="gray_stripe">
                  {$LNG.pl_fightstats}
               </div>
               <div class="ally_contents">
                  <p>{$LNG.pl_totalfight}: <span>{$totalfight|number}</span></p>
                  <p>{$LNG.pl_fightwon}: <span>{$fightwon|number} {if $totalfight}({round($fightwon / $totalfight * 100, 2)}%){/if}</span></p>
                  <p>{$LNG.pl_fightlose}: <span>{$fightlose|number} {if $totalfight}({round($fightlose / $totalfight * 100, 2)}%){/if}</span></p>
                  <p>{$LNG.pl_fightdraw}: <span>{$fightdraw|number} {if $totalfight}({round($fightdraw / $totalfight * 100, 2)}%){/if}</span></p>
               </div>
            </div>
         </div>
      </div>
      <!--/ally-->
      {if !$isOwner}
      <div class="ally_bottom">
         <a href="game.php?page=alliance&amp;mode=close" onclick="return confirm('{$LNG.al_leave_ally}');">{$LNG.al_leave_alliance}</a>
      </div>
      {/if}
   </div>
</div>
<div class="clear"></div>
</div>
{/block}