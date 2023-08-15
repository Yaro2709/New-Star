{block name="title" prepend}{$LNG.lm_logout}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lo_title}</h5>
        <div class="card-body">
            <p class="card-text">{$LNG.lo_notify} <br><a href="./game.php">{$LNG.lo_continue}</a></p>
        </div>
    </div>
</main>
{/block}
{block name="script" append}
<script type="text/javascript">
    var second = 5;
	function Countdown(){
		if(second == 0)
			return;
			
		second--;
		$('#seconds').text(second);
	}
	window.setTimeout("window.location.href='./game.php'", 5000);
	window.setInterval("Countdown()", 1000);
</script>
{/block}