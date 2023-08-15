{block name="title" prepend}{$LNG.lm_bonus}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/bonus.css">
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
            <div class="row" style="padding: 7px">
            {foreach $bonusList as $ID => $Element}
                <div class="col-md-4 fade">
                    <div class="card mr-1 background-border-black-blue shadow"> 
                        <div class="card-body">
                            <div class="row" style="align-items: center; ">
                                <div class="col-md-4">
                                    <div class="card background-border-black-blue"> 
                                        <img src="{$dpath}gebaeude/{$ID}.gif" class="img-fluid float-start opacity-70">
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="card">
                                        <div class="card-body">
                                            <p class="card-title text-align-right">{pretty_number($Element.bonus)}</p>
                                            <p class="card-text text-align-right">{$LNG.tech.{$ID}}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {/foreach}
            </div>
        </div>
    </div>
</div>
{/block}