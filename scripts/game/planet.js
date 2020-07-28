function OpenBox(Key){
	var btn = $('#open_btn_'+Key)
	if(btn.text() == '+')
	{
		$('#box_'+Key).stop(true,false).slideDown(300);
		btn.text('-')
	}
	else
	{
		$('#box_'+Key).stop(true,false).slideUp(300);
		btn.text('+')
	}
}

function GenerateName()
{		
	$.getJSON('game.php?page=planet&mode=GenerateName', function(response){
		$('#name').val(response.message);
	});
}

function Fild()
{
	var Count	= $('#filds').val();
	var type_fields	= $('#type_fields').val();
	var purchased_fields	= $('#purchased_fields').val();
	var power_fields	= $('#power_fields').val();
	
	if(isNaN(Count) || Count < 0 ) {
		$('#filds').val(0);
		Count = 0;
	}
	
	var cost_i 	= 0;
	var cost 	= 0;
	
	for(var i = 0; i < Count; i++ )
	{
		cost_i 	= Math.round(type_fields * Math.pow(power_fields,Number(purchased_fields) + Number(i)));
		cost 	= Number(cost) + Number(cost_i);
	}
	
	$('#cost_filds').text(NumberGetHumanReadable(cost));
	cost	= 0; step 	= 0;	cost_i	= 0;
}

function Diameter()
{
	var Count	= $('#diameters').val();
	var type_diameters	= $('#type_diameters').val();
	var purchased_diameters	= $('#purchased_diameters').val();
	var power_diameters	= $('#power_diameters').val();
	
	if(isNaN(Count) || Count < 0 ) {
		$('#diameters').val(0);
		Count = 0;
	}
	
	var cost_i 	= 0;
	var cost 	= 0;
	
	for(var i = 0; i < Count; i++ )
	{
		cost_i 	= Math.round(type_diameters * Math.pow(power_diameters,Number(purchased_diameters) + Number(i)));
		cost 	= Number(cost) + Number(cost_i);
	}
	
	$('#cost_diameters').text(NumberGetHumanReadable(cost));
	cost	= 0; step 	= 0;	cost_i	= 0;
}

function TPort()
{
	var galaxy	= $('#galaxy').val();
	var system	= $('#system').val();
	var planet	= $('#planets').val();
	var galaxy1 = $('#galaxy1').val();
	var system1 = $('#system1').val();
	var planet1 = $('#planet1').val();
	
	if(isNaN(galaxy) || galaxy < 0 ) {
		$('#galaxy').val(1);
		galaxy = 1;
	}
	if(isNaN(system) || system < 0 ) {
		$('#system').val(1);
		system = 1;
	}
	if(isNaN(planet) || planet < 0 ) {
		$('#planets').val(1);
		planet = 1;
	}

	$('#cost_tp').text(NumberGetHumanReadable(1000 * Math.abs(system1 - system) + 15000 * Math.abs(galaxy1 - galaxy) + 2500 * Math.abs(planet1 - planet)));
}