{block name="title" prepend}{if $mode == "defense"}{$LNG.lm_defenses}{else}{$LNG.lm_shipshard}{/if}{/block}
{block name="content"}
{if !$NotBuilding}<table width="70%" id="infobox" style="border: 2px solid red; text-align:center;background:transparent"><tr><td>{$LNG.bd_building_shipyard}</td></tr></table><br><br>{/if}
{if !empty($BuildList)}
<table style="width:760px">
	<tr>
		<td class="transparent">
			<div id="bx" class="z"></div>
			<br>
			<form action="game.php?page=shipyard&amp;mode={$mode}" method="post">
			<input type="hidden" name="action" value="delete">
			<table>
			<tr>
				<th>&nbsp;</th>
			</tr>
			<tr>
				<td><select name="auftr[]" id="auftr" size="10" multiple><option>&nbsp;</option></select><br><br>{$LNG.bd_cancel_warning}<br><input type="submit" value="{$LNG.bd_cancel_send}"></td>
			</tr>
			<tr>
				<th>&nbsp;</th>
			</tr>
			</table>
			</form>
			<br><span id="timeleft"></span><br><br>
		</td>
	</tr>
</table>
<br>
{/if}

{if $NotBuilding}<div style="text-align:center; width:100%;"><input type="submit" value="{$LNG.bd_build_ships}" class="build_submit ssubmit"></div>{/if}
	{foreach $elementList as $ID => $Element}<form action="game.php?page=shipyard&amp;mode={$mode}" method="post">
<div class="floatbox">
<div  onclick="return Dialog.info({$ID})" class="floatboxpic" style="background:url('{$dpath}gebaeude/{$ID}.gif'); background-size:100% 100%;"><div style="background:rgba(13, 16, 20, 0.95); height: 30px; border-bottom: 1px solid #000; padding-left:2px; width:100%;"><a class="tooltip" data-tooltip-content="<div style='max-width:200px;'>{$LNG.shortDescription.{$ID}|replace:'"':'\''}<br><br>						{$LNG.bd_remaining|replace:'"':'\''}<br>
						{foreach $Element.costOverflow as $ResType => $ResCount}
						{$LNG.tech.{$ResType}|replace:'"':'\''}: <span style='font-weight:700'>{$ResCount|number}</span><br>
						{/foreach} </div>" style="font-weight:bold; font-size:1.1em;" href="#" onclick="return Dialog.info({$ID})">
		{$LNG.tech.{$ID}}</a><span id="val_{$ID}">{if $Element.available != 0} ({$LNG.bd_available} {$Element.available|number}){/if}</span>
			</div></div>
		<div>{$LNG.fgf_time}:
        <span style="float:right;">
                        {if $Element.elementTime < 1}
						{$LNG.buildPerSec} {$Element.perSec}
						{else}
						{$Element.elementTime|time}
						{/if}
        </span>
        </div>
		
		<div style="; height:60px; text-align:right;" >
					<span>{foreach $Element.costResources as $RessID => $RessAmount}
					<b><span style="color:{if $Element.costOverflow[$RessID] == 0}lime{else}red{/if}">{$RessAmount|number}</span></b> <img src="{$dpath}images/{$RessID}.gif" alt="{$LNG.tech.{$RessID}}" width="20" height="20"><br>
					{/foreach}</span>
					</div>
			
					{if $Element.AlreadyBuild}<div style="text-align:center; border:1px solid #000; border-radius: 5px; height:34px; background:red;"><span style="color:#fff">{$LNG.bd_protection_shield_only_one}</span></div>
					{elseif $NotBuilding && $Element.buyable} 
					<div style="text-align:center;"><input type="text" style="padding:0px; width:70px" name="fmenge[{$ID}]" id="input_{$ID}" size="{$maxlength}" maxlength="{$maxlength}" value="0" tabindex="{$smarty.foreach.FleetList.iteration}"><input style="width:90px" type="button" value="{$LNG.bd_max_ships} {$Element.maxBuildable|number}" onclick="$('#input_{$ID}').val('{$Element.maxBuildable}')">
					<input type="submit" value="{$LNG.bd_build_ships}" class="build_submit bsship" ></div>
					{/if}

	</div></form>
	{/foreach}
	


{/block}
{block name="script" append}
<script type="text/javascript">
data			= {$BuildList|json};
bd_operating	= '{$LNG.bd_operating}';
bd_available	= '{$LNG.bd_available}';
bd_perSec		= '{$LNG.perSec}';
</script>
{if !empty($BuildList)}
<script src="scripts/base/bcmath.js"></script>
<script src="scripts/game/shipyard.js"></script>
<script type="text/javascript">
$(function() {
    ShipyardInit();
});
</script>
{/if}
{/block}