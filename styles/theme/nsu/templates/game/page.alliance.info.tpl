{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
   <div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_flettab">
                {$LNG.lm_alliance}
            </div>  
            <div class="row" style="padding: 7px">
                <div class="col-md-12">
                    <div class="card background-border-black-blue shadow"> 
                        <div class="ally_img" {if $ally_image}style="background-image:url({$ally_image})"{/if}>
                            <div class="designation">
                                <span class="">{$ally_name} [{$ally_tag}]</span><br>
                                {$ally_member_scount} {$LNG.all_member} {$LNG.all_of} {$ally_max_members}	
                            </div> 
                            <div style="position: absolute;right: 6px;bottom: 6px;z-index: 2;">
                                {if $ally_request_min_points}
                                <a href="game.php?page=alliance&amp;mode=apply&amp;id={$ally_id}">
                                    <button type="button" class="btn">{$LNG.al_click_to_send_request}</button>
                                </a>
                                {else}
                                {$ally_request_min_points_info}
                                {/if}
                            </div>  
                        </div>              
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="card mt-1 background-border-black-blue shadow"> 
                        <div class="card-body">
                            <p class="card-text">{if !empty($ally_description)}{$ally_description}{else}{$LNG.al_description_message}{/if}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card mt-1 mr-1 background-border-black-blue shadow"> 
                        <div class="card-body">
                            <p class="card-title text-align-center">{$LNG.pl_fightstats}</p>
                            <div class="row">
                                <div class="col-md-4">
                                    <p class="alleanza_zone">{$LNG.pl_fightwon}<br><span class="card-text">{$statisticData.fightwon|number} {if $statisticData.totalfight}({round($statisticData.fightwon / $statisticData.totalfight * 100, 2)}%){/if}</span></p>
                                </div>
                                <div class="col-md-4">
                                    <p class="alleanza_zone">{$LNG.pl_fightlose}<br><span class="card-text">{$statisticData.fightlose|number} {if $statisticData.totalfight}({round($statisticData.fightlose / $statisticData.totalfight * 100, 2)}%){/if}</span></p>
                                </div>
                                <div class="col-md-4">
                                    <p class="alleanza_zone">{$LNG.pl_fightdraw}<br><span class="card-text">{$statisticData.fightdraw|number} {if $statisticData.totalfight}({round($statisticData.fightdraw / $statisticData.totalfight * 100, 2)}%){/if}</span></p>
                                </div>
                            </div>
                            <p class="card-text">{$LNG.pl_totalfight} <span style="float: right;">{$statisticData.totalfight|number}</span></p>
                            <p class="card-text mb-3">{$LNG.op_damage_coef} <span style="float: right;">{$statisticData.damageCoef}</span></p>
                            <div class="alleanza12 tooltip" data-tooltip-content="{$LNG.pl_unitsshot} {$statisticData.desunits}" style="width:{$statisticData.damageDes}%"></div>
                            <div class="alleanza13 tooltip" data-tooltip-content="{$LNG.pl_unitslose} {$statisticData.lostunits}" style="width:{$statisticData.damageLost}%"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card mt-1 background-border-black-blue shadow"> 
                        <div class="card-body">
                            <p class="card-title text-align-center">{$LNG.al_diplo}</p>
                            <p class="card-text" style="min-height: 85px;">
                          {if $diplomaticData}
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
</div>
{/block}