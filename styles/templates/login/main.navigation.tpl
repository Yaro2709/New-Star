<nav class="navbar navbar-default navbar-inverse navbar-fixed-top " role="navigation" style="border-color: #333;">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">{$gameName}</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse navbar-ex1-collapse">
			<ul class="nav navbar-nav">
				<li><a href="index.php">{$LNG.menu_index}</a></li>
				<li><a href="index.php?page=board" target="board">{$LNG.forum}</a></li>
				<li><a href="index.php?page=news">{$LNG.menu_news}</a></li>
				<li><a href="index.php?page=rules">{$LNG.menu_rules}</a></li>
				<li><a href="index.php?page=battleHall">{$LNG.menu_battlehall}</a></li>
				<li><a href="index.php?page=banList">{$LNG.menu_banlist}</a></li>
				<li><a href="index.php?page=disclamer">{$LNG.menu_disclamer}</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<a class="btn btn-danger btn-sm navbar-btn" href="index.php?page=register">Sign up</a>
				<div class="btn-group ">
					<button class="btn navbar-btn btn-sm">Choose lang</button>
					<button class="btn dropdown-toggle navbar-btn btn-sm" data-toggle="dropdown">
						<span class="caret"></span>
					</button>
                    {if count($languages) > 1}
						<ul class="dropdown-menu" style="min-width:30px;" id="language">
                            {foreach $languages as $langKey => $langName}
								<li><a href="?lang={$langKey}" rel="alternate" hreflang="{$langKey}" title="{$langName}"><span class="flags {$langKey}">{$langName}</span></a></li>
                            {/foreach}
						</ul>
                    {/if}
				</div>
			</ul>
		</div><!-- /.navbar-collapse -->
	</div>
</nav>