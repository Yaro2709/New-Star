{block name="title" prepend}{$LNG.al_issue_ally_storage}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
    <div id="content">
<div id="ally_content" class="conteiner">
    <div class="gray_stripo">
    	<a href="game.php?page=alliance&amp;mode=storage" style="color:#8e9394;">{$LNG.al_storage}</a>
        <img src="{$dpath}img/iconav/arrow_right.png" alt="">
    	{$LNG.al_issue_ally_storage}  
		<div class="tornaindietro"><a href="game.php?page=alliance&amp;mode=storage">{$LNG.al_back}</a></div> 
	</div>
    <form id="trader" action="game.php?page=alliance" method="post">
        <input type="hidden" name="mode" value="admin">
        <input type="hidden" name="action" value="issue_send">
        <div class ="alleanza45">
            <select name="id_u" size="20" style="width: 685px;height: 100px;clear: both;margin: 7px;">
                {$Userlist}
            </select>            
            <script type="text/javascript">
                var UserList = new filterlist(document.getElementsByName('id_u')[0]);
            </script>
            <input name="regexp" style="width: 540px;margin: 7px;margin-top: 0;" onKeyUp="UserList.set(this.value)">
            <input type="button" onClick="UserList.set(this.form.regexp.value)" value="Фильтр">
            <input type="button" onClick="UserList.reset();this.form.regexp.value=''" value="Отменить">
            <div class="clear" style="margin-bottom:5px;"></div>
        </div>
        <div class ="alleanza45">
            <table class="tablesorter ally_ranks gray_stripe_th td_border_bottom">
            <tr>
                <th style="border-left:0;"></th>
                <th><span id="ress">0</span></th>
                <th>{$LNG.al_in_storage}</th>
            </tr>
            {foreach $resourceStorage as $resourceID => $resouceData}   
            <tr>
                <td style="text-align:left; padding-left:15px;"><label for="{$resourceID}" style="color:#6C6;">{$LNG.tech.$resourceID}</label></td>
                <td><input name="{$resourceID}" style="color:#6C6; width:98%;" id="{$resourceID}" class="trade_input" type="text" value="0" size="30"></td>
                <td><label for="{$resourceID}" style="color:#6C6;" class="tooltip" data-tooltip-content="{$ally_metal|number}">{$resouceData.current|number}</label></td>
            </tr>
            {/foreach}
            </table>
            <div class="clear" style="margin-top:5px"></div>
            <input type="submit" class="alleanza46" style="width:687px" value="ОК">
            <div class="clear" style="margin-bottom:5px"></div>
        </div>
    </form>
</div>
</div>

{/block}
{block name="script" append}
<script type="text/javascript">
var ress1charge = 1;
var ress2charge = 1;
var ress3charge = 1;
</script>
{/block}