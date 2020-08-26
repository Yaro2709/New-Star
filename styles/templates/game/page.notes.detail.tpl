{block name="title" prepend}{$LNG.lm_notes}{/block}
{block name="content"}
<div id="ally_content" class="conteiner">
    <div class="gray_flettab" style="padding-right:0;">{if $noteDetail.id == 0}{$LNG.nt_create_note}{else}{$LNG.nt_edit_note}{/if} <span style="color:#8e9394;">(<span id="cntChars">0</span> / 5.000{$LNG.nt_characters})</span> 
        <span class="tornaindietro" style="height: 14px;line-height: 14px;"><a style="float:right;" href="game.php?page=notes">{$LNG.nt_back}</a></span>
    </div>
    <div class="fleettab8" style="margin-bottom: 0;"></div>
    <form action="?page=notes&amp;mode=insert" method="post">
        <input type="hidden" name="id" value="{$noteDetail.id}">
        <div class="statbarsup1" style="margin: 7px 0px 7px 7px;">
            <table class="tablesorter ally_ranks">
                <tbody>
                    <tr>
                        <td>
                            <label for="priority">{$LNG.nt_priority}:</label> 
                            {html_options id=priority name=priority options=$PriorityList selected=$noteDetail.priority}
                        </td>
                        <td>
                            <label for="title">{$LNG.nt_subject_note}:</label>
                            <input id="title" placeholder="{$LNG.nt_title}" name="title" size="30" maxlength="30" value="{$noteDetail.title}" type="text">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <textarea name="text" placeholder="{$LNG.nt_text}" id="text" cols="60" rows="10" onkeyup="$('#cntChars').text($(this).val().length);">{$noteDetail.text}</textarea>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="fleettab1" style="height: 32px;"> 
            <button type="reset" class="rexx13">{$LNG.nt_reset}</button>
            <button type="submit" class="rexx12">{$LNG.nt_save}</button>
        </div>
    </form>
</div>
{/block}