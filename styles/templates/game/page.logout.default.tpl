{block name="title" prepend}{$LNG.lm_logout}{/block}
{block name="content"}
   <div id="content">
      <div id="ally_content" class="conteiner">
         <div class="gray_stripe">
            {$LNG.lo_title} <span style="color:#999;">{$LNG.lo_logout}</span>
         </div>
         <div class="ally_contents" style="text-align:center">
            {$LNG.lo_notify} <br><a href="./index.php">{$LNG.lo_continue}</a>
         </div>
      </div>
   </div>
<div class="clear"></div>
</div>
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
	window.setTimeout("window.location.href='./index.php'", 5000);
	window.setInterval("Countdown()", 1000);
</script>
{/block}