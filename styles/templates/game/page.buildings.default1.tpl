{block name="title" prepend}{$LNG.lm_buildings}{/block}
{block name="content"}
{if !empty($Queue)}

<div id="buildlist" class="buildlist">
	<table style="width:760px">
		{foreach $Queue as $List}
		{$ID = $List.element}
		<tr>
			<td style="width:70%;vertical-align:top;" class="left">
				{$List@iteration}.: 
				{if !($isBusy.research && ($ID == 6 || $ID == 31)) && !($isBusy.shipyard && ($ID == 15 || $ID == 21)) && $RoomIsOk && $CanBuildElement && $BuildInfoList[$ID].buyable}
				<form class="build_form" action="game.php?page=buildings" method="post">
					<input type="hidden" name="cmd" value="insert">
					<input type="hidden" name="building" value="{$ID}">
					<button type="submit" class="build_submit onlist">{$LNG.tech.{$ID}} {$List.level}{if $List.destroy} {$LNG.bd_dismantle}{/if}</button>
				</form>
				{else}{$LNG.tech.{$ID}} {$List.level} {if $List.destroy}{$LNG.bd_dismantle}{/if}{/if}
				{if $List@first}
				<br><br><div id="progressbar" data-time="{$List.resttime}"></div>
			</td>
			<td>
				<div id="time" data-time="{$List.time}"><br></div>
				<form action="game.php?page=buildings" method="post" class="build_form">
					<input type="hidden" name="cmd" value="cancel">
					<button type="submit" class="build_submit onlist">{$LNG.bd_cancel}</button>
				</form>
				{else}
			</td>
			<td>
				<form action="game.php?page=buildings" method="post" class="build_form">
					<input type="hidden" name="cmd" value="remove">
					<input type="hidden" name="listid" value="{$List@iteration}">
					<button type="submit" class="build_submit onlist">{$LNG.bd_cancel}</button>
				</form>
				{/if}
				<br><span style="color:lime" data-time="{$List.endtime}" class="timer">{$List.display}</span>
			</td>
		</tr>
	{/foreach}
	</table>
</div>
{/if}



    {*
<div id="build_content" class="conteiner">
    <div id="build_elements">
    	{foreach $BuildInfoList as $ID => $Element}
		<div id="build_{$ID}" class="build_box{if !empty($TechTreeList.{$ID})} required{/if}">
            <div class="head">
                <a href="#" onclick="return Dialog.info({$ID})" class="interrogation">?</a>                
                <a href="#" onclick="return Dialog.info({$ID})" class="title">
                	{$LNG.tech.{$ID}} {if $Element.level > 0}{$Element.level}{if $Element.maxLevel != 255}/{$Element.maxLevel}{/if} {$LNG.bd_lvl}{/if}
                </a>
                {if $ID == 43 && $Element.level > 0}
                  	<a href="#" style="margin-left:25px;" onclick="return Dialog.info({$ID})">[{$LNG.bd_jump_gate_action}]</a>
                {/if} 
                {if $ID == 52 && $Element.level > 0}
                	&nbsp;[<a href='javascript:OpenPopup(&quot;?page=sensor&quot;, &quot;&quot;, 640, 510);'>{$LNG.sn_scan}</a>]
                {/if}
            </div>
            {if empty($TechTreeList.{$ID})}
            <div class="content_box">
                <div class="image">
                   <a href="#" onclick="return Dialog.info({$ID})"><img src="{$dpath}gebaeude/{$ID}.png" alt="{$LNG.tech.{$ID}}" /></a>
                </div>
                <div class="prices">
                   	{foreach $Element.costResources as $RessID => $RessAmount}
                        <div class="price res{$RessID} {if $Element.costOverflow[$RessID] != 0}required{/if}">
                        	<div class="ico"></div>
                        	<div class="text {if $Element.costOverflow.{$RessID} > 0}tooltip{/if}" data-tooltip-content="{$LNG.bd_remaining} {$LNG.tech.{$RessID}} {round($Element.costOverflow.{$RessID})|number}">{$RessAmount|number}</div>                                        
                    	</div>
                    {/foreach}
                    {if count($Element.costResources) == 1}<br>{/if}
                    {if count($Element.costResources) <= 2}<br>{/if}
                    {if !empty($Element.infoEnergy)}
                    <div class="price">
                        {$Element.infoEnergy}                                 
                    </div>
                    {elseif empty($Element.infoEnergy) && count($Element.costResources) <= 3}
                    <br>
                    {/if}                
                </div>
                <div class="clear"></div>
                
                <div class="time_build">
                    {if $Element.elementTime > 0} {$LNG.bd_time}: <span>{$Element.elementTime|time}</span>{/if} 
                </div>
                
                
                {if $Element.level > 0 && (($ID == 44 && 0==$HaveMissiles) ||  $ID != 44)}
                <div class="break_build tooltip_sticky" data-tooltip-content="<table style='width:300px'><tr><th colspan='2'>{$LNG.bd_price_for_destroy} {$LNG.tech.{$ID}} {$Element.level}</th></tr>{foreach $Element.destroyResources as $ResType => $ResCount}<tr><td>{$LNG.tech.{$ResType}}</td><td>{$ResCount|number}</td></tr>{/foreach}<tr><td>{$LNG.bd_destroy_time}</td><td>{$Element.destroyTime|time}</td></tr><tr><td colspan='2'><form action='game.php?page=buildings' method='post' class='build_form'><input type='hidden' name='cmd' value='destroy'><input type='hidden' name='building' value='{$ID}'><button type='submit' class='build_submit onlist'>{$LNG.bd_dismantle}</button></form></td></tr></table>">x</div>
                {/if}
                <div class="btn_build_border">
                	{if $Element.maxLevel == $Element.level}
						<span class="btn_build red">{$LNG.bd_maxlevel}</span>
					{elseif ($isBusy.research && ($ID == 6 || $ID == 31)) || ($isBusy.shipyard && ($ID == 15 || $ID == 21))}
						<span class="btn_build red">{$LNG.bd_working}</span>
					{else}
						{if $RoomIsOk}
							{if $CanBuildElement && $Element.buyable}
							<form action="game.php?page=buildings" method="post" class="build_form">
								<input type="hidden" name="cmd" value="insert">
								<input type="hidden" name="building" value="{$ID}">
								<input class="build_number" onchange="counting({$ID});" type="number" name="lvlup" id="b_input_{$ID}" size="3" maxlength="3" min="{$Element.level + 1}" value="{$Element.level + 1}">
								<button type="submit" class="btn_build_part_left">{$LNG.bd_build_next_level}</button>
							</form>
							{else}
							<span class="btn_build red">{if $Element.level == 0}{$LNG.bd_build}{else}{$LNG.bd_build_next_level}{$Element.level + 1}{/if}</span>
							{/if}
						{else}
						<span class="btn_build red">{$LNG.bd_no_more_fields}</span>
						{/if}
					{/if}
                </div>
            </div>
            {else}
            <div class="content_box">
                <div class="image">
                   <a href="#" onclick="return Dialog.info({$ID})"><img src="{$dpath}gebaeude/{$ID}.png" alt="{$LNG.tech.{$ID}}" /></a>
                </div>
                <div class="prices">
                    <div class="price">
                        {$LNG.bd_to_build_the_necessary}:
                    </div>
                    {foreach $TechTreeList.{$ID} as $requireID => $NeedLevel}
                    {if $NeedLevel.own < $NeedLevel.count}
                    <div class="required_block">
                        <a href="#" onclick="return Dialog.info({$requireID})" class="tooltip" data-tooltip-content="{$LNG.tech.$requireID} ({$LNG.tt_lvl} {min($NeedLevel.count, $NeedLevel.own)} / {$NeedLevel.count})">
                        	<img src="{$dpath}gebaeude/{$requireID}.png" alt="{$LNG.tech.{$requireID}}" />
                        	<div class="text">{$NeedLevel.count}</div>
                        </a>
                        
                    </div>
                    {/if}
                    {/foreach}                                        
                </div>               
                <div class="clear"></div>
            </div>
            {/if}
        </div>
	{/foreach}
    <div class="clear"></div>
    </div>
</div>
*}




	{foreach $BuildInfoList as $ID => $Element}
	<div class="floatbox">
		<div class="floatboxpic" onclick="return Dialog.info({$ID})" style="background:url('{$dpath}gebaeude/{$ID}.gif'); background-size:100% 100%;"><div style="background:rgba(13, 16, 20, 0.95); width:100%;"><a class="tooltip" data-tooltip-content="
		<div style='max-width:200px;'>
		{$LNG.shortDescription.{$ID}|replace:'"':'\''}<br><br>
		{if !empty($Element.infoEnergy)}
		{$LNG.bd_next_level|replace:'"':'\''}<br>
		{$Element.infoEnergy|replace:'"':'\''}<br><br>
		{/if}
		{$LNG.bd_remaining|replace:'"':'\''}<br>
		{foreach $Element.costOverflow as $ResType => $ResCount}
		{$LNG.tech.{$ResType}|replace:'"':'\''}: 
		<span style='font-weight:700'>{$ResCount|number}</span><br>
						{/foreach} </div>" style="font-weight:bold; font-size:1.1em;" href="#" onclick="return Dialog.info({$ID})">{$LNG.tech.{$ID}}<br>{if $Element.level > 0}({$LNG.bd_lvl} {$Element.level}{if $Element.maxLevel != 255}/{$Element.maxLevel}{/if}){else}<br>{/if}</a></div></div>
		

		
	
		<div>{$LNG.fgf_time}:<span style="float:right;">{$Element.elementTime|time}</span></div>
									
				
					<div class="costoverflow">
					<span>{foreach $Element.costResources as $RessID => $RessAmount}
					<b><span style="color:{if $Element.costOverflow[$RessID] == 0}lime{else}red{/if}">{$RessAmount|number}</span></b> <img src="{$dpath}images/{$RessID}.gif" alt="{$LNG.tech.{$RessID}}" width="20" height="20"><br>
					{/foreach}</span>
					</div>
						<div class="divdestruct">{if $Element.level > 0}
							{if $ID == 43}<a href="#" onclick="return Dialog.info({$ID})">{$LNG.bd_jump_gate_action}</a>{/if}
							{if ($ID == 44 && !$HaveMissiles) ||  $ID != 44}<div class="abortpic tooltip_sticky" style="background:url('{$dpath}pic/abort.gif');" class="tooltip_sticky" data-tooltip-content="
								{* Start Destruction Popup *}
								<div style='width:300px'>
									<div>
										<th colspan='2'>{$LNG.bd_price_for_destroy} {$LNG.tech.{$ID}} {$Element.level}</th>
									</div>
									{foreach $Element.destroyResources as $ResType => $ResCount}
									<div>
										{$LNG.tech.{$ResType}}
										<span style='color:{if empty($Element.destroyOverflow[$RessID])}lime{else}red{/if}'>{$ResCount|number}</span>
									</div>
									{/foreach}
									<div>
										{$LNG.bd_destroy_time}
										{$Element.destroyTime|time}
									</div>
									<div>

											<form action='game.php?page=buildings' method='post' class='build_form'>
												<input type='hidden' name='cmd' value='destroy'>
												<input type='hidden' name='building' value='{$ID}'>
												<button type='submit' class='build_submit onlist'>{$LNG.bd_dismantle}</button>
											</form>
										
									</div>
								</div>
								{* End Destruction Popup *}
								"></div>{/if}
						{else}
							&nbsp;
						{/if}	
</div>						
<div class="submitdiv" style="
					{if $Element.maxLevel == $Element.levelToBuild}
						 background:red;"><span class="wi">{$LNG.bd_maxlevel}</span>
					{elseif ($isBusy.research && ($ID == 6 || $ID == 31)) || ($isBusy.shipyard && ($ID == 15 || $ID == 21))}
						 background:red;"><span class="wi">{$LNG.bd_working}</span>
					{else}
						{if $RoomIsOk}
							{if $CanBuildElement && $Element.buyable}
							 background:green;"><form action="game.php?page=buildings" method="post" class="build_form">
								<input type="hidden" name="cmd" value="insert">
								<input type="hidden" name="building" value="{$ID}">
								<button type="submit" class="build_submit">{if $Element.level == 0}{$LNG.bd_build}{else}{$LNG.bd_build_next_level}{$Element.levelToBuild + 1}{/if}</button>
							</form>
							{else}
							background:red;"><span class="wi">{if $Element.level == 0}{$LNG.bd_build}{else}{$LNG.bd_build_next_level}{$Element.levelToBuild + 1}{/if}</span>
							{/if}
						{else}
						background:red;"><span class="wi">{$LNG.bd_no_more_fields}</span>
						{/if}
					{/if}
										
</div>
	</div>
	{/foreach}

{/block}