<tr class="barraclass">
	<th colspan="2">{$LNG.st_position}</th>
	<th>{$LNG.st_player}</th>
	<th></th>
	<th>{$LNG.st_alliance}</th>
	<th>{$LNG.st_points}</th>
</tr>
{foreach name=RangeList item=RangeInfo from=$RangeList}
<tr class="classificabarra ">
    <td id="{$RangeInfo.rank}" class="classstat1">{$RangeInfo.rank}</td>
    <td class="classstat2">{if $RangeInfo.ranking == 0}<span style='color:#87CEEB'>*</span>{elseif $RangeInfo.ranking < 0}<span style='color:red'>{$RangeInfo.ranking}</span>{elseif $RangeInfo.ranking > 0}<span style='color:green'>+{$RangeInfo.ranking}</span>{/if}</td>
    <td class="classstat3">
        <div class="barracla classstat4"></div>		
        <a href="#" class="fbox-s-name classstat5" onclick="return Dialog.Playercard({$RangeInfo.id}, '{$RangeInfo.name}');">
            {if isModuleAvailable($smarty.const.MODULE_RACE)}
            <img class="tooltip" data-tooltip-content="{$LNG.tech.{$RangeInfo.race}}" src="{$dpath}gebaeude/{$RangeInfo.race}.gif" width="18"</a>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_FORMGOVERNMENT)}
            <img class="tooltip" data-tooltip-content="{$LNG.tech.{$RangeInfo.formgovernment}}" src="{$dpath}gebaeude/{$RangeInfo.formgovernment}.png" width="18"</a>
            {/if}
            {if isModuleAvailable($smarty.const.MODULE_ETHICS)}
            <img class="tooltip" data-tooltip-content="{$LNG.tech.{$RangeInfo.ethics}}" src="{$dpath}gebaeude/{$RangeInfo.ethics}.png" width="18"</a>
            {/if}
            <span {if $RangeInfo.id == $CUser_id} style="color:lime"{/if}>{$RangeInfo.name}</span>	
            {if !empty($RangeInfo.class)}<span class="classstat6">{foreach $RangeInfo.class as $class}<span class='galaxy-short-{$class} galaxy-short'>{$ShortStatus.$class} </span>{/foreach}</span>{/if}
        </a>		
    </td>
    <td class="classstat7">{if $RangeInfo.id != $CUser_id}<a href="#" onclick="return Dialog.PM({$RangeInfo.id});"><img src="{$dpath}img/iconav/mesages.png" title="{$LNG.st_write_message}" alt="{$LNG.st_write_message}"></a>{/if}</td>
    <td class="classstat8">{if $RangeInfo.allyid != 0}<a href="game.php?page=alliance&amp;mode=info&amp;id={$RangeInfo.allyid}">{if $RangeInfo.allyid == $CUser_ally}<span style="color:#33CCFF">{$RangeInfo.allyname}</span>{else}{$RangeInfo.allyname}{/if}</a>{else}-{/if}<div class="barracla" style=""></div></td>
    <td class="classstat10" style="text-align:right">{$RangeInfo.points}</td>
</tr>
{/foreach}