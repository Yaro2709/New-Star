{block name="title" prepend}{$LNG.lm_market}{/block}
{block name="content"}
<div id="page">
	<div id="content">
<div id="ally_content" class="conteinership ">
    <div class="gray_flettab">{$LNG.lm_market}
        <div class="gr_btn_top">
        	<a class="market_1 {if $cookie == 1}active{/if}" href="#" onclick="open_market('market_1', 1)">{$LNG.market_lot_active}</a>   
            <a class="market_2 {if $cookie == 2}active{/if}" href="#" onclick="open_market('market_2', 2)">{$LNG.market_go_lot}</a>
            <a class="market_3 {if $cookie == 3}active{/if}" href="#" onclick="open_market('market_3', 3)">{$LNG.market_you_lot}</a>
        </div>
    </div>
	<div class="fleettab8" style="margin-bottom: 0;"></div>
	
    <div id="market_conteiner">
        <div id="market_lost_msg"></div>
        <div id="market_1" class="markett2" {if $cookie == 1} style="display:block;"{else}style="display:none;"{/if}>
        {if !empty($market)}
        {foreach $market as $row}
        <div class="markett1" style="background:#000813 url({$dpath}img/content/market_{$row.class}.png) left center no-repeat;background-size: 90px;background-position-x: 10px;">
            <div class="markett3">{$row.lot}</div>
            <span class="markett4">{$row.time}</span>
            <span class="markett10">=</span>
            <div class="content_box">
                <a href="?page=market&mode=sell&id={$row.id}"><div class="markett6">{$row.price|number}</div></a>
            </div>
        </div>
        {/foreach}
        {else}
        <div class="markett1" style="background:#000813 url({$dpath}img/content/market.png) left center no-repeat;background-size: 90px;background-position-x: 10px;">
            <div class="markett3">{$LNG.market_not_lot}</div>
        </div>
        {/if}
        </div>
        <div id="market_2" class="markett2" {if $cookie == 2} style="display:block;"{else}style="display:none;"{/if}>
        {if !empty($lot)}
        <table style="width:100%;">
            <form action="?page=market&mode=add" method="post">
                {foreach $lot as $row} 	
                <div class="markett1" style="background:#000813 url({$dpath}gebaeude/{$row.id}.gif) left center no-repeat;background-size: 90px;background-position-x: 10px;">
                    <div class="markett3">{$LNG.tech.{$row.id}}</div>
                    <span class="markett4">{$row.count|number}</span>
                    <span class="markett10">+</span>
                    <div class="content_box">
                        <div class="markett60"><input name="lot{$row.id}" size="10" value="0"></div>
                    </div>
                </div>
                {/foreach}
                <div class="markett1" style="background:#000813 url({$dpath}gebaeude/{$res}.gif) left center no-repeat;background-size: 90px;background-position-x: 10px;">
                    <div class="markett3">{$LNG.market_price} {$LNG.tech.$res}</div>
                    <span style="right: 147px; position: absolute; padding: 3px;">{html_options name=class options=$class_name selected=1}</span>
                    <span class="markett10">=</span>
                    <div class="content_box">
                        <div class="markett60"><input name="price" id="price" size="10" value="0"></div>
                    </div>
                </div>
                <div class=" build_band2 ticket_bottom_band" style="height: 100%; position: initial;">    	
                    <input value="{$LNG.market_proceed}" type="submit" style="width: 98%;">
                </div>
			</form>	
        </table>
        {else}
        <div class="markett1" style="background:#000813 url({$dpath}img/content/market.png) left center no-repeat;background-size: 90px;background-position-x: 10px;">
            <div class="markett3">{$LNG.market_not_res}</div>
        </div>
        {/if}
        </div>
        <div id="market_3" class="markett2" {if $cookie == 3} style="display:block;"{else}style="display:none;"{/if}>
        {if !empty($u_lot)}
        {foreach $u_lot as $row}
        <div class="markett1" style="background:#000813 url({$dpath}img/content/market_{$row.class}.png) left center no-repeat;background-size: 90px;background-position-x: 10px;">
            <div class="markett3">{$row.lot}</div>
            <span class="markett4">{$row.time}</span>
            <span class="markett10">=</span>
            <div class="content_box">
                {if $row.time_off > $timestamp}
                <div class="markett6">-</div>
                {else}
                <a href="?page=market&mode=cancel_lot&id={$row.id}"><div class="markett61">{$LNG.market_take}</div></a>
                {/if}
            </div>
        </div>
        {/foreach}
        {else}
        <div class="markett1" style="background:#000813 url({$dpath}img/content/market.png) left center no-repeat;background-size: 90px;background-position-x: 10px;">
            <div class="markett3">{$LNG.market_not_lot_active}</div>
        </div>
        {/if}
        </div>
    </div>
</div>
</div>
</div> 
{/block}