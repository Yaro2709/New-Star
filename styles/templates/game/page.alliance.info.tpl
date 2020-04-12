{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner">
         <div class="gray_stripe">
            {$LNG.alm_ally}      
         </div>
         <div class="dis_img">
            <table class="no_visible">
               <tr>
                  <td>
                     {if $ally_image} <img src="{$ally_image}" />  {/if}          <span class="designation">
                     <span>{$ally_name} [{$ally_tag}]</span><br/>
                     {$ally_member_scount} {$LNG.all_member} {$LNG.all_of} {$ally_max_members}
                     </span>
                  </td>
               </tr>
            </table>
         </div>
         <div class="gray_stripe">
            {if $ally_request}
            <tr>
               {if $ally_request_min_points}
               <td><a href="game.php?page=alliance&amp;mode=apply&amp;id={$ally_id}">{$LNG.al_click_to_send_request}</a></td>
               {else}
               <td>{$ally_request_min_points_info}
                  {/if}
            </tr>
            {/if}
         </div>
         <div class="ally_contents">
            <span style="color: #fff">{if !empty($ally_description)}{$ally_description}{else}{$LNG.al_description_message}{/if}</span>           
         </div>
         <div class="">
            <div class="gray_stripe">
               <div class="right_part">
                  <div class="gray_stripe">
                     {$LNG.pl_fightstats}
                  </div>
                  <div class="ally_contents">
                     <p>{$LNG.pl_totalfight}: <span>{$statisticData.totalfight|number}</span></p>
                     <p>{$LNG.pl_fightwon}: <span>{$statisticData.fightwon|number} {if $statisticData.totalfight}({round($statisticData.fightwon / $statisticData.totalfight * 100, 2)}%){/if}</span></p>
                     <p>{$LNG.pl_fightlose}: <span>{$statisticData.fightlose|number} {if $statisticData.totalfight}({round($statisticData.fightlose / $statisticData.totalfight * 100, 2)}%){/if}</span></p>
                     <p>{$LNG.pl_fightdraw}: <span>{$statisticData.fightdraw|number} {if $statisticData.totalfight}({round($statisticData.fightdraw / $statisticData.totalfight * 100, 2)}%){/if}</span></p>
                  </div>
               </div>
               {if isset($diplomaticData)}
               {$LNG.al_diplo}
            </div>
            <div class="ally_contents">
               {if $diplomaticData}
               {if !empty($diplomaticData.0)}{$LNG.al_diplo_level.0}<br/>
               <ul>
                  {foreach item=PaktInfo from=$diplomaticData.0}
                  <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                  {/foreach}
               </ul>
               {/if}
               {if !empty($diplomaticData.1)}{$LNG.al_diplo_level.1}<br/>
               <ul>
                  {foreach item=PaktInfo from=$diplomaticData.1}
                  <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                  {/foreach}
               </ul>
               {/if}
               {if !empty($diplomaticData.2)}{$LNG.al_diplo_level.2}<br/>
               <ul>
                  {foreach item=PaktInfo from=$diplomaticData.2}
                  <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                  {/foreach}
               </ul>
               {/if}
               {if !empty($diplomaticData.3)}{$LNG.al_diplo_level.3}<br/>
               <ul>
                  {foreach item=PaktInfo from=$diplomaticData.3}
                  <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                  {/foreach}
               </ul>
               {/if}
               {if !empty($diplomaticData.4)}{$LNG.al_diplo_level.4}<br/>
               <ul>
                  {foreach item=PaktInfo from=$diplomaticData.4}
                  <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                  {/foreach}
               </ul>
               {/if}
               {if !empty($diplomaticData.5)}{$LNG.al_diplo_level.5}<br/>
               <ul>
                  {foreach item=PaktInfo from=$diplomaticData.5}
                  <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a><br>{/foreach}
               </ul>
               {/if}
               {else}
            </div>
         </div>
         {/if}
      </div>
   </div>
   {/if}<!--/ally-->
</div>
</div>
<div class="clear"></div>
</div>
{/block}