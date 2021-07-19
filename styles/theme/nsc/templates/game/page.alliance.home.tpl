{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
    <div id="content">
    <div id="ally_content" class="conteiner">
        <div class="gray_flettab ">{$LNG.lm_alliance}
            <div class="position" {if $rights.ADMIN} style="margin-right: 175px;"{/if} >
                {$LNG.al_rank}: {$rankName}
            </div> 
            {if $rights.ADMIN}
       	   	<div class="tornaindietroa">
                <a href="?page=alliance&amp;mode=admin" style="color:#fff">{$LNG.al_manage_alliance}</a>
            </div>  
            {/if} 
		</div>             
        <div class="fleettab8" style="margin-bottom: 0;"></div>   
        <div class="ally_img" {if $ally_image}style="background-image:url({$ally_image})"{/if}>
            <div class="designation">
                <span class="">{$ally_name} [{$ally_tag}]</span><br>
                {if $rights.MEMBERLIST} <a href="?page=alliance&amp;mode=memberList" style="display:inline;">{$ally_members} {$LNG.all_member}</a> {$LNG.all_of} {$ally_max_members}{else}{$ally_members} {$LNG.all_member} {$LNG.all_of}  {$ally_max_members}{/if}
                {if $rights.SEEAPPLY && $applyCount > 0}		
                    <a style="display:inline;" href="?page=alliance&amp;mode=admin&amp;action=mangeApply">{$requests}</a>
                {/if}	
            </div>      
        </div>              
        <div class="alleanza1" style="height:36px;width: 698px;">
            {if $rights.ROUNDMAIL}
            <a href="game.php?page=alliance&mode=circular" onclick="return Dialog.open(this.href, 716, 300);" class="mesages alleanza61">{$LNG.al_circular_message}</a>
            {else}
            <a class="mesages alleanza61 alleanza620">{$LNG.al_circular_message}</a>
            {/if}
            <a href="game.php?page=alliance&mode=development" class="development alleanza61">{$LNG.al_development}</a>
            <a href="game.php?page=alliance&mode=storage" class="storage alleanza61">{$LNG.al_storage}</a>
            {if $rights.DIPLOMATIC}
            <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacy" class="diplomacy alleanza61">{$LNG.al_diplo}</a>
            {else}
            <a class="diplomacy alleanza61 alleanza620">{$LNG.al_diplo}</a>
            {/if}
        </div>
        <div style="position: absolute;right: 14px;top:160px"> 
            <a href="{$ally_web}" class="alleanza59">{$LNG.al_web_site}</a> 
            {if !$isOwner}        
            <a href="game.php?page=alliance&amp;mode=close" onclick="return confirm('{$LNG.al_leave_ally}');" class="alleanza60">{$LNG.al_leave_alliance}</a> 
            {/if}
        </div>
        <div class="clear"></div>
        <div class="alleanza3" style="width: auto; float: none; height: auto;"> 
            <span class="alleanza5">{$LNG.al_inside_section}</span>
            <div class="alleanza36" style="width: auto;height: auto; margin-bottom: 35px;">{$ally_text}</div>
            <div class="clear"></div>
            <div class="clear"></div>
        </div>
        <div class="alleanza1" style="height: auto; width: auto; float: none;">
            <span class="alleanza5" style="margin-bottom:15px">{$LNG.al_events}</span>
            <p class="allievent"></p>
            <div class="ally_contents" style="padding: 30px 7px 3px 7px;">
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
        </div>
        <div class="clear"></div>
        <div class="alleanza3" style="width: auto; float: none; height: auto;"> 
            <span class="alleanza5">{$LNG.al_inside_section}</span>
            <div class="alleanza36" style="width: auto;height: auto; margin-bottom: 35px;">{if $ally_description}{$ally_description}{else}{$LNG.al_description_message}{/if} </div>
            <div class="clear"></div>
            <div class="clear"></div>
        </div>
        <div class="clear"></div>
        <div class="alleanzas">
            <div class="alleanza1">
            <span class="alleanza5">{$LNG.pl_fightstats}</span>
                <p class="alleanza7">{$LNG.pl_fightwon}<br><span class="alleanza6">{$fightwon|number} {if $totalfight}({round($fightwon / $totalfight * 100, 2)}%){/if}</span></p>
                <p class="alleanza8">{$LNG.pl_fightlose}<br><span class="alleanza6">{$fightlose|number} {if $totalfight}({round($fightlose / $totalfight * 100, 2)}%){/if}</span></p>
                <p class="alleanza9">{$LNG.pl_fightdraw}<br><span class="alleanza6">{$fightdraw|number} {if $totalfight}({round($fightdraw / $totalfight * 100, 2)}%){/if}</span></p>
                <p class="alleanza10">{$LNG.pl_totalfight} <span style="float: right;">{$totalfight|number}</span></p>
                <p class="alleanza11">{$LNG.op_damage_coef} <span style="float: right;">{$damageCoef}</span></p>
                <div class="alleanza12 tooltip" data-tooltip-content="{$LNG.pl_unitsshot} {$desunits}" style="width:{$damageDes}%"></div>
                <div class="alleanza13 tooltip" data-tooltip-content="{$LNG.pl_unitslose} {$lostunits}" style="width:{$damageLost}%"></div>
            </div>
        </div>	
        <div class="alleanza2">
            <span class="alleanza5">{$LNG.al_diplo}</span>
            <div class="alleanza38">
                      {if $DiploInfo}
                      {if !empty($DiploInfo.0)}<div class="c-diplo-0">{$LNG.al_diplo_level.0}</div>
                      <ul>
                         {foreach item=PaktInfo from=$DiploInfo.0}
                         <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                         {/foreach}
                      </ul>
                      {/if}
                      {if !empty($DiploInfo.1)}<div class="c-diplo-1">{$LNG.al_diplo_level.1}</div>
                      <ul>
                         {foreach item=PaktInfo from=$DiploInfo.1}
                         <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                         {/foreach}
                      </ul>
                      {/if}
                      {if !empty($DiploInfo.2)}<div class="c-diplo-2">{$LNG.al_diplo_level.2}</div>
                      <ul>
                         {foreach item=PaktInfo from=$DiploInfo.2}
                         <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                         {/foreach}
                      </ul>
                      {/if}
                      {if !empty($DiploInfo.3)}<div class="c-diplo-3">{$LNG.al_diplo_level.3}</div>
                      <ul>
                         {foreach item=PaktInfo from=$DiploInfo.3}
                         <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                         {/foreach}
                      </ul>
                      {/if}
                      {if !empty($DiploInfo.4)}<div class="c-diplo-4">{$LNG.al_diplo_level.4}</div>
                      <ul>
                         {foreach item=PaktInfo from=$DiploInfo.4}
                         <li><a href="?page=alliance&mode=info&amp;id={$PaktInfo.1}">{$PaktInfo.0}</a></li>
                         {/foreach}
                      </ul>
                      {/if}
                      {if !empty($DiploInfo.5)}<div class="c-diplo-5">{$LNG.al_diplo_level.5}</div>
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
	</div>
	<div class="clear"></div>
</div>
{/block}