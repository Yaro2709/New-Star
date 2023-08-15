{$count = count($productionTable.usedResource)}
<table class="tablesorter ally_ranks tabagg">
    <tbody>
        <tr>
            <th class="gray_stripo info1" colspan="1"></th>
            {foreach $productionTable.usedResource as $resourceID}
                <th class="gray_stripo info1 colore{$resourceID}" colspan="2"><img src="{$dpath}img/resources/{$resourceID}f.png">{$LNG.tech.$resourceID}</th>
            {/foreach}
        </tr>
        <tr>
            <th class="gray_stripo info1">{$LNG.in_level}</th>
            {foreach $productionTable.usedResource as $resourceID}
                <th class="gray_stripo info1">{$LNG.in_prod_p_hour}</th>
                <th class="gray_stripo info1">{$LNG.in_difference}</th>
            {/foreach}
        </tr>
        {foreach $productionTable.production as $elementLevel => $productionData}
		<tr>
			<td><span{if $CurrentLevel == $elementLevel} style="color:#ff0000"{/if}>{$elementLevel}</span></td>
			{foreach $productionData as $resourceID => $production}
			{$productionDiff = $production - $productionTable.production.$CurrentLevel.$resourceID}
			<td><span style="color:{if $production > 0}#08c708{elseif $production < 0}#ff4343{else}#ccc{/if}">{$production|number}</span></td>
			<td><span style="color:{if $productionDiff > 0}#08c708{elseif $productionDiff < 0}#ff4343{else}#ccc{/if}">{$productionDiff|number}</span></td>
			{/foreach}
		</tr>
		{/foreach} 
    </tbody>
</table>