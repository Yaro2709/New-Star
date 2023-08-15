{block name="title" prepend}{$LNG.lm_messagelist}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_messagelist}</h5>
        <div class="card-body">
            <form action="admin.php?page=messageList" method="post" id="form">
            <input type="hidden" name="side" value="{$page}" id="side">
                <table class="table table-dark table-hover"> 
                    <thead>
                        <tr>
                            <th><label for="type">{$LNG.ml_type}</label></th>
                            <th>{html_options options=$categories selected=$type name="type" class="form-control" id="type"}</th>
                            <th>{$LNG.ml_date_range}</th>
                            <th>
                                <div class="input-group">
                                    <input placeholder="dd" value="{$dateStart.day|default:''}" type="text" id="dateStartDay" name="dateStart[day]" class="form-control">
                                    <input placeholder="mm" value="{$dateStart.month|default:''}" type="text" id="dateStartMonth" name="dateStart[month]" class="form-control">
                                    <input placeholder="yyyy" value="{$dateStart.year|default:''}" type="text" id="dateStartYear" name="dateStart[year]" class="form-control">
                                </div>
                            </th>
                            <th>   
                                <div class="input-group">
                                    <input placeholder="dd" value="{$dateEnd.day|default:''}" type="text" id="dateEndDay" name="dateEnd[day]" class="form-control">
                                    <input placeholder="mm" value="{$dateEnd.month|default:''}" type="text" id="dateEndMonth" name="dateEnd[month]" class="form-control">
                                    <input placeholder="yyyy" value="{$dateEnd.year|default:''}" type="text" id="dateEndYear" name="dateEnd[year]" class="form-control">
                                </div>
                            </th>
                        </tr>
                        <tr>
                            <th><label for="sender">{$LNG.ml_sender}</label></th>
                            <th><input type="text" id="sender" name="sender" value="{$sender}" class="form-control"></th>
                            <th><label for="receiver">{$LNG.ml_receiver}</label></th>
                            <th colspan="2"><input type="text" id="receiver" name="receiver" value="{$receiver}" class="form-control"></th>
                        </tr>
                    </thead>
                </table>
                <input class="btn btn-primary mb-3" type="submit" value="{$LNG.button_proceed}">
                <table class="table table-dark table-hover"> 	
                    <thead>
                        <tr>
                            <th class="right" colspan="{if $type == 100}6{else}5{/if}">{$LNG.mg_page}: {if $page != 1}<a href="#" onclick="gotoPage({$page - 1});return false;">&laquo;</a> {/if}{for $site=1 to $maxPage}<a href="#" onclick="gotoPage({$site});return false;">{if $site == $page}<span><b>[{$site}]</b></span>{else}[{$site}]{/if}</a>{if $site != $maxPage} {/if}{/for}{if $page != $maxPage} <a href="#" onclick="gotoPage({$page + 1});return false;">&raquo;</a>{/if}</th>
                        </tr>
                        <tr>
                            <th>{$LNG.input_id}</th>
                            {if $type == 100}<th>{$LNG.ml_type}</th>{/if}
                            <th>{$LNG.ml_date}</th>
                            <th>{$LNG.ml_sender}</th>
                            <th>{$LNG.ml_receiver}</th>
                            <th>{$LNG.ml_subject}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $messageList as $messageID => $messageRow}
                        <tr data-messageID="{$messageID}">
                            <td><a href="#" class="toggle">{$messageID}</a></td>
                            {if $type == 100}<td><a href="#" class="toggle">{$LNG.mg_type[$messageRow.type]}</a></td>{/if}
                            <td><a href="#" class="toggle">{$messageRow.time}</a></td>
                            <td><a href="#" class="toggle">{$messageRow.sender}</a></td>
                            <td><a href="#" class="toggle">{$messageRow.receiver}</a></td>
                            <td><a href="#" class="toggle">{$messageRow.subject}{if $messageRow.deleted}&nbsp;<img src="./styles/resource/images/admin/i.gif" width="16" height="16" alt="" class="tooltip" data-tooltip-content="{$LNG.ml_deleted}">{/if}</a></td>
                        </tr>
                        <tr id="contentID{$messageID}" style="display:none;">
                            <td class="left" colspan="{if $type == 100}6{else}5{/if}" style="padding:5px 8px;">{$messageRow.text}</td>
                        </tr>
                    {/foreach}
                    </tbody>
                    <thead>
                        <tr>
                            <th class="right" colspan="{if $type == 100}6{else}5{/if}">{$LNG.mg_page}: {if $page != 1}<a href="#" onclick="gotoPage({$page - 1});return false;">&laquo;</a> {/if}{for $site=1 to $maxPage}<a href="#" onclick="gotoPage({$site});return false;">{if $site == $page}<span><b>[{$site}]</b></span>{else}[{$site}]{/if}</a>{if $site != $maxPage} {/if}{/for}{if $page != $maxPage} <a href="#" onclick="gotoPage({$page + 1});return false;">&raquo;</a>{/if}</th>
                        </tr>
                    </thead>
                </table>
            </form>
        </div>
    </div>
</main>
<script src="scripts/admin/messageList.js"></script>
{/block}