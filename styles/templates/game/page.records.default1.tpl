{block name="title" prepend}{$LNG.lm_records}{/block}
{block name="content"}

<table style="width:590px;">
<tbody>
<tr>
	<td class="transparent" colspan="3" style="text-align:center;">
	<div onclick="tabse(this,'tab0');" id="but0" class="active">{$LNG.tech.0}</div>
	<div onclick="tabse(this,'tab1');"  class="inactive">{$LNG.tech.100}</div>
	<div onclick="tabse(this,'tab2');"  class="inactive">{$LNG.tech.200}</div>
	<div onclick="tabse(this,'tab3');"  class="inactive">{$LNG.tech.400}</div><br><br></td>
</tr>
<tr>
	<th colspan="3" style="text-align:center;">{$LNG.rec_last_update_on}: {$update}</th>
</tr>

<tr id="tab0" class="activetab"><td colspan="3"><table style="width:100%;">
<tr>
	<th width="33%">{$LNG.tech.0}</th>
	<th width="33%">{$LNG.rec_players}</th>
	<th width="33%">{$LNG.rec_level}</th>
</tr>
{foreach $buildList as $elementID => $elementRow}
<tr>
	<td>{$LNG.tech.{$elementID}}</td>
	{if !empty($elementRow)}
	<td>{foreach $elementRow as $user}<a href='#' onclick='return Dialog.Playercard({$user.userID});'>{$user.username}</a>{if !$user@last}<br>{/if}{/foreach}</td>
	<td>{$elementRow[0].level|number}</td>
	{else}
	<td>-</td>
	<td>-</td>
	{/if}
</tr>
{/foreach}
</table></td></tr>
<tr id="tab1" class="inactivetab"><td colspan="3"><table>
<tr>
	<th width="33%">{$LNG.tech.100}</th>
	<th width="33%">{$LNG.rec_players}</th>
	<th width="33%">{$LNG.rec_level}</th>
</tr>
{foreach $researchList as $elementID => $elementRow}
<tr>
	<td>{$LNG.tech.{$elementID}}</td>
	{if !empty($elementRow)}
	<td>{foreach $elementRow as $user}<a href='#' onclick='return Dialog.Playercard({$user.userID});'>{$user.username}</a>{if !$user@last}<br>{/if}{/foreach}</td>
	<td>{$elementRow[0].level|number}</td>
	{else}
	<td>-</td>
	<td>-</td>
	{/if}
</tr>
{/foreach}
</table></td></tr>
<tr id="tab2" class="inactivetab"><td colspan="3"><table>
<tr>
	<th width="33%">{$LNG.tech.200}</th>
	<th width="33%">{$LNG.rec_players}</th>
	<th width="33%">{$LNG.rec_level}</th>
</tr>
{foreach $fleetList as $elementID => $elementRow}
<tr>
	<td>{$LNG.tech.{$elementID}}</td>
	{if !empty($elementRow)}
	<td>{foreach $elementRow as $user}<a href='#' onclick='return Dialog.Playercard({$user.userID});'>{$user.username}</a>{if !$user@last}<br>{/if}{/foreach}</td>
	<td>{$elementRow[0].level|number}</td>
	{else}
	<td>-</td>
	<td>-</td>
	{/if}
</tr>
{/foreach}
</table></td></tr>
<tr id="tab3" class="inactivetab"><td colspan="3"><table>
<tr>
	<th width="33%">{$LNG.tech.400}</th>
	<th width="33%">{$LNG.rec_players}</th>
	<th width="33%">{$LNG.rec_level}</th>
</tr>
{foreach $defenseList as $elementID => $elementRow}
<tr>
	<td>{$LNG.tech.{$elementID}}</td>
	{if !empty($elementRow)}
	<td>{foreach $elementRow as $user}<a href='#' onclick='return Dialog.Playercard({$user.userID});'>{$user.username}</a>{if !$user@last}<br>{/if}{/foreach}</td>
	<td>{$elementRow[0].level|number}</td>
	{else}
	<td>-</td>
	<td>-</td>
	{/if}
</tr>
{/foreach}
</table></td></tr></tbody>
</table><script>
var aclass = document.getElementById('but0');
var atab = document.getElementById('tab0');
</script>
{/block}