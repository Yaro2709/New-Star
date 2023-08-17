{block name="content"}
<table class="tablesorter ally_ranks tabstatistica" id="resulttable">
    <tbody class="row" style="padding: 7px;">
    <tr class="row col-12 barraclass">
        <th class="col-3">{$LNG.sh_tag}</th>
        <th class="col-3">{$LNG.sh_name}</th>
        <th class="col-3">{$LNG.sh_members}</th>
        <th class="col-2">{$LNG.sh_points}</th>
    </tr>
    {foreach $searchList as $searchRow}
    <tr class="row col-12 mt-1 classificabarra">
        <td class="col-3">
            <a href="game.php?page=alliance&amp;mode=info&amp;tag={$searchRow.allytag}">{$searchRow.allytag}</a>
        </td>
        <td class="col-3">{$searchRow.allyname}</td>
        <td class="col-3">{$searchRow.allymembers}</td>
        <td class="col-2">{$searchRow.allypoints}</td>
    </tr>
    {/foreach}
    </tbody>
</table>
{/block}