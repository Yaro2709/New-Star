{block name="title" prepend}{$LNG.lm_dump}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.lm_dump}</h5>
        <div class="card-body">
            <form action="admin.php?page=dump" method="post">
            <input type="hidden" name="action" value="dump">
                <div class="form-group">
                    <input type="checkbox" id="selectAll">
                    <label for="selectAll">{$LNG.du_select_all_tables}</label>
                    {html_options multiple="multiple" class="form-control" id="selectAll" size="10" name="dbtables[]" id="dbtables" values=$dumpData.sqlTables output=$dumpData.sqlTables}
                </div>
                <button type="submit" class="btn btn-primary">{$LNG.du_submit}</button>
            </form>
        </div>
    </div>
</main>
<script>
$(function() {
	$('#selectAll').on('click', function() {
		if($('#selectAll').prop('checked') === true)
		{
			$('#dbtables').val(function() {
				return $(this).children().map(function() { 
					return $(this).attr('value');
				}).toArray();
			});
		}
		else
		{
			$('#dbtables').val(null);
		}
	});
});
</script>
{/block}