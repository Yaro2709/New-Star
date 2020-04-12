{block name="title" prepend}{$LNG.lm_banned}{/block}
{block name="content"}
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner">
         <div class="gray_stripe">
            {$LNG.bn_players_banned_list}
         </div>
         <table class="tablesorter ally_ranks">
            <tr>
               <td>{$LNG.bn_from}</td>
               <td>{$LNG.bn_until}</td>
               <td>{$LNG.bn_player}</td>
               <td>{$LNG.bn_by}</td>
               <td>{$LNG.bn_reason}</td>
            </tr>
            {if $banCount}
            <tr>
               <td class="right" colspan="5">
                  {$LNG.mg_page}:            
                  {if $page != 1}<a href="game.php?page=banList&amp;side={$page - 1}">&laquo;</a>&nbsp;{/if}
                  <a href="game.php?page=banList&amp;side=1">{if 1 == $page}<span class="active_page">[1]</span>{else}[1]{/if}</a>
                  {if $page - 4 > 1} ... {/if}   
                  {if $page - 3 > 1}
                  <a href="game.php?page=banList&amp;side={$page - 3}">{if $page - 3 == $page}<span class="active_page">[{$page - 3}]</span>
                  {else}[{$page - 3}]{/if}</a>{/if} 
                  {if $page - 2 > 1}
                  <a href="game.php?page=banList&amp;side={$page - 2}">{if $page - 2 == $page}<span class="active_page">[{$page - 2}]</span>
                  {else}[{$page - 2}]{/if}</a>{/if}   
                  {if $page - 1 > 1}
                  <a href="game.php?page=banList&amp;side={$page - 1}">{if $page - 1 == $page}<span class="active_page">[{$page - 1}]</span>
                  {else}[{$page - 1}]{/if}</a>{/if}
                  {if $page     > 1}
                  <a href="game.php?page=banList&amp;side={$page    }">{if $page     == $page}<span class="active_page">[{$page    }]</span>
                  {else}[{$page   }]{/if}</a>{/if}
                  {if $page + 1 <= $maxPage}            
                  <a href="game.php?page=banList&amp;side={$page + 1}">{if $page + 1 == $page}<span class="active_page">[{$page + 1}]</span>
                  {else}[{$page + 1}]{/if}</a>{/if}
                  {if $page + 2 <= $maxPage}            
                  <a href="game.php?page=banList&amp;side={$page + 2}">{if $page + 2 == $page}<span class="active_page">[{$page + 2}]</span>
                  {else}[{$page + 2}]{/if}</a>{/if}
                  {if $page + 3 <= $maxPage}            
                  <a href="game.php?page=banList&amp;side={$page + 3}">{if $page + 3 == $page}<span class="active_page">[{$page + 3}]</span>
                  {else}[{$page + 3}]{/if}</a>{/if}  
                  {if $page + 4 < $maxPage} ... {/if}   
                  {if $page + 4 <= $maxPage}
                  <a href="game.php?page=banList&amp;side={$maxPage}">{if $maxPage == $page}<span class="active_page">[{$maxPage}]</span>{else}[{$maxPage}] {/if}</a>
                  {/if}      
                  {if $page != $maxPage}&nbsp;<a href="game.php?page=banList&amp;side={$page + 1}">&raquo;</a>{/if}
               </td>
            </tr>
            {foreach $banList as $banRow}
            <tr>
               <td>{$banRow.from}</td>
               <td>{$banRow.to}</td>
               <td>{$banRow.player}</td>
               <td><a href="mailto:{$banRow.mail}" title="{$banRow.info}">{$banRow.admin}</a></td>
               <td>{$banRow.theme}</td>
            </tr>
            {/foreach}
            <tr>
               <td class="right" colspan="5">
                  {$LNG.mg_page}:            
                  {if $page != 1}<a href="game.php?page=banList&amp;side={$page - 1}">&laquo;</a>&nbsp;{/if}
                  <a href="game.php?page=banList&amp;side=1">{if 1 == $page}<span class="active_page">[1]</span>{else}[1]{/if}</a>
                  {if $page - 4 > 1} ... {/if}   
                  {if $page - 3 > 1}
                  <a href="game.php?page=banList&amp;side={$page - 3}">{if $page - 3 == $page}<span class="active_page">[{$page - 3}]</span>
                  {else}[{$page - 3}]{/if}</a>{/if} 
                  {if $page - 2 > 1}
                  <a href="game.php?page=banList&amp;side={$page - 2}">{if $page - 2 == $page}<span class="active_page">[{$page - 2}]</span>
                  {else}[{$page - 2}]{/if}</a>{/if}   
                  {if $page - 1 > 1}
                  <a href="game.php?page=banList&amp;side={$page - 1}">{if $page - 1 == $page}<span class="active_page">[{$page - 1}]</span>
                  {else}[{$page - 1}]{/if}</a>{/if}
                  {if $page     > 1}
                  <a href="game.php?page=banList&amp;side={$page    }">{if $page     == $page}<span class="active_page">[{$page    }]</span>
                  {else}[{$page   }]{/if}</a>{/if}
                  {if $page + 1 <= $maxPage}            
                  <a href="game.php?page=banList&amp;side={$page + 1}">{if $page + 1 == $page}<span class="active_page">[{$page + 1}]</span>
                  {else}[{$page + 1}]{/if}</a>{/if}
                  {if $page + 2 <= $maxPage}            
                  <a href="game.php?page=banList&amp;side={$page + 2}">{if $page + 2 == $page}<span class="active_page">[{$page + 2}]</span>
                  {else}[{$page + 2}]{/if}</a>{/if}
                  {if $page + 3 <= $maxPage}            
                  <a href="game.php?page=banList&amp;side={$page + 3}">{if $page + 3 == $page}<span class="active_page">[{$page + 3}]</span>
                  {else}[{$page + 3}]{/if}</a>{/if}  
                  {if $page + 4 < $maxPage} ... {/if}   
                  {if $page + 4 <= $maxPage}
                  <a href="game.php?page=banList&amp;side={$maxPage}">{if $maxPage == $page}<span class="active_page">[{$maxPage}]</span>{else}[{$maxPage}] {/if}</a>
                  {/if}      
                  {if $page != $maxPage}&nbsp;<a href="game.php?page=banList&amp;side={$page + 1}">&raquo;</a>{/if}
               </td>
            </tr>
            <tr>
               <td colspan="5">{$LNG.bn_exists}{$banCount|number}{$LNG.bn_players_banned}</td>
            </tr>
            {else}
            <tr>
               <td colspan="5">{$LNG.bn_no_players_banned}</td>
            </tr>
            {/if}
         </table>
      </div>
   </div>
</div>
<div class="clear"></div>
</div>
{/block}