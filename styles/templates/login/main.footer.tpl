<div class="container">
	<footer>
		<p class="pull-right"><a href="#">Back to top</a></p>
		<p>© 2018 {$gameName}, Inc. · <a href="http://2moons.de">by 2moons.de</a> · <a href="https://github.com/HikeGame/2moons-2.0">github</a></p>
	</footer>
</div>
<div id="dialog" style="display:none;"></div>
<script>
var LoginConfig = {
    'isMultiUniverse': {$isMultiUniverse|json},
	'unisWildcast': {$unisWildcast|json},
	'referralEnable' : {$referralEnable|json},
	'basePath' : {$basepath|json}
};
</script>
{if $analyticsEnable}
<script type="text/javascript" src="http://www.google-analytics.com/ga.js"></script>
<script type="text/javascript">
try{
var pageTracker = _gat._getTracker("{$analyticsUID}");
pageTracker._trackPageview();
} catch(err) {}</script>
{/if}
</body>
</html>