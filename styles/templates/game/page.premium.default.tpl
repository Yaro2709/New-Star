{block name="title" prepend}{$LNG.lm_premium}{/block}
{block name="script"}
<script type="text/javascript" src="./scripts/game/price.js?v=6"></script>
{/block}
{block name="content"}
<div id="page">
   <div id="content">
      {if !empty($premiumList)}
      <div id="ally_content" class="conteiner">
         <div class="gray_stripe">
            {$LNG.lm_premium}               
         </div>
         <div id="build_elements" class="officier_elements gov2" style="padding-top:10px; padding-bottom:5px;">
            {foreach $premiumList as $ID => $Element}
            <div id="ofic_{$ID}" class="build_box">
               <div class="head">
                  {$LNG.tech.{$ID}}
                  {if $Element.timeLeft > 0}<span style="float:right; color:#CCC;">{$LNG.of_active}: <span id="time_{$ID}">-</span></span>{/if}
               </div>
               <div class="content_box">
                  <div class="image_mini">
                     <img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}">
                  </div>
                  <div class="prices_mini">
                     <p>
                        <font color="#00FF00">
                           {foreach $Element.elementBonus as $BonusName => $Bonus}{if $Bonus@iteration % 1 === 1}
                     <p>{/if}{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{abs($Bonus[0] * 100)}%{else}{floatval($Bonus[0])}{/if} {$LNG.bonus.$BonusName}{if $Bonus@iteration % 1 === 0 || $Bonus@last}</p>{else}&nbsp;{/if}{/foreach}</font></p>
                  </div>
                  <div class="clear"></div>
                  <div>
                     <form action="game.php?page=premium" method="post" class="build_form">
                        <div class="time_build">
                           {foreach $Element.costResources as $RessID => $RessAmount}{$LNG.tech.{$RessID}}: <b>
                           <span id="price{$ID}" style="color:{if $Element.costOverflow[$RessID] == 0}lime{else}red{/if}">{$RessAmount|number}</span>
                           </b>{/foreach}
                        </div>
                        <div class="clear"></div>
                        <div class="btn_build_border">
                           {if $Element.buyable}
                     <form action="game.php?page=premium" method="post" class="build_form">
                     <div class="clear"></div>
                     <input name="id" value="{$ID}" type="hidden">      
                     <div class="btn_build_border btn_build_border_left dm_btn_build_border_left">
                     <label class="max_btn_ship">{$LNG.prem_time}</label>
                     <div class="div_text count_ships_dots">
                     {foreach $Element.costResources as $RessID => $RessAmount}
                     <input id="amount{$ID}" class="text" onchange="Price{$RessID}('{$ID}', {$RessAmount});" name="amount" max="500" min="1" value="1" type="number">
                     {/foreach}
                     </div>
                     </div>
                     <div class="btn_build_border btn_build_border_right dm_btn_build_border_right">
                     <button class="btn_build gubernators_form_submit" type="submit">{$LNG.prem_go}</button>  
                     </div>                  
                     </form>
                     {else}
                     <span class="btn_build red">{$LNG.prem_stop}</span>
                     {/if}
                     </div>
                     </form>
                     <div class="clear"></div>
                  </div>
               </div>
               <div class="clear"></div>
            </div>
            {/foreach}
         </div>
      </div>
   </div>
   {/if}
</div>
<div class="clear"></div>
</div>
{/block}