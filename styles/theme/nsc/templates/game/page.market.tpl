{block name="title" prepend}{$LNG.lm_market}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/market.css">
<div id="page">
	<div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_flettab">{$LNG.lm_market}
                <div class="gr_btn_top">
                    <a class="market_1 {if $cookie == 1}active{/if}" href="#" onclick="open_market('market_1', 1)">{$LNG.market_lot_active}</a>   
                    <a class="market_2 {if $cookie == 2}active{/if}" href="#" onclick="open_market('market_2', 2)">{$LNG.market_go_lot}</a>
                    <a class="market_3 {if $cookie == 3}active{/if}" href="#" onclick="open_market('market_3', 3)">{$LNG.market_you_lot}</a>
                </div>
            </div>
            <div class="fleettab9" style="margin-bottom:5px"></div>
            <div id="market_1" class="markett_conteiner" {if $cookie == 1} style="display:block;"{else}style="display:none;"{/if}>
            {if !empty($market)}
            {foreach $market as $row}
                <div class="market_rows">
                    <div class="market_img_utits">
                        <img alt="" src="{$dpath}img/content/market_{$row.class}.png">
                    </div>
                    <div class="market_name_utits">
                        <span style="color:#6C6;">{$row.lot}</span>
                    </div>
                    <div class="count_blocks">
                        <span style="color:#FC6;float:right;">{$row.time}</span>     
                    </div>
                    <div class="market_button">
                        <a href="?page=market&mode=sell&id={$row.id}">
                            <button type="button" class="button_red">{$row.price|number} {$LNG.tech.$res}</button>
                        </a>
                    </div>
                </div>
            {/foreach}
            {else}
                <div class="market_rows">
                    <div class="market_img_utits">
                        <img alt="" src="{$dpath}img/content/market.png">
                    </div>
                    <div class="market_name_utits">
                        <span style="color:#6C6;">{$LNG.market_not_lot}</span>
                    </div>
                </div>
            {/if}
            </div>
            <div id="market_2" class="markett_conteiner" {if $cookie == 2} style="display:block;"{else}style="display:none;"{/if}>
            {if !empty($lot)}
                <form action="?page=market&mode=add" method="post">
                    {foreach $lot as $row} 	
                    <div class="market_rows">
                        <div class="market_img_utits">
                            <img alt="" src="{$dpath}gebaeude/{$row.id}.gif">
                        </div>
                        <div class="market_name_utits">
                            <span style="color:#6C6;">{$LNG.tech.{$row.id}}</span>
                        </div>
                        <div class="count_blocks">
                            <span style="color:#FC6;float:right;">{$row.count|number}</span>     
                        </div>
                        <div class="market_button">
                            <input class="input_light_blue" name="lot{$row.id}" type="number" min="0" value="0">
                        </div>
                    </div>
                    {/foreach}
                    <div class="market_rows">
                        <div class="market_img_utits">
                            <img alt="" src="{$dpath}gebaeude/{$res}.gif">
                        </div>
                        <div class="market_name_utits">
                            <span style="color:#6C6;">{$LNG.market_price} {$LNG.tech.$res}</span>
                        </div>
                        <div class="count_blocks">
                            <span style="color:#FC6;float:right;"></span>     
                        </div>
                        <div class="market_total_button">
                            {html_options name=class options=$class_name selected=1 class="select_light_blue"}
                            <input name="price" id="price" size="10" value="0" class="input_light_blue" type="number" min="0">
                            <input class="button_light_blue" type="submit" value="{$LNG.market_proceed}">
                        </div>
                    </div>
                </form>
            {else}
                <div class="market_rows">
                    <div class="market_img_utits">
                        <img alt="" src="{$dpath}img/content/market.png">
                    </div>
                    <div class="market_name_utits">
                        <span style="color:#6C6;">{$LNG.market_not_res}</span>
                    </div>
                </div>
            {/if}
            </div>
            <div id="market_3" class="markett_conteiner" {if $cookie == 3} style="display:block;"{else}style="display:none;"{/if}>
            {if !empty($u_lot)}
            {foreach $u_lot as $row}
                <div class="market_rows">
                    <div class="market_img_utits">
                        <img alt="" src="{$dpath}img/content/market_{$row.class}.png">
                    </div>
                    <div class="market_name_utits">
                        <span style="color:#6C6;">{$row.lot}</span>
                    </div>
                    <div class="count_blocks">
                        <span style="color:#FC6;float:right;">{$row.time}</span>     
                    </div>
                    <div class="market_button">
                        {if $row.time_off > $timestamp}
                        <button type="button" class="button_red">{$LNG.market_take}</button>
                        {else}
                        <a href="?page=market&mode=cancel_lot&id={$row.id}">
                            <button type="button" class="button_dark_blue">{$LNG.market_take}</button>
                        </a>
                        {/if}
                    </div>   
                </div>
            {/foreach}
            {else}
                <div class="market_rows">
                    <div class="market_img_utits">
                        <img alt="" src="{$dpath}img/content/market.png">
                    </div>
                    <div class="market_name_utits">
                        <span style="color:#6C6;">{$LNG.market_not_lot_active}</span>
                    </div>
                </div>
            {/if}
            </div>
        </div>
    </div>
</div> 
{/block}