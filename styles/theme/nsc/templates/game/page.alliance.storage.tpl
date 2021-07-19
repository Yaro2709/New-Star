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
    <div class="alleanza45">
    {foreach $resourceStorage as $resourceID => $resouceData} 
        <div class="ally_contents sepor_conten res_{$resourceID}" style="background-image: url({$dpath}img/resources/{$resourceID}f.png);">
            <div class="res_text">{$LNG.tech.$resourceID}:</div>
            <div class="res_count">{$resouceData.current|number}</div>
            <div class="clear"></div>
        </div>   
        {/foreach}
        <div class="ally_contents" style="padding:10px;">
            {if $rights.ADMIN}
            <div> 
                <a href="?page=alliance&amp;mode=issue" method="post" class="alleanza46">{$LNG.al_issue}</a>
            </div>
            {/if}
            {if $rights.BANK}
            <div>
                {if $time_vlyat < 0}
                <a href="?page=alliance&amp;mode=vlyat" method="post" class="alleanza46">{$LNG.al_vlyat}</a>
                {else}
                <a class="alleanza46">{$LNG.al_vlyat} {$LNG.al_via}: {$time_vlyat|time}</a>
                {/if}
            </div>
            {/if}
            <div>
                {if $time_put < 0}
                <a href="?page=alliance&amp;mode=put" class="alleanza46">{$LNG.al_put}</a>
                {else}
                <a class="alleanza46">{$LNG.al_put} {$LNG.al_via}: {$time_put|time}</a>
                {/if}
            </div>
            <div class="clear"></div>        
        </div>
	</div> 
</div>
{/block}