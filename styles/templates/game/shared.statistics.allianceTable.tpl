 <tr class="barraclass">
	<th colspan="2">{$LNG.st_position}</th>
	<th>{$LNG.st_alliance}</th>	
	<th>{$LNG.st_members}</th>
	<th style="text-align: center;padding-left: 20px;">{$LNG.st_points}</th>
	<th style="min-width:85px;">{$LNG.st_per_member}</th>
</tr>
{foreach name=RangeList item=RangeInfo from=$RangeList}
<tr class="classificabarra ">
<td class="classstat1">{$RangeInfo.rank}</td>
<td class="classstat2">{if $RangeInfo.ranking == 0}<span style='color:#87CEEB'>*</span>{elseif $RangeInfo.ranking < 0}<span style='color:red'>{$RangeInfo.ranking}</span>{elseif $RangeInfo.ranking > 0}<span style='color:green'>+{$RangeInfo.ranking}</span>{/if}</td>
<td class="classstat3">
<div class="barracla classstat4"></div>
    <a href="game.php?page=alliance&amp;mode=info&amp;id={$RangeInfo.id}" class="fbox-s-name f-eu classstat5" target="ally" {if $RangeInfo.id == $CUser_ally} style="color:lime"{/if}>
        <span>{$RangeInfo.name}</span>    	
    </a>
</td>
<td class="classstat7">{$RangeInfo.members}</td>
<td class="classstat7"></td>		
<td class="classstat8" style="text-align:right;width: 145px;max-width: 145px;min-width: 145px; padding-left: 0;"><div class="barracla" style="margin-left: 10px;"></div>{$RangeInfo.points}</td>
<td class="classstat10" style="text-align:right;width: 130px;max-width: 130px;">{$RangeInfo.mppoints}</td>
</tr>
{/foreach}