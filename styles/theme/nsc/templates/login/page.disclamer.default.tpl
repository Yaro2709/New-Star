{block name="title" prepend}{$LNG.nav_disclamer}{/block}
{block name="content"}
<main role="main" class="container">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.nav_disclamer}</h5>
        <div class="card-body">
            <div class="row">
				<address class="col-lg-6">
					<strong>{$LNG.disclamerLabelAddress}</strong><br>
                    {$disclamerAddress}
				</address>
				<address class="col-lg-6">
					<strong>{$LNG.disclamerLabelPhone}</strong><br>
                    {$disclamerPhone}
				</address>
			</div>
			<div class="row">
				<address class="col-lg-6">
					<strong>{$LNG.disclamerLabelMail}</strong><br>
					<a href="{$disclamerMail}">{$disclamerMail}</a>
				</address>
				<address class="col-lg-6">
					<strong>{$LNG.disclamerLabelNotice}</strong><br>
                    {$disclamerNotice}
				</address>
			</div>
        </div>
    </div>
</main>
{/block}