<div class="necccos">{$LNG.bd_needed_tech}</div>
{foreach $AllTech as $elementID => $requireList}
    {foreach $requireList as $requireID => $NeedLevel}
    <div class="required_block required_smal_text">
        <a href="#" onclick="return Dialog.info({$requireID})" class="tooltip" data-tooltip-content="
            <span style='color:{if $NeedLevel.own < $NeedLevel.count}red{else}lime{/if};'>
                {$LNG.tech.$requireID} {$LNG.tt_lvl}  {$NeedLevel.count} ({$NeedLevel.own}/{$NeedLevel.count})
            </span>"
        >
        <img src="{$dpath}gebaeude/{$requireID}.gif" alt="{$LNG.tech.$requireID}" />
        <div class="text" style="color:{if $NeedLevel.own < $NeedLevel.count}red{else}lime{/if};">{$NeedLevel.own}/{$NeedLevel.count}</div></a>            
    </div>
    {/foreach}
{/foreach}