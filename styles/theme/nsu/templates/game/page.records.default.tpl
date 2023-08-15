{block name="title" prepend}{$LNG.lm_records}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/records.css">
<div id="page">
<div id="content">
<div id="ally_content" class="conteiner">
   <div class="gray_stripe">
      <div style="float:left">{$LNG.lm_records}:</div>
      <span class="record_btn ico_star record_btn_active" title="{$LNG.all}" onclick="allopen();"></span>
      <span class="record_btn ico_builds" title="{$LNG.tech.0}" onclick="buildsopen();"></span>
      <span class="record_btn ico_tech" title="{$LNG.tech.100}" onclick="techopen();"></span>
      <span class="record_btn ico_fleet" title="{$LNG.tech.200}" onclick="fleetopen();"></span>
      <span class="record_btn ico_shield" title="{$LNG.tech.400}" onclick="defopen();"></span>
      <span style="color:#777; float:right;">{$LNG.rec_last_update_on}: {$update}</span>    
   </div>
   <div id="u000" style="display: block;">
      <div class="record_header">
         {$LNG.tech.0}
         <div class="record_header_top_line"></div>
         <div class="record_header_bottom_line"></div>
      </div>
      {foreach $buildList as $elementID => $elementRow}
      <div class="record_rows ">
         {if !empty($elementRow)}
         <div class="bottom_line_progres" style="width: {$PLANET[$resource[$elementID]]/$elementRow[0].level*100}%;"></div>
         {/if}
         <div class="record_img_utits">
            <a href="#" onclick="return Dialog.info({$elementID})">
            <img src="{$dpath}gebaeude/{$elementID}.gif">
            </a>
         </div>
         <div class="record_name_utits">
            <a href="#" onclick="return Dialog.info({$elementID})">{$LNG.tech.$elementID}</a>
         </div>
         {if !empty($elementRow)}
         <div class="record_made ico_record_made tooltip_sticky" data-tooltip-content=
            "
            <span style='line-height:20px; font-size:14px; color:#6c6;'>{$LNG.rec_user_top}:</span><br />
            {foreach $elementRow as $user}
            • <a href='#' style='line-height:20px;' onclick='return Dialog.Playercard({$user.userID});'>{$user.username}</a>{if !$user@last}<br/>{/if}       
            {/foreach}
            ">        	
         </div>
         <div class="record_count">
            <div class="record_text record_server">
               <span>{$LNG.rec_record}:</span> 
               <div>{$elementRow[0].level|number}</div>
            </div>
            <div class="record_text">
               <span>{$LNG.rec_you}:</span> 
               <div>{$PLANET[$resource[$elementID]]|number}</div>
            </div>
         </div>
         {/if}
      </div>
      {/foreach}
   </div>
   <div id="u100" style="display: block;">
      <div class="record_header">
         {$LNG.tech.100}
         <div class="record_header_top_line"></div>
         <div class="record_header_bottom_line"></div>
      </div>
      {foreach $researchList as $elementID => $elementRow}
      <div class="record_rows ">
         {if !empty($elementRow)}
         <div class="bottom_line_progres" style="width: {$USER[$resource[$elementID]]/$elementRow[0].level*100}%;"></div>
         {/if}
         <div class="record_img_utits">
            <a href="#" onclick="return Dialog.info({$elementID})">
            <img src="{$dpath}gebaeude/{$elementID}.gif">
            </a>
         </div>
         <div class="record_name_utits">
            <a href="#" onclick="return Dialog.info({$elementID})">{$LNG.tech.$elementID}</a>
         </div>
         {if !empty($elementRow)}
         <div class="record_made ico_record_made tooltip_sticky" data-tooltip-content=
            "
            <span style='line-height:20px; font-size:14px; color:#6c6;'>{$LNG.rec_user_top}:</span><br />
            {foreach $elementRow as $user}
            • <a href='#' style='line-height:20px;' onclick='return Dialog.Playercard({$user.userID});'>{$user.username}</a>{if !$user@last}<br/>{/if}       
            {/foreach}
            ">        	
         </div>
         <div class="record_count">
            <div class="record_text record_server">
               <span>{$LNG.rec_record}:</span> 
               <div>{$elementRow[0].level|number}</div>
            </div>
            <div class="record_text">
               <span>{$LNG.rec_you}:</span> 
               <div>{$USER[$resource[$elementID]]|number}</div>
            </div>
         </div>
         {/if}
      </div>
      {/foreach}
   </div>
   <div id="u200" style="display: block;">
      <div class="record_header">
         {$LNG.tech.200}
         <div class="record_header_top_line"></div>
         <div class="record_header_bottom_line"></div>
      </div>
      {foreach $fleetList as $elementID => $elementRow}
      <div class="record_rows ">
         {if !empty($elementRow)}
         <div class="bottom_line_progres" style="width: {$PLANET[$resource[$elementID]]/$elementRow[0].level*100}%;"></div>
         {/if}
         <div class="record_img_utits">
            <a href="#" onclick="return Dialog.info({$elementID})">
            <img src="{$dpath}gebaeude/{$elementID}.gif">
            </a>
         </div>
         <div class="record_name_utits">
            <a href="#" onclick="return Dialog.info({$elementID})">{$LNG.tech.$elementID}</a>
         </div>
         {if !empty($elementRow)}
         <div class="record_made ico_record_made tooltip_sticky" data-tooltip-content=
            "
            <span style='line-height:20px; font-size:14px; color:#6c6;'>{$LNG.rec_user_top}:</span><br />
            {foreach $elementRow as $user}
            • <a href='#' style='line-height:20px;' onclick='return Dialog.Playercard({$user.userID});'>{$user.username}</a>{if !$user@last}<br/>{/if}       
            {/foreach}
            ">        	
         </div>
         <div class="record_count">
            <div class="record_text record_server">
               <span>{$LNG.rec_record}:</span> 
               <div>{$elementRow[0].level|number}</div>
            </div>
            <div class="record_text">
               <span>{$LNG.rec_you}:</span> 
               <div>{$PLANET[$resource[$elementID]]|number}</div>
            </div>
         </div>
         {/if}
      </div>
      {/foreach}
   </div>
   <div id="u400" style="display: block;">
      <div class="record_header">
         {$LNG.tech.400}
         <div class="record_header_top_line"></div>
         <div class="record_header_bottom_line"></div>
      </div>
      {foreach $defenseList as $elementID => $elementRow}
      <div class="record_rows ">
         {if !empty($elementRow)}
         <div class="bottom_line_progres" style="width: {$PLANET[$resource[$elementID]]/$elementRow[0].level*100}%;"></div>
         {/if}
         <div class="record_img_utits">
            <a href="#" onclick="return Dialog.info({$elementID})">
            <img src="{$dpath}gebaeude/{$elementID}.gif">
            </a>
         </div>
         <div class="record_name_utits">
            <a href="#" onclick="return Dialog.info({$elementID})">{$LNG.tech.$elementID}</a>
         </div>
         {if !empty($elementRow)}
         <div class="record_made ico_record_made tooltip_sticky" data-tooltip-content=
            "
            <span style='line-height:20px; font-size:14px; color:#6c6;'>{$LNG.rec_user_top}:</span><br />
            {foreach $elementRow as $user}
            • <a href='#' style='line-height:20px;' onclick='return Dialog.Playercard({$user.userID});'>{$user.username}</a>{if !$user@last}<br/>{/if}       
            {/foreach}
            ">        	
         </div>
         <div class="record_count">
            <div class="record_text record_server">
               <span>{$LNG.rec_record}:</span> 
               <div>{$elementRow[0].level|number}</div>
            </div>
            <div class="record_text">
               <span>{$LNG.rec_you}:</span> 
               <div>{$PLANET[$resource[$elementID]]|number}</div>
            </div>
         </div>
         {/if}
      </div>
      {/foreach}
   </div>
</div>
{/block}