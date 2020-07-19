{block name="title" prepend}{$LNG.lm_overview}{/block}
{block name="script" append}{/block}
{block name="content"}
{* онлайн админов, реф. система, тикеты*}
<div id="page">
    <div id="content">
        <div id="ally_content" class="conteinership">
            <div class="fleettab10"></div>   
            <div class="gray_flettab">
                <div class="transparent">
                    {$LNG.fl_fleets} {$activeFleetSlots} / {$maxFleetSlots}
                    <div class="transparent" style="text-align:right; float:right;color: #b1b1b1;font-size: 13px;">
                        <span style="color: #8b99b0;font-weight: bold;">{$activeExpedition} / {$maxExpedition} {$LNG.fl_expeditions}</span>
                    </div> 
                </div>
            </div> 
            <table class="tablesorter ally_ranks">
                <tr>
                    <td>{$LNG.fl_number}</td>
                    <td>{$LNG.fl_mission}</td>
                    <td>{$LNG.fl_ammount}</td>
                    <td>{$LNG.fl_beginning}</td>
                    <td>{$LNG.fl_departure}</td>
                    <td>{$LNG.fl_destiny}</td>
                    <td>{$LNG.fl_objective}</td>
                    <td>{$LNG.fl_arrival}</td>
                    <td>{$LNG.fl_order}</td>
                </tr>
                {foreach name=FlyingFleets item=FlyingFleetRow from=$FlyingFleetList}
                <tr>
                    <td>{$smarty.foreach.FlyingFleets.iteration}</td>
                    <td>{$LNG["type_mission_{$FlyingFleetRow.mission}"]}
                        {if $FlyingFleetRow.state == 1}
                            <br><a title="{$LNG.fl_returning}">{$LNG.fl_r}</a>
                        {else}
                            <br><a title="{$LNG.fl_onway}">{$LNG.fl_a}</a>
                        {/if}
                    </td>
                    <td><a class="tooltip" data-tooltip-content="<table width='100%'><tr><th colspan='2' style='text-align:center;'>{$LNG.fl_info_detail}</th></tr>{foreach $FlyingFleetRow.FleetList as $shipID => $shipCount}<tr><td class='transparent'>{if $shipID != 260}{$LNG.tech.{$shipID}}{else}{$useri['i_name']}{/if}:</td><td class='transparent'>{$shipCount}</td></tr>{/foreach}</table>">{$FlyingFleetRow.amount}</a></td>
                    <td><a href="game.php?page=galaxy&amp;galaxy={$FlyingFleetRow.startGalaxy}&amp;system={$FlyingFleetRow.startSystem}">[{$FlyingFleetRow.startGalaxy}:{$FlyingFleetRow.startSystem}:{$FlyingFleetRow.startPlanet}]</a></td>
                    <td>{$FlyingFleetRow.startTime}</td>
                    <td><a href="game.php?page=galaxy&amp;galaxy={$FlyingFleetRow.endGalaxy}&amp;system={$FlyingFleetRow.endSystem}">[{$FlyingFleetRow.endGalaxy}:{$FlyingFleetRow.endSystem}:{$FlyingFleetRow.endPlanet}]</a></td>
                    {if $FlyingFleetRow.mission == 4}
                    <td>-</td>
                    <td style="color:lime">-</td>
                    {else}
                    <td>{$FlyingFleetRow.endTime}</td>
                    <td style="color:lime">{$FlyingFleetRow.backin}</td>
                    {/if}
                    <td>
                        {if !$isVacation && $FlyingFleetRow.state != 1}
                        <form action="game.php?page=fleetTable&amp;action=sendfleetback" method="post">
                            <input name="fleetID" value="{$FlyingFleetRow.id}" type="hidden">
                            <input value="{$LNG.fl_send_back}" type="submit">
                        </form>
                        {if $FlyingFleetRow.mission == 1}
                        <form action="game.php?page=fleetTable&amp;action=acs" method="post">
                            <input name="fleetID" value="{$FlyingFleetRow.id}" type="hidden">
                            <input value="{$LNG.fl_acs}" type="submit">
                        </form>
                    {/if}
                    {else}-{/if}
                    </td>
                </tr>
                {foreachelse}
                <tr>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                </tr>
                {/foreach}
                {if $maxFleetSlots == $activeFleetSlots}
                <tr>
                    <td colspan="9">{$LNG.fl_no_more_slots}</td>
                </tr>
                {/if}
             </table>		
        </div> 
    <div id="owerwiv" class="conteiner">
        <div class="gray_flettab">
            <div id="online_user">
            {$LNG.ov_online_users} <span>{$UsersOnline}</span>
            </div>
            <div id="gm_linck">
                <a title="" href="game.php?page=ticket" class="tooltip" data-tooltip-content="Отвечу на ваши вопросы">{$LNG.ov_ticket}</a>  
            </div>
        </div>
	<div class="fleettab9" style="margin-bottom:0"></div>   
    <div id="big_panet" style="background: url({$dpath}img/title/control_room.png) no-repeat, url({$dpath}planeten/{$planetimage}.jpg) top center no-repeat; background-size:cover;">
		<div class="palnet_pianeta_titoloa palnet_pianeta_titolo">    
            <a href="game.php?page=overview">
                <span class="planetname"><a href="#" onclick="return Dialog.PlanetAction();" title="{$LNG.ov_planetmenu}"><span class="planetname">{$planetname}</span></a>
                    <img src="{$dpath}img/iconav/pencil-over.png" class="palnet_imgopa">
                </span>  
            </a>
        </div>
        <div class="palnet_block_info palnet_luna_planeto">
			<img src="{$dpath}planeten/planet2d/{$planetimage}.png" height="110" width="110">
        </div>
		<marquee behavior="alternate" direction="left" scrollamount="1" onmouseover="this.stop();" onmouseout="this.start();" style="height: 15px;width: 445px;position: absolute;bottom: 1px;font-size: 10px;left: 6px;color: #b2b2b2;text-shadow: 0px 1px 0px rgba(0,0,0,0.6);">Hello my friends!</marquee>
		<div class="palnet_block_info palnet_big_info"> 
            <div class="left_part">
                <a href="game.php?page=overview" style="color:#b2b2b2">{$LNG.ov_diameter}</a>
            </div>
            <div class="right_part">
                {$planet_diameter} {$LNG.ov_distance_unit} (<span title="{$LNG.ov_developed_fields}">{$planet_field_current}</span> / <span title="{$LNG.ov_max_developed_fields}">{$planet_field_max}</span> {$LNG.ov_fields})
            </div>
            <div class="left_part" style="top: 20px;">
                <a href="game.php?page=overview" style="color:#b2b2b2">{$LNG.ov_temperature}</a>
            </div>
            <div class="right_part" style="top: 20px;">
                {$LNG.ov_aprox} {$planet_temp_min}{$LNG.ov_temp_unit} {$LNG.ov_to} {$planet_temp_max}{$LNG.ov_temp_unit}
            </div>
			<div class="left_part" style="top: 40px;">
                <a href="game.php?page=overview" style="color:#b2b2b2">{$LNG.ov_position}</a>
            </div>
            <div class="right_part" style="top: 40px;">
                <a href="game.php?page=galaxy&amp;galaxy={$galaxy}&amp;system={$system}">[{$galaxy}:{$system}:{$planet}]</a>
            </div>
			<div class="clear"></div>
			<div class="left_part" style="top: 60px;">
                <a href="game.php?page=overview" style="color:#b2b2b2">{$LNG.ov_points}</a>
            </div>
            <div class="right_part" style="top: 60px;">{$rankInfo}</div>
        </div>	
    </div>
	<div class="overvieew1">
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
        <div class="gray_latdes overvieew2" style="background: url({$dpath}img/content/control_roompi.png) no-repeat, url({$dpath}gebaeude/race/ov_{$race}.jpg) no-repeat ; background-size:cover;">
        {if isModuleAvailable($smarty.const.MODULE_RACE)}
            <div>
                <a href="game.php?page=race"><span class="overvieew5">{$LNG.tech.$race}</span></a>
                <a href="game.php?page=race" class=" ">
                    <img style='width: 90px;' src="{$dpath}gebaeude/{$race}.png" class="overvieew4 tooltip" data-tooltip-content="{$LNG.lm_race}" style="opacity:0.8">
                </a>
            </div>
        {/if}
        </div> 
        <div class="gray_latdes overvieew3">
            <div class="ricerche"><img src="{$dpath}img/iconav/tech.png" class="overvieew6"><span class="overvieew9"><a href="game.php?page=research">
                {if $buildInfo.tech}{$LNG.tech[$buildInfo.tech['id']]} <span class="level">({$buildInfo.tech['level']})</span><span class="timer" data-time="{$buildInfo.tech['timeleft']}">{$buildInfo.tech['starttime']}</span>{else}{$LNG.ov_free}{/if}</a></span>
            </div>
        </div>
        <div class="gray_latdes overvieew3">
            <div class="costruzioni"><img src="{$dpath}img/iconav/build.png" class="overvieew6"><span class="overvieew9"><a href="game.php?page=buildings">
                {if $buildInfo.buildings}{$LNG.tech[$buildInfo.buildings['id']]} <span class="level">({$buildInfo.buildings['level']}) - </span><span class="timer" data-time="{$buildInfo.buildings['timeleft']}">{$buildInfo.buildings['starttime']}</span>{else}{$LNG.ov_free}{/if}</a></span>
            </div>
        </div>
        <div class="gray_latdes overvieew3">
            <div class="flotte"><img src="{$dpath}img/iconav/fleet.png" class="overvieew6"><span class="overvieew9"><a href="game.php?page=shipyard">
                {if $buildInfo.fleet}{$LNG.tech[$buildInfo.fleet['id']]} <span class="level">({$buildInfo.fleet['level']})</span><br><span class="timer" data-time="{$buildInfo.fleet['timeleft']}">{$buildInfo.fleet['starttime']}</span>{else}{$LNG.ov_free}{/if}</a></span>
            </div>
        </div>
	</div>
    <div class="fleettab11" style="margin-top: 0;"></div>
    <div class="gray_latdes" style="border-left:0;border-right:0;">
        <div class="overvieew7" style="height:auto">
        {if $is_news}
            <div class="overvieew8" style="margin-top: 0;height: 243px;margin-bottom: 0; width: 700px;">
                <div class="title">{$LNG.ov_news}</div>
                <div id="news_ower">{$news}</div>
            </div> 
        {/if}			
        </div>        
    </div> 
</div>
{/block}
{block name="script" append}
    <script src="scripts/game/overview.js"></script>
    <script src="scripts/game/buildlist.js"></script>
{/block}