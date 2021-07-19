<script type="text/javascript">
    	setInterval(function() { AJAX() }, 5000);
</script>
<script type="text/javascript" src="./scripts/game/json.js"></script>
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
            {*<div class="olistabarrabasso">
            </div>
            <a href="#" onclick="return Dialog.Galaxy();" class="oamlink pulsanti">{$LNG.bd_buy} AM<span class="oamperc">+100%</span></a>*}
            <a class="big_btn btn_menu btn_menu_big"> <div class="servertime oservertime"></div> </a>
            {if $bonus_time < TIMESTAMP}
            <a class="big_btn blue btn_menu btn_menu_big" href="game.php?page=bonus">{$LNG.lm_bonus}</a>
            {else}
            <a class="big_btn blue btn_menu btn_menu_big">{$bonus_time_rest}</a>
            {/if}
            {*<div class="separator"></div>*} 
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