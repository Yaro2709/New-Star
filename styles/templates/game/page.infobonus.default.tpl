{block name="title" prepend}{$LNG.lm_infobonus}{/block}
{block name="content"}
<div id="page">
	<div id="content">
        <div id="ally_content" class="conteinership" style="margin-bottom: 15px;">
            <div class="gray_flettab">
                {$LNG.lm_infobonus}     
            </div>
            <div class="fleettab8" style="margin-bottom: 0;"></div>
            <table class="tablesorter ally_ranks tabstatistica" style="margin-bottom:5px">
                <tbody>
                    <tr class="torneo4">
                        <th style="width: 75px;min-width: 75px;">{$LNG.inb_percent}</th>
                        <th style="text-align: center;min-width: 75px;width: 75px;">{$LNG.inb_units}</th>
                        <th style="text-align:center;width: 465px;">{$LNG.inb_name}</th>
                    </tr>
                    {foreach $bonus as $Element}
                    <tr class="day0 week0 classificabarra">
                        <td class="classstat1" style="text-align: center;width: 65px;max-width: 65px;min-width: 65px;">+{($USER.factor.$Element * 100)|number}%</td>
                        <td class="classstat1" style="text-align: center;width: 100px;max-width: 100px;min-width: 100px;">+{($USER.factor.$Element)|number}
                            <div class="barracla" style="float: left;"></div>
                            <div class="barracla" style=""></div>
                        </td>
                        <td class="classstat10" style="text-align: right;width: 465px;min-width: 465px;">{$LNG.bonus.$Element}</td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>
{/block}