function buildsopen(){
	if(!$('.ico_builds').hasClass('record_btn_active'))
	{
        $('.record_btn').removeClass('record_btn_active');	
        $('.ico_builds').addClass('record_btn_active');
		$('.u000').show();
		$('.u200').hide();
		$('.u400').hide();
	}
};
function fleetopen(){
	if(!$('.ico_fleet').hasClass('record_btn_active'))
	{
        $('.record_btn').removeClass('record_btn_active');	
        $('.ico_fleet').addClass('record_btn_active');
		$('.u000').hide();
		$('.u200').show();
		$('.u400').hide();
	}
};
function defopen(){
	if(!$('.ico_shield').hasClass('record_btn_active'))
	{
        $('.record_btn').removeClass('record_btn_active');	
        $('.ico_shield').addClass('record_btn_active');
		$('.u000').hide();
		$('.u200').hide();
		$('.u400').show();
	}
};
function allopen(){
	if(!$('.ico_star').hasClass('record_btn_active'))
	{
        $('.record_btn').removeClass('record_btn_active');	
        $('.ico_star').addClass('record_btn_active');
		$('.u000').show();
		$('.u200').show();
		$('.u400').show();
	}
};
/*Filtrs*/
function filtrsall(){
	if(!$('#filtrsall').hasClass('imper_btn_filtrs_activ'))
	{
        $('.imper_btn_filtrs').removeClass('imper_btn_filtrs_activ');	
        $('#filtrsall').addClass('imper_btn_filtrs_activ');
		$('.imper_table .imper_f').show();
	}
};
function filtrsplanet(){
	if(!$('#filtrsplanet').hasClass('imper_btn_filtrs_activ'))
	{
        $('.imper_btn_filtrs').removeClass('imper_btn_filtrs_activ');	
        $('#filtrsplanet').addClass('imper_btn_filtrs_activ');
		$('.imper_table .imper_f').hide();
		$('.imper_table .imper_planet').show();
	}
};
function filtrsmoon(){
	if(!$('#filtrsmoon').hasClass('imper_btn_filtrs_activ'))
	{
        $('.imper_btn_filtrs').removeClass('imper_btn_filtrs_activ');	
        $('#filtrsmoon').addClass('imper_btn_filtrs_activ');
		$('.imper_table .imper_f').hide();
		$('.imper_table .imper_moon').show();
	}
};
//---navigation
function goleft(){
	$("#ipper_planets").scrollLeft($("#ipper_planets").scrollLeft() + 161);
};
function goright(){
	$("#ipper_planets").scrollLeft($("#ipper_planets").scrollLeft() - 161);
}
function goleftMAX(){
	$("#ipper_planets").scrollLeft(9999);
};
function gorightMAX(){
	$("#ipper_planets").scrollLeft(0);
}