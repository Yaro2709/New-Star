{block name="title" prepend}{$LNG.lm_overview}{/block}
{block name="script" append}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/overview.css">
<div id="page">
    <div id="content">
        {if !empty($fleets)}
        <div id="ally_content" class="conteiner conteinership">
            <div class="fleettab10"></div>   
            <div class="gray_flettab">
                <div class="transparent">
                    {$LNG.fl_fleets} {$activeFleetSlots} / {$maxFleetSlots}
                    <div class="transparent" style="text-align:right; float:right;color: #b1b1b1;font-size: 13px;">
                        <span style="color: #8b99b0;font-weight: bold;">{$activeExpedition} / {$maxExpedition} {$LNG.fl_expeditions}</span>
                    </div> 
                </div>
            </div> 
            <div class="fleet_log">
                {foreach $fleets as $index => $fleet}
                <div class="fleet_time">
                    <div id="fleettime_{$index}" class="fleets" data-fleet-end-time="{$fleet.returntime}" data-fleet-time="{$fleet.resttime}">{pretty_fly_time({$fleet.resttime})}</div>
                    <div class="tooltip fleet_static_time" data-tooltip-content="{$fleet.resttime1}">{$fleet.resttime1}</div>
                </div>
                <div class="fleet_text">
                    {$fleet.text}
                    <div class="clear"></div>
                </div>     
                <div class="separator"></div>
                {/foreach}       
            </div>
        </div>
        {/if}
        <div id="ally_content" class="conteiner">
            <div class="gray_flettab">
                <div id="online_user">
                {$LNG.ov_online_users} <span>{$UsersOnline}</span>
                </div>
                <div id="gm_linck">
                    <a title="" href="game.php?page=ticket" class="tooltip" data-tooltip-content="{$LNG.ov_ticket_tooltip}">{$LNG.ov_ticket}</a>  
                </div>
            </div> 
            <div class="row" style="padding: 7px">
                <div class="col-8">
                    <div class="card mr-1 background-border-black-blue shadow"> 
                        <div id="big_panet" style="background: url({$dpath}img/title/control_room.png) no-repeat, url({$dpath}planeten/{$planetimage}.jpg) top center no-repeat; background-size:cover;">
                            <div class="palnet_pianeta_titoloa palnet_pianeta_titolo">    
                                <a href="game.php?page=planet">
                                    <span class="planetname"><a href="game.php?page=planet" title="{$LNG.lm_planet}"><span class="planetname">{$planetname}</span></a>
                                        <img src="{$dpath}img/iconav/pencil-over.png" class="palnet_imgopa">
                                    </span>  
                                </a>
                            </div>
                            <div class="palnet_block_info palnet_luna_planeto">
                                <img src="{$dpath}planeten/planet2d/{$planetimage}.png" height="100" width="100">
                            </div>
                            <marquee behavior="alternate" direction="left" scrollamount="1" onmouseover="this.stop();" onmouseout="this.start();" style="height: 15px;width: 445px;position: absolute;bottom: 1px;font-size: 10px;left: 6px;color: #b2b2b2;text-shadow: 0px 1px 0px rgba(0,0,0,0.6);">Hello my friends!</marquee>
                            <div class="palnet_block_info palnet_big_info"> 
                                <div class="left_part">
                                    <a href="game.php?page=planet" style="color:#b2b2b2"><img src="{$dpath}img/iconav/diametr.png" class="overvieew6">{$LNG.ov_diameter}</a>
                                </div>
                                <div class="right_part">
                                    {$planet_diameter} {$LNG.ov_distance_unit} (<span title="{$LNG.ov_developed_fields}">{$planet_field_current}</span> / <span title="{$LNG.ov_max_developed_fields}">{$planet_field_max}</span> {$LNG.ov_fields})
                                </div>
                                <div class="left_part" style="top: 20px;">
                                    <a href="game.php?page=planet" style="color:#b2b2b2"><img src="{$dpath}img/iconav/temp.png" class="overvieew6">{$LNG.ov_temperature}</a>
                                </div>
                                <div class="right_part" style="top: 20px;">
                                    {$LNG.ov_aprox} {$planet_temp_min}{$LNG.ov_temp_unit} {$LNG.ov_to} {$planet_temp_max}{$LNG.ov_temp_unit}
                                </div>
                                <div class="left_part" style="top: 40px;">
                                    <a href="game.php?page=planet" style="color:#b2b2b2"><img src="{$dpath}img/iconav/position.png" class="overvieew6">{$LNG.ov_position}</a>
                                </div>
                                <div class="right_part" style="top: 40px;">
                                    <a href="game.php?page=galaxy&amp;galaxy={$galaxy}&amp;system={$system}">[{$galaxy}:{$system}:{$planet}]</a>
                                </div>
                                <div class="clear"></div>
                                <div class="left_part" style="top: 60px;">
                                    <a href="game.php?page=overview" style="color:#b2b2b2"><img src="{$dpath}img/iconav/stat.png" class="overvieew6">{$LNG.ov_points}</a>
                                </div>
                                <div class="right_part" style="top: 60px;">{$rankInfo}</div>
                            </div>	
                        </div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="card background-border-black-gray shadow">       
                        <div class="row">
                            <div class="col-md-6">
                                <div class="card background-border-black-blue">                     
                                    <div class="gray_latdes overvieew2" style="background: url({$dpath}img/content/control_roompi.png) no-repeat, url({$dpath}img/content/mondpi.jpg) no-repeat ; background-size:cover;">
                                    {if isModuleAvailable($smarty.const.MODULE_CREATE_MOON)}
                                    {if $planet_type == 1}	
                                    {if $Moon}
                                        <div>
                                            <a href="game.php?page=overview&amp;cp={$Moon.id}&amp;re=0"><span class="overvieew5">{$Moon.name}</span></a>
                                            <a href="game.php?page=overview&amp;cp={$Moon.id}&amp;re=0" class=" ">
                                                <img src="{$dpath}img/content/moon.png" class="overvieew4 tooltip" data-tooltip-content="{$Moon.name}" style="opacity:0.8">
                                            </a>
                                        </div>
                                    {else}
                                        <div>
                                            <a href="game.php?page=createMoon"><span class="overvieew5">{$LNG.ov_create_moon}</span></a>
                                            <a href="game.php?page=createMoon" class=" ">
                                                <img src="{$dpath}img/content/moon.png" class="overvieew4 tooltip" data-tooltip-content="{$LNG.ov_create_moon}" style="opacity:0.8">
                                            </a>
                                        </div>
                                    {/if}
                                    {/if}
                                    {/if}
                                    </div>
                                </div>
                            </div>    
                            <div class="col-md-6">
                                <div class="card background-border-black-blue">  
                                    <div class="gray_latdes overvieew2" style="background: url({$dpath}img/content/control_roompi.png) no-repeat, url({$dpath}img/content/control_acc.png) no-repeat ; background-size:cover;">
                                        <div>
                                            <a href="game.php?page=market"><span class="overvieew5">{$LNG.lm_market}</span></a>
                                            <a href="game.php?page=market" class=" ">
                                                <img src="{$dpath}img/content/market.png" class="overvieew4 tooltip" data-tooltip-content="{$LNG.lm_market}" style="opacity:0.8">
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="card background-border-black-gray">
                                    <div class="ricerche">
                                        <img src="{$dpath}img/iconav/ov_tech.png" class="overvieew27">
                                        <span class="overvieew9">
                                            <a href="game.php?page=research">
                                                {if $buildInfo.tech}
                                                    <span class="timer" data-time="{$buildInfo.tech['timeleft']}">??:??:??</span>
                                                    - {$LNG.tech[$buildInfo.tech['id']]}
                                                    <span class="level">({$buildInfo.tech['level']})</span>
                                                {else}
                                                    {$LNG.ov_free}
                                                {/if}
                                            </a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="card background-border-black-gray">
                                    <div class="costruzioni">
                                        <img src="{$dpath}img/iconav/ov_build.png" class="overvieew27">
                                        <span class="overvieew9">
                                            <a href="game.php?page=buildings">
                                                {if $buildInfo.buildings}
                                                    <span class="timer" data-time="{$buildInfo.buildings['timeleft']}">??:??:??</span>
                                                    - {$LNG.tech[$buildInfo.buildings['id']]}
                                                    <span class="level">({$buildInfo.buildings['level']})</span>
                                                {else}
                                                    {$LNG.ov_free}
                                                {/if}
                                            </a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="card background-border-black-gray">
                                    <div class="flotte">
                                        <img src="{$dpath}img/iconav/ov_fleet.png" class="overvieew27">
                                        <span class="overvieew9">
                                            <a href="game.php?page=shipyard">
                                                {if $buildInfo.fleet}
                                                    <span class="timer" data-time="{$buildInfo.fleet['timeleft']}">??:??:??</span>
                                                    - {$LNG.tech[$buildInfo.fleet['id']]}
                                                    <span class="level">({$buildInfo.fleet['level']})</span>
                                                {else}
                                                    {$LNG.ov_free}
                                                {/if}
                                            </a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12">
                    <div class="card mt-1 background-border-black-blue shadow"> 
                        <div class="card-body">
                            <p class="card-title">{$LNG.ov_panel_root}</p>
                            <div class="row">      
                                <div class="col-1">
                                    <div class="card mr-1 background-border-black-blue"> 
                                        {if isModuleAvailable($smarty.const.MODULE_RACE)}
                                        <a href="game.php?page=race"><div class="overvieew15 overvire tooltip" style="background: rgba(0, 0, 0, 0.25) url({$dpath}gebaeude/{$race}.gif) no-repeat center; background-size: 50px;" data-tooltip-content="{$LNG.tech.$race}"></div></a>
                                        {/if}
                                    </div>
                                </div>
                                <div class="col-1">
                                    <div class="card mr-1 background-border-black-blue"> 
                                        {if isModuleAvailable($smarty.const.MODULE_FORMGOVERNMENT)}
                                        <a href="game.php?page=formgovernment"><div class="overvieew15 overvire tooltip" style="background: rgba(0, 0, 0, 0.25) url({$dpath}gebaeude/{$formgovernment}.png) no-repeat center; background-size: 50px;" data-tooltip-content="{$LNG.tech.$formgovernment}"></div></a>
                                        {/if}
                                    </div>
                                </div>
                                <div class="col-1">
                                    <div class="card mr-1 background-border-black-blue"> 
                                        {if isModuleAvailable($smarty.const.MODULE_ETHICS)}
                                        <a href="game.php?page=ethics"><div class="overvieew15 overvire tooltip" style="background: rgba(0, 0, 0, 0.25) url({$dpath}gebaeude/{$ethics}.png) no-repeat center; background-size: 50px;" data-tooltip-content="{$LNG.tech.$ethics}"></div></a>
                                        {/if}
                                    </div>
                                </div>
                                <div class="col-1">
                                    <div class="card mr-1 background-border-black-blue"> 
                                        {if isModuleAvailable($smarty.const.MODULE_INFO_BONUS)}
                                        <a href="game.php?page=infobonus"><div class="overvieew15 overvire tooltip" style="background: rgba(0, 0, 0, 0.25) url({$dpath}img/title/infobonus.png) no-repeat center; background-size: 50px;" data-tooltip-content="{$LNG.lm_infobonus}"></div></a>
                                        {/if} 
                                    </div>
                                </div>
                                <div class="col-1">
                                    <div class="card mr-1 background-border-black-blue"> 
                                        {if isModuleAvailable($smarty.const.MODULE_PARTY)}
                                        <a href="game.php?page=party"><div class="overvieew15 overvire tooltip" style="background: rgba(0, 0, 0, 0.25) url({$dpath}img/title/party.png) no-repeat center; background-size: 50px;" data-tooltip-content="{$LNG.lm_party}"></div></a>
                                        {/if} 
                                    </div>
                                </div>
                                <div class="col-1">
                                    <div class="card mr-1 background-border-black-blue"> 
                                        {if isModuleAvailable($smarty.const.MODULE_IDEOLOGIES)}
                                        <a href="game.php?page=ideologies"><div class="overvieew15 overvire tooltip" style="background: rgba(0, 0, 0, 0.25) url({$dpath}img/title/ideologies.png) no-repeat center; background-size: 50px;" data-tooltip-content="{$LNG.lm_ideologies}"></div></a>
                                        {/if}  
                                    </div>
                                </div>
                                <div class="col-1">
                                    <div class="card mr-1 background-border-black-blue"> 
                                        {if isModuleAvailable($smarty.const.MODULE_OFFICIER)}
                                        <a href="game.php?page=officier"><div class="overvieew15 overvire tooltip" style="background: rgba(0, 0, 0, 0.25) url({$dpath}img/title/officier.png) no-repeat center; background-size: 50px;" data-tooltip-content="{$LNG.lm_officiers}"></div></a>
                                        {/if}  
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                {if $is_news}
                <div class="col-12">
                    <div class="card mt-1 background-border-black-blue shadow"> 
                        <div class="card-body">
                            <p class="card-title">{$LNG.ov_news}</p>
                            <p class="card-text overflow-auto" style="max-height: 50px;">{$news}</p>
                        </div>
                    </div>
                </div>
                {/if}
            </div>
        </div>
    </div>
</div>
{/block}
{block name="script" append}
    <script src="scripts/game/overview.js"></script>
    <script src="scripts/game/buildlist.js"></script>
{/block}