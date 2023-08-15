{block name="title" prepend}{$LNG.al_vlyat_ally_storage} {/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
    <div id="content">
<div id="ally_content" class="conteiner">
    <div class="gray_stripo">
    	<a href="game.php?page=alliance&amp;mode=storage" style="color:#8e9394;">{$LNG.al_storage}</a>
        <img src="{$dpath}img/iconav/arrow_right.png" alt="">
    	{$LNG.al_vlyat_ally_storage} 
		<span class="tornaindietro"><a href="game.php?page=alliance&amp;mode=storage">{$LNG.al_back}</a></span>
	</div>
    <form id="trader" action="game.php?page=alliance" method="post">
        <input type="hidden" name="mode" value="vlyatsend">
        <div class="alleanza45">
            {foreach $resourceStorage as $resourceID => $resouceData} 
            <div class="ally_contents sepor_conten res_{$resourceID}" style="background-image: url({$dpath}img/resources/{$resourceID}f.png);">
                <div class="res_text" style="margin-left: 15px;margin-top: 3px;">{$LNG.tech.$resourceID}:</div>
                <div class="res_count"><input name="{$resourceID}" id="{$resourceID}" class="trade_input" type="text" value="0" size="30"></div>
                <div class="clear"></div>
            </div>        
            {/foreach}
        </div> 
        <div class="ally_contents frax4" style="padding:0">
            <div style="float:left; margin-left:12px;margin-top: 4px;line-height: 18px;">
                <div class="res_text">{$LNG.al_summ_max}:</div>
                <div class="res_count" style="width:auto;">{$max_res|number}</div>
                <div class="clear"></div>
                <div class="res_text">{$LNG.al_summ_all}:</div>
                <div class="res_count" style="width:auto;"><span id="ress">0</span></div>
            </div>         
            <input type="submit" class="alleanza55" style="width: 50%;right: 7px;left: auto;" value="ОК">
            <div class="clear"></div>
        </div>
    </form>
</div>

{/block}
{block name="script" append}
<script type="text/javascript">
var ress1charge = 1;
var ress2charge = 1;
var ress3charge = 1;
var ress4charge = 1;
var ress5charge = 1;
var ress6charge = 1;
var ress7charge = 1;
</script>
{/block}