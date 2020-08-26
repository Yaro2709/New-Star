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
        <div id="ally_content" class="conteiner">
            <div class="gray_stripo">{$LNG.lm_bonus}</div>
            <div class="bonus1">
                <span class="bonus5">{$LNG.lm_bonus}</span>
                {foreach $bonusList as $ID => $Element}
                <div class="bonus2 fade">
                    <img src="{$dpath}gebaeude/{$ID}.gif">
                    <span class="bonus3">{pretty_number($Element.bonus)}</span>
                    <span class="bonus4">{$LNG.tech.{$ID}}</span>
                </div>
                {/foreach}
            </div>
        </div>
    </div>
</div>
{/block}