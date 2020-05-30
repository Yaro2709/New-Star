function add(){
	$("#form").attr('action', 'game.php?page=battleSimulator&action=moreslots');
	$("#form").attr('method', 'POST');
	$("#form").submit();
	return true;
}

$(function() {
	$("#tabs").tabs();

	var $tabs = $('#tabs').tabs({
		tabTemplate: '<li><a href="#{href}">#{label}</a></li>',
	});
});
function add(){
	$("#form").attr('action', 'game.php?page=battleSimulator&action=moreslots');
	$("#form").attr('method', 'POST');
	$("#form").submit();
	return true;
}

function check(){
	
	$('#form input[type=text]').val(function(i, old) {
		return old.replace(/[^[0-9]|\.]/g, '');
	});
	var kb = window.open('about:blank', 'kb', 'scrollbars=yes,statusbar=no,toolbar=no,location=no,directories=no,resizable=no,menubar=no,width='+screen.width+',height='+screen.height+', screenX=0, screenY=0, top=0, left=0');
	$("#submit:visible").removeAttr('style').hide().fadeOut();
	$("#wait:hidden").removeAttr('style').hide().fadeIn();
	$.post('game.php?page=battleSimulator&mode=send', $('#form').serialize(), function(data){
		try{ 
			data	= $.parseJSON(data);
			kb.focus();
			kb.location.href = 'CombatReport.php?raport='+data;
		} catch(e) {
			kb.window.close();
			Dialog.alert(data);
		}
	});
	
	setTimeout(function(){$("#submit:hidden").removeAttr('style').hide().fadeIn();}, 10000);
	setTimeout(function(){$("#wait:visible").removeAttr('style').hide().fadeOut();}, 10000);
	return true;
}
$(function() {
	$("#tabs").tabs();

	var $tabs = $('#tabs').tabs({
		tabTemplate: '<li><a href="#{href}">#{label}</a></li>',
	});
	
	$('.rexx20').on('click', function(e) 
	{
		e.preventDefault();
				
		var index = $(this).index()-1;
				
		$(this).parent().nextAll().each(function() {
			$(this).children('.rexx16 input:eq('+(index)+')').val(0);			
		});
		fleetAttPoints();
		fleetDefPoints();
		return false;
	});
	
	$('#form input[type=text]').keyup(function() {
		$('#form input[type=text]').val(function(i, old) {
			return NumberGetHumanReadable(old.replace(/[^[0-9]|\.]/g, ''));
		});		
	});
	$('#form').submit(function() {
		$('#form input[type=text]').val(function(i, old) {
			return old.replace(/[^[0-9]|\.]/g, '');
		});
	});
	$('.fleetAttCountBS').keyup(function() {
		fleetAttPoints();
	});
	$('.fleetDefCountBS').keyup(function() {
		fleetDefPoints();
	});
	
	$('#form input[type=text]').val(function(i, old) {
		return NumberGetHumanReadable(old.replace(/[^[0-9]|\.]/g, ''));
	});
	fleetAttPoints();
	fleetDefPoints();	
});