{block name="title" prepend}{$LNG.fcm_info}{/block}
{block name="content"}
	<div class="container" style="margin-top: 80px;">
		<div class="panel panel-default">
			<div class="panel-heading">{$LNG.fcm_info}</div>
			<div class="panel-body">
				<table class="table519">
					<tr>
						<td><p>{$message}</p>{if !empty($redirectButtons)}<p>{foreach $redirectButtons as $button}<a href="{$button.url}"><button class="btn btn-default">{$button.label}</button></a>{/foreach}</p>{/if}</td>
					</tr>
				</table>
			</div>
		</div>
	</div>

{/block}