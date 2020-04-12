function planet_select(id)
{
	if($('#p'+id).prop('checked'))
	{
		$('#p'+id).prop('checked', false);
		$('#prow_'+id).removeClass('rd_planet_row_active');
	}
	else
	{
		$('#p'+id).prop('checked', true);
		$('#prow_'+id).addClass('rd_planet_row_active');
	}
};
function planet_select_all()
{
	$('.rd_checkbox').prop('checked', true);
	$('.rd_planet_row_select').addClass('rd_planet_row_active');
}
function planet_reset_all()
{
	$('.rd_checkbox').prop('checked', false);
	$('.rd_planet_row_select').removeClass('rd_planet_row_active');
}