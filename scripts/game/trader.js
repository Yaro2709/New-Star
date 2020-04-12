$(function() {
    $(".trade_input").each(function(e) {
        $("#" + $(this).attr("id") + "Shortly").html(function(e, t) {
            return 0;
        });
    }).keyup(function(e) {
        $("#" + $(this).attr("id") + "Shortly").html(function(t, n) {
            return shortly_number($(e.currentTarget).val())
        });
        var t = 0;
        $(".trade_input").each(function() {
            t += parseFloat($(this).val().replace(/[^[0-9]|\.]/g, '')) * charge[$(this).data("resource")]
        });
        if (isNaN(t)) {
            $("#ress").text(0);
        } else {
            $("#ress").text(NumberGetHumanReadable(t));
        }
        return true;
    });

    $("#trader").submit(function() {
        $(".trade_input").val(function(e, t) {
            return t.replace(/[^[0-9]|\.]/g, "")
        });
    });
});

    function updateRess() {
    	$(".trade_input").each(function(e) {
    	    $("#" + $(this).attr("id") + "Shortly").html(function(t, n) {
    	        return shortly_number($(e.currentTarget).val())
    	    });
    	    var t = 0;
    	    $(".trade_input").each(function() {
    	        t += parseFloat($(this).val()) * charge[$(this).data("resource")]
    	    });
    	    if (isNaN(t)) {
    	        $("#ress").text(0);
    	    } else {
    	        $("#ress").text(NumberGetHumanReadable(t));
    	    }
    	    return true;
    	});
    }
	
$(function() {
	$('.trade_input').keyup(function(event) {
		$(event.currentTarget).val(function(i, old) {
			return NumberGetHumanReadable(old.replace(/[^[0-9]|\.]/g, ''));
		});
		
		var ress1   = $(".trade_input:eq(0)").val().replace(/[^[0-9]|\.]/g, '');
		var ress2	= $(".trade_input:eq(1)").val().replace(/[^[0-9]|\.]/g, '');
		var ress3	= $(".trade_input:eq(2)").val().replace(/[^[0-9]|\.]/g, '');

		var ress 	= ress1 * ress1charge + ress2 * ress2charge + ress3 * ress3charge;
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