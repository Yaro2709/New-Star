{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner">
         <div class="gray_stripo" style="margin-bottom:5px;">
            {$LNG.al_request_list}
            <div class="tornaindietro"> <a href="game.php?page=alliance">{$LNG.al_back}</a></div>
        </div> 
         <table id="memberList" class="tablesorter ally_ranks gray_stripe_th">
            <thead>
               <tr>
                  <th>{$LNG.al_candidate}</th>
                  <th>{$LNG.al_request_date}</th>
               </tr>
            </thead>
            <tbody>
               {foreach $applyList as $applyRow}
               <tr class="alleanza62">
                  <td><a href="game.php?page=alliance&amp;mode=admin&amp;action=detailApply&amp;id={$applyRow.id}">{$applyRow.username}</a></td>
                  <td><a href="game.php?page=alliance&amp;mode=admin&amp;action=detailApply&amp;id={$applyRow.id}">{$applyRow.time}</a></td>
               </tr>
               {/foreach}
            </tbody>
         </table>
      </div>
   </div>
</div>
{/block}