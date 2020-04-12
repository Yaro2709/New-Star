{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner">
         <div class="gray_stripe">
            <span style="float:left; display:block; width:140px;">{$LNG.alm_ally}</span>
            <div class="search_aly">
               <form action="game.php?page=alliance&amp;mode=search" method="post">
                  <input type="text" placeholder="{$LNG.al_alliance_search}" name="searchtext" value=""> 
                  <input type="submit" value="{$LNG.al_find_submit}"> 
               </form>
            </div>
            <a href="game.php?page=alliance&amp;mode=create" class="batn_lincks right_flank plus">{$LNG.al_alliance_make}</a>   
         </div>	
      </div>
   </div>
</div>
<div class="clear"></div>
</div>
{/block}