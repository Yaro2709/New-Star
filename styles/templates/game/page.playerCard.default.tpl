{block name="title" prepend}{$LNG.lm_playercard}{/block}
{block name="content"}
<body id="playerCard" class="popup" style="overflow-x: hidden;">
    <div id="body">
        <div id="popup_conteirer">
            <div id="content">
                <div id="ally_content" class="conteiner player_card" style="width:auto;">
                    <div class="gray_stripo">{$LNG.op_user_info}</div> 
                    <div class="playercrd3">
                        <span class="playercrd14"> {$name} 
                            {if $allyname}<a href="#" onclick="parent.location = 'game.php?page=alliance&amp;mode=info&amp;id={$allyid}';return false;" class="playercrd17">{$allyname}</a>{else}{/if}
                        </span>
                        <span class=" f-ru playercrd13"></span>
                        <img src="{$ava}" class="playercrd4 tooltip" data-tooltip-content="{$name}">
                        <a href="#" onclick="parent.location = 'game.php?page=galaxy&amp;galaxy={$galaxy}&amp;system={$system}';return false;" class="playercrd5">{$homeplanet} [{$galaxy}:{$system}:{$planet}]</a>
                        <p class="playercrd10">{$LNG.op_timezone} <span style="color: #8b99b0;">{$timezone}</span></p>
                        <div class="clear"></div>
                        {*if $id != $yourid}
                        <a style="position: absolute;right:68px;top:3px;" href="#" onclick="return Dialog.PM({$id});" title="{$LNG.pl_message}"><img src="../styles/images/iconav/messages.png" height="20px" class="messagesnew4"></a>
                        <a style="position: absolute;right:35px;top:0px;" target="_parent" href="/game.php?page=buddyList&amp;mode=addenemies&amp;id=255414" title="Добавить в список врагов"><img src="../styles/images/iconav/enemiess.png" height="25px" class="messagesnew4"></a>
                        <a style="position: absolute;right:7px;top:0px;" href="#" onclick="return Dialog.Buddy({$id})" title="{$LNG.pl_buddy}"><img src="../styles/images/iconav/friendd.png" height="25px" class="messagesnew4"></a>
                        {/if*}
                    </div>  
                    <div class="clear"></div>
                    <div class="alleanza1" style="width:275px;margin-right:0">	
                        <span class="alleanza5">{$LNG.lm_statistics} </span>	
                        <table class="tablesorter ally_ranks playercard_tables">
                            <tbody>
                                <tr class="playercrd2">
                                    <td style="text-align: left;">{$LNG.pl_builds}</td>
                                    <td>{$build_points}</td>
                                    <td style="font-weight:bold">#{$build_rank}</td>
                                </tr>
                                <tr class="playercrd2">
                                    <td style="text-align: left;">{$LNG.pl_tech}</td>
                                    <td>{$tech_points}</td>	
                                    <td style="font-weight:bold">#{$tech_rank}</td>	
                                </tr>
                                <tr class="playercrd2">
                                    <td style="text-align: left;">{$LNG.pl_fleet}</td>
                                    <td>{$fleet_points}</td>
                                    <td style="font-weight:bold">#{$fleet_rank}</td>		
                                </tr>
                                <tr class="playercrd2"> 
                                    <td style="text-align: left;">{$LNG.pl_def}</td>
                                    <td>{$defs_points}</td>	
                                    <td style="font-weight:bold">#{$defs_rank}</td>	
                                </tr>
                                <tr class="playercrd2">
                                    <td style="text-align: left;">{$LNG.pl_total}</td>
                                    <td>{$total_points}</td>	
                                    <td style="font-weight:bold">#{$total_rank}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="alleanza1" style="float:right">
                        <span class="alleanza5">{$LNG.pl_fightstats}</span>
                        <p class="alleanza7">{$LNG.pl_fightwon}<br><span class="alleanza6">{$wons} ({$siegprozent}%)</span></p>
                        <p class="alleanza8">{$LNG.pl_fightlose}<br><span class="alleanza6">{$loos} ({$loosprozent}%)</span></p>
                        <p class="alleanza9">{$LNG.pl_fightdraw}<br><span class="alleanza6">{$draws} ({$drawsprozent}%)</span></p>
                        <p class="alleanza10">{$LNG.pl_totalfight} <span style="float: right;">{$totalfights}</span></p>
                        <p class="alleanza11">{$LNG.op_damage_coef} <span style="float: right;">{$damageCoef}</span></p>
                        <div class="alleanza12 tooltip" data-tooltip-content="{$LNG.pl_unitsshot} {$desunits}" style="width:{$damageDes}%"></div>
                        <div class="alleanza13 tooltip" data-tooltip-content="{$LNG.pl_unitslose} {$lostunits}" style="width:{$damageLost}%"></div>
                    </div>
                    <div class="clear"></div>    
                </div>
            </div>
        </div>
    </div>         
</body>
{/block}