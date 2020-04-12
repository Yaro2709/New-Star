{block name="title" prepend}{$LNG.hnav_search}{/block}
{block name="content"}
<div id="page">
   <div id="content">
      <table style="width:760px">
         <tr>
            <th>{$LNG.sh_search_in_the_universe}</th>
         </tr>
         <tr>
            <td>
               {html_options options=$modeSelector name="type" id="type"}
               <input type="text" name="searchtext" id="searchtext">
               <input type="button" value="{$LNG.sh_search}">
            </td>
         </tr>
      </table>
   </div>
</div>
<div class="clear"></div>
</div>
{/block}