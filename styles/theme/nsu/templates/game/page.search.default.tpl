{block name="title" prepend}{$LNG.lm_search}{/block}
{block name="content"}
<link rel="stylesheet" type="text/css" href="{$dpath}css/statistics.css">
<div id="page">
	<div id="content">
        <div id="ally_content" class="conteiner">
            <div class="gray_stripo">
                {$LNG.sh_search_in_the_universe} 
                <span id="loading" class="tornaindietro" style="display:none;">{$LNG.sh_loading}</span>
            </div>
            <div class="row">
                <div class="col-12 statbarsup1">
                    <table class="tablesorter ally_ranks">
                        <tr>
                            <td>
                                {html_options options=$modeSelector name="type" id="type"}
                                <input type="text" name="searchtext" id="searchtext">
                                <input type="button" value="{$LNG.sh_search}">
                            </td>
                        </tr>
                    </table>
                    <div id="search_table"></div>
                </div>
            </div>
            
        </div>
    </div>
</div>
{/block}