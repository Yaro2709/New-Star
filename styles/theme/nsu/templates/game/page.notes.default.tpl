{block name="title" prepend}{$LNG.lm_notes}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/statistics.css">
<div id="ally_content" class="conteinership">
    <form action="game.php?page=notes&amp;mode=delete" method="post">
    <div class="gray_flettab" style="padding-right:0;">{$LNG.nt_notes}
        <a href="game.php?page=notes&amp;mode=detail" class="tornaindietroa">{$LNG.nt_create_new_note}</a>
    </div>
    <table class="tablesorter ally_ranks tabstatistica">
        <tbody class="row" style="padding: 7px;">
            <tr class="row col-12 barraclass">
                <th class="col-2">{$LNG.nt_dlte_note}</th>
                <th class="col-2">{$LNG.nt_date_note}</th>
                <th class="col-4">{$LNG.nt_subject_note}</th>
                <th class="col-4">{$LNG.nt_size_note}</th>
            </tr>
            {foreach $notesList as $notesID => $notesRow}
            <tr class="row col-12 mt-1 classificabarra">
                <td class="col-2">
                    <input style="height:10px;" name="delmes[{$notesID}]" type="checkbox">
                </td>
                <td class="col-2">{$notesRow.time}</td>
                <td class="col-4">
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
                <td class="col-4">
                    <a href="mailto:{$banRow.mail}" title="{$banRow.info}">{$notesRow.size|number}</a>
                </td>
            </tr>
            {foreachelse}
            <tr class="row col-12 mt-1 classificabarra">
                <td class="col-12">{$LNG.nt_you_dont_have_notes}</td>
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