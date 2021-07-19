{block name="title" prepend}{$LNG.lm_notes}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/statistics.css">
<div id="ally_content" class="conteinership">
    <form action="game.php?page=notes&amp;mode=delete" method="post">
    <div class="gray_flettab" style="padding-right:0;">{$LNG.nt_notes}
        <a href="game.php?page=notes&amp;mode=detail" class="tornaindietroa">{$LNG.nt_create_new_note}</a>
    </div>
    <div class="fleettab8" style="margin-bottom: 0;"></div>
    <table class="tablesorter ally_ranks tabstatistica" style="margin-bottom: 5px;">
        <tbody>
            <tr class="torneo4">
                <th style="width: 55px; min-width: 55px;">{$LNG.nt_dlte_note}</th>
                <th style="width:155px;min-width:155px;">{$LNG.nt_date_note}</th>
                <th style="width:110px;min-width:110px;text-align: left;">{$LNG.nt_subject_note}</th>
                <th style="    width: 320px; min-width: 320px;text-align: right;">{$LNG.nt_size_note}</th>
            </tr>
            {foreach $notesList as $notesID => $notesRow}
            <tr class="classificabarra">
                <td class="classstat3" style="text-align: left;width: 45px;max-width: 45px;min-width: 45px;"><input style="height:10px;" name="delmes[{$notesID}]" type="checkbox"></td>
                <td class="classstat8" style="text-align: left;width: 160px;max-width: 160px;min-width: 160px;">{$notesRow.time}</td>
                <td class="classstat8" style="text-align: left;width: 115px;max-width: 115px;min-width: 115px;">
                    <a href="game.php?page=notes&amp;mode=detail&amp;id={$notesID}">
                        {if {$notesRow.priority} == 0}
                        <span style="color:lime">{$notesRow.title}</span>
                        {elseif {$notesRow.priority} == 2}
                        <span style="color:red">{$notesRow.title}</span>
                        {else}
                        <span style="color:yellow">{$notesRow.title}</span>
                        {/if}
                    </a>
                </td>
                <td class="classstat8 tooltip" style="text-align: right;width: 310px;max-width: 310px;min-width: 310px;overflow: hidden; white-space: nowrap;">{$notesRow.size|number}</td>
            </tr>
            {foreachelse}
            <tr class="classificabarra">
                <td colspan="4" style="width: 670px; min-width: 670px;" class="classstat3">{$LNG.nt_you_dont_have_notes}</td>
            </tr>
            {/foreach}
        </tbody>
    </table>
    <div class="alleanza57"></div>
    {foreach $notesList as $notesID => $notesRow}
    {if $notesRow@last}
    <div class="fleettab1" style="height:21px;">
        <button type="submit" class="tornaindietroa" style="border-radius: 0px 0px 4px 0px;moz-border-radius: 0px 0px 4px 0px;-webkit-border-radius: 0px 0px 4px 0px; padding-top: 0px;height: 21px;">{$LNG.nt_dlte_note}</button>
    </div>
    {/if}
    {/foreach}
</div>
{/block}