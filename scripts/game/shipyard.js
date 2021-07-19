var v  			= new Date();
var auftr 		= {};
var bx 			= {};
var valShip		= {};

$(function() {
	$('.count_ships_dots input[type=text]').keyup(function() {
		countDots();		
	});
	$('form').submit(function() {
		DotsToCount();
	});
	
	if(data.Queue != undefined)
		ShipyardInit();
});

function ShipyardInit() 
{
	Shipyard		= data.Queue;
	Amount			= new DecimalNumber(Shipyard[0][1],0);
	hanger_id		= data.b_hangar_id_plus;
	$('#timeleft').text(data.pretty_time_b_hangar);
	BuildlistShipyard();
	ShipyardInterval	= window.setInterval(BuildlistShipyard, 3000);
}

function BuildlistShipyard() {
	var n = new Date();
	var s = Shipyard[0][2] - hanger_id - Math.round((n.getTime() - v.getTime()) / 1000);
	var s = Math.round(s);
	var m = 0;
	var h = 0;
    var perSec = Math.floor(1/Shipyard[0][2]);
	
	if (s <= 0) 
	{
        Amount.sub(perSec);
		$('#val_'+Shipyard[0][3]).text(function(i, old){
			return ' ('+bd_available+NumberGetHumanReadable(parseInt(old.replace(/.* (.*)\)/, '$1').replace(/\./g, ''))+(perSec))+')';
		})
		if (parseInt(Amount) <= 0) {
			Shipyard.shift();
			if (Shipyard.length == 0) {
				$("#bx").html(Ready);
				$("#auftr0").html(Ready);
				document.location.href	= document.location.href;
				window.clearInterval(ShipyardInterval);
				return;
			}
			Amount = Amount.reset(Shipyard[0][1]);
		} else {
			$("#auftr0").text(Amount.toString());
		}
		hanger_id = 0;
		v = new Date();
		s = 0;
	}
	$("#bx").text(GetRestTimeFormat(s));
}

/*------------------------------------------------------------*/
function counting(id)
{
    DotsToCount();
	var Data 			= DatatList[id];
	var	sitem			= '#s_'+(String(id));
	var Ellimet			= $(sitem);
	var it 				= 1;
	var	count 			= Math.max(0, Number(Ellimet.find('#input_'+(String(id))).val()));
	
	if(count > MaxCount)
	{
		count = MaxCount;
		Ellimet.find('#input_'+(String(id))).val(MaxCount);
	}
	
	var costResources 	= 0;
	var res 			= 0;
	var costResources	= Array();
	costResources[901]	= 0;
	costResources[902] = 0;
	costResources[903] = 0;
	costResources[921] = 0;
	costResources[922] = 0;
	
	var metal 			= Number(String($('#current_metal').text()).replace(/[.]/g, ''));
	var crystal 		= Number(String($('#current_crystal').text()).replace(/[.]/g, ''));
	var deuterium 		= Number(String($('#current_deuterium').text()).replace(/[.]/g, ''));
	var darkmatter 		= Number(String($('#current_darkmatter').text()).replace(/[.]/g, ''));
	var energy 			= Number(String($('#current_energy').text()).replace(/[.]/g, ''));
	var antimatter 			= Number(String($('#current_antimatter').text()).replace(/[.]/g, ''));
	
	if(typeof Data.costResources[901] !== "undefined")
	{
		res = Number(Data.costResources[901]);
		costResources[901] += Math.round(res * count);
	}
	if(typeof Data.costResources[902] !== "undefined")
	{
		res = Number(Data.costResources[902]);
		costResources[902] += Math.round(res * count);
	}
	if(typeof Data.costResources[903] !== "undefined")
	{
		res = Number(Data.costResources[903]);
		costResources[903] += Math.round(res * count);
	}
	if(typeof Data.costResources[911] !== "undefined")
	{
		res = Number(Data.costResources[911]);
		costResources[911] += Math.round(res * count);
	}
	if(typeof Data.costResources[921] !== "undefined")
	{
		res = Number(Data.costResources[921]);
		costResources[921] += Math.round(res * count);
	}
	if(typeof Data.costResources[922] !== "undefined")
	{
		res = Number(Data.costResources[922]);
		costResources[922] += Math.round(res * count);
	}
	
	if(costResources[901] > 0)
	{	
		Ellimet.find(".res901").find(".text").html(NumberGetHumanReadable(costResources[901]));
		
		if(metal < costResources[901])	
		{
			Ellimet.find(".res901").addClass('required'); 
			Ellimet.find(".res901").find(".text").addClass('tooltip'); 
			Ellimet.find(".res901").find(".text").attr('data-tooltip-content', LNGning + ' ' + LNGtech901 + ' ' + NumberGetHumanReadable(costResources[901] - metal)); 
		}	
		else
		{
			Ellimet.find(".res901").removeClass('required')
			Ellimet.find(".res901").find(".text").removeClass('tooltip'); 
			Ellimet.find(".res901").find(".text").removeAttr('data-tooltip-content'); 
		}
	}
	
	if(costResources[902] > 0)
	{			
		Ellimet.find(".res902").find(".text").html(NumberGetHumanReadable(costResources[902]));
		
		if(crystal < costResources[902])	
		if(crystal < costResources[902])	
		{
			Ellimet.find(".res902").addClass('required'); 
			Ellimet.find(".res902").find(".text").addClass('tooltip'); 
			Ellimet.find(".res902").find(".text").attr('data-tooltip-content', LNGning + ' ' + LNGtech902 + ' ' + NumberGetHumanReadable(costResources[902] - crystal)); 
		}	
		else
		{
			Ellimet.find(".res902").removeClass('required')
			Ellimet.find(".res902").find(".text").removeClass('tooltip'); 
			Ellimet.find(".res902").find(".text").removeAttr('data-tooltip-content'); 
		}
	}	
	
	if(costResources[903] > 0)
	{			
		Ellimet.find(".res903").find(".text").html(NumberGetHumanReadable(costResources[903]));
		
		if(deuterium < costResources[903])	
		{
			Ellimet.find(".res903").addClass('required'); 
			Ellimet.find(".res903").find(".text").addClass('tooltip'); 
			Ellimet.find(".res903").find(".text").attr('data-tooltip-content', LNGning + ' ' + LNGtech903 + ' ' + NumberGetHumanReadable(costResources[903] - deuterium)); 
		}	
		else
		{
			Ellimet.find(".res903").removeClass('required')
			Ellimet.find(".res903").find(".text").removeClass('tooltip'); 
			Ellimet.find(".res903").find(".text").removeAttr('data-tooltip-content'); 
		}
	}	
	
	if(costResources[911] > 0)
	{			
		Ellimet.find(".res911").find(".text").html(NumberGetHumanReadable(costResources[911]));
		
		if(energy < costResources[911])	
		{
			Ellimet.find(".res911").addClass('required'); 
			Ellimet.find(".res911").find(".text").addClass('tooltip'); 
			Ellimet.find(".res911").find(".text").attr('data-tooltip-content', LNGning + ' ' + LNGtech911 + ' ' + NumberGetHumanReadable(costResources[921] - energy)); 
		}	
		else
		{
			Ellimet.find(".res911").removeClass('required')
			Ellimet.find(".res911").find(".text").removeClass('tooltip'); 
			Ellimet.find(".res911").find(".text").removeAttr('data-tooltip-content'); 
		}
	}
	
	if(costResources[921] > 0)
	{			
		Ellimet.find(".res921").find(".text").html(NumberGetHumanReadable(costResources[921]));
		
		if(darkmatter < costResources[921])	
		{
			Ellimet.find(".res921").addClass('required'); 
			Ellimet.find(".res921").find(".text").addClass('tooltip'); 
			Ellimet.find(".res921").find(".text").attr('data-tooltip-content', LNGning + ' ' + LNGtech921 + ' ' + NumberGetHumanReadable(costResources[921] - darkmatter)); 
		}	
		else
		{
			Ellimet.find(".res921").removeClass('required')
			Ellimet.find(".res921").find(".text").removeClass('tooltip'); 
			Ellimet.find(".res921").find(".text").removeAttr('data-tooltip-content'); 
		}
	}	
	
	if(costResources[922] > 0)
	{			
		Ellimet.find(".res922").find(".text").html(NumberGetHumanReadable(costResources[922]));
		
		if(antimatter < costResources[922])	
		{
			Ellimet.find(".res922").addClass('required'); 
			Ellimet.find(".res922").find(".text").addClass('tooltip'); 
			Ellimet.find(".res922").find(".text").attr('data-tooltip-content', LNGning + ' ' + LNGtech922 + ' ' + NumberGetHumanReadable(costResources[922] - antimatter)); 
		}	
		else
		{
			Ellimet.find(".res922").removeClass('required')
			Ellimet.find(".res922").find(".text").removeClass('tooltip'); 
			Ellimet.find(".res922").find(".text").removeAttr('data-tooltip-content'); 
		}
	}	
	
	s =  Math.ceil(Data.elementTime * count);
	
	{ m = Math.floor( s / 60 ); s = s - m * 60; }
	{ h = Math.floor( m / 60 ); m = m - h * 60; }
	{ d = Math.floor( h / 24 ); h = h - d * 24; }
	if ( s < 10 ) { s = '0' + s }
	if ( m < 10 ) { m = '0' + m }
	if ( h < 10 ) { h = '' + h }
	if ( s >= 0 ) { s = s + short_second }
	if ( m > 0 ) { m = m + short_minute }  else m = '00' + short_minute;
	if ( m == 0 && h > 0 ) { m = '0' + m + short_minute}
	if ( h > 0 ) { h = h + short_hour }  else h = '00' + short_hour ;
	if ( d > 0 ) { d = d + short_day }  else d = '';
	
	Ellimet.find(".time_build_edit").text( d + ' ' + h + ' ' + m + ' ' + s);

    countDots();	

};

$(function () {
    $('.count_ships_dots input[type=text]').keyup(function () {
        countDots();
    });
    $('form').submit(function () {
        DotsToCount();
    });
});

function DotsToCount() {
    $('.count_ships_dots input[type=text]').val(function (i, old) {
        return old.replace(/[^[0-9]|\.]/g, '');
    });
}

function countDots() {
    $('.count_ships_dots input[type=text]').val(function (i, old) {
        return NumberGetHumanReadable(old.replace(/[^[0-9]|\.]/g, ''));
    });
}