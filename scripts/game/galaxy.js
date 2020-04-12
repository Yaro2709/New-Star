function doit(missionID, planetID) {
	$.getJSON("game.php?page=fleetAjax&ajax=1&mission="+missionID+"&planetID="+planetID, function(data)
	{
		$('#slots').text(data.slots);
		if(typeof data.ships !== "undefined")
		{
			$.each(data.ships, function(elementID, value) {
				$('#elementID'+elementID).text(number_format(value));
			});
		}
		
		var statustable	= $('#fleetstatusrow');
		var messages	= statustable.find("~tr");
		if(messages.length == MaxFleetSetting) {
			messages.filter(':last').remove();
		}
		var element		= $('<td />').attr('colspan', 8).attr('class', data.code == 600 ? "success" : "error").text(data.mess).wrap('<tr />').parent();
		statustable.removeAttr('style').after(element);
	});
}

function galaxy_submit(e) {
    $("#auto").attr("name", e);
    $("#galaxy_form").submit()
}

function MovimentoGalassia(e) {
    e = e ? e : evento ? evento : null;
    if (e.keyCode == 37) {
        galaxy_submit("systemLeft")
    }
    if (e.keyCode == 39) {
        galaxy_submit("systemRight")
    }
}

function klicdiplo() {
    $("#diplom_btn").toggleClass("gl_click_hide");
    $("#diplom_content").stop(false, true).slideToggle(300)
}

function kliclegend() {
    $("#faq_btn").toggleClass("gl_click_hide");
    $("#faq_content").stop(false, true).slideToggle(300)
}
document.onkeydown = MovimentoGalassia;