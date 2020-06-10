//Арсeнал
function ars(){
	if(!$('#ars').hasClass('imper_btn_filtrs_activ'))
	{
        $('.imper_btn_filtrs').removeClass('imper_btn_filtrs_activ');	
        $('#ars').addClass('imper_btn_filtrs_activ');
		$('.ars_elements .build_box').show();
	}
};

function ars1(){
	if(!$('#ars1').hasClass('imper_btn_filtrs_activ'))
	{
        $('.imper_btn_filtrs').removeClass('imper_btn_filtrs_activ');	
        $('#ars1').addClass('imper_btn_filtrs_activ');
        $('.ars_elements .build_box').hide();
		$('.ars_elements .ars1').show();
	}
};