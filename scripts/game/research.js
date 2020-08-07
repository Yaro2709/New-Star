var resttime	= 0;
var time		= 0;
var endtime		= 0;
var interval	= 0;
var buildname	= "";

function Buildlist() {
	var rest	= resttime - (serverTime.getTime() - startTime) / 1000;
	if (rest <= 0) {
		window.clearInterval(interval);
		$('#time').text(Ready);
		$('#command').remove();
		document.title	= Ready + ' | ' + Gamename;
		window.setTimeout(function() {
			window.location.href = 'game.php?page=research';
		}, 1000);
		return true;
	}
	document.title	= GetRestTimeFormat(rest) + ' - ' + buildname + ' | ' + Gamename;
	
	$('#time').text(GetRestTimeFormat(rest));
}

function CreateProcessbar() {
	if(time != 0) {
		$('#progressbar').progressbar({
			value: Math.max(100 - (resttime / time) * 100, 0.01)
		});
		$('.ui-progressbar-value').addClass('ui-corner-right').animate({width: "100%"}, resttime * 1000, "linear");
	}
}

$(document).ready(function() {
	time		= $('#time').data('time');
	resttime	= $('#progressbar').data('time');
	endtime		= $('.timer:first').data('time');
	if(typeof resttime !== "undefined"){
		buildname	= $('.onlist:first').text();
		interval	= window.setInterval(Buildlist, 1000);
		window.setTimeout(CreateProcessbar, 5);
		Buildlist();
	}
});

/*------------------------------------------------------------*/
function counting(id)
{
	var Data 			= DatatList[id];
	var	sitem			= '#research_'+(String(id));
	var Ellimet			= $(sitem);
	var it 				= 1;
	var	count 			= Math.max((1 +  Number(Data.level)), Number(Ellimet.find('#b_input_'+(String(id))).val()));
	var	countMin 		= Data.level;
	
	/*
	if(count > MaxCount)
	{
		count = MaxCount;
		Ellimet.find('#input_'+(String(id))).val(MaxCount);
	}
	*/
	
	var costRessources 	= 0;
	var res 			= 0;
	var costRessources	= Array();
	costRessources[901]	= 0;
	costRessources[902] = 0;//
	costRessources[903] = 0;
	costRessources[921] = 0;
	
	var metal 			= Number(String($('#current_metal').text()).replace(/[.]/g, ''));
	var crystal 		= Number(String($('#current_crystal').text()).replace(/[.]/g, ''));
	var deuterium 		= Number(String($('#current_deuterium').text()).replace(/[.]/g, ''));
	var darkmatter 		= Number(String($('#current_darkmatter').text()).replace(/[.]/g, ''));
	var energy 			= Number(String($('#current_energy').text()).replace(/[.]/g, ''));
	
	if(typeof Data.costRessources[901] !== "undefined")
	{
		res = Number(Data.costRessources[901]);
		costRessources[901] += Math.floor(res);
		for (var i = 2; i <= (count - countMin); i++) 
		{        	
			costRessources[901] += Math.floor(res * Math.pow(Data.factor, i-1));
    	}		
	}
	if(typeof Data.costRessources[902] !== "undefined")
	{
		res = Number(Data.costRessources[902]);
		costRessources[902] += Math.floor(res);
		for (var i = 2; i <= (count - countMin); i++) 
		{        	
			costRessources[902] += Math.floor(res * Math.pow(Data.factor, i-1));
    	}
	}
	if(typeof Data.costRessources[903] !== "undefined")
	{
		res = Number(Data.costRessources[903]);
		costRessources[903] += Math.floor(res);
		for (var i = 2; i <= (count - countMin); i++) 
		{        	
			costRessources[903] += Math.floor(res * Math.pow(Data.factor, i-1));
    	}
	}
	if(typeof Data.costRessources[911] !== "undefined")
	{
		res = Number(Data.costRessources[911]);
		costRessources[911] += Math.floor(res);
		for (var i = 2; i <= (count - countMin); i++) 
		{        	
			costRessources[911] = Math.floor(res * Math.pow(Data.factor, i-1));
    	}
	}
	if(typeof Data.costRessources[921] !== "undefined")
	{
		res = Number(Data.costRessources[921]);
		costRessources[921] += Math.floor(res);
		for (var i = 2; i <= (count - countMin); i++) 
		{        	
			costRessources[921] += Math.floor(res * Math.pow(Data.factor, i-1));
    	}
	}
	
	if(costRessources[901] > 0)
	{	
		Ellimet.find(".res901").find(".text").html(NumberGetHumanReadable(costRessources[901]));
		
		if(metal < costRessources[901])	
		{
			Ellimet.find(".res901").addClass('required'); 
			Ellimet.find(".res901").find(".text").addClass('tooltip'); 
			Ellimet.find(".res901").find(".text").attr('data-tooltip-content', LNGning + ' ' + LNGtech901 + ' ' + NumberGetHumanReadable(costRessources[901] - metal)); 
		}	
		else
		{
			Ellimet.find(".res901").removeClass('required')
			Ellimet.find(".res901").find(".text").removeClass('tooltip'); 
			Ellimet.find(".res901").find(".text").removeAttr('data-tooltip-content'); 
		}
	}
	
	if(costRessources[902] > 0)
	{			
		Ellimet.find(".res902").find(".text").html(NumberGetHumanReadable(costRessources[902]));
		
		if(crystal < costRessources[902])	
		{
			Ellimet.find(".res902").addClass('required'); 
			Ellimet.find(".res902").find(".text").addClass('tooltip'); 
			Ellimet.find(".res902").find(".text").attr('data-tooltip-content', LNGning + ' ' + LNGtech902 + ' ' + NumberGetHumanReadable(costRessources[902] - crystal)); 
		}	
		else
		{
			Ellimet.find(".res902").removeClass('required')
			Ellimet.find(".res902").find(".text").removeClass('tooltip'); 
			Ellimet.find(".res902").find(".text").removeAttr('data-tooltip-content'); 
		}
	}	
	
	if(costRessources[903] > 0)
	{			
		Ellimet.find(".res903").find(".text").html(NumberGetHumanReadable(costRessources[903]));
		
		if(deuterium < costRessources[903])	
		{
			Ellimet.find(".res903").addClass('required'); 
			Ellimet.find(".res903").find(".text").addClass('tooltip'); 
			Ellimet.find(".res903").find(".text").attr('data-tooltip-content', LNGning + ' ' + LNGtech903 + ' ' + NumberGetHumanReadable(costRessources[903] - deuterium)); 
		}	
		else
		{
			Ellimet.find(".res903").removeClass('required')
			Ellimet.find(".res903").find(".text").removeClass('tooltip'); 
			Ellimet.find(".res903").find(".text").removeAttr('data-tooltip-content'); 
		}
	}	
	
	if(costRessources[911] > 0)
	{			
		Ellimet.find(".res911").find(".text").html(NumberGetHumanReadable(costRessources[911]));
		
		if(energy < costRessources[911])	
		{
			Ellimet.find(".res911").addClass('required'); 
			Ellimet.find(".res911").find(".text").addClass('tooltip'); 
			Ellimet.find(".res911").find(".text").attr('data-tooltip-content', LNGning + ' ' + LNGtech911 + ' ' + NumberGetHumanReadable(costRessources[921] - energy)); 
		}	
		else
		{
			Ellimet.find(".res911").removeClass('required')
			Ellimet.find(".res911").find(".text").removeClass('tooltip'); 
			Ellimet.find(".res911").find(".text").removeAttr('data-tooltip-content'); 
		}
	}
	
	if(costRessources[921] > 0)
	{			
		Ellimet.find(".res921").find(".text").html(NumberGetHumanReadable(costRessources[921]));
		
		if(darkmatter < costRessources[921])	
		{
			Ellimet.find(".res921").addClass('required'); 
			Ellimet.find(".res921").find(".text").addClass('tooltip'); 
			Ellimet.find(".res921").find(".text").attr('data-tooltip-content', LNGning + ' ' + LNGtech921 + ' ' + NumberGetHumanReadable(costRessources[921] - darkmatter)); 
		}	
		else
		{
			Ellimet.find(".res921").removeClass('required')
			Ellimet.find(".res921").find(".text").removeClass('tooltip'); 
			Ellimet.find(".res921").find(".text").removeAttr('data-tooltip-content'); 
		}
	}	
	s =  Math.ceil(Data.elementTime);  
	for (var i = 2; i <= (count - countMin); i++) 
	{    
		s +=  Math.ceil(Data.elementTime * Math.pow(Data.factor, i-1));    	
    }
		
	//s =  Math.ceil(Data.elementTime * count);
	
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
};