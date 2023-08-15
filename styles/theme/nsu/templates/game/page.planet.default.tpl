{block name="title" prepend}{$LNG.lm_planet}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/planet.css">
<div id="page">
    <div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_stripe" style="margin-bottom:5px;">
                {$LNG.lm_planet}
            </div>
            <div class="ally_img">
                <table class="no_visible">
                    <tbody>
                        <tr>
                            <td>
                                <img src="{$dpath}img/title/planet.jpg" alt="*">
                                <span class="designation">
                                    <span>{$LNG.lm_planet}</span><br>
                                </span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div> 
            <div id="build_elements" class="prem_shop">
                <div class="build_box" style="height: 100%; width: 97.65%; margin-left: 1% !important;">
                    <div class="head" onclick="OpenBox('fields');">
                        {$LNG.pla_increase_in_fields}
                        <span style="color:#FC0;">{$field_max} (+{$purchased_fields})</span>
                        <span id="open_btn_fields" class="prem_open_btn">+</span>
                    </div>
                    <div id="box_fields" class="content_box">   
                        <div id="box_prem_expedition" class="content_box" style="display: block;">
                            <form action="game.php?page=planet&amp;mode=field" method="POST">
                                <img class="pren_img" alt="" title="" src="{$dpath}img/content/planet_tele.jpg">
                                <input id="type_fields" value="{$type_fields}" type="hidden">
                                <input id="power_fields" value="{$power_fields}" type="hidden">
                                <input id="purchased_fields" value="{$purchased_fields}" type="hidden">
                                <div class="content_form">
                                    + <input id="filds" name="filds" maxlength="2" size="3" onchange="Fild();" min="0" max="99" value="0" type="number">
                                    <span style="float:right;"><span style="color:#0F0; font-weight:bold;" style="color:#090;" id="cost_filds">0</span> {$LNG.tech.921}</span>
                                </div>
                                <input class="pren_btn_buy" value="{$LNG.pla_incre_ok}" type="submit">   	
                            </form>
                        </div>
                    </div>
                </div> 
                <div class="build_box" style="height: 100%; width: 97.65%; margin-left: 1% !important;">
                    <div class="head" onclick="OpenBox('diameters');">
                        {$LNG.pla_increase_in_diameter}
                        <span style="color:#FC0;">{$diameter} (+{$purchased_diameters})</span>
                        <span id="open_btn_diameters" class="prem_open_btn">+</span>
                    </div>
                    <div id="box_diameters" class="content_box">   
                        <div id="box_prem_expedition" class="content_box" style="display: block;">
                            <form action="game.php?page=planet&amp;mode=diameter" method="POST">
                                <img class="pren_img" alt="" title="" src="{$dpath}img/content/planet_dia.jpg">
                                <input id="type_diameters" value="{$type_diameters}" type="hidden">
                                <input id="power_diameters" value="{$power_diameters}" type="hidden">
                                <input id="purchased_diameters" value="{$purchased_diameters}" type="hidden">
					            <div class="content_form">
                                    + <input id="diameters" name="diameters" maxlength="2" size="3" onchange="Diameter();" min="0" max="99" value="0" type="number">          	
                                    <span style="float:right;"><span style="color:#0F0; font-weight:bold;" style="color:#090;" id="cost_diameters">0</span> {$LNG.tech.921}</span>
                                </div>
                                <input class="pren_btn_buy" value="{$LNG.pla_incre_ok}" type="submit">
                            </form>
                        </div>
                    </div>
                </div> 
                {if $planet_type == 1}
                <div class="build_box" style="height: 100%; width: 97.65%; margin-left: 1% !important;">
                    <div class="head" onclick="OpenBox('teleport');">
                        {$LNG.pla_tele_pal}
                        {if $last_relocate > TIMESTAMP}<span style="color:#F33">({$LNG.pla_tel_next} {$last_relocate_next})</span>{/if}
                        <span id="open_btn_teleport" class="prem_open_btn">+</span>
                    </div>
                    <div id="box_teleport" class="content_box" style="height:auto;"> 
                        <div id="box_prem_expedition" class="content_box" style="display: block;">
                            <form action="game.php?page=planet&amp;mode=coord" method="POST">
                                <img class="pren_img" alt="" title="" src="{$dpath}img/content/planet_field.jpg">
                                <input id="galaxy1" name="galaxy1" value="{$tGalaxy}" type="hidden">
                                <input id="system1" name="system1" value="{$tSystem}" type="hidden">
                                <input id="planet1" name="planet1" value="{$tPlanet}" type="hidden">   
                                <div class="content_form">               
                                    {$LNG.pla_tele_gal}: <input style="width:30px;" id="galaxy" min="1" max="999" name="galaxyt" onchange="TPort();" size="1" value="{$tGalaxy}" type="number">
                                    {$LNG.pla_tele_sys}: <input style="width:60px;" id="system" min="1" max="999" name="systemt" onchange="TPort();" size="3" value="{$tSystem}" type="number">
                                    {$LNG.pla_tele_pla}: <input style="width:35px;" id="planets" min="1" max="999" name="planetst" onchange="TPort();" size="1" value="{$tPlanet}" type="number">
                                    <span style="float:right;"><span style="color:#0F0; font-weight:bold;" id="cost_tp">0</span> {$LNG.tech.921}</span>
                                </div>
                                <input class="pren_btn_buy" value="{$LNG.pla_tele_sub}" type="submit">         		                	
                            </form>
                        </div>   	
                    </div>
                </div>
                {/if}
                <div class="build_box" style="height: 100%; width: 97.65%; margin-left: 1% !important;">
                    <div class="head" onclick="OpenBox('planet_rename');">
                        {$LNG.pla_new_name}
                        <span id="open_btn_planet_rename" class="prem_open_btn">+</span>
                    </div>
                    <div id="box_planet_rename" class="content_box" style="height:auto;">
                        <div style="padding:10px; color:#CCC; line-height:20px;">
                            <label for="name">{$LNG.pla_new_name} </label>
                            <input class="left" type="text" name="name" id="name" size="12" maxlength="7" autocomplete="off">
                            <label onclick="GenerateName()" style="color:#999; margin-left:3px;">{$LNG.pla_gen}</label>
                            <input type="button" style="width:175px; margin-top:6px;" onclick="checkrename()" value="{$LNG.pla_send}">
                        </div>
                    </div>
                </div>
                <div class="build_box" style="height: 100%; width: 97.65%; margin-left: 1% !important;">
                    <div class="head" onclick="OpenBox('delete_planet');">
                        <span style="color:#F33">{$LNG.pla_del}</span>
                        <span id="open_btn_delete_planet" class="prem_open_btn">+</span>            
                    </div>
                    <div id="box_delete_planet" class="content_box" style="height:auto;">
                        <div style="padding:10px; color:#CCC; line-height:20px;">
                            <span style="color:#999;">{$ov_security_confirm}</span><br />
                            <label for="password">{$LNG.pla_pass} </label><input class="left" type="password" name="password" id="password" size="25" maxlength="20" autocomplete="off">
                            <input type="button" onclick="checkcancel()" value="{$LNG.pla_send}">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
{/block}