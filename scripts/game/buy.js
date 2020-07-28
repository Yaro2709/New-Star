function updateVars(ID)
{	
	var Element 	= ID;
	$('#Element').val(Element);
	$('#img').attr('src', $('#img').data('src')+Element+'.gif');
	$('#price').text(NumberGetHumanReadable(CostInfo[Element][2]));
	$('#traderHead').text(CostInfo[Element][1]);
	$('#batn').show();
	Reset();
}

function Total()
{
	var Count	= $('#count').val();
	
	if(isNaN(Count) || Count < 0) {
		$('#count').val(0);
		Count = 0;
	}
	
	var Element 	= $('#Element').val();
	$('#total_price_factor').text(NumberGetHumanReadable(CostInfo[Element][2] * Math.pow(CostInfo[Element][3], (Number(CostInfo[Element][0]) + Number(Count)))));
    $('#total_price_count').text(NumberGetHumanReadable(CostInfo[Element][2] * Count));
}

function Reset()
{
	$('#count').val(0);
	$('#total_price_factor').text(0);
    $('#total_price_count').text(0);
}