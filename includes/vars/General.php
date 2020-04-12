<?php

/**
 *  2Moons 
 *   by Jan-Otto Kröpke 2009-2016
 *
 * For the full copyright and license information, please view the LICENSE
 *
 * @package 2Moons
 * @author Jan-Otto Kröpke <slaver7@gmail.com>
 * @copyright 2009 Lucky
 * @copyright 2016 Jan-Otto Kröpke <slaver7@gmail.com>
 * @licence MIT
 * @version 1.8.0
 * @link https://github.com/jkroepke/2Moons
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
$resource[921] = 'darkmatter';

$reslist['ressources']  = array(901, 902, 903, 911, 921);
$reslist['resstype'][1] = array(901, 902, 903);
$reslist['resstype'][2] = array(911);
$reslist['resstype'][3] = array(921);
$reslist['res_production']      = array(901 => 0, 902 => 0, 903 => 0, 911 => 0);

$reslist['lab']                 = array(31); //единицы, которые объединяются в сеть
$reslist['planet_no_basic']     = array(3); //планеты, у которых нет базовой добычи
$reslist['shipyard']            = array(21); //нет верфя - ничего не построешь
$reslist['shipyard_no_build']   = array(15,21); //если эти еденицы улучшаются, то верфь не работает
$reslist['storage']             = array(22, 23, 24);


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