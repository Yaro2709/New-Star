{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
    <div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_stripo" style="padding-right:0; margin-bottom:5px;">
                {$LNG.al_diplo_head}
                <div class="tornaindietro"><a href="game.php?page=alliance&amp;mode=admin">{$LNG.al_back}</a></div>
            </div>
            <div class="row" style="padding: 7px">
                {foreach $diploList.0 as $diploMode => $diploAlliances}
                <div class="col-md-12">
                    <div class="card mt-1 valueTest2">
                        <div class="card-body">
                            <p class="c-diplo-{$diploMode} card-title">
                                <span class="text-align-right">{$LNG.al_diplo_level.$diploMode}</span>
                                <span class="text-align-left">
                                    <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyCreate&amp;diploMode={$diploMode}" onclick="return Dialog.open(this.href, 716, 300);" class="batn_lincks right_flank diplomacy" style="position: absolute;right: 15px;top: 7px;">{$LNG.al_diplo_head}</a>
                                </span>
                            </p>
                            <p class="card-text overflow-auto" style="max-height: 50px;">
                                {foreach $diploAlliances as $diploID => $diploName}
                                    {$diploName}
                                    {if $diploMode != 5}
                                        <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyDelete&amp;id={$diploID}" onclick="return confirm('{$LNG.al_diplo_confirm_delete}');" style="text-decoration:none; font-size:14px;">
                                            <img src="{$dpath}img/general/false.png" alt="" width="14" height="14">
                                        </a>
                                    {/if}	
                                {foreachelse}
                                    <span>{$LNG.al_diplo_no_entry}</span>
                                {/foreach}
                            </p>
                        </div> 
                    </div> 
                </div>
                {/foreach}
                <div class="col-md-6">
                    <div class="card mt-1 mr-1 valueTest2">
                        <div class="card-body">
                            <p class="card-title text-align-center">
                                {$LNG.al_diplo_accept}
                            </p>
                            <p class="card-text">
                                {if array_filter($diploList.1)}
                                    {foreach $diploList.1 as $diploMode => $diploAlliances}	
                                        {if !empty($diploAlliances)}
                                            {$LNG.al_diplo_level.$diploMode}<br/>
                                            <ul>
                                                {foreach $diploAlliances as $diploID => $diploName}
                                                <li>
                                                    {$diploName}
                                                        <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyAccept&amp;id={$diploID}" onclick="return confirm('{$LNG.al_diplo_accept_yes_confirm}');">
                                                            <img src="{$dpath}img/general/true.png" alt="" width="16" height="16">
                                                        </a>
                                                    {if $diploMode != 5}
                                                        <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyDelete&amp;id={$diploID}" onclick="return confirm('{$LNG.al_diplo_accept_no_confirm}');">
                                                            <img src="{$dpath}img/general/false.png" alt="" width="16" height="16">
                                                        </a>
                                                    {/if}
                                                </li>
                                                {/foreach}
                                            </ul>
                                        {/if}
                                    {/foreach}
                                {else}
                                    <span>{$LNG.al_diplo_no_accept}</span>
                                {/if}
                            </p>
                        </div> 
                    </div> 
                </div>
                <div class="col-md-6">
                    <div class="card mt-1 valueTest2">
                        <div class="card-body">
                            <p class="card-title text-align-center">
                                {$LNG.al_diplo_accept_send}
                            </p>
                            <p class="card-text">
                                {if array_filter($diploList.2)}
                                    {foreach $diploList.2 as $diploMode => $diploAlliances}	
                                        {if !empty($diploAlliances)}
                                            {$LNG.al_diplo_level.$diploMode}<br/>
                                            <ul>
                                                {foreach $diploAlliances as $diploID => $diploName}
                                                <li>
                                                    {$diploName}
                                                    {if $diploMode != 5}
                                                        <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyDelete&amp;id={$diploID}" onclick="return confirm('{$LNG.al_diplo_confirm_delete}');">
                                                            <img src="{$dpath}img/general/false.png" alt="" width="16" height="16">
                                                        </a>
                                                    {/if}
                                                </li>
                                                {/foreach}
                                            </ul>
                                        {/if}
                                    {/foreach}
                                {else}
                                    <span>{$LNG.al_diplo_no_accept}</span>
                                {/if} 
                            </p>
                        </div> 
                    </div> 
                </div>
            </div>
        </div>
    </div>
</div>
{/block}