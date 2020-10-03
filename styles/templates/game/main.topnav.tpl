<div id="header">
    <div id="top_nav" class="otopnav"> 
        <a title="{$LNG.lm_overview}" href="game.php?page=overview">
            <img src="{$dpath}img/general/logo.png" class="game_logo">
        </a>
        <div style="display:none;">					
            <select id="lstPlaneta" name="lstPlaneta" onchange="document.location = $(this).val();">
                {html_options options=$PlanetSelect selected=$current_pids}
            </select>
        </div>
        <div class="mini_planet_navigation" style="margin: auto;left: 0;right: 0;width: 235px;background: none;top: 46px;position: absolute;">
            <span class="link_back" title="" onclick="eval('location=\''+document.getElementById('lstPlaneta').options[document.getElementById('lstPlaneta').selectedIndex-1].value+'\'');"></span>
            <span class="link_next" title="" onclick="eval('location=\''+document.getElementById('lstPlaneta').options[document.getElementById('lstPlaneta').selectedIndex+1].value+'\'');"></span>
        </div>
        <div id="planet_select" style="margin: auto;left: 0;right: 0;top:46px;">
            <div class="active_panet">
				<div class="name_palnet" style="padding-left: 1px;width: 96px;"><img src='{$dpath}planeten/planet2d/{$planetImage}.png' style="float:left;height: 22px;padding-top:3px;margin-right: 5px;">{$planetName}</div> 
                <span class="ico_build"></span>                            
				<div class="coordinates_palnet">[{$planetGalaxy}:{$planetSystem}:{$planetPlanet}]</div>
				<div class="clear"></div>
			</div>
            <div id="list_palnet">
            {foreach $PlanetListing as $ID => $Element}        
			<div class="separator_h"></div>                   
            <div class="palnet_row {if $current_pid == $ID}active_palnet_row{/if}">
				<div class="fleet_indicators">
                    <img id="{$ID}m1" {if $Element.totalAttacks == 0}style="display:none;"{/if} src="{$dpath}img/iconav/p_select_attack.png" alt="" class="tooltip" data-tooltip-content="{$LNG.pla_attack_1}" />                                    
                    <img id="{$ID}m12" style="display:none;" src="{$dpath}img/iconav/p_select_grab.png" alt="" class="tooltip" data-tooltip-content="Планету захватывают" />
                    <img id="{$ID}m6" {if $Element.totalSpio == 0}style="display:none;"{/if} src="{$dpath}img/iconav/p_select_spio.png" alt="" class="tooltip" data-tooltip-content="{$LNG.pla_attack_2}" />
                    <img id="{$ID}m10" {if $Element.totalRockets == 0}style="display:none;"{/if} src="{$dpath}img/iconav/p_select_rocket.png" alt="" class="tooltip" data-tooltip-content="{$LNG.pla_attack_3}" />                 
                    {if $Element.luna !=0}  
                    <img id="{$Element.luna}m1" {if $Element.totalAttackLuna == 0}style="display:none;"{/if} src="{$dpath}img/iconav/p_select_moon_attack.png" alt="" class="tooltip" data-tooltip-content="{$LNG.pla_attack_4}" />
                    <img id="{$Element.luna}m6" {if $Element.totalRocketsLuna == 0}style="display:none;"{/if} src="{$dpath}img/iconav/p_select_moon_spio.png" alt="" class="tooltip" data-tooltip-content="{$LNG.pla_attack_5}" />       
                    <img id="{$Element.luna}m9" style="display:none;" src="{$dpath}img/iconav/p_select_destrued.png" alt="" class="tooltip" data-tooltip-content="{$LNG.pla_attack_6}" />
                    <img id="{$Element.luna}m10" {if $Element.totalSpioLuna == 0}style="display:none;"{/if} src="{$dpath}img/iconav/p_select_moon_rocket.png" alt="" class="tooltip" data-tooltip-content="{$LNG.pla_attack_7}" />                         
					{/if}                
                    <div class="clear"></div>
                </div>	   
                <span class="{if $current_pid == $ID}active_urlpalnet{else}urlpalnet{/if}" url="cp={$ID}">
					<img src='{$dpath}planeten/planet2d/{$Element.image}.png' style="float:left;height: 22px;padding-top: 5px;">
                    <span class="name_palnet"  style="padding-top: 5px;padding-left: 5px;width: 70px;">{$Element.name}</span>
					<span class="ico_build">
                        {if $Element.buildInfo.buildings}
                            <img src="{$dpath}img/iconav/p_select_build.png" alt="" class="tooltip" data-tooltip-content="
                                <table class='reducefleet_table'>
                                    <tr>
                                    <td rowspan='2'><img alt='' src='{$dpath}gebaeude/{$Element.buildInfo.buildings['id']}.gif' width='35' height='35'></td>
                                    <td>{$LNG.tech[$Element.buildInfo.buildings['id']]} ({$Element.buildInfo.buildings['level']|number})</td>
                                    </tr>
                                    <tr><td>{pretty_time($Element.buildInfo.buildings['timeleft'])} </td></tr>
                                </table>
                            "/>
						{/if}
						{if $Element.buildInfo.fleet}
                            <img src="{$dpath}img/iconav/p_select_ship.png" alt="" class="tooltip" data-tooltip-content="
                                <table class='reducefleet_table'>
                                    <tr>
                                    <td rowspan='2'><img alt='' src='{$dpath}gebaeude/{$Element.buildInfo.fleet['id']}.gif' width='35' height='35'></td>
                                    <td>{$LNG.tech[$Element.buildInfo.fleet['id']]}</td>
                                    </tr>
                                    <tr><td>{$Element.buildInfo.fleet['level']|number}</td></tr>
                                </table>
                            "/> 
						{/if}
						{if $Element.buildInfo.tech}
							<img src="{$dpath}img/iconav/p_select_tech.png" alt="" class="tooltip" data-tooltip-content="
                                <table class='reducefleet_table'>
                                <tr>
                                <td rowspan='2'><img alt='' src='{$dpath}gebaeude/{$Element.buildInfo.tech['id']}.gif' width='35' height='35'></td>
                                <td>{$LNG.tech[$Element.buildInfo.tech['id']]} ({$Element.buildInfo.tech['level']|number})</td>
                                </tr>
                                <tr><td>{pretty_time($Element.buildInfo.tech['timeleft'])} </td></tr>
                                </table> 
                            "/>
						{/if}
					</span>  			
                    <span class="coordinates_palnet" style="width: 60px;">[{$Element.galaxy}:{$Element.system}:{$Element.planet}]</span>
                </span>
                {if $Element.luna !=0}                             
                <div class="separator_v"></div>
                <span class="{if $current_pid == $Element.luna}active_urlpalnet{else}urlpalnet{/if}" url="cp={$Element.luna}">
                    <span class="moon_select {if $current_pid == $Element.luna}moon_active{/if}"></span>
                    <span class="ico_build"><br /></span>
                </span>
                {/if}                
            </div> 
            {/foreach}                       
            </div>
        </div><!--/planet_select-->			
		<img title="" src="{$foto}" class="settingxterium" onclick="return Dialog.Playercard({$userID}, '{$username}');">
        <span class="usernameow" onclick="return Dialog.Playercard({$userID}, '{$username}');">{$username}</span>
		<span class="usernamepos"></span>        
        <div id="res_nav">
            {foreach $resourceTable as $resourceID => $resouceData} 
                {if !isset($resouceData.current)}
                    {$resouceData.current = $resouceData.max + $resouceData.used}
                    <div id="res_block_{$resouceData.name}" class="bloc_res tooltip" data-tooltip-content="<span class='colore{$resourceID}'>{$LNG.tech.$resourceID}</span><div style='border-bottom:1px dashed #666; margin:7px 0 4px 0;'></div>{$LNG.RE} {$resouceData.percent|number}%">
                        <div class="ico_res"></div>
                        <div class="stock_res">
                            <div class="stock_percentage stock_percentage_left" style="width:{abs($resouceData.percent/2)}%;{if $resouceData.percent > -0.1}display:none;{/if}"></div>
                            <div class="stock_percentage stock_percentage_right" style="width:{$resouceData.percent/2}%;{if $resouceData.percent < 0.1}display:none;{/if}"></div>
                            <div class="separator_{$resouceData.name}"></div>
                            <div class="stock_text"><span id="current_{$resouceData.name}" name="{$resouceData.current|number}" data-real="{$resouceData.current}">{$resouceData.used|shortly_number}</span>/{$resouceData.max|shortly_number}</div>
                        </div>
                    </div>
                {else}
                    {if !isset($resouceData.current) || !isset($resouceData.max)}
                        <div id="res_block_{$resouceData.name}" class="bloc_res tooltip" data-tooltip-content="<span class='colore{$resourceID}'>{$LNG.tech.$resourceID}</span><div style='border-bottom:1px dashed #666; margin:7px 0 4px 0;'></div>{$LNG.RE} {pretty_number($resouceData.current)}">
                            {if isModuleAvailable($smarty.const.MODULE_FAIR)}
                            <a href="game.php?page=fair"><div class="ico_res"></div></a>
                            {else}
                            <div class="ico_res"></div>
                            {/if}
                            <div class="stock_res2">
                                <div class="stock_percentage" style="width:100%;"></div>
                                <div class="separator_{$resouceData.name}"></div>
                                <div class="stock_text"><span class='colore{$resourceID}' id="current_{$resouceData.name}" name="{$resouceData.current|number}" data-real="{$resouceData.current}">{shortly_number($resouceData.current)}</span></div>
                            </div>
                        </div>
                    {else}
                        <div id="res_block_{$resouceData.name}" class="bloc_res tooltip" 
                            data-tooltip-content="
                            <span class='colore{$resourceID}'>{$LNG.tech.$resourceID}</span>
                            <div style='border-bottom:1px dashed #666; margin:7px 0 4px 0;'></div>
                            {$LNG.PPS}: {$resouceData.information}
                            <br/>{$LNG.PPD}: {$resouceData.informationd}
                            <br/>{$LNG.PPW}: {$resouceData.informationz} 
                            <div style='border-bottom:1px dashed #666; margin:7px 0 4px 0;'>
                            </div> <span style='color:#999'>{$resouceData.current|number}/{$resouceData.max|number}</span>">
                            {if isModuleAvailable($smarty.const.MODULE_TRADER)}
                            <a href="game.php?page=trader"><div class="ico_res"></div></a>
                            {else}
                            <div class="ico_res"></div>
                            {/if}
                            {*<a href="game.php?page=trader&amp;mode=trade&amp;resource=901" class="exchange_res tooltip" data-tooltip-content="Обменять <span class='colore{$resourceID}'>{$LNG.tech.$resourceID}</span>"></a>*}
                            <div class="stock_res">
                                <div class="stock_percentage" style="width:{$resouceData.percent}%;"></div>
                                <div class="stock_text">
                                    <span id="current_{$resouceData.name}" name="{$resouceData.current|number}" data-real="{$resouceData.current}">{shortly_number($resouceData.current)}</span>
                                    (<span class="pricent">{if $resouceData.percent <= 100}{$resouceData.percent}{else $resouceData.percent > 100}100{/if}</span>%)
                                </div>
                            </div>	
                        </div>
                    {/if}
                {/if}
            {/foreach}       
        </div>
        <!--/res_nav-->            
    </div><!--/top_nav-->
    <div id="barrasottoover">
		<div id="top_nav_parte_left">
            {if isModuleAvailable($smarty.const.MODULE_CONTROL)}
			<a title="{$LNG.lm_control}" href="game.php?page=control"><span class="imperia"></span></a>
            <div class="separator_nav"></div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_STATISTICS)}
			<a title="{$LNG.lm_statistics}" href="game.php?page=statistics"><span class="stats"></span></a>
			<div class="separator_nav"></div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_ACHIEVEMENTS)}
			<a title="{$LNG.lm_achievements}" href="game.php?page=achievements"><span class="achievv"></span></a>
			<div class="separator_nav"></div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_BATTLEHALL)}
			<a title="{$LNG.lm_topkb}" href="game.php?page=battleHall"><span class="topbk"></span></a>
			<div class="separator_nav"></div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_CHAT)}
			<a title="{$LNG.lm_chat}" href="game.php?page=chat"><span class="chat"></span></a>
            <div class="separator_nav"></div> 
            {/if}
            {if !empty($hasBoard)}
			<a title="{$LNG.lm_forums}" href="game.php?page=board" target="_blank"><span class="forum"></span></a>
			<div class="separator_nav"></div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_MESSAGES)}
            <a title="{$LNG.lm_messages}" href="game.php?page=messages" id="a_mesage">
                <span class="mesages"></span>
                {nocache}{if $new_message > 0}<span class="new_email"><span id="newmesnum">{$new_message}</span></span>{/if}{/nocache}
            </a>                                       
            <div class="separator_nav"></div> 
            {/if}
        </div>    
        {if isModuleAvailable($smarty.const.MODULE_STORE)}
        <div class="premiumbarra">
			<img class="premiumimgbarra" src="{$dpath}img/iconav/ico-account-premium.png">
            <a href="game.php?page=store">  
                <span class="premiumtopbar">
                    <span class="premiumscrittabar">{$LNG.lm_store}</span>
                </span>
            </a>
        </div>
        {/if}
	</div>
    <div id="top_menu_bottom">
        <div class="left"></div>
        <div class="mid"></div>
        <div class="right"></div>
    </div>
    {if !$vmode}
		<script type="text/javascript">
		var viewShortlyNumber	= {$shortlyNumber|json};
		var vacation			= {$vmode};
        $(function() {
		{foreach $resourceTable as $resourceID => $resourceData}
		{if isset($resourceData.production)}
            resourceTicker({
                available: {$resourceData.current|json},
                limit: [0, {$resourceData.max|json}],
                production: {$resourceData.production|json},
                valueElem: "current_{$resourceData.name}",
                valuePoursent: "bar_{$resourceID}"
            }, true);
		{/if}
		{/foreach}
        });
		</script>
        <script src="scripts/game/topnav.js"></script>
    {/if}
    <script type="text/javascript">
		$(document).ready(function(){
			var flag_planet_menu = false;
			$('#planet_select').click(function(){ 
				$(this).toggleClass('active');
				$('#list_palnet').stop(false,false).slideToggle(300);
				flag_planet_menu = true;
			});		
			if(flag_planet_menu)
			{					
				document.body.onclick = function (e) {
					e = e || event;
					target = e.target || e.srcElement;
					if (target.id == "planet_select") {
						return;
					} else {
						$('#list_palnet').hide();
						$('#planet_select').removeClass('active');
						flag_planet_menu = false;
					}
				}
			}
			$('.urlpalnet').click( function(){
				document.location = '?'+queryString+'&'+$(this).attr("url");
			});		
			
			var listener = new window.keypress.Listener();
			listener.simple_combo("shift left", function() {
				eval('location=\''+document.getElementById('lstPlaneta').options[document.getElementById('lstPlaneta').selectedIndex-1].value+'\'');
				console.log("You pressed shift and left");
			});
			listener.simple_combo("shift right", function() {
				eval('location=\''+document.getElementById('lstPlaneta').options[document.getElementById('lstPlaneta').selectedIndex+1].value+'\'');
				console.log("You pressed shift and right");
			});
		});
	</script>
</div>
{if $closed}
<div class="infobox">{$LNG.ov_closed}</div>
{elseif $delete}
<div class="infobox">{$delete}</div>
{elseif $vacation}
<div class="infobox">{$LNG.tn_vacation_mode} {$vacation}</div>
{/if}
</div>