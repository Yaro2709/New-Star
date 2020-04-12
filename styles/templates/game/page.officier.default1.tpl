{block name="title" prepend}{$LNG.lm_officiers}{/block}
{block name="content"}
{if !empty($darkmatterList)}
<div onclick="tabse(this,'tab0');" id="but0" class="active">{$of_dm_trade}</div>
{if $officierList}
<div onclick="tabse(this,'tab1');"  class="inactive">{$LNG.of_offi}</div>
{/if}<br></br>
<div id="tab0"  class="activetab">
	{foreach $darkmatterList as $ID => $Element}
	<div style=" border-radius: 5px; width:172px; margin:5px; border:1px solid #000;  float:left; background:rgba(0,0,0,0.95);">
		<div  onclick="return Dialog.info({$ID})" style=" width:172px; height:172px; background:url('{$dpath}gebaeude/{$ID}.gif'); background-size:100% 100%;">
			<div style="background:rgba(13, 16, 20, 0.95); width:100%;">
				<a class="tooltip" data-tooltip-content="
				<div style='max-width:200px;'>
					{$LNG.shortDescription.{$ID}|replace:'"':'\''}<br><br>
					{foreach $Element.elementBonus as $BonusName => $Bonus}{if $Bonus@iteration % 3 === 1}
					<p>{/if}{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{abs($Bonus[0] * 100)}%{else}{$Bonus[0]}{/if} {$LNG.bonus.$BonusName}{if $Bonus@iteration % 3 === 0 || $Bonus@last}</p>
					{else}&nbsp;{/if}{/foreach}
				</div>
				" style="font-weight:bold; font-size:1.1em;" href="#" onclick="return Dialog.info({$ID})">{$LNG.tech.{$ID}}<br>
				</a>
			</div>
		</div>
		<div>{$LNG.in_dest_durati}:<span style="float:right;">{$Element.time|time}</span></div>
		<br>
		<div style="; height:20px; text-align:right;" >
			<span>{foreach $Element.costResources as $RessID => $RessAmount}
			<b><span style="color:{if $Element.costOverflow[$RessID] == 0}lime{else}red{/if}">{$RessAmount|number}</span></b> <img src="{$dpath}images/{$RessID}.gif" alt="{$LNG.tech.{$RessID}}" width="20" height="20"><br>
			{/foreach}</span>
		</div>
		<div style="text-align:center; border:1px solid #000; border-radius: 5px; height:34px;
			{if $Element.timeLeft > 0}
			{$LNG.of_still}
			background:green;">
			<span style="color:#fff" id="time_{$ID}">-</span>
			{$LNG.of_active}
			{if $Element.buyable}
			<form action="game.php?page=officier" method="post" class="build_form">
				<input type="hidden" name="id" value="{$ID}">
				<button type="submit" class="build_submit">{$LNG.of_recruit}</button>
			</form>
			{/if}
			{elseif $Element.buyable}
			background:green;">
			<form action="game.php?page=officier" method="post" class="build_form">
				<input type="hidden" name="id" value="{$ID}">
				<button type="submit" class="build_submit">{$LNG.of_recruit}</button>
			</form>
			{else}
			background:red;"><span style="color:#fff">{$LNG.of_recruit}</span>
			{/if}
		</div>
	</div>
	{/foreach}
</div>
{/if}
{if $officierList}
<div id="tab1"  class="inactivetab">
	{foreach $officierList as $ID => $Element}
	<div style=" border-radius: 5px; width:172px; margin:5px; border:1px solid #000;  float:left; background:rgba(0,0,0,0.95);">
		<div  onclick="return Dialog.info({$ID})" style=" width:172px; height:172px; background:url('{$dpath}gebaeude/{$ID}.jpg'); background-size:100% 100%;">
			<div style="background:rgba(13, 16, 20, 0.95); width:100%;">
				<a class="tooltip" data-tooltip-content="
				<div style='max-width:200px;'>
					{$LNG.shortDescription.{$ID}|replace:'"':'\''}<br><br>
					{foreach $Element.elementBonus as $BonusName => $Bonus}{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{abs($Bonus[0] * 100)}%{else}{floatval($Bonus[0])}{/if} {$LNG.bonus.$BonusName|replace:'"':'\''}<br>{/foreach}</p>
				</div>
				" style="font-weight:bold; font-size:1.1em;" href="#" onclick="return Dialog.info({$ID})">{$LNG.tech.{$ID}|replace:'"':'\''}<br>
				({$LNG.of_lvl} {$Element.level}/{$Element.maxLevel})
				</a>
			</div>
		</div>
		<div><span style="float:right;"></span></div>
		<div style="; height:20px; text-align:right;" >
			<span>{foreach $Element.costResources as $RessID => $RessAmount}
			<b><span style="color:{if $Element.costOverflow[$RessID] == 0}lime{else}red{/if}">{$RessAmount|number}</span></b> <img src="{$dpath}images/{$RessID}.gif" alt="{$LNG.tech.{$RessID}}" width="20" height="20"><br>
			{/foreach}</span>
		</div>
		<div style="text-align:center; border:1px solid #000; border-radius: 5px; height:34px;
			{if $Element.maxLevel <= $Element.level}
			background:red;">
			<span style="color:#fff">{$LNG.bd_maxlevel}</span>
			{elseif $Element.buyable}
			background:green;">
			<form action="game.php?page=officier" method="post" class="build_form">
				<input type="hidden" name="id" value="{$ID}">
				<button type="submit" class="build_submit">{$LNG.of_recruit}</button>
			</form>
			{else}
			background:red;"><span style="color:#fff">{$LNG.of_recruit}</span>
			{/if}
		</div>
	</div>
	{/foreach}
</div>
{/if}<script>
	var aclass = document.getElementById('but0');
	var atab = document.getElementById('tab0');
</script>
{/block}
{block name="script"}
<script src="scripts/game/officier.js"></script>
{/block}