{block name="title" prepend}{$LNG.lm_topkb}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/statistics.css">
<div id="page">
	<div id="content">
        <div id="ally_content" class="conteinership" style="margin-bottom: 15px;">
            <div class="gray_flettab">
                {$LNG.tkb_top}
                <span style="float:right;font-weight:100"><b>{$LNG.tkb_legende} </b> <span style="color:lime"><b>{$LNG.tkb_gewinner}</b> </span><span style="color:#FF0000"><b>{$LNG.tkb_verlierer}</b></span></span>      
            </div>
            <table class="tablesorter ally_ranks tabstatistica" style="margin-bottom:5px">
                <tbody class="row" style="padding: 7px;">
                    <tr class="row col-12 barraclass">
                        <th class="col-1">{$LNG.tkb_platz}</th>
                        <th class="col-4">{$LNG.tkb_owners}</th>
                        <th class="col-2">
                            <a href="game.php?page=battleHall&order=date&sort={if $sort == "ASC"}DESC{else}ASC{/if}"{if $order == "date"} style="font-weight:bold;"{/if}>{$LNG.tkb_datum}</a>
                        </th>
                        <th class="col-5">
                            <a href="game.php?page=battleHall&order=units&sort={if $sort == "ASC"}DESC{else}ASC{/if}"{if $order == "units"} style="font-weight:bold;"{/if}>{$LNG.tkb_units}</a>
                        </th>
                    </tr>
                    {foreach $TopKBList as $row}
                    <tr class="row col-12 mt-1 classificabarra">
                        <td class="col-1">{$row@iteration}</td>
                        <td class="col-4">
                            <a href="game.php?page=raport&amp;mode=battlehall&amp;raport={$row.rid}" target="_blank">
                                {if $row.result == "a"}
                                <span style="color:#00FF00">{$row.attacker}</span> VS <span style="color:#FF0000">{$row.defender}</span>
                                {elseif $row.result == "r"}
                                <span style="color:#FF0000">{$row.attacker}</span> VS <span style="color:#00FF00">{$row.defender}</span>
                                {else}
                                {$row.attacker} VS {$row.defender}
                                {/if}
                            </a>
                        </td>
                        <td class="col-2">{$row.date}</td>
                        <td class="col-5" style="text-align: right">{$row.units|number}</td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>
{/block}