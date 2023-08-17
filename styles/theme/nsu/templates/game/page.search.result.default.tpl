{block name="content"}
<table class="tablesorter ally_ranks tabstatistica" id="resulttable">
    <tbody class="row" style="padding: 7px;">
    <tr class="row col-12 barraclass">
        <th class="col-2">{$LNG.sh_name}</th>
        <th class="col-2">{$LNG.sh_alliance}</th>
        <th class="col-3">{$LNG.sh_planet}</th>
        <th class="col-2">{$LNG.sh_coords}</th>
        <th class="col-3">{$LNG.sh_position}</th>
    </tr>
    {foreach $searchList as $searchRow}
    <tr class="row col-12 mt-1 classificabarra">
        <td class="col-2">
            <a href="#" onclick="return Dialog.Playercard({$searchRow.userid});">{$searchRow.username}</a>
        </td>
        <td class="col-2">
            {if $searchRow.allyname}
                <a href="game.php?page=alliance&amp;mode=info&amp;id={$searchRow.allyid}">{$searchRow.allyname}</a>
            {else}
                -
            {/if}
        </td>
        <td class="col-3">{$searchRow.planetname}</td>
        <td class="col-2">
            <a href="game.php?page=galaxy&amp;galaxy={$searchRow.galaxy}&amp;system={$searchRow.system}">[{$searchRow.galaxy}:{$searchRow.system}:{$searchRow.planet}]</a>
        </td>
        <td class="col-3">{$searchRow.rank}</td>
    </tr>
    {/foreach}
    </tbody>
</table>
{/block}