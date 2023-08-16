{block name="title" prepend}{$LNG.al_storage}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/alliance.css">
<div id="page">
    <div id="content">
<div id="ally_content" class="conteiner">
    <div class="gray_stripo">
        <div class="titolosinistra">	
            {$LNG.al_storage} 
        </div>
        <div class="tornaindietro">
            <a href="?page=alliance">{$LNG.al_back}</a> 
        </div>                     
    </div>
    <div class="row" style="padding: 7px">
        {foreach $resourceStorage as $resourceID => $resouceData}
                <div class="col-md-12">
                    <div class="card mt-1 valueTest2">
                        <div class="card-body">
                            <div class="row sepor_conten res_{$resourceID}" style="background-image: url({$dpath}img/resources/{$resourceID}f.png);">
                                <div class="col-md-3">
                                    <div class="res_text">{$LNG.tech.$resourceID}:</div>
                                </div> 
                                <div class="col-md-9">
                                    <div class="res_count">{$resouceData.current|number}</div>
                                </div> 
                            </div> 
                        </div> 
                    </div> 
                </div>
        {/foreach}
        {if $rights.ADMIN}
            <div class="col-md-4">
                <div class="card mt-1 valueTest2"> 
                    <div class="card-body">
                        <a href="?page=alliance&amp;mode=issue" method="post">
                            <button type="button" class="btn">{$LNG.al_issue}</button>
                        </a>
                    </div>
                </div>
            </div>
        {/if}
        {if $rights.BANK}
            <div class="col-md-4">
                <div class="card mt-1 valueTest2"> 
                    <div class="card-body">
                        {if $time_vlyat < 0}
                        <a href="?page=alliance&amp;mode=issue" method="post">
                            <button type="button" class="btn">{$LNG.al_vlyat}</button>
                        </a>
                        {else}
                        <a>
                            <button type="button" class="btn">{$LNG.al_vlyat} {$LNG.al_via}: {$time_vlyat|time}</button>
                        </a>
                        {/if}
                    </div>
                </div>
            </div>
        {/if}
            <div class="col-md-4">
                <div class="card mt-1 valueTest2"> 
                    <div class="card-body">
                        {if $time_put < 0}
                        <a href="?page=alliance&amp;mode=issue" method="post">
                            <button type="button" class="btn">{$LNG.al_put}</button>
                        </a>
                        {else}
                        <a>
                            <button type="button" class="btn">{$LNG.al_put} {$LNG.al_via}: {$time_put|time}</button>
                        </a>
                        {/if}
                    </div>
                </div>
            </div>
    </div>
</div>
{/block}