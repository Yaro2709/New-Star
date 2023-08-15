{block name="title" prepend}{$LNG.nav_battlehall}{/block}
{block name="content"}
<main role="main" class="container">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.nav_battlehall}</h5>
        <div class="card-body">
        {if $isMultiUniverse}<p>{html_options options=$universeSelect selected=$UNI class="form-control changeUni" id="universe" name="universe"}</p>{/if}
            <table class="table table-dark table-hover">
                <thead>
					<tr>
						<th>{$LNG.tkb_platz}</th>
						<th>{$LNG.tkb_owners}</th>
						<th>{$LNG.tkb_datum}</th>
						<th>{$LNG.tkb_units}</th>
					</tr>
				</thead>
                <tbody>
                {foreach $hallList as $hallRow}
                    <tr>
                        <td>{$hallRow@iteration}</td>
                        <td>
                            {if $hallRow.result == "a"}
                                <span style="color:#00FF00">{$hallRow.attacker}</span><span style="color:#FFFFFF"><b> VS </b></span><span style="color:#FF0000">{$hallRow.defender}</span>
                            {elseif $hallRow.result == "r"}
                                <span style="color:#FF0000">{$hallRow.attacker}</span><span style="color:#FFFFFF"><b> VS </b></span><span style="color:#00FF00">{$hallRow.defender}</span>
                            {else}
                                {$hallRow.attacker}<b> VS </b>{$hallRow.defender}
                            {/if}
                        </td>
                        <td>{$hallRow.time}</td>
                        <td>{$hallRow.units|number}</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
        <div class="card-footer text-center">
            <p>{$LNG.tkb_legende}<span style="color:#00FF00">{$LNG.tkb_gewinner}</span><span style="color:#FF0000">{$LNG.tkb_verlierer}</span></p>
        </div>
    </div>
</main>
{/block}