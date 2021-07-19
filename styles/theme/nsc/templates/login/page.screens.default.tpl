{block name="title" prepend}{$LNG.nav_screens}{/block}
{block name="content"}
<main role="main" class="container">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.nav_screens}</h5>
        <div class="card-body">
			<div class="row">
			{foreach $screenshots as $screenshot}
				<div class="col-lg-2 mb-3">
					<a class="gallery" href="{$screenshot.path}" target="_blank" rel="gallery">
						<img src="{$screenshot.thumbnail}" alt="" width="120" height="120" class="img-thumbnail bg-primary border-primary">
					</a>
				</div>
            {/foreach}
			</div>
        </div>
    </div>
</main>
{/block}
{block name="script"}
<script>
$(function() {
	$(".gallery").fancybox();
});
</script>
{/block}