<div class="build_box flethan">
    <div class="hang3">             
        <span>{$LNG.tech.{$Element.id}}</span> 
    </div>
    <div class="content_box" style="padding-right: 3px;">
        <div class="image hang2 tooltip" {if $Element.speed != 0}data-tooltip-content="{$LNG.fl_fleet_speed} {$Element.speed}"{/if}>
            <a href="#" onclick="return Dialog.info({$Element.id})"><img src="{$dpath}gebaeude/{$Element.id}.gif" alt="{$Element.id}" /></a>  
        </div>
		<div class="hang4" id="ship{$Element.id}_value">{$Element.count|number}</div>
        {if $Element.speed != 0}
		<div class="fl_fllets_rows_input_div hang1">
			<div onclick="maxShip('ship{$Element.id}');" class="maximhang">Max</div>
            <div onclick="minShip('ship{$Element.id}');" class="minimhang">Min</div>    
            <input class="countdots inputhang" name="ship{$Element.id}" id="ship{$Element.id}_input" value="0" onkeyup="getReadeble({$Element.id}); fleetPoints();">
        </div>
        {else}
        <div class="fl_fllets_rows_input_div hang1"></div>
        {/if}
    </div>
    <div class="clear"></div>
</div>