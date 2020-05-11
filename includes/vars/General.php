<?php

/*
 * ╔══╗╔══╗╔╗──╔╗╔═══╗╔══╗╔╗─╔╗╔╗╔╗──╔╗╔══╗╔══╗╔══╗
 * ║╔═╝║╔╗║║║──║║║╔═╗║║╔╗║║╚═╝║║║║║─╔╝║╚═╗║║╔═╝╚═╗║
 * ║║──║║║║║╚╗╔╝║║╚═╝║║╚╝║║╔╗─║║╚╝║─╚╗║╔═╝║║╚═╗──║║
 * ║║──║║║║║╔╗╔╗║║╔══╝║╔╗║║║╚╗║╚═╗║──║║╚═╗║║╔╗║──║║
 * ║╚═╗║╚╝║║║╚╝║║║║───║║║║║║─║║─╔╝║──║║╔═╝║║╚╝║──║║
 * ╚══╝╚══╝╚╝──╚╝╚╝───╚╝╚╝╚╝─╚╝─╚═╝──╚╝╚══╝╚══╝──╚╝
 *
 * @author Tsvira Yaroslav <https://github.com/Yaro2709>
 * @info ***
 * @link https://github.com/Yaro2709/New-Star
 * @Basis 2Moons: XG-Project v2.8.0
 * @Basis New-Star: 2Moons v1.8.0
 */

// VARS DB -> SCRIPT WRAPPER

$cache	= Cache::get();
$cache->add('vars', 'VarsBuildCache');
extract($cache->getData('vars'));

require_once('includes/vars/Trader.php');

$resource[901] = 'metal';
$resource[902] = 'crystal';
$resource[903] = 'deuterium';
$resource[911] = 'energy';
$resource[912] = 'build';
$resource[913] = 'tech';
$resource[914] = 'fleet';
$resource[915] = 'defense';
$resource[916] = 'missile';
$resource[921] = 'darkmatter';

$reslist['ressources']          = array(901, 902, 903, 911, 912, 913, 914, 915, 916, 921);
$reslist['resstype'][1]         = array(901, 902, 903);
$reslist['resstype'][2]         = array(911, 912, 913, 914, 915, 916);
$reslist['resstype'][3]         = array(921);
$reslist['res_production']      = array(901 => 0, 902 => 0, 903 => 0, 911 => 0, 912 => 0, 913 => 0, 914 => 0, 915 => 0, 916 => 0);

$reslist['lab']                 = array(916,913); //единицы, которые объединяются в сеть
$reslist['planet_no_basic']     = array(3); //планеты, у которых нет базовой добычи
$reslist['shipyard']            = array(21); //нет верфя - ничего не построешь
$reslist['shipyard_no_build']   = array(14,15,21); //если эти еденицы улучшаются, то верфь не работает

$res_stop_product = 911;

//Классофикация флота на орбите
//Боевой флот
$reslist['tablefleet_combat'] = array(204,205,206,207,215,213,211,225,226,214,216,227,228,218,222 ,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,233,253,254,255,235,256,257,258,259,221,260,261,262,229,263,264,265,224,238,266,230,267);
//Транспорт
$reslist['tablefleet_transport'] = array(202,203,217);
//Переработчики
$reslist['tablefleet_recyclers'] = array(209,219);
//Особые
$reslist['tablefleet_special'] = array(208,210,220,223);
//Флот, который взлетает с орбиты
$reslist['tablefleet'] = array(202,203,204,205,208,209,210 ,231,232,242,243,244,233,253,254,261,262,229,206,207,215,219,217,220,213,211 ,234,236,237,245,246,247,248,255,235,256,257,263,264,265,224,223,230,214,216,225,226,227,228,221,222,218 ,238,239,240,241,249,250,251,252,258,259,238,260,238,266,230,267);