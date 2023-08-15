<tbody class="row" style="padding: 7px;">
<tr class="row col-12 barraclass">
	<th class="col-1">{$LNG.st_position}</th>
    <th class="col-1"></th>
	<th class="col-2">{$LNG.st_alliance}</th>	
	<th class="col-2">{$LNG.st_members}</th>
	<th class="col-3">{$LNG.st_points}</th>
	<th class="col-3">{$LNG.st_per_member}</th>
</tr>
{foreach name=RangeList item=RangeInfo from=$RangeList}
<tr class="row col-12 mt-1 classificabarra">
<td class="col-1 classstat1">{$RangeInfo.rank}</td>
<td class="col-1 classstat2">{if $RangeInfo.ranking == 0}<span style='color:#87CEEB'>*</span>{elseif $RangeInfo.ranking < 0}<span style='color:red'>{$RangeInfo.ranking}</span>{elseif $RangeInfo.ranking > 0}<span style='color:green'>+{$RangeInfo.ranking}</span>{/if}</td>
<td class="col-2 classstat3">
<div class="barracla classstat4"></div>
    <a href="game.php?page=alliance&amp;mode=info&amp;id={$RangeInfo.id}" class="fbox-s-name f-eu classstat5" target="ally" {if $RangeInfo.id == $CUser_ally} style="color:lime"{/if}>
        <span>{$RangeInfo.name}</span>    	
    </a>
</td>
<td class="col-2 classstat7">{$RangeInfo.members}</td>		
<td class="col-3 classstat8"><div class="barracla" style="margin-left: 10px;"></div>{$RangeInfo.points}</td>
<td class="col-3 classstat10">{$RangeInfo.mppoints}</td>
</tr>
{/foreach}
</tbody>