{block name="title" prepend}{$LNG.lm_playercard}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/playerCard.css">
<body id="playerCard" class="popup" style="overflow-x: hidden;">
    <div id="body">
        <div id="popup_conteirer">
            <div id="content">
                <div id="ally_content" class="conteiner player_card" style="width:auto;">
                    <div class="gray_stripo">{$LNG.op_user_info}</div> 
                    <div class="row" style="padding: 7px">
                        <div class="col-md-12">
                            <div class="card background-border-black-gray shadow"> 
                                <div class="card-body">
                                    <div class="row" style="align-items: center; ">
                                        <div class="col-2">
                                            <img src="{$ava}" class="img-fluid float-start opacity-70 border-radius-50">
                                        </div>
                                        <div class="col-10">
                                            <div class="card">
                                                <div class="card-body">
                                                    <p class="card-title" style="font-size: 20px;">
                                                        {$name} 
                                                        {if $allyname}[<a href="#" onclick="parent.location = 'game.php?page=alliance&amp;mode=info&amp;id={$allyid}';return false;" class="playercrd17">{$allyname}</a>{else}{/if}]
                                                    </p>
                                                    <p class="card-title">
                                                        <a href="#" onclick="parent.location = 'game.php?page=galaxy&amp;galaxy={$galaxy}&amp;system={$system}';return false;">{$homeplanet} [{$galaxy}:{$system}:{$planet}]</a>
                                                    </p>
                                                    <p class="card-title">{$timezone}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="card mt-1 background-border-black-gray shadow"> 
                                <div class="card-body">
                                    <div class="row" style="align-items: center; ">
                                        <div class="col-6">
                                            <div class="card mr-1 background-border-black-blue shadow"> 
                                                <div class="card-body">
                                                    <p class="card-title text-align-center">{$LNG.lm_statistics}</p>
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
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="card background-border-black-blue shadow"> 
                                                <div class="card-body">
                                                    <p class="card-title text-align-center">{$LNG.pl_fightstats}</p>
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <p class="alleanza_zone">{$LNG.pl_fightwon}<br><span class="card-text">{$wons} ({$siegprozent}%)</span></p>
                                                        </div>
                                                        <div class="col-4">
                                                            <p class="alleanza_zone">{$LNG.pl_fightlose}<br><span class="card-text">{$loos} ({$loosprozent}%)</span></p>
                                                        </div>
                                                        <div class="col-4">
                                                            <p class="alleanza_zone">{$LNG.pl_fightdraw}<br><span class="card-text">{$draws} ({$drawsprozent}%)</span></p>
                                                        </div>
                                                    </div>
                                                    <p class="card-text">{$LNG.pl_totalfight} <span style="float: right;">{$totalfights|number}</span></p>
                                                    <p class="card-text mb-3">{$LNG.op_damage_coef} <span style="float: right;">{$damageCoef}</span></p>
                                                    <div class="alleanza12 tooltip" data-tooltip-content="{$LNG.pl_unitsshot} {$desunits}" style="width:{$damageDes}%"></div>
                                                    <div class="alleanza13 tooltip" data-tooltip-content="{$LNG.pl_unitslose} {$lostunits}" style="width:{$damageLost}%"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </div>
                </div>
            </div>
        </div>
    </div>         
</body>
{/block}