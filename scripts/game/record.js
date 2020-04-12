function buildsopen(){
	if(!$('.ico_builds').hasClass('record_btn_active'))
	{
        $('.record_btn').removeClass('record_btn_active');	
        $('.ico_builds').addClass('record_btn_active');
		$('#u000').show();
		$('#u100').hide();
		$('#u200').hide();
		$('#u400').hide();
	}
};
function techopen(){
	if(!$('.ico_tech').hasClass('record_btn_active'))
	{
        $('.record_btn').removeClass('record_btn_active');	
        $('.ico_tech').addClass('record_btn_active');
		$('#u000').hide();
		$('#u100').show();
		$('#u200').hide();
		$('#u400').hide();
	}
};

function fleetopen(){
	if(!$('.ico_fleet').hasClass('record_btn_active'))
	{
        $('.record_btn').removeClass('record_btn_active');	
        $('.ico_fleet').addClass('record_btn_active');
		$('#u000').hide();
		$('#u100').hide();
		$('#u200').show();
		$('#u400').hide();
	}
};
function defopen(){
	if(!$('.ico_shield').hasClass('record_btn_active'))
	{
        $('.record_btn').removeClass('record_btn_active');	
        $('.ico_shield').addClass('record_btn_active');
		$('#u000').hide();
		$('#u100').hide();
		$('#u200').hide();
		$('#u400').show();
	}
};
function allopen(){
	if(!$('.ico_star').hasClass('record_btn_active'))
	{
        $('.record_btn').removeClass('record_btn_active');	
        $('.ico_star').addClass('record_btn_active');
		$('#u000').show();
		$('#u100').show();
		$('#u200').show();
		$('#u400').show();
	}
};