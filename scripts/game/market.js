function open_market(IDblock, IDopen)
{
	if(!$('.gr_btn_top a.'+ IDblock).hasClass('active'))
	{
        $('.gr_btn_top a').removeClass('active');	
        $('.gr_btn_top a.'+ IDblock).addClass('active');
		$('.markett_conteiner').hide();
		$('#' + IDblock).show();
		
		if(IDopen != 'no')
			$.cookie("open_market", IDopen);	
	}
}