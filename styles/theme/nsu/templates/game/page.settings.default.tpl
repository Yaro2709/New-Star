{block name="title" prepend}{$LNG.lm_options}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/settings.css">
<div id="page">
	<div id="content">
	<div id="achivment">
    <div class="ach_main_block academy_main_block1">
    <form action="game.php?page=settings" method="post">
    <input type="hidden" name="mode" value="send">
    <div id="academy_head" class="gray_stripe">
        {$LNG.lm_options}
    </div>
	<div id="academy" class="ach_main_content">
        <div class="ach_menu">
            <ul>
                <li class="skils1 {if $cookie == 1}active{/if}">
                	<a href="#" onclick="openV('skils1', 1)">{$LNG.op_user}</a>
                </li>
                <li class="skils2 {if $cookie == 2}active{/if}">
                	<a href="#" onclick="openV('skils2', 2)">{$LNG.op_general_settings}</a>
                </li>
                <li class="skils3 {if $cookie == 3}active{/if}">
                	<a href="#" onclick="openV('skils3', 3)">{$LNG.op_galaxy_settings}</a>
                </li>
                <li class="skils4 {if $cookie == 4}active{/if}">
                	<a href="#" onclick="openV('skils4', 4)">{$LNG.op_vacation_delete_mode}</a>
                </li>
                {if $userAuthlevel > 0}
                <li class="skils5 {if $cookie == 5}active{/if}">
                	<a href="#" onclick="openV('skils5', 5)">{$LNG.op_admin_title_options}</a>
                </li>
                {/if}
            </ul>  
        </div>
		<div id="skils1" class="settingleft" {if $cookie == 1} style="display:block;"{else}style="display:none;"{/if}>
            <div style="float:left; width:100%;">
                <div class="ach_content" style="min-height: 130px;">
                    <div class="gray_stripe">{$LNG.op_user_data}</div>
                        <div class="ally_contents" style="padding-bottom:20px;">
                            <div class="content_box">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_foto}</label>
                                <input name="foto" maxlength="90" size="20" value="{$foto}" type="text" class="autocomplete">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_background}</label>
                                <input name="background" maxlength="90" size="20" value="{$background}" type="text" class="autocomplete">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_username}</label>
                                {if $changeNickTime < 0}<input name="username" size="20" value="{$username}" type="text">{else}{$username}{/if}
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_old_pass}</label>
                                <input name="password" size="20" type="password" class="autocomplete">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_new_pass}</label>
                                <input name="newpassword" size="20" maxlength="40" type="password" class="autocomplete">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_repeat_new_pass}</label>
                                <input name="newpassword2" size="20" maxlength="40" type="password" class="autocomplete">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_email_adress}</label>
                                <input name="email" maxlength="64" size="20" value="{$email}" type="text">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_permanent_email_adress}</label>
                                {$permaEmail}
                                <div class="clear"></div>
                            </div>
                        </div>
                    <div class="clear"></div>
                </div>
                <div class=" build_band2 ticket_bottom_band">    	
                    <input value="{$LNG.op_save_changes}" type="submit" style="width: 568px;">
                </div>
            </div>
        </div>
        <div id="skils2" class="settingleft" {if $cookie == 2} style="display:block;"{else}style="display:none;"{/if}>
            <div style="float:left; width:100%;">
                <div class="ach_content" style="min-height: 130px;">
                    <div class="gray_stripe">{$LNG.op_general_settings}</div>
                        <div class="ally_contents" style="padding-bottom:20px;">
                            <div class="content_box">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_timezone}</label>
                                {html_options name=timezone options=$Selectors.timezones selected=$timezone}
                                {if count($Selectors.lang) > 1}
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_lang}</label>
                                {html_options name=language options=$Selectors.lang selected=$userLang}
                                {/if}
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_sort_planets_by}</label>
                                {html_options name=planetSort options=$Selectors.Sort selected=$planetSort}
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_sort_kind}</label>
                                {html_options name=planetOrder options=$Selectors.SortUpDown selected=$planetOrder}
                                {if count($Selectors.Skins) > 1}
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_skin_example}</label>
                                {html_options options=$Selectors.Skins selected=$theme name="theme" id="theme"}
                                {/if}
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_active_build_messages}</label>
                                <input name="queueMessages" type="checkbox" value="1" {if $queueMessages == 1}checked="checked"{/if}>
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_active_spy_messages_mode}</label>
                                <input name="spyMessagesMode" type="checkbox" value="1" {if $spyMessagesMode == 1}checked="checked"{/if}>
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_block_pm}</label>
                                <input name="blockPM" type="checkbox" value="1" {if $blockPM == 1}checked="checked"{/if}>
                            </div>
                        </div>
                    <div class="clear"></div>
                </div>
                <div class=" build_band2 ticket_bottom_band">    	
                    <input value="{$LNG.op_save_changes}" type="submit" style="width: 568px;">
                </div>
            </div>
        </div>
        <div id="skils3" class="settingleft" {if $cookie == 3} style="display:block;"{else}style="display:none;"{/if}>
            <div style="float:left; width:100%;">
                <div class="ach_content" style="min-height: 130px;">
                    <div class="gray_stripe">{$LNG.op_galaxy_settings}</div>
                        <div class="ally_contents" style="padding-bottom:20px;">
                            <div class="content_box">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_spy_probes_number}</label>
                                <input name="spycount" size="{$spycount|count_characters + 3}" value="{$spycount}" type="int">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_max_fleets_messages}</label>
                                <input name="fleetactions" maxlength="2" size="{$fleetActions|count_characters + 2}" value="{$fleetActions}" type="int">
                            </div>
                        </div>
                    <div class="gray_stripe">{$LNG.op_shortcut} ({$LNG.op_show})</div>
                        <div class="ally_contents" style="padding-bottom:20px;">
                            <div class="content_box">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_spy}</label>
                                <input name="galaxySpy" type="checkbox" value="1" {if $galaxySpy == 1}checked="checked"{/if}>
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_write_message}</label>
                                <input name="galaxyMessage" type="checkbox" value="1" {if $galaxyMessage == 1}checked="checked"{/if}>
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_add_to_buddy_list}</label>
                                <input name="galaxyBuddyList" type="checkbox" value="1" {if $galaxyBuddyList == 1}checked="checked"{/if}>
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_missile_attack}</label>
                                <input name="galaxyMissle" type="checkbox" value="1" {if $galaxyMissle == 1}checked="checked"{/if}>
                            </div>
                        </div>
                    <div class="clear"></div>
                </div>
                <div class=" build_band2 ticket_bottom_band">    	
                    <input value="{$LNG.op_save_changes}" type="submit" style="width: 568px;">
                </div>
            </div>
        </div>
        <div id="skils4" class="settingleft" {if $cookie == 4} style="display:block;"{else}style="display:none;"{/if}>
            <div style="float:left; width:100%;">
                <div class="ach_content" style="min-height: 130px;">
                    <div class="gray_stripe">{$LNG.op_vacation_delete_mode}</div>
                        <div class="ally_contents" style="padding-bottom:20px;">
                            <div class="content_box">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_activate_vacation_mode}</label>
                                <input name="vacation" type="checkbox" value="1">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_dlte_account}</label>
                                <input name="delete" type="checkbox" value="1" {if $delete > 0}checked="checked"{/if}>
                            </div>
                        </div>
                    {if isModuleAvailable($smarty.const.MODULE_BANNER)}
                    <div class="gray_stripe">{$LNG.ov_userbanner}</div>
                        <div class="ally_contents" style="padding-bottom:20px;">
                            <div class="content_box">
                                <div class="clear"></div>
                                <img src="userpic.php?id={$userid}" alt="" width="513" height="95" id="userpic">
                                <br><br>
                                <table>
                                <tr><td class="transparent">HTML:</td>
                                <td class="transparent"><input type="text" value='<a href="{$SELF_URL}{if $ref_active}index.php?ref={$userid}{/if}"><img src="{$SELF_URL}userpic.php?id={$userid}"></a>' readonly="readonly" style="width:450px;"></td></tr>
                                <tr><td class="transparent">BBCode:</td>
                                <td class="transparent"><input type="text" value="[url={$SELF_URL}{if $ref_active}index.php?ref={$userid}{/if}][img]{$SELF_URL}userpic.php?id={$userid}[/img][/url]" readonly="readonly" style="width:450px;"></td></tr>
                                </table>
                            </div>
                        </div>
                    {/if}
                    <div class="clear"></div>
                </div>
                <div class=" build_band2 ticket_bottom_band">    	
                    <input value="{$LNG.op_save_changes}" type="submit" style="width: 568px;">
                </div>
            </div>
        </div>
        {if $userAuthlevel > 0}
        <div id="skils5" class="settingleft" {if $cookie == 5} style="display:block;"{else}style="display:none;"{/if}>
            <div style="float:left; width:100%;">
                <div class="ach_content" style="min-height: 130px;">
                    <div class="gray_stripe">{$LNG.op_admin_title_options}</div>
                        <div class="ally_contents" style="padding-bottom:20px;">
                            <div class="content_box">
                                <div class="clear"></div>
                                <label class="left_label" style="width: 300px;">{$LNG.op_admin_planets_protection}</label>
                                <input name="adminprotection" type="checkbox" value="1" {if $adminProtection > 0}checked="checked"{/if}>
                            </div>
                        </div>
                    <div class="clear"></div>
                </div>
                <div class=" build_band2 ticket_bottom_band">    	
                    <input value="{$LNG.op_save_changes}" type="submit" style="width: 568px;">
                </div>
            </div>
        </div>
        {/if}
	</div>
    </form>
    </div>
    </div>
{/block}