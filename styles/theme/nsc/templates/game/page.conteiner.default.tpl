{block name="title" prepend}{$LNG.lm_container}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/conteiner.css">
<div id="page">
    <div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_stripe">
                <div class="position tooltip" data-tooltip-content="{$LNG.cont_open_24}">
                    <font color="#2db300"> {$sum|number}</font>
                </div>
            </div>
            <div class="ally_img">
                <table class="no_visible">
                    <tr>
                        <td>
                            <img src="{$dpath}img/title/conteiner.jpg" alt="*" />
                            <span class="designation">
                                <span>{$LNG.lm_container} ({$conteiner|number})</span><br/>
                            </span>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="build_elements" class="officier_elements prem_shop">
                <div class="conteiner_rows" style="margin: 0px 7px 4px 7px;">
                    <div class="conteiner_img_utits" style="width: 100px;height: 40px;">
                        <img alt="" src="{$dpath}img/content/open_cont.png">
                    </div>
                    <form action="game.php?page=conteiner&amp;mode=open" method="post" class="getRead">
                        <input style="display:block;float:right;color: #fff;font-weight: bold; font-size: 13px;height:41px;line-height:41px;padding: 0 15px;border: 1px solid #005a87;background: #004466 !important;-moz-border-radius: 0px 0px 3px;-webkit-border-radius: 0px 0px 3px 0px;border-radius: 0px 0px 3px;" class="pre_btn_buy" type="submit" value="{$LNG.cont_open_go}"/>
                        <input style="width:50px;float:right;height:33px;line-height:33px;margin-left:6px;border-color: #005a87; margin-right:1px;-moz-border-radius: 0px 0px 0px 0px;-webkit-border-radius: 0px 0px px 0px;border-radius: 0px 0px 0px;" name="conts" id="conts" type="number" min="1" max="{if $conteiner> 50}500{else}{$conteiner}{/if}"  value="{if $conteiner> 500}500{else}{$conteiner}{/if}"/>	 
                    </form>
                </div>
                {foreach $logs as $row}
                <div class="conteiner_rows">
                    <div class="conteiner_img_utits">
                        <img alt="" src="{$dpath}gebaeude/{$row.item}.gif">
                    </div>
                    <div class="conteiner_name_utits">
                        <span style="color:#6C6;">{$LNG.tech.{$row.item}}</span>
                    </div>
                    <div class="count_blocks">
                        <span style="color:#FC6;float:right;">+ {$row.count|number} {if $row.factor > 1}<span style="color:#d90036;"><b>(x{$row.factor})</b></span> {/if}</span>     
                    </div>
                </div>
                {/foreach}	
            </div>
        </div>
    </div>
</div>
{/block}