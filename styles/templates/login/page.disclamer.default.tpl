{block name="title" prepend}{$LNG.siteTitleDisclamer}{/block}
{block name="content"}
	<div class="container" style="margin-top: 80px;">
		<div class="panel panel-default">
			<div class="panel-heading">{$LNG.siteTitleDisclamer}</div>
			<div class="panel-body">
				<p class="lead">Information</p>
				<p>The contact page will change the following with a contact form so that your player can send you mail in case of problem connecting your game.</p>

				<hr>

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
	</div>
{/block}