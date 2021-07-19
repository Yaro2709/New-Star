{block name="title" prepend}{$LNG.lm_options}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/settings.css">
<div id="page">
	<div id="content">
	<div id="achivment">
    <div class="ach_main_block academy_main_block1">
    <form action="game.php?page=settings&amp;mode=send" method="post">
    <input type="hidden" name="mode" value="send">
    <div id="academy_head" class="gray_stripe">
        {$LNG.lm_options}
    </div>
	<div id="academy" class="ach_main_content">
        <div class="ach_menu">
            <ul>
                <li class="skils1 active">
                	<a href="#" onclick="openV('skils1', 1)">{$LNG.op_vacation}</a>
                </li>
            </ul>  
        </div>
		<div id="skils1" class="settingleft" style="display:block;">
            <div style="float:left; width:100%;">
                <div class="ach_content" style="min-height: 130px;">
                    <div class="gray_stripe">{$LNG.op_vacation}</div>
                        <div class="ally_contents" style="padding-bottom:20px;">
                            <div class="content_box">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_end_vacation_mode}</label>
                                <input name="vacation" type="checkbox" value="1" {if !$canVacationDisbaled}disabled{/if}>
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_dlte_account}</label>
                                <input name="delete" type="checkbox" value="1" {if $delete > 0}checked="checked"{/if}>
                            </div>
                        </div>
                    <div class="clear"></div>
                </div>
                <div class=" build_band2 ticket_bottom_band">    	
                    <input value="{$LNG.op_save_changes}" type="submit" style="width: 568px;">
                </div>
            </div>
        </div>
	</div>
    </form>
    </div>
    </div>
{/block}