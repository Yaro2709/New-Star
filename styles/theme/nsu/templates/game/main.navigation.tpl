
<div id="divCover">

<div id="divTop" class="game_top_frame" style="position:fixed;z-index:29998;">
                <div class="game_top_frame_content">
                        <div style="display:none;">					
            <select id="lstPlaneta" name="lstPlaneta" onchange="document.location = $(this).val();">
                {html_options options=$PlanetSelect selected=$current_pids}
            </select>
        </div>
        <div class="mini_planet_navigation" style="margin: auto;left:  -720px;right: 0;width: 235px;background: none;top: 6px;position: absolute;    z-index: 999;">
            <span class="link_back" title="" onclick="eval('location=\''+document.getElementById('lstPlaneta').options[document.getElementById('lstPlaneta').selectedIndex-1].value+'\'');"></span>
            <span class="link_next" title="" onclick="eval('location=\''+document.getElementById('lstPlaneta').options[document.getElementById('lstPlaneta').selectedIndex+1].value+'\'');"></span>
        </div>
        <div id="planet_select" style="margin: auto;left: -720px;right: 0;top:6px;">
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
                        <div style="position:absolute;margin-top:4px;margin-left:4px;">
                            <span style="float:left;font-size:12px;margin-left: 233px;width:100px;margin-top: 0px;"> 
                                <table cellpadding="0" cellspacing="0" height="100%" width="100%"><tbody><tr><td class="value" style="font-size: 12px;height: 23px;"><span id="main_PlayerIG"><span><span class="v-norm">500</span></span></span> <span style="color:#daa548">AM</span></td></tr></tbody></table>
                            </span>
                            <span style="float:left;font-size:12px;width:100px;margin-top: 0px;"> 
                                <table cellpadding="0" cellspacing="0" height="100%" width="100%"><tbody><tr><td class="value" style="font-size: 12px;height: 23px;"><span id="main_PlayerIG"><span><span class="v-norm">500</span></span></span> <span style="color:#daa548">AM</span></td></tr></tbody></table>
                            </span>
                            <span style="float:left;font-size:12px;width:100px;margin-top: 0px;"> 
                                <table cellpadding="0" cellspacing="0" height="100%" width="100%"><tbody><tr><td class="value" style="font-size: 12px;height: 23px;"><span id="main_PlayerIG"><span><span class="v-norm">500</span></span></span> <span style="color:#daa548">AM</span></td></tr></tbody></table>
                            </span>
                            {* <span class="right4" style="float:left;margin-left:2px;"> 
                                    <button class="image_btn_bg noselect" id="btn_WndTrade" type="button" data-hint="Торговые операции" style="width:24px;height:24px;" onclick="sound_click(2);getWindow('WndTrade').show()"><img style="" id="btn_WndTrade_img" border="0" src="/images/icons/i_trade_16.png"></button> 
                            </span>

                            <span style="float:left;font-size:12px;margin-left:1px;width:140px;margin-top:1px"> 
                                <table cellpadding="0" cellspacing="0" height="100%" width="100%"><tbody><tr><td class="value" style="font-size:12px"><span id="main_PlayerCR"><span data-hint="208 535.0224951200"><span data-hint="208 535.0224951200" class="v-norm">208 535</span></span></span> <span style="color:#daa548">CR</span></td></tr></tbody></table>
                            </span>    
                            <span style="float:left;font-size:12px;margin-left:2px;width:100px;margin-top:1px"> 
                                <table cellpadding="0" cellspacing="0" height="100%" width="100%"><tbody><tr><td class="value" style="font-size:12px"><span id="main_PlayerIG"><span><span class="v-norm">500</span></span></span> <span style="color:#daa548">IG</span></td></tr></tbody></table>
                            </span>    
                            
                            <span class="vsep" style="position:relative;width:3px;float:left;margin-left:6px;margin-right:4px;"> 
                            </span>
                            

                            
                            
                            <span class="right4" style="float:left;margin-left:2px;"> 
                                    <button class="image_btn_bg noselect" id="btn_WndScience" type="button" data-hint="Исследования" style="width:24px;height:24px;" onclick="sound_click(2);getWindow('WndScience').show()"><img style="" id="btn_WndScience_img" border="0" src="/images/icons/i_science_16.png"></button> 
                            </span>
                            
                            <span style="float:left;font-size:12px;margin-left:1px;width:320px;height:24px;margin-top:0px"> 
                                <table cellpadding="0" cellspacing="1" height="100%" width="100%"><tbody><tr><td class="value" id="main_PlayerScience" style="font-size:12px;width:270px">Нет исследований</td><td class="value" id="main_PlayerScienceTime" style="font-size:11px;width:70px" sec="0">-</td></tr></tbody></table>
                            </span>    

                            <span class="vsep" style="position:relative;width:3px;float:left;margin-left:6px;margin-right:4px;"> 
                            </span>
                            
                            <span class="right4" style="float:left;margin-left:2px;"> 
                                    <button class="image_btn_bg noselect" id="btn_WndShipProjects" type="button" data-hint="Проекты кораблей" style="width:24px;height:24px;" onclick="sound_click(2);getWindow('WndShipProjects').show()"><img style="" id="btn_WndShipProjects_img" border="0" src="/images/icons/i_shipprojects_16.png"></button> 
                            </span>

                            <span style="float:left;font-size:12px;margin-left:1px;width:300px;height:24px;margin-top:0px"> 
                                <table cellpadding="0" cellspacing="1" height="100%" width="100%"><tbody><tr><td class="value" id="main_PlayerProject" style="font-size:12px;width:230px">Нет проектирования</td><td class="value" id="main_PlayerProjectTime" style="font-size:11px;width:70px" sec="0">-</td></tr></tbody></table>
                            </span>    
                            *}
                            
                            
                                                        
                        </div>

                       </div>
                </div>

                <div id="divMenu" class="game_left_frame" style="z-index:29998;top:50%;margin-top: -17.5%;position:fixed;left:0px;height:345px;width:46px">
                        <div class="game_left_frame_content">
                            <a title="{$LNG.lm_control}" href="/game.php?page=overview">
                                <span style="float:left;margin-top:-4px"> 
                                    <button class="image_btn_bg noselect" type="button" style="width:34px;height:34px;">
                                        <img style="width:22px;" border="0" src="{$dpath}img/test2/i_spy_24.png">
                                    </button> 
                                </span>
                            </a>
                            <a title="{$LNG.lm_control}" href="/game.php?page=research">
                                <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" type="button" style="width:34px;height:34px;">
                                        <img style="width:22px;" border="0" src="{$dpath}img/test2/br.png">
                                    </button> 
                                </span>
                            </a>
                            <a title="{$LNG.lm_control}" href="/game.php?page=buildings">
                                <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" type="button" style="width:34px;height:34px;">
                                        <img style="width:22px;" border="0" src="{$dpath}img/test2/bb.png">
                                    </button> 
                                </span>
                            </a>
                            <a title="{$LNG.lm_control}" href="/game.php?page=shipyard&mode=fleet">
                                <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" type="button" style="width:34px;height:34px;">
                                        <img style="width:22px;" border="0" src="{$dpath}img/test2/bs.png">
                                    </button> 
                                </span>
                            </a>
                            <a title="{$LNG.lm_control}" href="/game.php?page=shipyard&mode=defense">
                                <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" type="button" style="width:34px;height:34px;">
                                        <img style="width:22px;" border="0" src="{$dpath}img/test2/5-t.png">
                                    </button> 
                                </span>
                            </a>
                            <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" id="btn_WndShipProjects" type="button" data-hint="Проекты кораблей" style="width:34px;height:34px;" onclick="sound_click(2);getWindow('WndShipProjects').show()"><img style="width:22px;" id="btn_WndShipProjects_img" border="0" src="{$dpath}img/iconav/over.png"></button> 
                            </span>
                           
                            <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" id="btn_WndScience" type="button" data-hint="Исследования" style="width:34px;height:34px;" onclick="sound_click(2);getWindow('WndScience').show()"><img style="width:22px;" id="btn_WndScience_img" border="0" src="{$dpath}img/iconav/over.png"></button> 
                            </span>

                            <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" id="btn_WndMessages" type="button" style="width:34px;height:34px;" onclick="sound_click(2);getWindow('WndMessages').show()"><img style="width:22px;" id="btn_WndMessages_img" border="0" src="{$dpath}img/iconav/over.png"></button> 
                            </span>
                            
                            <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" id="btn_WndMessage" type="button" data-hint="Отправить сообщение" style="width:34px;height:34px;" onclick="sound_click(2);getWindow('WndMessage').show()"><img style="width:22px;" id="btn_WndMessage_img" border="0" src="{$dpath}img/iconav/over.png"></button> 
                            </span> 
                    </div>
                </div>
                <div id="divMenu" class="game_right_frame" style="z-index:29998;top:50%;margin-top: -17.5%;position:fixed;right: 1px;height:345px;width:46px;">
                        <div class="game_right_frame_content">
                            
                            <span style="float:left;margin-top:-4px"> 
                                   <button class="image_btn_bg noselect" id="btn_WndPlayerSettings" type="button" data-hint="Настройки аккаунта" style="width:34px;height:34px;" onclick="sound_click(2);getWindow('WndPlayerSettings').show()"><img style="width:22px;" id="btn_WndPlayerSettings_img" border="0" src="/images/icons/i_settings_24.png"></button> 
                            </span>
                            <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" id="btn_WndHelp" type="button" data-hint="Справочник" style="width:34px;height:34px;" onclick="sound_click(2);getWindow('WndHelp').show()"><img style="width:22px;" id="btn_WndHelp_img" border="0" src="/images/icons/i_help_24.png"></button> 
                            </span>
                            <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" id="btn_WndBugReports" type="button" data-hint="Заявки в службу поддержки" style="width:34px;height:34px;" onclick="sound_click(2);getWindow('WndBugReports').show()"><img style="width:22px;" id="btn_WndBugReports_img" border="0" src="/images/icons/i_bugreport_24.png"></button> 
                            </span>
                            <span style="float:left;margin-top:1px"> 
                                    <button class="image_btn_bg noselect" id="btn_WndFederation" type="button" data-hint="Федерация" style="width:34px;height:34px;" onclick="sound_click(2);getWindow('WndFederation').show()"><img style="width:22px;" id="btn_WndFederation_img" border="0" src="/images/icons/a_federation_24.gif" data-hint="Задания Федерации: 2 в процессе"></button> 
                            </span>
                            <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" id="btn_WndTrade" type="button" data-hint="Торговые операции" style="width:34px;height:34px;" onclick="sound_click(2);getWindow('WndTrade').show()"><img style="width:22px;" id="btn_WndTrade_img" border="0" src="/images/icons/i_atrade_24.gif"></button> 
                            </span>
                            <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" id="btn_WndShipProjects" type="button" data-hint="Проекты кораблей" style="width:34px;height:34px;" onclick="sound_click(2);getWindow('WndShipProjects').show()"><img style="width:22px;" id="btn_WndShipProjects_img" border="0" src="/images/icons/i_shipprojects_24.png"></button> 
                            </span>
                           
                            <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" id="btn_WndScience" type="button" data-hint="Исследования" style="width:34px;height:34px;" onclick="sound_click(2);getWindow('WndScience').show()"><img style="width:22px;" id="btn_WndScience_img" border="0" src="/images/icons/i_science_24.png"></button> 
                            </span>

                            <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" id="btn_WndMessages" type="button" style="width:34px;height:34px;" onclick="sound_click(2);getWindow('WndMessages').show()"><img style="width:22px;" id="btn_WndMessages_img" border="0" src="/images/icons/i_messages_24.png"></button> 
                            </span>
                            
                            <span style="float:left;margin-top:2px"> 
                                    <button class="image_btn_bg noselect" id="btn_WndMessage" type="button" data-hint="Отправить сообщение" style="width:34px;height:34px;" onclick="sound_click(2);getWindow('WndMessage').show()"><img style="width:22px;" id="btn_WndMessage_img" border="0" src="/images/icons/i_message_24.png"></button> 
                            </span>

                            
                            
                        </div>
                </div>
                <div id="divBottom" class="game_bottom_frame" style="position:fixed;z-index:29998;left:-490px;margin-left: 50%;bottom:0px;height:40px;width:980px">
                    <div class="game_bottom_frame_content">
                        <div style="float:right;margin-top:2px;margin-right:4px;">
                            <button type="button" class="text_btn_bg noselect" style="font-size:12px;height:24px;width:92px;background-position:left 0px top 0px,right 0px top 0px, left 2px top;background-size:3px 24px, 3px 24px, 86px 24px;" onclick="sound_click(2);getWindow('WndStat').show()"><div style="margin-top:0px">{$LNG.lm_logout}</div></button>                        
                        </div>
                        <div class="vsep" style="float:right;margin-top:4px;margin-right:5px;width:3px;height:22px"></div>
                        <div style="float:right;margin-top:2px;margin-right:4px;">
                        <a href="game.php?page=settings">
                            <button type="button" class="text_btn_bg noselect" style="font-size:12px;height:24px;width:92px;background-position:left 0px top 0px,right 0px top 0px, left 2px top;background-size:3px 24px, 3px 24px, 86px 24px;" onclick="sound_click(2);window.open('https://forum.starfederation.ru')"><div style="margin-top:0px">{$LNG.lm_options}</div></button>    
                        </a>            
                        </div>
                        {if isModuleAvailable($smarty.const.MODULE_RECORDS)}
                        <div class="vsep" style="float:right;margin-top:4px;margin-right:5px;width:3px;height:22px"></div>
                        <div style="float:right;margin-top:2px;margin-right:4px;">
                        <a href="game.php?page=records">
                            <button type="button" class="text_btn_bg noselect" style="font-size:12px;height:24px;width:92px;background-position:left 0px top 0px,right 0px top 0px, left 2px top;background-size:3px 24px, 3px 24px, 86px 24px;" onclick="sound_click(2);window.open('https://forum.starfederation.ru')"><div style="margin-top:0px">{$LNG.lm_records}</div></button>  
                        </a>             
                        </div>
                        {/if}
                        {if isModuleAvailable($smarty.const.MODULE_BUDDYLIST)}
                        <div class="vsep" style="float:right;margin-top:4px;margin-right:5px;width:3px;height:22px"></div>
                        <div style="float:right;margin-top:2px;margin-right:4px;">
                        <a href="game.php?page=buddyList">
                            <button type="button" class="text_btn_bg noselect" style="font-size:12px;height:24px;width:92px;background-position:left 0px top 0px,right 0px top 0px, left 2px top;background-size:3px 24px, 3px 24px, 86px 24px;" onclick="sound_click(2);window.open('https://forum.starfederation.ru')"><div style="margin-top:0px">{$LNG.lm_buddylist}</div></button>    
                        </a>                              
                        </div>
                        {/if}
                        <div class="vsep" style="float:right;margin-top:4px;margin-right:5px;width:3px;height:22px"></div>
                        <div style="float:right;margin-top:2px;margin-right:4px;">
                        <a href="index.php?page=rules" target="_blank">
                            <button type="button" class="text_btn_bg noselect" style="font-size:12px;height:24px;width:92px;background-position:left 0px top 0px,right 0px top 0px, left 2px top;background-size:3px 24px, 3px 24px, 86px 24px;" onclick="sound_click(2);window.open('https://forum.starfederation.ru')"><div style="margin-top:0px">{$LNG.lm_rules}</div></button> 
                        </a>         
                        </div>
                        {if isModuleAvailable($smarty.const.MODULE_TECHTREE)}
                        <div class="vsep" style="float:right;margin-top:4px;margin-right:5px;width:3px;height:22px"></div>
                        <div style="float:right;margin-top:2px;margin-right:4px;">
                        <a href="game.php?page=techtree">
                            <button type="button" class="text_btn_bg noselect" style="font-size:12px;height:24px;width:92px;background-position:left 0px top 0px,right 0px top 0px, left 2px top;background-size:3px 24px, 3px 24px, 86px 24px;" onclick="sound_click(2);window.open('https://forum.starfederation.ru')"><div style="margin-top:0px">{$LNG.lm_technology}</div></button>  
                        </a>         
                        </div>
                        {/if}
                        {if isModuleAvailable($smarty.const.MODULE_BATTLEHALL)}
                        <div class="vsep" style="float:right;margin-top:4px;margin-right:5px;width:3px;height:22px"></div>
                        <div style="float:right;margin-top:2px;margin-right:4px;">
                        <a href="game.php?page=battleHall">
                            <button type="button" class="text_btn_bg noselect" style="font-size:12px;height:24px;width:92px;background-position:left 0px top 0px,right 0px top 0px, left 2px top;background-size:3px 24px, 3px 24px, 106px 24px;" onclick="sound_click(2);getWindow('WndBattleLogs').show()"><div style="margin-top:0px">{$LNG.lm_topkb}</div></button>   
                        </a>                             
                        </div>
                        {/if}
                        {if isModuleAvailable($smarty.const.MODULE_ACHIEVEMENTS)}
                        <div class="vsep" style="float:right;margin-top:4px;margin-right:5px;width:3px;height:22px"></div>
                        <div style="float:right;margin-top:2px;margin-right:4px;">
                        <a href="game.php?page=achievements">
                            <button type="button" class="text_btn_bg noselect" style="font-size:12px;height:24px;width:92px;background-position:left 0px top 0px,right 0px top 0px, left 2px top;background-size:3px 24px, 3px 24px, 86px 24px;" onclick="sound_click(2);window.open('https://forum.starfederation.ru')"><div style="margin-top:0px">{$LNG.lm_achievements}</div></button>
                        </a>         
                        </div>
                        {/if}
                        {if !empty($hasBoard)}
                        <div class="vsep" style="float:right;margin-top:4px;margin-right:5px;width:3px;height:22px"></div>
                        <div style="float:right;margin-top:2px;margin-right:4px;">
                        <a href="game.php?page=board" target="_blank">
                            <button type="button" class="text_btn_bg noselect" style="font-size:12px;height:24px;width:92px;background-position:left 0px top 0px,right 0px top 0px, left 2px top;background-size:3px 24px, 3px 24px, 106px 24px;" onclick="sound_click(2);getWindow('WndBattleLogs').show()"><div style="margin-top:0px">{$LNG.lm_forums}</div></button>     
                        </a>         
                        </div>
                        {/if}
                    </div>
                </div>
                
 </div>               
                
<script type="text/javascript">
    	setInterval(function() { AJAX() }, 5000);
</script>
<script type="text/javascript" src="./scripts/game/json.js"></script>
{*
<div id="left_side">  
	<div id="side_menu_up">
        <div class="img"></div>
    </div>
    <div id="left_menu">
        <div id="touchscreenleft_menu">   
            <div id="indicators">
                <div id="attack" class="indicator {if $ataks > 0}active_indicator{/if}">
                    <div class="icoi"></div>
                </div>
                <div id="espionage" class="indicator {if $spio > 0}active_indicator{/if}">
                    <div class="icoi"></div>
                </div>
                <div id="destruction" class="indicator {if $unic > 0}active_indicator{/if}">
                    <div class="icoi"></div>
                </div>
                <div id="rocket" class="indicator {if $rakets > 0}active_indicator{/if}">
                    <div class="icoi"></div>
                </div>
            </div>
            
            <a class="big_btn btn_menu btn_menu_big"> <div class="servertime oservertime"></div> </a>
            {if $bonus_time < TIMESTAMP}
            <a class="big_btn blue btn_menu btn_menu_big" href="game.php?page=bonus">{$LNG.lm_bonus}</a>
            {else}
            <a class="big_btn blue btn_menu btn_menu_big">{$bonus_time_rest}</a>
            {/if}
            
            <!-- ricerche  tecnologie-->
            {if isModuleAvailable($smarty.const.MODULE_RESEARCH)}
            <a class="nuovomenusinistra" href="game.php?page=research" id="munu_research">{$LNG.lm_research}</a>
            <a class="nuovomenudestra" href="game.php?page=research"><img src="{$dpath}img/iconav/research.png" class="imgovernuovo"></a>
            {/if}
            <!-- costruzioni risorse-->
            {if isModuleAvailable($smarty.const.MODULE_BUILDING)}
            <a class="nuovomenusinistra" href="game.php?page=buildings" id="munu_build">{$LNG.lm_buildings}</a>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_RESSOURCE_LIST)}
            <a class="nuovomenudestra tooltip" href="game.php?page=resources" id="munu_resources" data-tooltip-content="{$LNG.lm_resources}"><img src="{$dpath}img/iconav/resources.png" class="oimgaltro"></a>
            {/if}
            <!-- flotta hangar -->
            {if isModuleAvailable($smarty.const.MODULE_SHIPYARD_FLEET)}
            <a class="nuovomenusinistra" href="game.php?page=shipyard&amp;mode=fleet" id="munu_shipyard_fleet">{$LNG.lm_shipshard}</a>
            <a class="nuovomenudestra" href="game.php?page=shipyard&amp;mode=fleet" id="munu_fleetable"><img src="{$dpath}img/iconav/hangar.png" class="imgovernuovo"></a>
            {/if}
            <!-- difese -->
            {if isModuleAvailable($smarty.const.MODULE_SHIPYARD_DEFENSIVE)}
            <a class="nuovomenusinistra" href="game.php?page=shipyard&amp;mode=defense" id="munu_shipyard_defense">{$LNG.lm_defenses}</a>
            <a class="nuovomenudestra" href="game.php?page=shipyard&amp;mode=defense"><img src="{$dpath}img/iconav/shield.png" class="imgovernuovo"></a>
            {/if}
            <!-- Orbita -->
            <a class="nuovomenusinistra" href="game.php?page=fleetTable" id="munu_orbita">{$LNG.lm_fleet}</a>
            {if isModuleAvailable($smarty.const.MODULE_SIMULATOR)}
            <a class="nuovomenudestra tooltip" href="game.php?page=battleSimulator" id="munu_fleetable" data-tooltip-content="{$LNG.lm_battlesim}"><img src="{$dpath}img/iconav/target.png" class="oimgaltro"></a>	
            {/if}            
            <!-- alleanza-->
            {if isModuleAvailable($smarty.const.MODULE_ALLIANCE)}
			<a class="nuovomenusinistra" href="game.php?page=alliance" id="munu_alliance">{$LNG.lm_alliance}</a>
            <a class="nuovomenudestra" href="game.php?page=alliance"><img src="{$dpath}img/iconav/alliance.png" class="imgovernuovo" id="ciaone"></a>	
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_MARKET)}
            <a class="nuovomenusinistra" href="game.php?page=market">{$LNG.lm_market}</a>
            <a class="nuovomenudestra" href="game.php?page=market"><img src="{$dpath}img/iconav/market.png" class="imgovernuovo"></a>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_ARSENAL)}
            <a class="nuovomenusinistra" href="game.php?page=arsenal">{$LNG.lm_ars}</a>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_CONTAINER)}
            <a class="nuovomenudestra tooltip" href="game.php?page=conteiner" id="munu_fleetable" data-tooltip-content="{$LNG.lm_container}"><img src="{$dpath}img/iconav/arsenal.png" class="oimgaltro"></a>	
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_OFFICIER)}
            <a class="nuovomenusinistra" href="game.php?page=officier" id="munu_senat">{$LNG.lm_officiers}</a>
            <a class="nuovomenudestra" href="game.php?page=officier"><img src="{$dpath}img/iconav/governatori.png" class="imgovernuovo" id="ciaone"></a>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_MINERALS)}
            <a class="nuovomenusinistra" href="game.php?page=minerals" id="munu_senat">{$LNG.lm_minerals}</a>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_DETAILS)}
            <a class="nuovomenudestra tooltip" href="game.php?page=details" id="munu_fleetable" data-tooltip-content="{$LNG.lm_details}"><img src="{$dpath}img/iconav/blackmarket.png" class="oimgaltro"></a>	
            {/if}
            <!-- ufficiali governatori -->
            {if isModuleAvailable($smarty.const.MODULE_GALAXY)}
            <a class="galassiabott" href="game.php?page=galaxy" id="munu_galaxy">{$LNG.lm_galaxy}</a>
            {/if}   
     		{if $authlevel > 0}
            <a  href="admin.php" class="big_btn green btn_menu btn_menu_big">{$LNG.lm_administration}</a>
            {/if}
            <div class="clear"></div>                
    </div>
    </div><!--/left_menu-->
    <div class="menubassoleft">
        <div id="top_nav_parte_sotto"> 
            {if isModuleAvailable($smarty.const.MODULE_TECHTREE)}
            <a title="{$LNG.lm_technology}" href="game.php?page=techtree"><span class="techtree"></span></a>
            <div class="separator_nav"></div>
            {/if} 
			<a title="{$LNG.lm_rules}" href="index.php?page=rules" target="_blank"><span class="rules"></span></a>
            <div class="separator_nav"></div>
            {if isModuleAvailable($smarty.const.MODULE_BUDDYLIST)}
            <a title="{$LNG.lm_buddylist}" href="game.php?page=buddyList"><span class="frend"></span></a>
            <div class="separator_nav"></div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_RECORDS)}
			<a title="{$LNG.lm_records}" href="game.php?page=records"><span class="record"></span></a>
            <div class="separator_nav"></div>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_SUPPORT)}
			<a title="{$LNG.lm_support}" href="game.php?page=ticket"><span class="soopart"></span></a>				
			<div class="separator_nav"></div>
            {/if}
			<a title="{$LNG.lm_options}" href="game.php?page=settings"><span class="seting"></span></a>  
			<div class="separator_nav"></div>		
			<a title="{$LNG.lm_logout}" href="game.php?page=logout"> <span class="exit"></span></a>				  
        </div>
        <div id="side_menu_bottom">
            <div class="img"></div>
        </div>
    </div> 
</div>
*}
<div style="height:0; overflow:hidden;" loop="false;" id="music">
    <audio id="beepataks" preload="auto">
        <source src="./sound/sirena.mp3"></source>
        <source src="./sound/sirena.ogg"></source>
    </audio>
    <audio id="msgaudio" preload="auto">
        <source src="./sound/msg.mp3"></source>
        <source src="./sound/msg.ogg"></source>
    </audio>
    <script type="text/javascript">
		var ataks = "{$ataks}";
		var spio = "{$spio}";
        var unic = "{$unic}";
		var rakets = "{$rakets}";
		var msg = {$new_message};
		document.getElementById('msgaudio').volume={$msgvolume};
		document.getElementById('beepataks').volume={$volume};
	</script>
</div>
<script type="text/javascript">
            {foreach $resourceTable as $resourceID => $resouceData} 
                {if !isset($resouceData.current)}
                    {$resouceData.current = $resouceData.max + $resouceData.used}                   
                    var currentVar_{$resouceData.name} = {$resouceData.current};
                {else}
                    var currentVar_{$resouceData.name} = {$resouceData.current};
                {/if}
            {/foreach}  
</script>