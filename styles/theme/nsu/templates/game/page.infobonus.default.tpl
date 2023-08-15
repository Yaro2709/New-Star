{block name="title" prepend}{$LNG.lm_infobonus}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/statistics.css">
<div id="page">
	<div id="content">
        <div id="ally_content" class="conteinership" style="margin-bottom: 15px;">
            <div class="gray_flettab" style="padding-right:0;">
                {$LNG.lm_infobonus}
                <a href="game.php?page=overview" class="tornaindietroa">{$LNG.lm_overview}</a> 
            </div>
            <table class="tablesorter ally_ranks tabstatistica">
                <tbody class="row" style="padding: 7px;">
                    <tr class="row col-12 barraclass">
                        <th class="col-1"></th>
                        <th class="col-1">{$LNG.inb_percent}</th>
                        <th class="col-1">{$LNG.inb_units}</th>
                        <th class="col-9">{$LNG.inb_name}</th>
                    </tr>
                    {foreach $bonus as $Element}
                    <tr class="row col-12 mt-1 classificabarra">
                        <td class="col-1">
                            <div class="info_bonus_img"><img height="18" width="18" src="{$dpath}gebaeude/bonus/{$Element}.gif"></div>
                        </td>
                        <td class="col-1">
                            <font color="{if $USER.factor.$Element < 0}#db374b{else}#096{/if}">{($USER.factor.$Element * 100)|number}%</font>
                        </td>
                        <td class="col-1">
                            <font color="{if $USER.factor.$Element < 0}#db374b{else}#096{/if}">{($USER.factor.$Element)|number}</font>
                        </td>
                        <td class="col-9" style="text-align: right">
                            {$LNG.bonus.$Element}
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>
{/block}