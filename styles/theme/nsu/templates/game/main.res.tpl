        <div id="res_min">
            <div class="navigation">
                {foreach $resourceTable as $resourceID => $resouceData} 
                {if !isset($resouceData.current)}
                    {$resouceData.current = $resouceData.max + $resouceData.used}
                    <span style ="width: 5.9%;" class="res_block colore{$resourceID} valueTest tooltip" data-tooltip-content="<span class='colore{$resourceID}'>{$LNG.tech.$resourceID}</span><div style='border-bottom:1px dashed #666; margin:7px 0 4px 0;'></div>{$LNG.RE} {$resouceData.percent|number}%"><img src="./styles/theme/nsc/img/resources/{$resourceID}f.png">
                        <span id="current_{$resouceData.name}">{$resouceData.current|shortly_number}</span>
                    </span>
                {else}
                    
                    {if !isset($resouceData.current) || !isset($resouceData.max)}
                        <span style ="width: 5.9%;" class="res_block colore{$resourceID} valueTest tooltip" data-tooltip-content="<span class='colore{$resourceID}'>{$LNG.tech.$resourceID}</span><div style='border-bottom:1px dashed #666; margin:7px 0 4px 0;'></div>{$LNG.RE} {pretty_number($resouceData.current)}"><img src="./styles/theme/nsc/img/resources/{$resourceID}f.png">
                            <span id="current_{$resouceData.name}">{$resouceData.current|shortly_number}</span>
                        </span>
                    {else}
                        <span style ="width: 5.9%;" class="res_block colore{$resourceID} valueTest tooltip" data-tooltip-content="
                            <span class='colore{$resourceID}'>{$LNG.tech.$resourceID}</span>
                            <div style='border-bottom:1px dashed #666; margin:7px 0 4px 0;'></div>
                            {$LNG.PPS}: {$resouceData.information}
                            <br/>{$LNG.PPD}: {$resouceData.informationd}
                            <br/>{$LNG.PPW}: {$resouceData.informationz} 
                            <div style='border-bottom:1px dashed #666; margin:7px 0 4px 0;'>
                            </div> <span style='color:#999'>{$resouceData.current|number}/{$resouceData.max|number}</span>"><img src="./styles/theme/nsc/img/resources/{$resourceID}f.png">
                                <span id="current_{$resouceData.name}">{$resouceData.current|shortly_number}</span>
                        </span>
                    {/if}
                {/if}
                {/foreach} 
            </div>
        </div>