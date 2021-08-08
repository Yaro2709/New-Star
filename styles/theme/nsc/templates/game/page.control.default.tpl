{block name="title" prepend}{$LNG.lm_control}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/control.css">
<div id="page">
<div id="content">

<div id="ally_content" style="width:auto;" class="conteiner">
<div class="gray_stripe">
   <div style="float:left">{$LNG.lm_control}</div>
       <span style="float:right;color:#54989d;">{$LNG.lv_max_colon} {$PlanetCount} / {$MaxPlanets} </span>
    </div>
<div id="empire_filtrs">

   <span onclick="filtrsall();" id="filtrsall" class="imper_btn_filtrs imper_btn_filtrs_activ">{$LNG.lv_max} <span>({$AllCount})</span></span>
   {if $PlanetCount >= 1}<span onclick="filtrsplanet();" id="filtrsplanet" class="imper_btn_filtrs">{$LNG.lv_max_planet} <span>({$PlanetCount})</span></span>{/if}
   {if $MoonCount >= 1}<span onclick="filtrsmoon();" id="filtrsmoon" class="imper_btn_filtrs">{$LNG.lv_max_moon} <span>({$MoonCount})</span></span> {/if}
   <div class="clear"></div>

</div>
<div class="gray_stripe">
   <div class="imper_left_part">
    {if isModuleAvailable($smarty.const.MODULE_REDUCE_RESOURCES)}
      <a href="game.php?page=reduceResources" class="fleet_reduce1 ico_reduceresources tooltip" data-tooltip-content="{$LNG['lm_reduceresources']}"></a>
    {/if}
    {if isModuleAvailable($smarty.const.MODULE_REDUCE_FLEET)}
      <a href="game.php?page=reduceFleet" class="fleet_reduce1 ico_reducefleet tooltip" data-tooltip-content="{$LNG['lm_reducefleet']}"></a>
    {/if}
    {if isModuleAvailable($smarty.const.MODULE_DELIVERY)}
      <a href="game.php?page=delivery" class="fleet_reduce1 ico_deliveryres tooltip" data-tooltip-content="{$LNG['lm_delivery']}"></a>
    {/if}
   </div>
   <div class="imper_right_part">
      <div onclick="gorightMAX();" class="imper_goleft_2 imper_navigation"></div>
      <div onclick="goright();" class="imper_goleft imper_navigation"></div>
      <div onclick="goleftMAX();" class="imper_goright_2 imper_navigation"></div>
      <div onclick="goleft();" class="imper_goright imper_navigation"></div>
      <div class="icovavigation">
         <span class="record_btn ico_star record_btn_active" title="{$LNG.all}" onclick="allopen();"></span>
         <span class="record_btn ico_builds" title="{$LNG.tech.0}" onclick="buildsopen();"></span>
         <span class="record_btn ico_fleet" title="{$LNG.tech.200}" onclick="fleetopen();"></span>
         <span class="record_btn ico_shield" title="{$LNG.tech.400}" onclick="defopen();"></span>
         <div class="clear"></div>
      </div>
   </div>
</div>
<div style="width: 20px;float: left;">
   <div class="imper_block_image">
      <div class="imper_block_info_text"></div>
      <div class="imper_block_info_text"></div>
      <div class="imper_block_info_text"></div>
      <div class="imper_block_info_text"></div>
   </div>
   <div class="imper_block_th"></div>
   {foreach $planetList.resource as $elementID => $resourceArray}
   <div class="imper_block_td" style = "line-height: 0px;padding: 0px 0px;">
        <img height="18" width="18" src="{$dpath}gebaeude/{$elementID}.gif">
   </div>
   {/foreach}
   <div class="imper_block_th"></div>
   {foreach $planetList.res as $elementID => $resArray}
   <div class="imper_block_td" style = "line-height: 0px;padding: 0px 0px;">
        <img height="18" width="18" src="{$dpath}gebaeude/{$elementID}.gif">
   </div>
   {/foreach}
   <div class="u000">
      <div class="imper_block_th"></div>
      {foreach $planetList.build as $elementID => $buildArray}
      <div class="imper_block_td" style = "line-height: 0px;padding: 0px 0px;">
        <img height="18" width="18" src="{$dpath}gebaeude/{$elementID}.gif">
   </div>
      {/foreach}
   </div>
   <div class="u200">
      <div class="imper_block_th"></div>
      {foreach $planetList.fleet as $elementID => $fleetArray}
      <div class="imper_block_td" style = "line-height: 0px;padding: 0px 0px;">
        <img height="18" width="18" src="{$dpath}gebaeude/{$elementID}.gif">
   </div>
      {/foreach}
   </div>
   <div class="u400">
      <div class="imper_block_th"></div>
      {foreach $planetList.defense as $elementID => $fleetArray}
      <div class="imper_block_td" style = "line-height: 0px;padding: 0px 0px;">
        <img height="18" width="18" src="{$dpath}gebaeude/{$elementID}.gif">
   </div>
      {/foreach}
   </div>
</div>
<div class="imper_left_part">
   <div class="imper_block_image">
      <div class="imper_block_info_text">{$LNG.lv_name}</div>
      <div class="imper_block_info_text">{$LNG.lv_coords}</div>
      <div class="imper_block_info_text">{$LNG.lv_fields}</div>
      <div class="imper_block_info_text">{$LNG.lv_go_planet}</div>
   </div>
   <div class="imper_block_th">{$LNG.lv_resources}</div>
   {foreach $planetList.resource as $elementID => $resourceArray}
   <div class="imper_block_td">{$LNG.tech.$elementID}</div>
   {/foreach}
   <div class="imper_block_th">{$LNG.lv_resources_h}</div>
   {foreach $planetList.res as $elementID => $resArray}
   <div class="imper_block_td">{$LNG.tech.$elementID}</div>
   {/foreach}
   <div class="u000">
      <div class="imper_block_th">{$LNG.tech.0}</div>
      {foreach $planetList.build as $elementID => $buildArray}
      <div class="imper_block_td">{$LNG.tech.$elementID}</div>
      {/foreach}
   </div>
   <div class="u200">
      <div class="imper_block_th">{$LNG.tech.200}</div>
      {foreach $planetList.fleet as $elementID => $fleetArray}
      <div class="imper_block_td">{$LNG.tech.$elementID}</div>
      {/foreach}
   </div>
   <div class="u400">
      <div class="imper_block_th">{$LNG.tech.400}</div>
      {foreach $planetList.defense as $elementID => $fleetArray}
      <div class="imper_block_td">{$LNG.tech.$elementID}</div>
      {/foreach}
   </div>
</div>
<div onclick="goright();" class="imper_goleft_big"></div>
<div onclick="goleft();" class="imper_goright_big"></div>
<div class="imper_right_part" id="ipper_planets">
   <table class="imper_table">
      <tr>
         <td class="imper_f">
            <div class="imper_block_vertical" id="sigma">
               <div class="imper_block_image">
                  <div class="gradient_block_image">Σ</div>
                  <div class="imper_block_info_text">{$LNG.lv_sum}</div>
                  <div class="imper_block_info_text"></div>
                  <div class="imper_block_info_text"></div>
                  <div class="imper_block_info_text"></div>
               </div>
               <div class="imper_block_th"></div>
               {foreach $planetList.resource as $elementID => $resourceArray}
               <div class="imper_block_td">{array_sum($resourceArray)|number}</div>
               {/foreach}
               <div class="imper_block_th"></div>
               {foreach $planetList.res as $elementID => $resArray}
               <div class="imper_block_td">{array_sum($resArray)|number}</div>
               {/foreach}
               <div class="u000">
                  <div class="imper_block_th"></div>
                  {foreach $planetList.build as $elementID => $buildArray}
                  <div class="imper_block_td">{array_sum($buildArray)|number}</div>
                  {/foreach}
               </div>
               <div class="u200">
                  <div class="imper_block_th"></div>
                  {foreach $planetList.fleet as $elementID => $fleetArray}
                  <div class="imper_block_td">{array_sum($fleetArray)|number}</div>
                  {/foreach}
               </div>
               <div class="u400">
                  <div class="imper_block_th"></div>
                  {foreach $planetList.defense as $elementID => $fleetArray}
                  <div class="imper_block_td">{array_sum($fleetArray)|number}</div>
                  {/foreach}
               </div>
            </div>
         </td>
         {foreach $planetList.image as $planetID => $image}
         <td class="imper_f 
            imper_{if $planetList.coords.$planetID.planet_type == 1}planet{else}moon{/if}
            ">
            <div class="imper_block_vertical">
               <div class="imper_block_image" style="background-image:url({$dpath}planeten/small/s_{$image}.jpg);">
                  <div class="gradient_block_image"></div>
                  <div class="imper_block_info_text"><a href="game.php?page=overview&amp;cp={$planetID}">{$planetList.name.$planetID}</a></div>
                  <div class="imper_block_info_text">
                     <a href="game.php?page=galaxy&amp;galaxy={$planetList.coords.$planetID.galaxy}&amp;system={$planetList.coords.$planetID.system}">[{$planetList.coords.$planetID.galaxy}:{$planetList.coords.$planetID.system}:{$planetList.coords.$planetID.planet}]</a>
                  </div>
                  <div class="imper_block_info_text">
                     {$planetList.field.$planetID.current|number} / {$planetList.field.$planetID.max|number}
                  </div>
                  <a class="ico_rows_planet imper_go_planet" href="game.php?page=overview&amp;cp={$planetID}"></a>
               </div>
               <div class="imper_block_th"></div>
               {foreach $planetList.resource as $elementID => $resourceArray}
               <div class="imper_block_td">{$planetList.resource.$elementID.$planetID|number}</div>
               {/foreach}
               <div class="imper_block_th"></div>
               {foreach $planetList.res as $elementID => $resArray}
               <div class="imper_block_td">{$planetList.res.$elementID.$planetID|number}</div>
               {/foreach}
               <div class="u000">
                  <div class="imper_block_th"></div>
                  {foreach $planetList.build as $elementID => $buildArray}
                  <div class="imper_block_td">{$planetList.build.$elementID.$planetID|number}</div>
                  {/foreach}
               </div>
               <div class="u200">
                  <div class="imper_block_th"></div>
                  {foreach $planetList.fleet as $elementID => $fleetArray}
                  <div class="imper_block_td">{$planetList.fleet.$elementID.$planetID|number}</div>
                  {/foreach}
               </div>
               <div class="u400">
                  <div class="imper_block_th"></div>
                  {foreach $planetList.defense as $elementID => $fleetArray}
                  <div class="imper_block_td">{$planetList.defense.$elementID.$planetID|number}</div>
                  {/foreach}
               </div>
            </div>
            <div class="clear"></div>
         </td>
         {/foreach}
      </tr>
   </table>
</div>
{/block}