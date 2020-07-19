{if !empty($FleetInfo.fleetgun)}
<div class="info2">
    {if $FleetInfo.fleetgun == 'notype'}
    <div class="info5" style="width: auto;float: left;min-width: 277px;">
        <div class="info10 info11" style="background:url({$dpath}img/information/notype.png)"></div> 
        <span class="fleettab14" style="font-size: 14px;">{$LNG.in_attack_pt}</span>
        <span class="fleettab15" style=" width: 210px;">{$FleetInfo.attack|number}</span>
    </div>
    {else}
        {if !empty($FleetInfo.fleetgun.laser.attack)}
        <div class="info5" style="width: auto;float: left;min-width: 277px;">
            <div class="info10 info11" style="background:url({$dpath}img/information/laser.jpg)"></div> 
            <span class="fleettab14" style="font-size: 14px;">{$LNG.in_attack_laser}</span>
            <span class="fleettab15" style=" width: 210px;">{$FleetInfo.fleetgun.laser.attack|number}</span>
        </div>
        {/if}
        {if !empty($FleetInfo.fleetgun.ion.attack)}
        <div class="info5" style="width: auto;float: left;min-width: 277px;">
            <div class="info10 info11" style="background:url({$dpath}img/information/ion.jpg)"></div> 
            <span class="fleettab14" style="font-size: 14px;">{$LNG.in_attack_ionic}</span>
            <span class="fleettab15" style=" width: 210px;">{$FleetInfo.fleetgun.ion.attack|number}</span>
        </div>
        {/if}
        {if !empty($FleetInfo.fleetgun.plasma.attack)}
        <div class="info5" style="width: auto;float: left;min-width: 277px;">
            <div class="info10 info11" style="background:url({$dpath}img/information/plasma.jpg)"></div> 
            <span class="fleettab14" style="font-size: 14px;">{$LNG.in_attack_buster}</span>
            <span class="fleettab15" style=" width: 210px;">{$FleetInfo.fleetgun.plasma.attack|number}</span>
        </div>
        {/if}
        {if !empty($FleetInfo.fleetgun.gravity.attack)}
        <div class="info5" style="width: auto;float: left;min-width: 277px;">
            <div class="info10 info11" style="background:url({$dpath}img/information/gravity.jpg)"></div> 
            <span class="fleettab14" style="font-size: 14px;">{$LNG.in_attack_graviton}</span>
            <span class="fleettab15" style=" width: 210px;">{$FleetInfo.fleetgun.gravity.attack|number}</span>
        </div>
        {/if}
    {/if}
</div>
{/if}
<div class="info2 info3">
    <div class="info5">
        <div class="info10 info11" style="background:url({$dpath}img/information/d_{$FleetInfo.info.class_defend}.png)"></div>  
        <span class="fleettab14" style="font-size: 14px;">{$LNG["in_armor_{$FleetInfo.info.class_defend}"]}</span>
        <span class="fleettab15" style=" width: 210px;">{$FleetInfo.structure|number}</span>
    </div>
</div>
{if $FleetInfo.info.class_shield != 's_none'}
<div class="info2 info4">
    <div class="info5">
        <div class="info10 info11" style="background:url({$dpath}img/information/s_{$FleetInfo.info.class_shield}.png)"></div>
        <span class="fleettab14" style="font-size: 14px;">{$LNG["in_shield_{$FleetInfo.info.class_shield}"]}</span>
        <span class="fleettab15" style=" width: 210px;">{$FleetInfo.shield|number}</span>
    </div>
</div>
{/if}
{if !empty($FleetInfo.tech) && !empty($FleetInfo.speed1)}
<div class="info8">
    {if $FleetInfo.tech == 1 || $FleetInfo.tech == 4}
    <div class="info9 tooltip" style="background:url({$dpath}img/information/comb.png) #000813 no-repeat left;background-size:30px;" data-tooltip-content="{$LNG.tech.115}">
    {elseif $FleetInfo.tech == 2 || $FleetInfo.tech == 5}
    <div class="info9 tooltip" style="background:url({$dpath}img/information/imp.png) #000813 no-repeat left;background-size:30px;" data-tooltip-content="{$LNG.tech.117}">
    {else}
    <div class="info9 tooltip" style="background:url({$dpath}img/information/hyper.png) #000813 no-repeat left;background-size:30px;" data-tooltip-content="{$LNG.tech.118}">
    {/if}
        <span class="fleettab14" style="font-size: 13px;top: 0px;">
            {$LNG.in_engine}
        </span>
        <span class="fleettab15 info12">{$FleetInfo.speed1|number}</span>
    </div>
    {/if}
	{if !empty($FleetInfo.consumption1)}	
    <div class="info9" style="background:url({$dpath}img/information/consumption.png) #000813 no-repeat left;background-size:30px;">
        <span class="fleettab14" style="font-size: 13px;top: 0px;">{$LNG.in_consumption}</span>
        <span class="fleettab15 info12">{$FleetInfo.consumption1|number}{if $FleetInfo.consumption1 != $FleetInfo.consumption2}({$FleetInfo.consumption2|number}){/if}</span>
    </div>
    {/if}
    {if !empty($FleetInfo.capacity)}
    <div class="info9" style="background:url({$dpath}img/information/capacity.png) #000813 no-repeat left;background-size:30px;">
        <span class="fleettab14" style="font-size: 13px;top: 0px;">{$LNG.in_capacity}</span>
        <span class="fleettab15 info12">{$FleetInfo.capacity|number}</span>
    </div> 
</div> 
{/if} 
{if !empty($FleetInfo.rapidfire.to)}	
<div class="info2 info3" style="height: auto;">
    <span class="info13">{$LNG.in_rf_again}</span>
    <div class="info14">
        {foreach $FleetInfo.rapidfire.to as $rapidfireID => $shoots}
        <div style="float: left; width: 45px;height: 45px;position: relative;">
            <span class="arsenal8 tooltip" data-tooltip-content="{$LNG.in_number}">{$shoots|number}</span>
            <img src="./styles/theme/gow/gebaeude/{$rapidfireID}.gif" alt="{$LNG.tech.$rapidfireID}" class="info7 tooltip" data-tooltip-content="{$LNG.tech.$rapidfireID}">
        </div>
        {/foreach}
    </div>
</div>
{/if}
{if !empty($FleetInfo.rapidfire.from)}    
<div class="info2 info3" style="height: auto;">
    <span class="info13">{$LNG.in_rf_from}</span>
    <div class="info14">
        {foreach $FleetInfo.rapidfire.from as $rapidfireID => $shoots}
        <div style="float: left; width: 45px;height: 45px;position: relative;">
            <span class="arsenal8 tooltip" data-tooltip-content="{$LNG.in_number}">{$shoots|number}</span>
            <img src="./styles/theme/gow/gebaeude/{$rapidfireID}.gif" alt="{$LNG.tech.$rapidfireID}" class="info7 tooltip" data-tooltip-content="{$LNG.tech.$rapidfireID}">
        </div>
        {/foreach}
    </div>
</div>
{/if}