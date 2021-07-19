{block name="title" prepend}{$LNG.lm_statistics}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/statistics.css">
<div id="page">
	<div id="content">
<div id="ally_content" class="conteiner">
<div class="gray_stripo">
    {$LNG.st_statistics}  ({$LNG.st_updated}: {$stat_date}) <span class="tornaindietro">{$LNG.st_next} <span style="color:#FC0"><b id="brpstats"><b><font></font></b></b></span></span>
</div>
<div class="statbarsup1">
<form name="stats" id="stats" method="post" action="">
   <table class="tablesorter ally_ranks">
      <tr>
         <td>
            <label for="who">{$LNG.st_show}</label> <select name="who" id="who" onchange="$('#stats').submit();">{html_options options=$Selectors.who selected=$who}</select>
         </td>
         <td>
            <label for="type">{$LNG.st_per}</label> <select name="type" id="type" onchange="$('#stats').submit();">{html_options options=$Selectors.type selected=$type}</select>
         </td>
         <td>
            <label for="range">{$LNG.st_in_the_positions}</label> <select name="range" id="range" onchange="$('#stats').submit();">{html_options options=$Selectors.range selected=$range}</select>
         </td>
      </tr>
   </table>
</form>
</div>
<table class="tablesorter ally_ranks tabstatistica">
{if $who == 1}
	{include file="shared.statistics.playerTable.tpl"}
{elseif $who == 2}
	{include file="shared.statistics.allianceTable.tpl"}
{/if}
</table>
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