{block name="title" prepend}{$LNG.lm_bonus}{/block}
{block name="content"}
<script type="text/javascript">
$(document).ready(function(){
 $.fn.fade_img = function (ops) {
  var $elem = this;
  var res = $.extend({ delay: 2000, speed: 600 }, ops);
  for (var i=0, pause=0, l=$elem.length; i<l; i++, pause+=res.delay) {
   $elem.eq(i).delay(pause).fadeIn(res.speed);
  }
  return $elem;
 };
 $('div.fade').fade_img();
});
</script>
<div id="page">
<div id="content">
<div id="ally_content" class="conteiner" style="width:500px;"   >
   <div class="gray_stripe">
      {$LNG.lm_bonus}                    
   </div>
   <div class="ally_contents">
	{foreach $bonusList as $ID => $Element}
			<div class="record_rows fade" style="width: 138px;text-align: left;margin: 0px 4px 8px 4px;float: left;border: 1px solid #091d2e;">
               <div class="record_img_utits">
                  <img alt="" src="{$dpath}img/resources/{$ID}.gif">
               </div>
               <div class="record_name_utits">
			   {$LNG.tech.{$ID}}: {pretty_number($Element.bonus)}
               </div>
            </div>
	{/foreach}		
   </div>
</div>
{/block}