{block name="title" prepend}{$LNG.lm_ars}{/block}
{block name="content"}
<div id="page">
   <div id="content">
      {if $arsList}
      <div id="ally_content" class="conteiner">
         <div class="gray_stripe" style="padding-right:0;">
            {$LNG.lm_ars}              
         </div>
         {*
         <div id="empire_filtrs">
            <span onclick="ars();" id="ars" class="imper_btn_filtrs imper_btn_filtrs_activ">1 <span></span></span>
            <span onclick="ars1();" id="ars1" class="imper_btn_filtrs">2 <span></span></span>
            <div class="clear"></div>
        </div>
         *}
        <div class="fleettab8" style="margin-bottom: 0;"></div>
         <div id="build_elements" class="ars_elements gov2">
            {foreach $arsList as $ID => $Element}
            <div id="ars_{$ID}" class="build_box">
                {*<div id="ars_{$ID}" class="build_box {if $ID == in_array($ID, $ars1)}ars1{else}ars2{/if}">*}
               <div class="head">               
                  {$LNG.tech.{$ID}}
                  <font class="gov6">({$LNG.bd_lvl} {$Element.level|number})</font>
               </div>
               <div class="content_box">
                  <div class="image_mini">
                    <img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" />
                  </div>
                  <div class="prices_mini">
                     <font color="#096">
                        {foreach $Element.elementBonus as $BonusName => $Bonus}{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{sqrt($Bonus[0] * $Element.level * 100)|number}%{else}{sqrt($Bonus[0] * $Element.level)|number}{/if} {$LNG.bonus.$BonusName}<br>
                        {/foreach}
                     </font>
                  </div>
               </div>
            </div>
            {/foreach}
            <div class="clear"></div>
         </div>
      </div>
   </div>
   {/if}
</div>
{/block}