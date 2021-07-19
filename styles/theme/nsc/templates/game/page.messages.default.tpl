{block name="title" prepend}{$LNG.lm_messages}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/messages.css">
<div id="page">
	<div id="content">
<div id="ally_content" class="conteiner">
	<div id="achivment">
		<div class="ach_main_block" style="border:0">
			<div class="gray_flettab">
				{$LNG.mg_overview}<span id="loading" style="display:none;"> ({$LNG.loading})</span>
			</div>
			<div class="ach_main_content">               
				<div class="ach_menu" style="min-height: 374px;">
					<ul>    
                            {foreach $CategoryList as $CategoryID => $CategoryRow}
                                <li class="skils1 deactive" style="height:28px;">
                                    <a href="#" onclick="Message.getMessages({$CategoryID});return false;" class="planet1 messagesnew5" id="mes_{$CategoryID}" style="background-image:url({$dpath}img/iconav/mes_{$CategoryID}.png);color:{$CategoryRow.color};">{$LNG.mg_type.{$CategoryID}} <span id="unread_{$CategoryID}">{$CategoryRow.unread}</span>/<span id="total_{$CategoryID}">{$CategoryRow.total}</span></a>
                                </li>
                            {/foreach}            
					</ul> 
				</div>
                <div id="mes_viw" style="margin-left: 176px"></div>
				
{/block}