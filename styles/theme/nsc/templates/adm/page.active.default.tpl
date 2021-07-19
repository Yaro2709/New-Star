{block name="title" prepend}{$LNG.lm_active}{/block}
{block name="script" append}{/block}
{block name="content"}
<script type="text/javascript">
	function activeUser(validationID, validationKey) {
		$.getJSON('index.php?page=vertify&mode=json&i='+validationID+'&k='+validationKey, function(data){
			alert(data);
			parent.frames['Hauptframe'].location.reload();
		});
		return false;
	}
</script>
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_active}</h5>
        <div class="card-body">
            <table class="table table-dark table-hover">
                <thead>
                    <tr>
                        <th>{$LNG.input_id}</th>
                        <th>{$LNG.ap_username}</th>
                        <th>{$LNG.ap_datum}</th>
                        <th>{$LNG.ap_email}</th>
                        <th>{$LNG.ap_ip}</th>
                        <th>{$LNG.ap_status}</th>
                        <th>{$LNG.ap_del}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach name=User item=User from=$Users}
                    <tr>
                        <td>{$User.id}</td>
                        <td>{$User.name}</td>
                        <td><nobr>{$User.date}</nobr></td>
                        <td>{$User.email}</td>
                        <td>{$User.ip}</td>
                        <td><a href="#" onclick="return activeUser({$User.id},'{$User.validationKey}');">{$LNG.ap_aktivieren}</a></td>
                        <td><a href="?page=active&amp;action=delete&id={$User.id}" onclick="return confirm('{$LNG.ap_sicher}{$User.username} {$LNG.ap_entfernen}');"><img border="0" src="./styles/resource/images/alliance/CLOSE.png" width="16" height="16"></a></td>
                    </tr>
                    {/foreach}
                    <tr>
                        <td colspan="8">{$LNG.ap_insgesamt} {count($Users)} {$LNG.ap_nicht_aktivierte}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</main>
{/block}