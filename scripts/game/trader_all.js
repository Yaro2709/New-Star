$(function() {
	$('.trade_input').keyup(function(event) {
		$(event.currentTarget).val(function(i, old) {
			return NumberGetHumanReadable(old.replace(/[^[0-9]|\.]/g, ''));
		});
		
		var ress1   = $(".trade_input:eq(0)").val().replace(/[^[0-9]|\.]/g, '');
		var ress2	= $(".trade_input:eq(1)").val().replace(/[^[0-9]|\.]/g, '');
		var ress3	= $(".trade_input:eq(2)").val().replace(/[^[0-9]|\.]/g, '');
        var ress4	= $(".trade_input:eq(3)").val().replace(/[^[0-9]|\.]/g, '');
        var ress5	= $(".trade_input:eq(4)").val().replace(/[^[0-9]|\.]/g, '');
        var ress6	= $(".trade_input:eq(5)").val().replace(/[^[0-9]|\.]/g, '');
        var ress7	= $(".trade_input:eq(6)").val().replace(/[^[0-9]|\.]/g, '');

		var ress 	= ress1 * ress1charge + ress2 * ress2charge + ress3 * ress3charge + ress4 * ress4charge + ress5 * ress5charge + ress6 * ress6charge + ress7 * ress7charge;
			ress    = Math.ceil(ress);
		if (isNaN(ress))
			$("#ress").text(0);
		else 
			$("#ress").text(NumberGetHumanReadable(ress));
	});
	$('#trader').submit(function() {
		$('.trade_input').val(function(i, old) {
			return old.replace(/[^[0-9]|\.]/g, '');
		});
	});
	$('#trader2').submit(function() {
		$('.trade_input').val(function(i, old) {
			return old.replace(/[^[0-9]|\.]/g, '');
		});
	});
});