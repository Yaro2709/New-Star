function AJAX()
{
  jQuery.post("./json.php", {'ataks': ataks, 'spio': spio, 'unic': unic, 'rakets': rakets, 'ajax': 1, 'msg': msg}, function(data)
    {
      var indicators = document.getElementById('indicators');
	  var newemail = document.getElementById('new_email');
	  var beepataks = document.getElementById('beepataks');
	  var msgaudio = document.getElementById('msgaudio');
      if(data.ICOFLEET)
      {
        indicators.innerHTML = data.ICOFLEET;
		if(data.SOUNDATAKS){
			beepataks.play();
		}
		if( msg < data.msg){
			if(data.SOUNDMSG){
			msgaudio.play();}
			}
		ataks = data.ataks;
		spio = data.spio;
		unic = data.unic;
		rakets = data.rakets;
		msg = data.msg;
      }
    }, "json"
  );
}