{include file="ins_header.tpl"}
{include file="ins_nav.tpl"}
<main role="main" class="container">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.upgrade_header}</h5>
        <div class="card-body">
            {if !empty($updates)}
				<form action="?mode=doupgrade" method="POST">
					<p class="card-text">{sprintf($LNG.upgrade_available,$sql_revision,$file_revision)}</p>
					{foreach $updates as $file => $content}
						<p class="card-text">{$file}</p>
                        <div style="border: 1px solid #1C1F23; padding: 5px 10px; margin: 5px 10px;" class="card-text">{$content}</div>
					{/foreach}
                    <button type="submit" class="btn btn-primary">{$LNG.continue}</button>
				</form>
			{else}
				<p class="card-text">{sprintf($LNG.upgrade_notavailable,$sql_revision)}</p>
                <a href="index.php">
                    <button type="button" class="btn btn-primary">{$LNG.back}</button>
                </a> 
			{/if}
        </div>
    </div>
</main>
{include file="ins_footer.tpl"}