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
        <div class="row" style="padding: 7px">
            <div class="col-md-12">
            <div class="card background-border-black-blue shadow"> 
                <div class="ally_img" {if $ally_image}style="background-image:url({$ally_image})"{/if}>
                    <div class="designation">
                        <span class="">{$ally_name} [{$ally_tag}]</span><br>
                        {if $rights.MEMBERLIST} <a href="?page=alliance&amp;mode=memberList" style="display:inline;">{$ally_members} {$LNG.all_member}</a> {$LNG.all_of} {$ally_max_members}{else}{$ally_members} {$LNG.all_member} {$LNG.all_of}  {$ally_max_members}{/if}
                        {if $rights.SEEAPPLY && $applyCount > 0}		
                            <a style="display:inline;" href="?page=alliance&amp;mode=admin&amp;action=mangeApply">{$requests}</a>
                        {/if}	
                    </div> 
                    <div style="position: absolute;right: 6px;bottom: 6px;z-index: 2;">
                        <a href="{$ally_web}">
                            <button type="button" class="btn mb-1">{$LNG.al_web_site}</button>
                        </a>
                        {if !$isOwner} 
                        <a href="game.php?page=alliance&amp;mode=close" onclick="return confirm('{$LNG.al_leave_ally}');">
                            <button type="button" class="btn">{$LNG.al_leave_alliance}</button>
                        </a>
                        {/if}
                    </div>  
                </div>              
            </div>
            </div>
            <div class="col-md-3">
                <div class="card mt-1 background-border-black-blue shadow"> 
                    <div class="card-body">
                        {if $rights.ROUNDMAIL}
                        <a href="game.php?page=alliance&mode=circular" onclick="return Dialog.open(this.href, 716, 300);">
                            <button type="button" class="btn mesages">{$LNG.al_circular_message}</button>
                        </a>
                        {else}
                        <button type="button" class="btn mesages alleanza620">{$LNG.al_circular_message}</button>
                        {/if}
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card mt-1 background-border-black-blue shadow"> 
                    <div class="card-body">
                        <a href="game.php?page=alliance&mode=development">
                            <button type="button" class="btn development">{$LNG.al_development}</button>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card mt-1 background-border-black-blue shadow"> 
                    <div class="card-body">
                        <a href="game.php?page=alliance&mode=storage">
                            <button type="button" class="btn storage">{$LNG.al_storage}</button>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card mt-1 background-border-black-blue shadow"> 
                    <div class="card-body">
                        {if $rights.DIPLOMATIC}
                        <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacy">
                            <button type="button" class="btn diplomacy">{$LNG.al_diplo}</button>
                        </a>
                        {else}
                        <button type="button" class="btn diplomacy alleanza620">{$LNG.al_diplo}</button>
                        {/if}
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="card mt-1 background-border-black-blue shadow"> 
                    <div class="card-body">
                        <p class="card-title text-align-center">{$LNG.al_inside_section}</p>
                        <p class="card-text">{$ally_text}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="card mt-1 background-border-black-blue shadow"> 
                    <div class="card-body">
                        <p class="card-title text-align-center">{$LNG.al_events}</p>
                        <p class="card-text">
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
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="card mt-1 background-border-black-blue shadow"> 
                    <div class="card-body">
                        <p class="card-title text-align-center">{$LNG.al_inside_section}</p>
                        <p class="card-text">{if $ally_description}{$ally_description}{else}{$LNG.al_description_message}{/if}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mt-1 mr-1 background-border-black-blue shadow"> 
                    <div class="card-body">
                        <p class="card-title text-align-center">{$LNG.pl_fightstats}</p>
                        <div class="row">
                            <div class="col-md-4">
                                <p class="alleanza_zone">{$LNG.pl_fightwon}<br><span class="card-text">{$fightwon|number} {if $totalfight}({round($fightwon / $totalfight * 100, 2)}%){/if}</span></p>
                            </div>
                            <div class="col-md-4">
                                <p class="alleanza_zone">{$LNG.pl_fightlose}<br><span class="card-text">{$fightlose|number} {if $totalfight}({round($fightlose / $totalfight * 100, 2)}%){/if}</span></p>
                            </div>
                            <div class="col-md-4">
                                <p class="alleanza_zone">{$LNG.pl_fightdraw}<br><span class="card-text">{$fightdraw|number} {if $totalfight}({round($fightdraw / $totalfight * 100, 2)}%){/if}</span></p>
                            </div>
                        </div>
                        <p class="card-text">{$LNG.pl_totalfight} <span style="float: right;">{$totalfight|number}</span></p>
                        <p class="card-text mb-3">{$LNG.op_damage_coef} <span style="float: right;">{$damageCoef}</span></p>
                        <div class="alleanza12 tooltip" data-tooltip-content="{$LNG.pl_unitsshot} {$desunits}" style="width:{$damageDes}%"></div>
                        <div class="alleanza13 tooltip" data-tooltip-content="{$LNG.pl_unitslose} {$lostunits}" style="width:{$damageLost}%"></div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mt-1 background-border-black-blue shadow"> 
                    <div class="card-body">
                        <p class="card-title text-align-center">{$LNG.al_diplo}</p>
                        <p class="card-text overflow-auto" style="min-height: 85px;">
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
                        </p>
                    </div>
                </div>
            </div>
        </div>	
	</div>
</div>
{/block}