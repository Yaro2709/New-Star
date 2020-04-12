{block name="title" prepend}{$LNG.lm_chat}{/block}
{block name="content"}
<div id="page">
	<div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_flettab" style="padding-right:0;">
               {$LNG.lm_chat}
            </div>
<iframe src="./chat/index.php?action={$smarty.get.action|default:''|escape:'html'}" style="border: 0px;width:100%;height:300px;" ALLOWTRANSPARENCY="true"></iframe>
</div>
</div>
</div>
{/block}