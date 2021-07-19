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
            <div class="fleettab8" style="margin-bottom: 0;"></div>
            <table class="tablesorter ally_ranks tabstatistica" style="margin-bottom:5px">
                <tbody>
                    <tr class="torneo4">
                        <th style="width: 45px;min-width: 45px;">{$LNG.tkb_platz}</th>
                        <th style="text-align: center;min-width: 215px;width: 215px;">{$LNG.tkb_owners}</th>
                        <th style="text-align:center;width: 185px;"><a href="game.php?page=battleHall&order=date&sort={if $sort == "ASC"}DESC{else}ASC{/if}"{if $order == "date"} style="font-weight:bold;"{/if}>{$LNG.tkb_datum}</a></th>
                        <th style="text-align:right;width: 200px;"><a href="game.php?page=battleHall&order=units&sort={if $sort == "ASC"}DESC{else}ASC{/if}"{if $order == "units"} style="font-weight:bold;"{/if}>{$LNG.tkb_units}</a></th>
                    </tr>
                    {foreach $TopKBList as $row}
                    <tr class="day0 week0 classificabarra">
                        <td class="classstat1">{$row@iteration}</td>
                        <td class="classstat3" style="width: 200px;max-width: 200px;min-width: 200px;">
                            <div class="barracla classstat4"></div>
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
                        <td class="classstat8" style="text-align: center;width: 190px;max-width: 190px;min-width: 190px;"> 
                            <div class="barracla" style="float: left;"></div>{$row.date}
                            <div class="barracla" style=""></div>
                        </td>
                        <td class="classstat10" style="text-align: right;width: 185px;min-width: 185px;">{$row.units|number}</td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>
{/block}