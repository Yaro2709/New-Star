{block name="title" prepend}{$LNG.siteTitleScreens}{/block}
{block name="content"}
	<div class="container" style="margin-top: 80px;">
		<div class="panel panel-default">
			<div class="panel-heading">{$LNG.siteTitleScreens}</div>
			<div class="panel-body">
				<div class="row">
				{foreach $screenshots as $screenshot}
					<div class="col-lg-4" style="margin-bottom: 20px;">
						<a class="gallery" href="{$screenshot.path}" target="_blank" rel="gallery">
							<img src="{$screenshot.thumbnail}" alt="" width="120" height="120" class="img-rounded">
						</a>
					</div>
                {/foreach}
				</div>
			</div>
		</div>
	</div>
{/block}
{block name="script"}
<script>
$(function() {
	$(".gallery").fancybox();
});
</script>
{/block}