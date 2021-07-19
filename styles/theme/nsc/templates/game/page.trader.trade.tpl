{block name="title" prepend}{$LNG.lm_trader}{/block}
{block name="content"}
<div id="page">
   <div id="content">
      <div id="ally_content" class="conteiner" style="width:500px;">
         <div class="gray_stripe">
            {$LNG.tr_sell} <span style="color:#09F;">{$LNG.tech.$tradeResourceID}</span>              
         </div>
         <form id="trader" action="" method="post">
            <input type="hidden" name="mode" value="send">
            <input type="hidden" name="resource" value="{$tradeResourceID}">
            <table class="tablesorter ally_ranks">
               <tbody>
                  <tr>
                     <td style="text-align:right;">{$LNG.tech.$tradeResourceID}</td>
                     <td class="tr_table_td_img"><img alt="{$LNG.tech.$tradeResourceID}" title="{$LNG.tech.$tradeResourceID}" src="{$dpath}img/resources/{$tradeResourceID}f.png"></td>
                     <td colspan="2"><span style="color:#F63;" id="ress">0</span></td>
                  </tr>
                  {foreach $tradeResources as $tradeResource}
                  <tr>
                     <td style="text-align:right;"><label for="resource{$tradeResource}">{$LNG.tech[$tradeResource]}</label></td>
                     <td class="tr_table_td_img">
                        <label for="resource{$tradeResource}"><img src="{$dpath}img/resources/{$tradeResource}f.png"></label>
                     </td>
                     <td>+ <input name="trade[{$tradeResource}]" id="resource{$tradeResource}" class="trade_input" value="0" size="30" type="text" data-resource="{$tradeResource}"></td>
                     <td>{$charge[$tradeResource]}</td>
                  </tr>
                  {/foreach}
               </tbody>
            </table>
            <div class="build_band ticket_bottom_band" style="padding-left:20px;">
               <input class="bottom_band_submit" value="{$LNG.tr_exchange}" type="submit">
            </div>
         </form>
      </div>
   </div>
</div>
{/block}
{block name="script" append}
<script type="text/javascript">
   var charge = {$charge|json};
</script>
{/block}