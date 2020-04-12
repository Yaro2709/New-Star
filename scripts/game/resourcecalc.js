function berechne(id) {
  var gesmet = 0;
  var geskris = 0;
  var gesdeut = 0;
  var gesener = 0;
  var sges = 0;
  var sgess = 0;
  for (ii = 0; ii < data.length; ii++) {
    var i = data[ii][0];
    var sx = document.getElementById('i'+i).value;
	var sd = 0;
    Metall = (data[ii][1] > -1) ? data[ii][1] : 0;
    Kristall = (data[ii][2] > -1) ? data[ii][2] : 0;
    Deuterium = (data[ii][3] > -1) ? data[ii][3] : 0;
    Energy = (data[ii][4] > -1) ? data[ii][4] : 0;
    Fac = (data[ii][8] > -1) ? data[ii][8] : 2;
 
	if (Fac != 99) {
		sd = document.getElementById('s'+i).value;
		if(sd.toString().length < 2)
		sd= "0"+sd;
	}
	
	
    if (Fac == 99) {
      Metall = Metall * sx;
      Kristall = Kristall * sx;
      Deuterium = Deuterium * sx;
      Energy = Energy * sx;
    }else {
      var tMet = 0;
      var tKris = 0;
      var tDeut = 0;
      var tEner = 0;
      for (j = sd; j < sx; j++) {
		tMet += Math.floor(Metall * Math.pow(Fac, j));
		tKris += Math.floor(Kristall * Math.pow(Fac, j));
		tDeut += Math.floor(Deuterium * Math.pow(Fac, j));
		tEner += Math.floor(Energy * Math.pow(Fac, j));
      }
      Metall = tMet;
      Kristall = tKris;
      Deuterium = tDeut;
      Energy = tEner;
    }
 
    gesmet += Metall;
    geskris += Kristall;
    gesdeut += Deuterium;
    gesener += Energy;
    sges -= sx;
	if (Fac != 99) {
		sgess -= sd;
	}
    document.getElementById('met'+i).firstChild.nodeValue = pc(Metall);
    document.getElementById('kris'+i).firstChild.nodeValue = pc(Kristall);
    document.getElementById('deut'+i).firstChild.nodeValue = pc(Deuterium);
    document.getElementById('ener'+i).firstChild.nodeValue = pc(Energy);
    document.getElementById('l'+i).firstChild.nodeValue = pc(Math.floor((Metall+Kristall+Deuterium+Energy)/1000000));
  }
  document.getElementById('metres').firstChild.nodeValue = pc(gesmet);
  document.getElementById('krisres').firstChild.nodeValue = pc(geskris);
  document.getElementById('deutres').firstChild.nodeValue = pc(gesdeut);
  document.getElementById('enerres').firstChild.nodeValue = pc(gesener);
  document.getElementById('sges').firstChild.nodeValue = pc(-sges);
  if (Fac != 99) {
	document.getElementById('sgess').firstChild.nodeValue = pc(-sgess);
  }
  document.getElementById('lres').firstChild.nodeValue = pc(Math.floor((gesmet+geskris+gesdeut+gesener)/1000000));
}
 
function reset() {
  for (ii = 0; ii < data.length; ii++) {
    var i = data[ii][0];
    document.getElementById('i'+i).value = 0;
    document.getElementById('met'+i).firstChild.nodeValue = 0;
    document.getElementById('kris'+i).firstChild.nodeValue = 0;
    document.getElementById('deut'+i).firstChild.nodeValue = 0;
    document.getElementById('ener'+i).firstChild.nodeValue = 0;
    document.getElementById('l'+i).firstChild.nodeValue = 0;
  }
  document.getElementById('metres').firstChild.nodeValue = 0;
  document.getElementById('krisres').firstChild.nodeValue = 0;
  document.getElementById('deutres').firstChild.nodeValue = 0;
  document.getElementById('enerres').firstChild.nodeValue = 0;
  document.getElementById('sges').firstChild.nodeValue = 0;
  document.getElementById('sgess').firstChild.nodeValue = 0;
  document.getElementById('lres').firstChild.nodeValue = 0;
}
 
function div(a, b) {
  return Math.floor(a / b);
}
 
function mod(a, b) {
  return a - Math.floor(a / b) * b; // schon besser YEAH ^^
}
 
function chkint(id) {
  sxx = '';
  sx = id.value.toUpperCase();
  for(i = 0; i < sx.length; i++) {
    if(sx.charCodeAt(i) >= 48 && sx.charCodeAt(i) <= 57) {
      sxx = sxx + sx.charAt(i);
    }
  }
  if(id.value != sxx) {
    id.value = sxx;
  }
}
 
function chkval(id) {
  if (id.value == '') id.value = '0';
}
 
function pc(s) {
  var sx = '';
  s = s + '';
  for (ipc = s.length; ipc >= 0; ipc--) {
    sx = s.charAt(ipc) + sx;
    if ((div(s.length - ipc,3) == (s.length - ipc) / 3) && (s.length != ipc) && (0 != ipc)) sx = '.' + sx;
  }
  return sx;
}