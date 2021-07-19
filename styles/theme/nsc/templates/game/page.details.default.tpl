{block name="title" prepend}{$LNG.lm_details}{/block}
{block name="script"}
<script type="text/javascript" src="./scripts/game/price.js?v=6"></script>
{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/building.css">
<div id="page">
    <div id="content">
    {if $detailsOverview}
        <div id="ally_content" class="conteiner" style="width: 100%;">
            <div class="gray_stripe">
                {$LNG.lm_details}              
            </div>
            <div id="build_elements" class="ars_elements gov2">
                {foreach $detailsOverview as $ID => $Element}
                <div id="ofic_{$ID}" class="build_box">
                    <div class="head">               
                        {$LNG.tech.{$ID}}
                        <font class="gov6">({$LNG.bd_lvl} {$Element.level|number})</font>
                    </div>
                    <div class="content_box">
                        <div class="image_mini">
                            <img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" />
                        </div>
                        <div class="prices_mini">
                            <font color="#096">{foreach $Element.elementBonus as $BonusName => $Bonus}{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{round(abs($Bonus[0] * 100) * {sqrt($Element.level)}, 2)}%{else}{round(floatval($Bonus[0]) * {sqrt($Element.level)}, 2)}{/if} {$LNG.bonus.$BonusName}<br>{/foreach}</font>
                        </div>
                    </div>
                </div>
                {/foreach}
                <div class="clear"></div>
            </div>
        </div>
    {/if}
    <div class="clear" style="margin-top: 10px;"></div>
    {if $detailsList}
        <div id="ally_content" class="conteiner" style="width: 100%;">
            <div class="gray_stripe">
                {$LNG.lm_details} ({$LNG.st_updated}: {$stat_date}) 
                <span class="tornaindietro">{$LNG.st_next} <span style="color:#FC0"><b id="brpstats"><b><font></font></b></b></span></span>            
            </div>
            <div id="build_elements" class="officier_elements gov2">
                {foreach $detailsList as $ID => $Element}
                <div id="ofic_{$ID}" class="build_box">
                    <div class="head">
                        {$LNG.tech.{$ID}}
                        <font class="gov6">({$LNG.bd_lvl} {$Element.level|number})</font>
                    </div>
                    <div class="content_box">
                        <div class="image_mini">
                            <img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" />
                        </div>
                        <div class="prices_mini">
                            <font color="#096">
                            {foreach $Element.AllTech as $elementID => $requireList}
                                {foreach $requireList as $requireID => $NeedLevel}
                                    {$LNG.tech.$requireID} {$NeedLevel.count|number}<br>
                                {/foreach}
                            {/foreach}
                            </font>
                        </div>
                        <div class="clear"></div>
                        <form action="game.php?page=details" method="post" class="build_form">
                            <div class="time_build">
                                {foreach $Element.costResources as $RessID => $RessAmount}{$LNG.tech.{$RessID}}: 
                                <b><span id="price{$ID}" style="color:{if $Element.costOverflow[$RessID] == 0}lime{else}red{/if}">{$RessAmount|number}</span></b>
                                {/foreach}
                            </div>
                            <div class="clear"></div>
                            <div class="btn_build_border">
                            {if $Element.buyable}
                                <form action="game.php?page=details" method="post" class="build_form">
                                    <div class="clear"></div>
                                    <input name="id" value="{$ID}" type="hidden">      
                                    <div class="btn_build_border btn_build_border_left dm_btn_build_border_left">
                                        <label class="max_btn_ship">{$LNG.bd_lvl_up}</label>
                                        <div class="div_text count_ships_dots">
                                            {foreach $Element.costResources as $RessID => $RessAmount}
                                            <input id="amount{$ID}" class="text" onchange="Price{$RessID}('{$ID}', {$RessAmount});" name="amount" max="{$Element.maxLevel}" min="1" value="1" type="number">
                                            {/foreach}
                                        </div>
                                    </div>
                                    <div class="btn_build_border btn_build_border_right dm_btn_build_border_right">
                                        <button class="btn_build gubernators_form_submit" type="submit">{$LNG.bd_buy}</button>  
                                    </div>                  
                                </form>
                            {else}
                                <span class="btn_build red">{$LNG.bd_notres}</span>
                            {/if}
                            </div>
                        </form>
                        <div class="clear"></div>
                    </div>
                </div>
                {/foreach}
                <div class="clear"></div>
            </div>
        </div>
        {/if}
    </div>
</div>
<script type="text/javascript">
	v = new Date();
	var brpstats = document.getElementById('brpstats');
	function tstats(){
		n  = new Date();
		ss = {$nextStatUpdate};
		s  = ss - Math.floor( (n.getTime() - v.getTime()) / 1000);
		m  = 0;
		h  = 0;
		d  = 0;
		if ( s < 0 ) {
			   var zeit = new Date();
			var ende = zeit.getTime();
			ende = ende + 100;
		
			function countdown() {
		
				var zeit2 = new Date();
				var jetzt = zeit2.getTime();
		
				if(jetzt >= ende) {
				   brpstats.innerHTML = '<blink><b><font color=red>...</font></b></blink>';
				}
		
			}
		
			setInterval(countdown, 1000);
		} else 
		{
			   if ( s > 59 ) { m = Math.floor( s / 60 ); s = s - m * 60; }
			   if ( m > 59 ) { h = Math.floor( m / 60 ); m = m - h * 60; }
			   if ( h > 24 ) { d = Math.floor( h / 24 ); h = h - d * 24; }
			   if ( s < 10 ) { s = '0' + s }
			   if ( m < 10 ) { m = '0' + m }
			   if ( h < 10 ) { h = '' + h }
			   if ( s >= 0 ) { s = s + 's' }
			   if ( m > 0 ) { m = m + 'm' }  else m = '';
			   if ( m == 0 && h > 0 ) { m = '0' + m + 'm'}
			   if ( h > 0 ) { h = h + 'h' }  else h = '';
			   if ( d > 0 ) { d = d + 'd' }  else d = '';
		
			   brpstats.innerHTML = ' <b><font>' + d + ' ' + h + ' ' + m + ' ' + s + '</font></b>';
		}
		window.setTimeout('tstats();',999);
	}
	window.onload=tstats();
</script>
{/block}