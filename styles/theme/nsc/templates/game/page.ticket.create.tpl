{block name="title" prepend}{$LNG.ti_create_head} - {$LNG.lm_support}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/ticket.css">
<div id="page">
    <div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_flettab" style="padding-right:0;">{$LNG.ti_create_head}
                <a href="game.php?page=ticket" class="tornaindietroa">{$LNG.ti_overview}</a>
            </div>
            <div class="ticket_create_info">
                <p>{$LNG.ti_create_info}</p>
            </div>
            <form action="game.php?page=ticket&mode=send" method="post" id="form">
                <input type="hidden" name="id" value="0">
                <div class="statbarsup1" style="margin: 0px 0px 7px 7px;">
                    <table class="tablesorter ally_ranks">
                        <tbody>
                            <tr>
                                <td>
                                    <label for="category">{$LNG.ti_category}:</label> 
                                    <select id="category" name="category">
                                        <option></option>
                                        <option>{$LNG.ti_category_error}</option>
                                        <option>{$LNG.ti_category_bug}</option>
                                        <option>{$LNG.ti_category_language}</option>
                                    </select>
                                </td>
                                <td>
                                    <label for="subject" style="margin-left:20px;">{$LNG.ti_subject}:</label> 
                                    <input type="text" id="subject" name="subject" size="40" maxlength="255">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <textarea placeholder="{$LNG.ti_mess}" class="ticket_message_send_text" id="message" name="message" row="60" cols="8" style="height:100px;"></textarea>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="fleettab1" style="height: 32px;"> 
                    <button type="submit" class="rexx12">{$LNG.ti_submit}</button>
                </div>
            </form>
        </div>
    </div>
</div>
{/block}