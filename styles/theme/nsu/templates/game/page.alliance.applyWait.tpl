{block name="title" prepend}{$LNG.lm_research}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
    <div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_flettab" style="padding-right:0;">{$request_text}</div>
            <div class="ally_img">
                <table class="no_visible">
                    <tbody><tr>
                        <td>
                            <img src="./styles/theme/nsc/img/title/al_app.jpg" alt="*">
                            <span class="designation">
                                <span>{$LNG.al_your_request_title}</span><br>
                            </span>
                        </td>
                    </tr>
                </tbody></table>
            </div>
            <div class="clear"></div>
                <div class="build_band2" style="padding-right:0;">
                <form action="game.php?page=alliance&amp;mode=cancelApply" method="post">
                    <input class="bottom_band_submit message_check_message" id="submit" name="button" value="{$LNG.al_continue}" type="button"> 
                </form>
                <p>{$LNG.al_request_wait_message_step_2}</p>
            </div>
        </div>
    </div>
</div>
{/block}