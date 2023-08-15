{block name="title" prepend}{$LNG.lm_galaxy}{/block}
{block name="content"} 
<link rel="stylesheet" type="text/css" href="{$dpath}css/galactic.css">
<div id="page">
    <div id="content">
        <div id="galactic_block_1">
            <div style="position:absolute; width:0; height:0;">
                {if $action == 'sendMissle'}
                <form action="?page=fleetMissile" method="post">
                    <input type="hidden" name="galaxy" value="{$galaxy}">
                    <input type="hidden" name="system" value="{$system}">
                    <input type="hidden" name="planet" value="{$planet}">
                    <input type="hidden" name="type" value="{$type}">
                    <table class="table569" style='width: 715px !important;'>
                        <tr>
                            <th colspan="2">{$LNG.gl_missil_launch} [{$galaxy}:{$system}:{$planet}]</th>
                        </tr>
                        <tr>
                            <td>{$missile_count} <input type="text" name="SendMI" size="2" maxlength="7"></td>
                            <td>{$LNG.gl_objective}: 
                                {html_options name=Target options=$missileSelector}
                            </td>
                        </tr>
                        <tr>
                            <th colspan="2" style="text-align:center;"><input type="submit" value="{$LNG.gl_missil_launch_action}"></th>
                        </tr>
                    </table>
                </form>
                {/if}
                <div id="galactic_block_1">
                    <div id="galactic_header" style="position:relative;">
                        <form action="?page=galaxy" method="post" id="galaxy_form">
                            <input id="auto" value="dr" type="hidden">
                            <div class="gal_nazv" style="margin-left:15px;">{$LNG.gl_galaxy}:</div>
                            <div id="nav_1">
                                <input class="prev" name="galaxyeft" onclick="galaxy_submit('galaxyLeft')" type="button">
                                <input class="gal_p3" name="galaxy" value="{$galaxy}" size="5" maxlength="4" tabindex="2" type="text">
                                <input class="next" name="galaxyRight" onclick="galaxy_submit('galaxyRight')" type="button">
                            </div>
                            <div class="gal_p4">{$LNG.gl_solar_system}:</div>
                            <div id="nav_2">
                                <input type="button" class="prev" name="systemLeft" onclick="galaxy_submit('systemLeft')">
                                <input class="gal_p3" type="text" name="system" value="{$system}" size="5" maxlength="4" tabindex="2">
                                <input type="button" class="next" name="systemRight" onclick="galaxy_submit('systemRight')">
                            </div>
                            <div class="gal_sep"></div>
                            <input value="{$LNG.gl_show}" id="galactic_show" type="submit">
                        </form>
                    </div>
                    <!--/galactic_header-->
                    <div id="galactic_status">
                        <div class="gal_p5">{$LNG.gl_pos}</div>
                        <div class="status_sep"></div>
                        <div class="gal_p6">{$LNG.gl_name_activity}</div>
                        <div class="status_sep"></div>
                        <div class="gal_p7">{$LNG.gl_moon}</div>
                        <div class="status_sep"></div>
                        <div class="gal_p8">{$LNG.gl_debris}</div>
                        <div class="status_sep"></div>
                        <div class="gal_p9">{$LNG.gl_player_estate}</div>
                        <div class="status_sep"></div>
                        <div class="gal_p10">{$LNG.gl_alliance}</div>
                        <div class="status_sep"></div>
                        <div class="gal_p11">{$LNG.gl_actions}</div>
                    </div>
                    <!--/galactic_status-->
                    {for $planet=1 to $max_planets}
                    {if !isset($GalaxyRows[$planet])}
                    <div class="gal_user {if $planet != 1 && $planet != 3 && $planet != 5 && $planet != 7 && $planet != 9 && $planet != 11 && $planet != 13 && $planet != 15}second{/if}">   
                        <div class="gal_number">
                            <a href="game.php?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1" class="tooltip" data-tooltip-content="
                                <table class='reducefleet_table'>
                                    <tr>
                                        <td class='reducefleet_img_ship'><img src='{$dpath}img/iconav/position.png'></td>
                                        <td class='reducefleet_name_ship'>{$LNG.gl_sp}</td>
                                    </tr>
                                    <tr>
                                        <td class='reducefleet_img_ship'><img src='{$dpath}img/iconav/diametr.png'></td>
                                        <td class='reducefleet_name_ship'>{$LNG.ov_fields} <span class='reducefleet_count_ship'>{$planetData[$planet]['fields'] * $planet_factor}</span></td>
                                    </tr>
                                    <tr>
                                        <td class='reducefleet_img_ship'><img src='{$dpath}img/iconav/temp.png'></td>
                                        <td class='reducefleet_name_ship'>{$LNG.ov_temperature} <span class='reducefleet_count_ship'>{$planetData[$planet]['temp']}</span></td>
                                    </tr>
                                </table>
                            ">
                            <span style="color:{$planetData[$planet]['color']}">{$planet}</span></a>
                        </div>
                        <div class="gal_player_cont" style="float:right">
                            <a class="ico_coloni ico_animation" href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=7"></a>    
                        </div>       
                    </div> 
                    {elseif $GalaxyRows[$planet] === false}
                    <div class="gal_user {if $planet != 1 && $planet != 3 && $planet != 5 && $planet != 7 && $planet != 9 && $planet != 11 && $planet != 13 && $planet != 15}second{/if}">   
                        <div class="gal_number">
                            <span style="color:#efbf13">{$planet}</span>
                        </div>
                        <div class="gal_planet_name">{$LNG.gl_planet_destroyed}</div>
                    </div><!--/gal_user-->     
                    {else}
                    <div class="gal_user {if $planet != 1 && $planet != 3 && $planet != 5 && $planet != 7 && $planet != 9 && $planet != 11 && $planet != 13 && $planet != 15}second{/if}" style="
                        background-image:url({$dpath}planeten/panel/{$GalaxyRows[$planet].planet.image}.png);
                        background-repeat: no-repeat;
                        background-position: top left;
                    ">   
                        <div class="gal_number">
                            <a href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1">
                            <span style="color:#0abd00">{$planet}</span></a>
                        </div>
                        {$currentPlanet = $GalaxyRows[$planet]}
                        <span id="p_{$currentPlanet.planet.id}" class="tooltip gal_img_planet" data-tooltip-content="{$LNG.gl_planet} {$currentPlanet.planet.name} [{$galaxy}:{$system}:{$planet}]">
                            <div class="gl-actions">
                                <table class="gl-actions-t">	
                                    <tbody>	
                                        <tr>
                                        {if $currentPlanet.missions.1}<td><a class="gl-actions-i ri i-mis1 tooltip" href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=1" data-tooltip-content="{$LNG.type_mission_1}"></a></td>{/if}
                                        {if $currentPlanet.missions.3}<td><a class="gl-actions-i ri i-mis3 tooltip" href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=3" data-tooltip-content="{$LNG.type_mission_3}"></a></td>{/if}
                                        {if $currentPlanet.missions.4}<td><a class="gl-actions-i ri i-mis4 tooltip" href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=4" data-tooltip-content="{$LNG.type_mission_4}"></a></td>{/if}
                                        {if $currentPlanet.missions.5}<td><a class="gl-actions-i ri i-mis5 tooltip" href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=5" data-tooltip-content="{$LNG.type_mission_5}"></a></td>{/if}
                                        {if $currentPlanet.missions.10}<td><a class="gl-actions-i ri i-mis10 tooltip" href="?page=galaxy&amp;action=sendMissle&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}" data-tooltip-content="{$LNG.type_mission_10}"></a></td>{/if}            
                                        {if $currentPlanet.missions.6}<td><a class="gl-actions-i ri i-mis6 tooltip" href='javascript:doit(6,{$currentPlanet.planet.id});' data-tooltip-content="{$LNG.type_mission_6}"></a></td>{/if}
                                        {foreach $currentPlanet.user.class as $class}
                                        {if $class != 'vacation' && $currentPlanet.planet.phalanx}
                                        <td><a class="gl-actions-i ri i-mis17 tooltip" href='javascript:OpenPopup(&quot;?page=phalanx&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&quot;, &quot;&quot;, 640, 510);' data-tooltip-content="{$LNG.gl_phalanx}"></a></td>
                                        {/if}
                                        {foreachelse}
                                        {if $currentPlanet.planet.phalanx}
                                        <td><a class="gl-actions-i ri i-mis17 tooltip" href='javascript:OpenPopup(&quot;?page=phalanx&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&quot;, &quot;&quot;, 640, 510);' data-tooltip-content="{$LNG.gl_phalanx}"></a></td>
                                        {/if}
                                        {/foreach}
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <img src="{$dpath}planeten/planet2d/{$currentPlanet.planet.image}.png" alt="">
                            {*<span>200</span>*}		
                        </span>
                        <div class="gal_planet_name">{$currentPlanet.planet.name} {$currentPlanet.lastActivity} </div>
                        <div class="gal_ico_moon ico_animation">
                        {if $currentPlanet.moon}
                            <div class="ico_moon tooltip" data-tooltip-content="
                                <table class='tooltip_class_table'>
                                    <tr>
                                        <th colspan='2'>{$LNG.gl_moon} [{$galaxy}:{$system}:{$planet}]</th>
                                    </tr>
                                    <tr>
                                        <td class='tooltip_class_table_text_left'><span>{$LNG.gl_diameter}</span> {$currentPlanet.moon.diameter|number}</td>
                                    </tr>
                                    <tr>
                                        <td class='tooltip_class_table_text_left'><span>{$LNG.gl_temperature}</span> {$currentPlanet.moon.temp_min}</td>
                                    </tr>
                                </table>
                            "></div>
                            <div class="gl-actions" style="top: 5px;z-index: 2;padding-left: 0px;left: 44px;">
                                <table class="gl-actions-t">	
                                    <tbody>
                                        <tr>
                                            {if $currentPlanet.missions.1}<td><a class="gl-actions-i ri i-mis1 tooltip" href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=1" data-tooltip-content="{$LNG.type_mission_1}"></a></td>{/if}
                                            {if $currentPlanet.missions.3}<td><a class="gl-actions-i ri i-mis3 tooltip" href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=3" data-tooltip-content="{$LNG.type_mission_3}"></a></td>{/if}
                                            {if $currentPlanet.missions.4}<td><a class="gl-actions-i ri i-mis4 tooltip" href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=4" data-tooltip-content="{$LNG.type_mission_4}"></a></td>{/if}
                                            {if $currentPlanet.missions.5}<td><a class="gl-actions-i ri i-mis5 tooltip" href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=5" data-tooltip-content="{$LNG.type_mission_5}"></a></td>{/if}	            
                                            {if $currentPlanet.missions.6}<td><a class="gl-actions-i ri i-mis6 tooltip" href='javascript:doit(6,{$currentPlanet.moon.id});' data-tooltip-content="{$LNG.type_mission_6}"></a></td>{/if}
                                            {if $currentPlanet.missions.9}<td><a class="gl-actions-i ri i-mis9 tooltip" href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=9" data-tooltip-content="{$LNG.type_mission_9}"></a></td>{/if}	            
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        {/if}
                        </div>
                        <div class="gal_ico_trash">
                        {if $currentPlanet.debris}
                            <div class="ico_trash_{if $currentPlanet.debris.metal + $currentPlanet.debris.crystal > 225000000000 }big{elseif $currentPlanet.debris.metal + $currentPlanet.debris.crystal < 225000000000 && $currentPlanet.debris.metal + $currentPlanet.debris.crystal > 7500000000}medium{elseif $currentPlanet.debris.metal + $currentPlanet.debris.crystal < 7500000000}small{/if} ico_animation
                            tooltip_sticky" data-tooltip-content="
                                <table class='tooltip_class_table'>
                                    <tbody>
                                        <tr>
                                            <th>{$LNG.gl_debris_field} [{$galaxy}:{$system}:{$planet}]</th>
                                        </tr>
                                        <tr>
                                            <td class='tooltip_class_table_text_left'>
                                                <span>{$LNG.tech.901}</span>: <span class='tooltip_class_901'>{$currentPlanet.debris.metal|number}</span><br>
                                                <span>{$LNG.tech.902}</span>: <span class='tooltip_class_902'>{$currentPlanet.debris.crystal|number}</span>
                                            </td>
                                        </tr>            
                                        <tr>
                                            <td>
                                                <a class='tooltip_class_a_bigbtn' href='javascript:doit(8, {$currentPlanet.planet.id});'>{$LNG.type_mission_8}</a>
                                            </td>
                                        </tr>            
                                    </tbody>
                                </table>">
                            </div>
                        {/if}
                        </div>	
                        <div class="gal_player_name">
                            <a class="tooltip_sticky" data-tooltip-content="
                                <table class='tooltip_class_table'>
                                    <tbody>
                                        <tr>
                                            <th>{$currentPlanet.user.playerrank}</th>
                                        </tr>
                                        {if !$currentPlanet.ownPlanet}
                                        {if $currentPlanet.user.isBuddy}
                                        <tr>
                                            <td>
                                                <a class='tooltip_class_a_bigbtn' href='#' onclick='return Dialog.Buddy({$currentPlanet.user.id})'>{$LNG.gl_buddy_request}</a>
                                            </td>
                                        </tr>
                                        {/if}
                                        <tr>
                                            <td>
                                                <a class='tooltip_class_a_bigbtn' href='#' onclick='return Dialog.Playercard({$currentPlanet.user.id});'>{$LNG.gl_playercard}</a>
                                            </td>
                                        </tr>
                                        {/if}
                                        <tr>
                                            <td>
                                                <a class='tooltip_class_a_bigbtn' href='?page=statistics&amp;who=1&amp;start={$currentPlanet.user.rank}'>{$LNG.gl_see_on_stats}</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>{foreach $currentPlanet.user.class as $class}{if !$class@first}{/if}<span class='galaxy-short-{$class} galaxy-short'>{$ShortStatus.$class}</span>{/foreach}</td>
                                        </tr>                                        
                                    </tbody>
                                </table>">
                                <span class="{foreach $currentPlanet.user.class as $class}{if !$class@first} {/if}galaxy-username-{$class}{/foreach}  galaxy-username" {if !$currentPlanet.user.isBuddy}style='color:#eae45c'{/if}>{$currentPlanet.user.username}</span>
                                {if !empty($currentPlanet.user.class)}
                                <span>(</span>{foreach $currentPlanet.user.class as $class}{if !$class@first}{/if}<span class="galaxy-short-{$class} galaxy-short">{$ShortStatus.$class}</span>{/foreach}<span>)</span>
                                {/if}
                            </a>
                        </div>
                        <div class="gal_ally_name">
                            {if $currentPlanet.alliance}
                            <a class="tooltip_sticky" data-tooltip-content="
                                <table class='tooltip_class_table'>
                                    <tbody>
                                        <tr>
                                            <th>{$LNG.gl_alliance} {$currentPlanet.alliance.name} {$currentPlanet.alliance.member}</th>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a class='tooltip_class_a_bigbtn' href='?page=alliance&amp;mode=info&amp;id={$currentPlanet.alliance.id}'>{$LNG.gl_alliance_page}</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a class='tooltip_class_a_bigbtn' href='?page=statistics&amp;start={$currentPlanet.alliance.rank}&amp;who=2'>{$LNG.gl_see_on_stats}</a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>">
                                <span class="galaxy-alliance {foreach $currentPlanet.alliance.class as $class}{if !$class@first} {/if}{$class}{/foreach}"{$class}>{$currentPlanet.alliance.tag}</span>
                            </a>
                            {/if}	
                        </div>
                        <div class="gal_player_cont" style="float:right">
                        {if $currentPlanet.action}
                            {if $currentPlanet.action.esp}
                                <a class="ico_watch ico_animation" title="{$LNG.gl_spy}" href="javascript:doit(6,{$currentPlanet.planet.id},{$spyShips|json|escape:'html'})"></a>	
                            {/if}
                            {if $currentPlanet.action.message} 
                                <a href="#" class="ico_post ico_animation" onclick="return Dialog.PM({$currentPlanet.user.id})" title="{$LNG.write_message}"></a>				      
                            {/if}
                            {if $currentPlanet.action.buddy}	
                                <a href="#" class="ico_friend ico_animation" onclick="return Dialog.Buddy({$currentPlanet.user.id})" title="{$LNG.gl_buddy_request}"></a>				
                            {/if}
                        {/if}	               
                        </div> 
                    </div>
                    {/if}
                    {/for}
                    <div id="gal_block_1_footer">
                        <a id="dali" class="dali btn_galassia" href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$max_planets + 1}&amp;planettype=1&amp;target_mission=15"><img src="{$dpath}img/iconav/g_expedition.png">{$LNG.gl_out_space}</a>
                        <a id="expedition" class="expedition btn_galassia1" href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$max_planets + 1}&amp;planettype=1&amp;target_mission=18"><img src="{$dpath}img/iconav/g_hostile.png">{$LNG.type_mission_18}</a>
                    </div>
                </div>
                <div id="send_zond">
                    <table>
                        <tr style="display: none;" id="fleetstatusrow"></tr>
                    </table>
                </div>
                <div id="galactic_block_2">
                    <div id="block_status">
                        <div class="gal_stat_1">
                            <div class="gal_text_1">{$planetcount}</div>
                            <div class="gal_text_2">{$LNG.gl_populed_planets}</div>
                        </div>
                        <div class="gal_stat_2">
                            <div class="gal_text_1"><span id="grecyclers">{$grecyclers|number}</span></div>
                            <div class="gal_text_2">{$LNG.gl_avaible_recyclers}</div>
                        </div>
                        <div class="gal_stat_3">
                            <div class="gal_text_1"><span id="slots">{$maxfleetcount}</span>/{$fleetmax}</div>
                            <div class="gal_text_2">{$LNG.gl_fleets}</div>
                        </div>
                        <div class="gal_stat_4">
                            <div class="gal_text_1"><span id="probes">{$spyprobes|number}</span></div>
                            <div class="gal_text_2">{$LNG.gl_avaible_spyprobes}</div>
                        </div>
                        <div class="gal_stat_5">
                            <div class="gal_text_1"><span id="recyclers">{$grecyclers|number}</span> </div>
                            <div class="gal_text_2">{$LNG.gl_avaible_grecyclers}</div>
                        </div>
                        <div class="gal_stat_6">
                            <div class="gal_text_1">{$currentmip|number}</div>
                            <div class="gal_text_2">{$LNG.gl_avaible_missiles}</div>
                        </div>
                    </div>   
                    {* 
                    <div id="block_diplom">
                        <div id="diplom_shapka">
                            <div class="diplom_color">Цвета дипломатии</div>
                            <div class="gal_show_content">
                                <div id="diplom_btn" class="gal_show_block" onclick="klicdiplo();"></div><!--/show_block-->
                            </div>
                        </div>
                        <div id="diplom_content">
                            <div class="block_1">
                                <div class="gal_text_1">Игроки:</div>
                                <div class="gal_text_2">Альянсы:</div>
                            </div>
                            <div class="block_2">
                                <div class="dipl_color first">
                                    <div class="yellow"></div>
                                    <div class="color_text">Друзья</div>
                                </div>

                                <div class="dipl_color second">
                                    <div class="red"></div>
                                    <div class="color_text">Враги</div>
                                </div>
                                <div id="attention">Цвета врагов приоритетнее цветов друзей!</div>
                    
                                <div class="dipl_color ally first">
                                    <div class="green"></div>
                                    <div class="color_text">{$LNG.al_diplo_level.2}</div>
                                </div>
                                <div class="dipl_color ally second">
                                    <div class="white"></div>
                                    <div class="color_text">{$LNG.al_diplo_level.1}</div>
                                </div>
                                <div class="dipl_color ally third">
                                    <div class="grey_yellow"></div>
                                    <div class="color_text">{$LNG.al_diplo_level.3}</div>
                                </div>
                                <div class="dipl_color ally thour">
                                    <div class="brown"></div>
                                    <div class="color_text">{$LNG.al_diplo_level.4}</div>
                                </div>
                                <div class="dipl_color ally_2 first">
                                    <div class="red"></div>
                                    <div class="color_text">{$LNG.al_diplo_level.5}</div>
                                </div>
                                
                                <div class="dipl_color ally_2 second">
                                    <div class="green"></div>
                                    <div class="color_text">{$LNG.al_diplo_level.6}</div>
                                </div>
                                
                                <div class="dipl_color ally_2 third">
                                    <div class="blue"></div>
                                    <div class="color_text">Свой альянс</div>
                                </div>
                            </div>
                        </div>
                    </div>  
                    <div id="diplom_faq">    
                        <div id="diplom_shapka">
                            <div class="spravka">Справка</div>
                            <div class="gal_show_content">
                                <div id="faq_btn" class="gal_show_block" onclick="kliclegend();"></div><!--/show_block-->
                            </div>
                        </div>
                        <div id="faq_content">
                            <div class="nad1">Сильный игрок:</div>
                            <div class="nad2">с</div>
                            <div class="nad3">Режим отпуска:</div>
                            <div class="nad4">РО</div>
                            <div class="nad5">Неактивен более 7 дней:</div>
                            <div class="nad6">i</div>
                            <div class="nad7">Слабый игрок:</div>
                            <div class="nad8">н</div>
                            <div class="nad9">Заблокирован:</div>
                            <div class="nad10">бан</div>
                            <div class="nad11">Неактивен более 28 дней:</div>
                            <div class="nad12">I</div>        
                        </div>    
                    </div>  
                    *}
                </div>
            </div>
        </div>
    </div>
	<script type="text/javascript">
		status_ok		= '{$LNG.gl_ajax_status_ok}';
		status_fail		= '{$LNG.gl_ajax_status_fail}';
		MaxFleetSetting = {$settings_fleetactions};
	</script>
</div>
{/block}