function Price901(Element, Price)
{
	var Amount  	= parseInt($('#amount'+Element).val());
	var metal 	    = parseInt($('#res_901').text().replace(/\./g, ''));
	var TotalPrice	= Price * Amount;
	
	var PriceE		= $('#price'+Element);
	
	if(TotalPrice <= metal)
		PriceE.css('color','lime');
	else
		PriceE.css('color','red');

	PriceE.html(NumberGetHumanReadable(TotalPrice));
}

function Price902(Element, Price)
{
	var Amount  	= parseInt($('#amount'+Element).val());
	var crystal 	= parseInt($('#res_902').text().replace(/\./g, ''));
	var TotalPrice	= Price * Amount;
	
	var PriceE		= $('#price'+Element);
	
	if(TotalPrice <= crystal)
		PriceE.css('color','lime');
	else
		PriceE.css('color','red');

	PriceE.html(NumberGetHumanReadable(TotalPrice));
}

function Price903(Element, Price)
{
	var Amount  	= parseInt($('#amount'+Element).val());
	var deuterium 	= parseInt($('#res_903').text().replace(/\./g, ''));
	var TotalPrice	= Price * Amount;
	
	var PriceE		= $('#price'+Element);
	
	if(TotalPrice <= deuterium)
		PriceE.css('color','lime');
	else
		PriceE.css('color','red');

	PriceE.html(NumberGetHumanReadable(TotalPrice));
}

function Price921(Element, Price)
{
	var Amount  	= parseInt($('#amount'+Element).val());
	var darkmatter 	= parseInt(($('#res_921').attr('name')).text().replace(/\./g, ''));
	var TotalPrice	= Price * Amount;
	
	var PriceE		= $('#price'+Element);
	
	if(TotalPrice <= darkmatter)
		PriceE.css('color','lime');
	else
		PriceE.css('color','red');

	PriceE.html(NumberGetHumanReadable(TotalPrice));
}

function Price922(Element, Price)
{
	var Amount  	= parseInt($('#amount'+Element).val());
	var antimatter 	= parseInt($('#res_922').text().replace(/\./g, ''));
	var TotalPrice	= Price * Amount;
	
	var PriceE		= $('#price'+Element);
	
	if(TotalPrice <= antimatter)
		PriceE.css('color','lime');
	else
		PriceE.css('color','red');

	PriceE.html(NumberGetHumanReadable(TotalPrice));
}

function Price923(Element, Price)
{
	var Amount  	= parseInt($('#amount'+Element).val());
	var stardust 	= parseInt($('#res_923').text().replace(/\./g, ''));
	var TotalPrice	= Price * Amount;
	
	var PriceE		= $('#price'+Element);
	
	if(TotalPrice <= stardust)
		PriceE.css('color','lime');
	else
		PriceE.css('color','red');

	PriceE.html(NumberGetHumanReadable(TotalPrice));
}

function Price924(Element, Price)
{
	var Amount  	= parseInt($('#amount'+Element).val());
	var contein 	= parseInt($('#res_924').text().replace(/\./g, ''));
	var TotalPrice	= Price * Amount;
	
	var PriceE		= $('#price'+Element);
	
	if(TotalPrice <= contein)
		PriceE.css('color','lime');
	else
		PriceE.css('color','red');

	PriceE.html(NumberGetHumanReadable(TotalPrice));
}