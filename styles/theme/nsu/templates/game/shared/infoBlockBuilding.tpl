{foreach $ressources as $res}
    {if !empty($Element.{$res + $suffix})}
    <div class="res_info info_res_block valueTest2">
        <a class="tooltip" data-tooltip-content="
            <table class='reducefleet_table'>
                <tr>
                    <td class='reducefleet_img_ship'><img src='{$dpath}img/resources/{$res}f.png'></td>
                    <td class='reducefleet_name_ship'>{$LNG.tech.{$res}} <span class='reducefleet_count_ship'>{$Element.{$res + $suffix}|number}</span></td>
                </tr>
            </table>">
            <img height="15" width="15" src="{$dpath}img/resources/{$res}f.png">
        </a>
    </div>   
    {/if}
{/foreach}