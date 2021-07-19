$(function () {
    $('#count_calculator input[type=text]').keyup(function () {
        countDots();
    });
    $('form').submit(function () {
        DotsToCount();
    });
});

function DotsToCount() {
    $('#count_calculator input[type=text]').val(function (i, old) {
        return old.replace(/[^[0-9]|\.]/g, '');
    });
}

function countDots() {
    $('#count_calculator input[type=text]').val(function (i, old) {
        return NumberGetHumanReadable(old.replace(/[^[0-9]|\.]/g, ''));
    });
}

function updateVars(ID)
{	
	var shipID 	= ID;
    $('#shipID').val(shipID);
	$('#img').attr('src', $('#img').data('src')+shipID+'.gif');
	$('#traderHead').text(CostInfo[shipID][1]);
    $('#batn').show();
	Reset();
}

function MaxShips()
{
	var shipID 	= $('#shipID').val();
	$('#count').val(CostInfo[shipID][0]);
	Total();
}

function Total()
{
    DotsToCount();
	var Count	= $('#count').val();
    
	if(isNaN(Count) || Count < 0) {
		($('#count').val(0));
		Count = 0;
	}
	countDots();
	var shipID 	= $('#shipID').val();
	$('#total_metal').text(NumberGetHumanReadable(CostInfo[shipID][2][901] * Count * (1 - Charge / 100)));
	$('#total_crystal').text(NumberGetHumanReadable(CostInfo[shipID][2][902] * Count * (1 - Charge / 100)));
	$('#total_deuterium').text(NumberGetHumanReadable(CostInfo[shipID][2][903] * Count * (1 - Charge / 100)));
	$('#total_darkmatter').text(NumberGetHumanReadable(CostInfo[shipID][2][921] * Count * (1 - Charge / 100)));
}

function Reset()
{
	$('#count').val(0);
	$('#total_metal').text(0);
	$('#total_crystal').text(0);
	$('#total_deuterium').text(0);
	$('#total_darkmatter').text(0);
}

$(document).ready(function() {
	updateVars();
});