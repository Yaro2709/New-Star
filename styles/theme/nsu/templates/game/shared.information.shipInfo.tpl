{if !empty($FleetInfo.fleetgun)}
<div class="row background-border-black-gray m-1">
    {if $FleetInfo.fleetgun == 'notype'}
    <div class="col-6">
        <div class="card m-1 background-border-black-blue shadow"> 
            <div class="card-body">
                <div class="card-img-left opacity-70" style="background:url({$dpath}img/information/notype.png)"></div> 
                <p class="card-title text-align-right">{$LNG.in_attack_pt}</p>
                <p class="card-text text-align-right gradient-gray">{$FleetInfo.attack|number}</p>
            </div>
        </div>
    </div>
    {else}
    {if !empty($FleetInfo.fleetgun.laser.attack)}
    <div class="col-6">
        <div class="card m-1 background-border-black-blue shadow"> 
            <div class="card-body">
                <div class="card-img-left opacity-70" style="background:url({$dpath}img/information/laser.jpg)"></div> 
                <p class="card-title text-align-right">{$LNG.in_attack_laser}</p>
                <p class="card-text text-align-right gradient-gray">{$FleetInfo.fleetgun.laser.attack|number}</p>
            </div>
        </div>
    </div>
    {/if}
    {if !empty($FleetInfo.fleetgun.ion.attack)}
    <div class="col-6">
        <div class="card m-1 background-border-black-blue shadow"> 
            <div class="card-body">
                <div class="card-img-left opacity-70" style="background:url({$dpath}img/information/ion.jpg)"></div> 
                <p class="card-title text-align-right">{$LNG.in_attack_ionic}</p>
                <p class="card-text text-align-right gradient-gray">{$FleetInfo.fleetgun.ion.attack|number}</p>
            </div>
        </div>
    </div>
    {/if}
    {if !empty($FleetInfo.fleetgun.plasma.attack)}
    <div class="col-6">
        <div class="card m-1 background-border-black-blue shadow"> 
            <div class="card-body">
                <div class="card-img-left opacity-70" style="background:url({$dpath}img/information/plasma.jpg)"></div> 
                <p class="card-title text-align-right">{$LNG.in_attack_buster}</p>
                <p class="card-text text-align-right gradient-gray">{$FleetInfo.fleetgun.plasma.attack|number}</p>
            </div>
        </div>
    </div>        
    {/if}
    {if !empty($FleetInfo.fleetgun.gravity.attack)}
    <div class="col-6">
        <div class="card m-1 background-border-black-blue shadow"> 
            <div class="card-body">
                <div class="card-img-left opacity-70" style="background:url({$dpath}img/information/gravity.jpg)"></div> 
                <p class="card-title text-align-right">{$LNG.in_attack_graviton}</p>
                <p class="card-text text-align-right gradient-gray">{$FleetInfo.fleetgun.gravity.attack|number}</p>
            </div>
        </div>
    </div>
    {/if}
    {/if}
</div>
{/if}
<div class="row background-border-black-gray m-1">
    <div class="col-6">
        <div class="card m-1 background-border-black-blue shadow"> 
            <div class="card-body">
                <div class="card-img-left opacity-70" style="background:url({$dpath}img/information/d_{$FleetInfo.info.class_defend}.png)"></div> 
                <p class="card-title text-align-right">{$LNG["in_armor_{$FleetInfo.info.class_defend}"]}</p>
                <p class="card-text text-align-right gradient-gray">{$FleetInfo.structure|number}</p>
            </div>
        </div>
    </div>
    {if $FleetInfo.info.class_shield != 's_none'}
    <div class="col-6">
        <div class="card m-1 background-border-black-blue shadow"> 
            <div class="card-body">
                <div class="card-img-left opacity-70" style="background:url({$dpath}img/information/s_{$FleetInfo.info.class_shield}.png)"></div> 
                <p class="card-title text-align-right">{$LNG["in_shield_{$FleetInfo.info.class_shield}"]}</p>
                <p class="card-text text-align-right gradient-gray">{$FleetInfo.shield|number}</p>
            </div>
        </div>
    </div>
    {/if}
</div>
{if !empty($FleetInfo.tech) && !empty($FleetInfo.speed1)}
<div class="row background-border-black-gray m-1">
    <div class="col-4">
        <div class="card m-1 background-border-black-blue shadow"> 
            <div class="card-body">
                {if $FleetInfo.tech == 1 || $FleetInfo.tech == 4}
                <div class="card-img-left opacity-70 tooltip" style="background:url({$dpath}img/information/comb.png)" data-tooltip-content="{$LNG.tech.115}"></div> 
                {elseif $FleetInfo.tech == 2 || $FleetInfo.tech == 5}
                <div class="card-img-left opacity-70 tooltip" style="background:url({$dpath}img/information/imp.png)" data-tooltip-content="{$LNG.tech.117}"></div> 
                {else}
                <div class="card-img-left opacity-70 tooltip" style="background:url({$dpath}img/information/hyper.png)" data-tooltip-content="{$LNG.tech.118}"></div> 
                {/if} 
                <p class="card-title text-align-right">{$LNG.in_engine}</p>
                <p class="card-text text-align-right gradient-gray">{$FleetInfo.speed1|number}</p>
            </div>
        </div>
    </div>
    {if !empty($FleetInfo.consumption1)}
    <div class="col-4">
        <div class="card m-1 background-border-black-blue shadow"> 
            <div class="card-body">
                <div class="card-img-left opacity-70" style="background:url({$dpath}img/information/consumption.png)"></div> 
                <p class="card-title text-align-right">{$LNG.in_consumption}</p>
                <p class="card-text text-align-right gradient-gray">{$FleetInfo.consumption1|number}{if $FleetInfo.consumption1 != $FleetInfo.consumption2}({$FleetInfo.consumption2|number}){/if}</p>
            </div>
        </div>
    </div>
    {/if}
    {if !empty($FleetInfo.capacity)}
    <div class="col-4">
        <div class="card m-1 background-border-black-blue shadow"> 
            <div class="card-body">
                <div class="card-img-left opacity-70" style="background:url({$dpath}img/information/capacity.png)"></div> 
                <p class="card-title text-align-right">{$LNG.in_capacity}</p>
                <p class="card-text text-align-right gradient-gray">{$FleetInfo.capacity|number}</p>
            </div>
        </div>
    </div>
    {/if}
</div>
{/if}
<div class="row background-border-black-gray m-1">
    {if !empty($FleetInfo.rapidfire.to)}
    <div class="col-6">
        <div class="card m-1 background-border-black-blue shadow"> 
            <div class="card-body">
                <p class="card-title text-align-right">{$LNG.in_rf_again}</p>
                <div class="row">
                {foreach $FleetInfo.rapidfire.to as $rapidfireID => $shoots}
                    <div class="col-2">
                        <div class="card background-border-black-blue m-1"> 
                            <span class="card-img-text background-color-blue opacity-70 tooltip" data-tooltip-content="{$LNG.in_number}">{$shoots|number}</span>
                            <img src="{$dpath}gebaeude/{$rapidfireID}.gif" alt="{$LNG.tech.$rapidfireID}" class="opacity-70 tooltip" data-tooltip-content="{$LNG.tech.$rapidfireID}">
                        </div>
                    </div>
                {/foreach}
                </div>
            </div>
        </div>
    </div>
    {/if}
    {if !empty($FleetInfo.rapidfire.from)} 
    <div class="col-6">
        <div class="card m-1 background-border-black-blue shadow"> 
            <div class="card-body">
                <p class="card-title text-align-right">{$LNG.in_rf_from}</p>
                <div class="row">
                {foreach $FleetInfo.rapidfire.from as $rapidfireID => $shoots}
                    <div class="col-2">
                        <div class="card background-border-black-blue m-1"> 
                            <span class="card-img-text background-color-red opacity-70 tooltip" data-tooltip-content="{$LNG.in_number}">{$shoots|number}</span>
                            <img src="{$dpath}gebaeude/{$rapidfireID}.gif" alt="{$LNG.tech.$rapidfireID}" class="opacity-70 tooltip" data-tooltip-content="{$LNG.tech.$rapidfireID}">
                        </div>
                    </div>
                {/foreach}
                </div>
            </div>
        </div>
    </div>
    {/if}
</div>