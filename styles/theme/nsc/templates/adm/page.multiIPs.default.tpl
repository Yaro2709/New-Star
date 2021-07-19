{block name="title" prepend}{$LNG.lm_multiip}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_multiip}</h5>
        <div class="card-body">
            <table class="table table-dark">
                <thead>
                    <tr>
                        <th>{$LNG.input_id}</th>
                        <th>{$LNG.se_id_owner}</th>
                        <th>{$LNG.se_name}</th>
                        <th>{$LNG.se_email}</th>
                        <th>{$LNG.ac_register_time}</th>
                        <th>{$LNG.ac_act_time}</th>
                        <th>{$LNG.mip_known}</th>
                    </tr>
                </thead>
                {foreach $multiGroups as $IP => $Users}
                    <tbody>
                        <tr>
                            <td rowspan="{count($Users)}">{$IP}</td>
                            {foreach $Users as $ID => $User}
                            <td>{$ID}</td>
                            <td>{$User.username}</td>
                            <td>{$User.email}</td>
                            <td>{$User.register_time}</td>
                            <td>{$User.onlinetime}</td>
                            <td>{if ($User.isKnown != 0)}<a href="admin.php?page=multiip&amp;action=unknown&amp;id={$ID}"><img src="styles/resource/images/true.png"></a>{else}<a href="admin.php?page=multiip&amp;action=known&amp;id={$ID}"><img src="styles/resource/images/false.png"></a>{/if}</td>
                            </tr>{if !$User@last}<tr>{/if}
                            {/foreach}
                    </tbody>
                {/foreach}
            </table>
        </div>
    </div>
</main>
{/block}