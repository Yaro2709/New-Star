{block name="title" prepend}{$LNG.al_transfer_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
   <div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_stripo">
                {$LNG.al_transfer_alliance}
                <span class="tornaindietro"><a href="game.php?page=alliance&amp;mode=admin">{$LNG.al_back}</a></span>
            </div>
            <form action="game.php?page=alliance&amp;mode=admin&amp;action=transfer" method="post">
                <div class="ally_contents" style="padding: 10px;">
                    {$LNG.al_transfer_to}: 
                    {html_options name=newleader options=$transferUserList class="big_ally_select" style="width: 595px;"}
                </div>
                <div class="alleanza57" style="margin-top: 0; "></div>
                <div class="frax4">
                    <input type="submit" class="alleanza55" value="{$LNG.al_transfer_submit}">
                </div>
            </form>
        </div>
    </div>
</div>  
{/block}