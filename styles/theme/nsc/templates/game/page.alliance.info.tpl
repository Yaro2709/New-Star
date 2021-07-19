{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
   <div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_flettab ">
                {$LNG.lm_alliance}
            </div>                   
            <div class="fleettab8" style="margin-bottom: 0;"></div>
            <div class="ally_img" {if $ally_image}style="background-image:url({$ally_image})"{/if}>     
                <div class="designation">
                    <span>{$ally_name} [{$ally_tag}]</span><br>
                    {$ally_member_scount} {$LNG.all_member} {$LNG.all_of} {$ally_max_members}
                </div>                             
            </div>  
        <div style="position: absolute;right: 14px;top:160px"> 
            {if $ally_request_min_points}
            <a href="game.php?page=alliance&amp;mode=apply&amp;id={$ally_id}" class="alleanza59">{$LNG.al_click_to_send_request}</a> 
            {else}
            {$ally_request_min_points_info}
            {/if}
        </div>    
        <div class="alleanza42">
           {if !empty($ally_description)}{$ally_description}{else}{$LNG.al_description_message}{/if}
        </div>           
		<div class="alleanza41">
            <span class="alleanza5">{$LNG.al_diplo}</span>
            <div class="alleanza38" style="height: 100px;">                   
            {if $diplomaticData}
               {if !empty($diplomaticData.0)}<div class="c-diplo-0">{$LNG.al_diplo_level.0}</div> 
               <ul>
                  {foreach item=PaktInfo from=$diplomaticData.0}
                  <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                  {/foreach}
               </ul>
               {/if}
               {if !empty($diplomaticData.1)}<div class="c-diplo-1">{$LNG.al_diplo_level.1}</div> 
               <ul>
                  {foreach item=PaktInfo from=$diplomaticData.1}
                  <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                  {/foreach}
               </ul>
               {/if}
               {if !empty($diplomaticData.2)}<div class="c-diplo-2">{$LNG.al_diplo_level.2}</div> 
               <ul>
                  {foreach item=PaktInfo from=$diplomaticData.2}
                  <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                  {/foreach}
               </ul>
               {/if}
               {if !empty($diplomaticData.3)}<div class="c-diplo-3">{$LNG.al_diplo_level.3}</div> 
               <ul>
                  {foreach item=PaktInfo from=$diplomaticData.3}
                  <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                  {/foreach}
               </ul>
               {/if}
               {if !empty($diplomaticData.4)}<div class="c-diplo-4">{$LNG.al_diplo_level.4}</div> 
               <ul>
                  {foreach item=PaktInfo from=$diplomaticData.4}
                  <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                  {/foreach}
               </ul>
               {/if}
               {if !empty($diplomaticData.5)}<div class="c-diplo-5">{$LNG.al_diplo_level.5}</div> 
               <ul>
                  {foreach item=PaktInfo from=$diplomaticData.5}
                  <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a><br>{/foreach}
               </ul>
               {/if}
            {else}
                <span>{$LNG.al_no_diplo}</span>
            {/if}                                   
            </div>
        </div>
		<div class="alleanza1" style="bottom: 2px;top: auto;">
            {if !empty($statisticData)}
            <span class="alleanza5">{$LNG.pl_fightstats}</span>
            <p class="alleanza7">{$LNG.pl_fightwon}<br><span class="alleanza6">{$statisticData.fightwon|number} {if $statisticData.totalfight}({round($statisticData.fightwon / $statisticData.totalfight * 100, 2)}%){/if}</span></p>
            <p class="alleanza8">{$LNG.pl_fightlose}<br><span class="alleanza6">{$statisticData.fightlose|number} {if $statisticData.totalfight}({round($statisticData.fightlose / $statisticData.totalfight * 100, 2)}%){/if}</span></p>
            <p class="alleanza9">{$LNG.pl_fightdraw}<br><span class="alleanza6">{$statisticData.fightdraw|number} {if $statisticData.totalfight}({round($statisticData.fightdraw / $statisticData.totalfight * 100, 2)}%){/if}</span></p>
	        <p class="alleanza10">{$LNG.pl_totalfight} <span style="float: right;">{$statisticData.totalfight|number}</span></p>
		    <p class="alleanza11">{$LNG.op_damage_coef} <span style="float: right;">{$statisticData.damageCoef}</span></p>
			<div class="alleanza12 tooltip" data-tooltip-content="{$LNG.pl_unitsshot} {$statisticData.desunits}" style="width:{$statisticData.damageDes}%"></div>
			<div class="alleanza13 tooltip" data-tooltip-content="{$LNG.pl_unitslose} {$statisticData.lostunits}" style="width:{$statisticData.damageLost}%"></div>
            {/if} 
        </div>	         
    </div>
</div>
{/block}