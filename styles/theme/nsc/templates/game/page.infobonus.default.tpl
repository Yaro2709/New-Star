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
            <div class="fleettab8" style="margin-bottom: 0;"></div>
            <table class="tablesorter ally_ranks tabstatistica" style="margin-bottom:5px">
                <tbody>
                    <tr class="torneo4">
                        <th style="width: 35px;min-width: 35px;">#</th>
                        <th style="width: 85px;min-width: 85px;">{$LNG.inb_percent}</th>
                        <th style="text-align: center;min-width: 75px;width: 75px;">{$LNG.inb_units}</th>
                        <th style="text-align:center;width: 465px;">{$LNG.inb_name}</th>
                    </tr>
                    {foreach $bonus as $Element}
                    <tr class="day0 week0 classificabarra">
                        <td class="classstat1" style="text-align: center;width: 35px;max-width: 35px;min-width: 35px;">
                            <div class="barracla" style=""></div>
                            <div class="info_bonus_img"><img height="18" width="18" src="{$dpath}gebaeude/bonus/{$Element}.gif"></div>
                        </td>
                        <td class="classstat1" style="text-align: center;width: 65px;max-width: 65px;min-width: 65px;">
                            <font color="{if $USER.factor.$Element < 0}#db374b{else}#096{/if}">{($USER.factor.$Element * 100)|number}%</font>
                        </td>
                        <td class="classstat1" style="text-align: center;width: 100px;max-width: 100px;min-width: 100px;">
                            <font color="{if $USER.factor.$Element < 0}#db374b{else}#096{/if}">{($USER.factor.$Element)|number}</font>
                            <div class="barracla" style="float: left;"></div>
                            <div class="barracla" style=""></div>
                        </td>
                        <td class="classstat10" style="text-align: right;width: 405px;min-width: 405px;">{$LNG.bonus.$Element}</td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>
{/block}