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
$resource[904] = 'people';
$resource[911] = 'energy';
$resource[912] = 'build';
$resource[913] = 'tech';
$resource[914] = 'fleet';
$resource[915] = 'defense';
$resource[916] = 'missile';
$resource[921] = 'darkmatter';
$resource[922] = 'antimatter';
$resource[923] = 'stardust';
$resource[924] = 'container';

$reslist['ressources']          = array(901, 902, 903, 911, 912, 913, 914, 915, 916, 921, 922, 923, 924);
$reslist['resstype'][1]         = array(901, 902, 903);
$reslist['resstype'][2]         = array(911, 912, 913, 914, 915, 916);
$reslist['resstype'][3]         = array(921, 922, 923, 924);
$reslist['res_production']      = array(901 => 0, 902 => 0, 903 => 0, 911 => 0, 912 => 0, 913 => 0, 914 => 0, 915 => 0, 916 => 0);
//Классофикация арсенала
$reslist['spec_ars'][1]         = array(2001,2002,2003,2005);
$reslist['spec_ars'][2]         = array(2004,2006,2007,2008,2009,2010);
//Классофикация флота
$reslist['spec_fleet'][1]       = array(208,209,210,212,220);
$reslist['spec_fleet'][2]       = array(202,203,204,205);
$reslist['spec_fleet'][3]       = array(206,209,207,211,213,215,217,219);
$reslist['spec_fleet'][4]       = array(214,216,218);
//Классофикация обороны
$reslist['spec_defense'][1]     = array(407,408,409,411);
$reslist['spec_defense'][2]     = array(401,402,403);
$reslist['spec_defense'][3]     = array(405,404,406);
$reslist['spec_defense'][4]     = array(410);
//Классофикация исследований
$reslist['spec_tech'][1]        = array(106,108,109,110,111);
$reslist['spec_tech'][2]        = array(114,115,117,118);
$reslist['spec_tech'][3]        = array(120,121,122,199);
$reslist['spec_tech'][4]        = array(131,132,133,113,123,124);
//Классофикация построек
$reslist['spec_build'][1]       = array(1,2,3,4,12,22,23,24,41);
$reslist['spec_build'][2]       = array(6,31,42);
$reslist['spec_build'][3]       = array(14,15,21,44);
$reslist['spec_build'][4]       = array(33,34,43);

$reslist['domes']               = array(407,408,409); //щиты
$reslist['orbital_bases']       = array(411); //Орбитальные базы

$reslist['not_bought']          = array(199,407,408,409,411); //не покупается
$reslist['min_planet_per_tech'] = array(124); //технологии, которые влияют на минимальное колличество планет.
$reslist['resources_points']    = array(901,902,903); //ресурсы, которые учитывает статистика

$reslist['planet_no_basic']     = array(3); //планеты, у которых нет базовой добычи
$reslist['shipyard']            = array(14,15,21); //если эти еденицы улучшаются, то верфь не работает
$reslist['lab']                 = array(6,31);

$reslist['battle_bonus']        = array(109,110,111,120,121,122,199,602); //что учитывается в симмуляторе
$reslist['build_speed_res']     = array(901,902,903); //Ресусры, которые образуют время создания чего-либо
$resglobal['stop_product']      = 911; //Ресурс, при недостатке которого вырубает добычу
$resglobal['build_speed']       = 912; //Ресурс, который влияет на скорость построек
$resglobal['tech_speed']        = 913; //Ресурс, который влияет на скорость исследований
$resglobal['fleet_speed']       = 914; //Ресурс, который влияет на скорость флота
$resglobal['defense_speed']     = 915; //Ресурс, который влияет на скорость обороны
$resglobal['missile_speed']     = 916; //Ресурс, который влияет на скорость ракет 
$resglobal['buy_moon_res']      = 921; //Ресурс, за который покупается луна
$resglobal['buy_moon_price']    = 20000; //Цена этого ресурса
$resglobal['buy_instantly']     = 921; //Ресурс за который происходит покупка единиц

$resglobal['market_res']        = 922; //Ресурс, который используется при торговле на рынке
$reslist['not_market_send']     = array(199,407,408,409,411); //не выставляется на продажу

//Классофикация флота на орбите
//Своз флота
$reslist['reducefleet'] = array(204,205,206,207,211,213,214,215,216,218);
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