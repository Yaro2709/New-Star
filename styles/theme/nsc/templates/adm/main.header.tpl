<!DOCTYPE html>

<!--[if lt IE 7 ]> <html lang="{$lang}" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="{$lang}" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="{$lang}" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="{$lang}" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="{$lang}" class="no-js"> <!--<![endif]-->
<head>
    <!--title-->
    <title>{block name="title"} - {$game_name}{/block}</title>	
    <meta name="generator" content="New-Star {$VERSION}">
	<meta name="keywords" content="New-Star {$VERSION}">
	<meta name="description" content="New-Star Browsergame powerd by https://github.com/Yaro2709/New-Star">
    <!--favicon-->
    <link rel="shortcut icon" href="./favicon.ico" type="image/x-icon">
    <!--goto refresh-->
    {if !empty($goto)}
	<meta http-equiv="refresh" content="{$gotoinsec};URL={$goto}">
	{/if}
    <!--content-type-->
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <!--bootstrap-->
	<link rel="stylesheet" type="text/css" href="styles/resource/css/base/bootstrap.min_4.6.0.css">

    <link rel="stylesheet" type="text/css" href="styles/resource/css/base/my_bootstrap.css">
    <link rel="stylesheet" type="text/css" href="styles/resource/css/base/my_bootstrap_admin.css">

    <!--bootstrap requirements-->
    <script type="text/javascript" src="scripts/base/jquery.js"></script>
    <script type="text/javascript" src="scripts/base/jquery.ui.js"></script>
    <script type="text/javascript" src="scripts/base/popper.min.js"></script>
    <script type="text/javascript" src="scripts/base/bootstrap.min.js"></script>
    <!--bootstrap adaptation to the device-->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!--bootstrap carousel-->
    <script>
        $(function() {
            $('.carousel').each(function(){
                $(this).carousel({
                    interval: false
                });
            });
        });
    </script>
    <!--style-->
    <link rel="stylesheet" type="text/css" href="styles/resource/css/admin/admin.css">
    <!--fancybox-->
    <link rel="stylesheet" type="text/css" href="styles/resource/css/base/jquery.fancybox_3.5.7.css">
    <script type="text/javascript" src="scripts/base/jquery.fancybox.js"></script>
    <!--jquery cookie-->
    <script type="text/javascript" src="scripts/base/jquery.cookie.js"></script>
    <!--script-->
	<script type="text/javascript">
        var ServerTimezoneOffset = {$Offset};
        var serverTime 	= new Date({$date.0}, {$date.1 - 1}, {$date.2}, {$date.3}, {$date.4}, {$date.5});
        var xsize 	= screen.width;
        var ysize 	= screen.height;
        var breite	= 720;
        var hoehe	= 300;
        var xpos	= (xsize-breite) / 2;
        var ypos	= (ysize-hoehe) / 2;
        var Ready		= "{$LNG.ready}";
        var Skin		= "{$dpath}";
        var Lang		= "{$lang}";
        var head_info	= "{$LNG.fcm_info}";
        var days 		= {$LNG.week_day|json|default:'[]'} 
        var months 		= {$LNG.months|json|default:'[]'} ;
        var tdformat	= "{$LNG.js_tdformat}";
        function openEdit(id, type) {
            var editlist = window.open("?page=QuickEditor&edit="+type+"&id="+id, "edit", "scrollbars=yes,statusbar=no,toolbar=no,location=no,directories=no,resizable=no,menubar=no,width=850,height=600,screenX="+((xsize-600)/2)+",screenY="+((ysize-850)/2)+",top="+((ysize-600)/2)+",left="+((xsize-850)/2));
            editlist.focus();
        }
	</script> 
    <script type="text/javascript" src="scripts/game/base.js?v={$REV}"></script>
	{foreach item=scriptname from=$scripts}
	<script type="text/javascript" src="scripts/game/{$scriptname}.js?v={$REV}"></script>
	{/foreach}
	<script type="text/javascript">
	$(function() {
		{$execscript}
	});
	</script>
	<script>{if isset($code)}var loginError = {$code|json};{/if}</script>
	{block name="script"}{/block}	
</head>

<body id="{$smarty.get.page|htmlspecialchars|default:'overview'}" class="{$bodyclass}">
	<div id="tooltip" class="tip"></div>