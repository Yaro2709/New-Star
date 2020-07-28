function CheckArg()
{
	
	r901	= $('#r901').val();
	r902	= $('#r902').val();
	r903	= $('#r903').val();

		
	if(r901 + r902 + r903 > 0) {
		//document.getElementById('form').submit();
		$('#form').submit();
	} else {
		alert('???');
	}
	return false;
}



var ContentDOM	= $(),
	CountPlanet = 0,
	CostOne		= 0,
	r901 		= 0,
	r902 		= 0,
	r903 		= 0,
	DOMr901		= $(),
	DOMr902		= $(),
	DOMr903		= $(),
	DOMs901		= $(),
	DOMs902		= $(),
	DOMs903		= $()
;

$(document).ready(function()
{
	ContentDOM	= $('#ally_content');

	DOMr901		= ContentDOM.find('#r901');
	DOMr902		= ContentDOM.find('#r902');
	DOMr903		= ContentDOM.find('#r903');

	DOMs901		= ContentDOM.find('#s901');
	DOMs902		= ContentDOM.find('#s902');
	DOMs903		= ContentDOM.find('#s903');

	DOMs922		= ContentDOM.find('#cost');

	DOMr901.keyup(CalculatorResources);
	DOMr902.keyup(CalculatorResources);
	DOMr903.keyup(CalculatorResources);
});

function CalculatorResources()
{
	var Max901 	= Number(getRessource('metal'));
	var Max902 	= Number(getRessource('crystal'));
	var Max903 	= Number(getRessource('deuterium'));
	var Max922 	= Number(getRessource('antimatter'));
	
	var Val901 	= Number(DOMr901.val().replace(/[^[0-9]|\.]/g, ''));
	var Val902 	= Number(DOMr902.val().replace(/[^[0-9]|\.]/g, ''));
	var Val903 	= Number(DOMr903.val().replace(/[^[0-9]|\.]/g, ''));	

	var sVal901 = Val901 * CountPlanet;
	var sVal902 = Val902 * CountPlanet;
	var sVal903 = Val903 * CountPlanet;
	var sVal922 = CostOne * CountPlanet;	
	
	if(sVal901 > Max901)
		DOMs901.text(NumberGetHumanReadable(sVal901)).css('color', '#DC2E31');	
	else
		DOMs901.text(NumberGetHumanReadable(sVal901)).css('color', '#a47d7a');	
	
	if(sVal902 > Max902)	
		DOMs902.text(NumberGetHumanReadable(sVal902)).css('color', '#DC2E31');	
	else
		DOMs902.text(NumberGetHumanReadable(sVal902)).css('color', '#5ca6aa');	
		
	if(sVal903 > Max903)
		DOMs903.text(NumberGetHumanReadable(sVal903)).css('color', '#DC2E31');
	else
		DOMs903.text(NumberGetHumanReadable(sVal903)).css('color', '#339966');	
	
	DOMr901.val(NumberGetHumanReadable(Val901));
	DOMr902.val(NumberGetHumanReadable(Val902));
	DOMr903.val(NumberGetHumanReadable(Val903));
	
	if(sVal922 > Max922)
		DOMs922.text(NumberGetHumanReadable(sVal922)).css('color', '#DC2E31');
	else
		DOMs922.text(NumberGetHumanReadable(sVal922)).css('color', '#76C400');
	
}

function planet_select(id)
{
	if($('#p'+id).prop('checked'))
	{
		
		if(CountPlanet > 0)
			CountPlanet--;
		
		CalculatorResources();
		$('#p'+id).prop('checked', false);
		$('#prow_'+id).removeClass('rd_planet_row_active');
	}
	else
	{
		CountPlanet++;
		CalculatorResources();
		$('#p'+id).prop('checked', true);
		$('#prow_'+id).addClass('rd_planet_row_active');
	}
};

function planet_select_all()
{
	CountPlanet = MaxPlanet;
	CalculatorResources();
	$('.rd_checkbox').prop('checked', true);
	$('.rd_planet_row_select').addClass('rd_planet_row_active');
}

function planet_reset_all()
{
	CountPlanet = 0;
	CalculatorResources();
	$('.rd_checkbox').prop('checked', false);
	$('.rd_planet_row_select').removeClass('rd_planet_row_active');
}
function delivery_send()
{
	DOMr901.val(function(i, old) {
			return old.replace(/[^[0-9]|\.]/g, '');
		});
	DOMr902.val(function(i, old) {
			return old.replace(/[^[0-9]|\.]/g, '');
		});
	DOMr903.val(function(i, old) {
			return old.replace(/[^[0-9]|\.]/g, '');
		});
		
	return true;
}