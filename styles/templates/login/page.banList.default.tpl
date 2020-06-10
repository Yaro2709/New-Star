{block name="title" prepend}{$LNG.nav_banlist}{/block}
{block name="content"}
<main role="main" class="container">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.nav_banlist}</h5>
        <div class="card-body">
        {if $isMultiUniverse}<p>{html_options options=$universeSelect selected=$UNI class="form-control changeUni" id="universe" name="universe"}</p>{/if}
            <table class="table table-dark table-hover">
            <small>
				<thead>
					<tr>
						<th>{$LNG.bn_from}</th>
						<th>{$LNG.bn_until}</th>
						<th>{$LNG.bn_player}</th>
						<th>{$LNG.bn_by}</th>
						<th>{$LNG.bn_reason}</th>
					</tr>
				</thead>
                <tbody>
                {if $banCount}
                {foreach $banList as $banRow}
					<tr>
						<td>{$banRow.from}</td>
						<td>{$banRow.to}</td>
						<td>{$banRow.player}</td>
						<td><a href="mailto:{$banRow.mail}" title="{$banRow.info}">{$banRow.admin}</a></td>
						<td>{$banRow.theme}</td>
					</tr>
                {/foreach}
                    <tr>
						<td colspan="5">{$LNG.bn_exists}{$banCount|number}{$LNG.bn_players_banned}</td>
					</tr>
                {else}
					<tr>
						<td colspan="5">{$LNG.bn_no_players_banned}</td>
					</tr>
                {/if}
				</tbody>
            </small>
			</table>
        </div>
        {if $banCount}
        <div class="card-footer text-center">
            <div class="btn-group mr-2" role="group" aria-label="First group">
            {if $page != 1}
                <a href="index.php?page=banList&amp;side={$page - 1}">
                    <button type="button" class="btn btn-secondary">Prev</button>
                </a>
			{/if}
            {for $site=1 to $maxPage}
            {if $site == $page}
                <a href="#" onclick="false;">
                    <button type="button" class="btn btn-secondary active">{$site}</button>
                </a>
			{else}
                <a href="index.php?page=banList&amp;side={$site}">
                    <button type="button" class="btn btn-secondary">{$site}</button>
                </a>
            {/if}
            {/for}
            {if $page != $maxPage}
                <a href="index.php?page=banList&amp;side={$page + 1}">
                    <button type="button" class="btn btn-secondary">Next</button>
                </a>
            {/if}
            </div>
        </div>
        {/if}
    </div>
</main>
{/block}