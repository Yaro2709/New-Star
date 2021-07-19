<!DOCTYPE html>

<!--[if lt IE 7 ]> <html lang="{$lang}" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="{$lang}" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="{$lang}" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="{$lang}" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="{$lang}" class="no-js"> <!--<![endif]-->
<head>
    <!--title-->
	<title>{$title}</title>
    <meta name="generator" content="New-Star">
	<meta name="keywords" content="New-Star">
	<meta name="description" content="New-Star Browsergame powerd by https://github.com/Yaro2709/New-Star">
    <!--favicon-->
    <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon">
    <!--goto refresh-->
	{if !empty($goto)}
	<meta http-equiv="refresh" content="{$gotoinsec};URL={$goto}">
	{/if}
    <!--content-type-->
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <!--bootstrap-->
    <link rel="stylesheet" type="text/css" href="../styles/resource/css/base/bootstrap.min_4.6.0.css">
    <link rel="stylesheet" type="text/css" href="../styles/resource/css/base/my_bootstrap.css">
    <!--bootstrap requirements-->
    <script type="text/javascript" src="../scripts/base/jquery.js"></script>
    <script type="text/javascript" src="../scripts/base/jquery.ui.js"></script>
    <script type="text/javascript" src="../scripts/base/popper.min.js"></script>
    <script type="text/javascript" src="../scripts/base/bootstrap.min.js"></script>
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
    <link rel="stylesheet" type="text/css" href="../styles/resource/css/install/install.css">
    <!--script-->
	{foreach item=scriptname from=$scripts}
    <script type="text/javascript" src="../scripts/game/{$scriptname}.js"></script>
	{/foreach}
	{block name="script"}{/block}
	<script type="text/javascript">
        $(function() {
            {$execscript}
        });
	</script>
</head>
<body id="step{$smarty.get.step|htmlspecialchars|default:'intro'}">
<div id="tooltip" class="tip"></div>