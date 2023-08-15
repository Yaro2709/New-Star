{block name="title" prepend}{$LNG.lm_fleet}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/fleetTable.css">
<div id="page">
	<div id="content">
        <div id="ally_content" class="conteiner">
            <form action="game.php?page=fleetStep3" method="post">
            <input type="hidden" name="token" value="{$token}">  
                <div class="gray_stripo">
                {$LNG.fl_mission} 
                    <span class="tornaindietro fleetstep2-31">
                        <span class="fleetstep2-3">{$LNG.fl_resources} <a style="float:right; color:#666;" href="javascript:maxResources()">Все ресурсы</a></span>
                    </span>
                </div>
                <div class="fleetstep2-2">
                    <div class="fl_mission_selector">
                        {foreach $MissionSelector as $MissionID}
                        <div class="fl_mission_selector_row">
                           <input {if $MissionID == 18}onclick="ListSector()"{/if} id="radio_{$MissionID}" {if $mission == $MissionID} checked {/if}type="radio" name="mission" value="{$MissionID}">
                           <label {if $MissionID == 18}onclick="ListSector()"{/if} class="i-miss{$MissionID}o" for="radio_{$MissionID}">{$LNG["type_mission_{$MissionID}"]}</label>
                        </div>
                        {if $MissionID == 18}
                        <div class="fl_mission_selector_caution">{$LNG.fl_expedition_alert_message}</div>
                        {/if}
                        {if $MissionID == 11}
                        <div class="fl_mission_selector_caution">{$LNG.fl_dm_alert_message}</div>
                        {/if}
                        {/foreach}
                    </div>
			        <div class="fleetstep2-1">	
                        <div class="fl_res_rows_input_div">
                            <img class="fl_res_rows_ico_img" alt="{$LNG.met}"  title="{$LNG.met}" src="{$dpath}img/resources/901f.png" />
                            <div onclick="minResource('metal');" class="fl_res_rows_input_min">Min</div>
                            <div onclick="maxResource('metal');" class="fl_res_rows_input_max">Max</div>
                            <input class="countdots fl_res_rows_input_countdots" name="metal" onchange="calculateTransportCapacity();" type="text">
                        </div>
                        <div class="fl_res_rows_input_div">
                            <img class="fl_res_rows_ico_img" alt="{$LNG.cry}"  title="{$LNG.cry}" src="{$dpath}img/resources/902f.png" />
                            <div onclick="minResource('crystal');" class="fl_res_rows_input_min">Min</div>
                            <div onclick="maxResource('crystal');" class="fl_res_rows_input_max">Max</div>
                            <input class="countdots fl_res_rows_input_countdots" name="crystal" onchange="calculateTransportCapacity();" type="text">
                        </div>
                        <div class="fl_res_rows_input_div">
                            <img class="fl_res_rows_ico_img" alt="{$LNG.det}"  title="{$LNG.det}" src="{$dpath}img/resources/903f.png" />
                            <div onclick="minResource('deuterium');" class="fl_res_rows_input_min">Min</div>
                            <div onclick="maxResource('deuterium');" class="fl_res_rows_input_max">Max</div>
                            <input class="countdots fl_res_rows_input_countdots" name="deuterium" onchange="calculateTransportCapacity();" type="text">
                        </div>
                        <span class="fleetstep2-4">{$LNG.fl_cargo_remainin}: <span id="remainingresources"><font color="lime">-</font></span></span>
                        <span class="fleetstep2-5">{$LNG.fl_fuel_consumption}: 
                            <span style="color:#096;">{pretty_number($consumption)}</span>
                            <span id="consumption" class="consumption" style="display:none;">{pretty_number($consumption)}</span>
                        </span>	
                    </div>
                    {if $StaySelector}                   
					<span class="fleetstep2-6">{$LNG.fl_hold_time} {html_options name=staytime options=$StaySelector}</span>
                    {/if}
                    <div {if $mission != 18} style="display:none;"{/if} id="listsector">
                        {foreach $Sector as $IDSector => $rowSector}
                        <div class="label_sector">
                            <input type="radio" name="sectors" id="sector_{$IDSector}" value="{$IDSector}" class="tooltip" data-tooltip-content="{$LNG.fl_enemy_text.$IDSector}"/>
                            <label for="sector_{$IDSector}" class="tooltip" data-tooltip-content="{$LNG.fl_enemy_text.$IDSector}">{$rowSector}</label>
                        </div>
                        {/foreach}    
                    </div>
                    <script type="text/javascript">
                        data	= {$fleetdata|json};
                        function ListSector()
                        {
                            $('#listsector').show();
                        }
                    </script>
                </div> 
                <div class="alleanza57" style="margin-top: -1px;"></div>
                <div class="fleettab1" style="height:52px;">
                    <input class="fl_bigbtn_go" type="submit" value="{$LNG.fl_continue}">
                </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">
    data	= {$fleetdata|json};
</script>
{/block}