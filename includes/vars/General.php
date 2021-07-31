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

$reslist['ressources']                  = array(901, 902, 903, 911, 912, 913, 914, 915, 916, 921, 922, 923, 924);
$reslist['resstype'][1]                 = array(901, 902, 903);
$reslist['resstype'][2]                 = array(911, 912, 913, 914, 915, 916);
$reslist['resstype'][3]                 = array(921, 922, 923, 924);
$reslist['res_production']              = array(901 => 0, 902 => 0, 903 => 0, 911 => 0, 912 => 0, 913 => 0, 914 => 0, 915 => 0, 916 => 0);
//Классофикация арсенала
$reslist['spec_ars'][1]                 = array(2001,2002,2003,2005);
$reslist['spec_ars'][2]                 = array(2004,2006,2007,2008,2009,2010);
//Классофикация флота
$reslist['spec_fleet'][1]               = explode(',', Config::get()->reslist_spec_fleet_1);
$reslist['spec_fleet'][2]               = explode(',', Config::get()->reslist_spec_fleet_2);
$reslist['spec_fleet'][3]               = explode(',', Config::get()->reslist_spec_fleet_3);
$reslist['spec_fleet'][4]               = explode(',', Config::get()->reslist_spec_fleet_4);
//Классофикация обороны
$reslist['spec_defense'][1]             = explode(',', Config::get()->reslist_spec_defense_1);
$reslist['spec_defense'][2]             = explode(',', Config::get()->reslist_spec_defense_2);
$reslist['spec_defense'][3]             = explode(',', Config::get()->reslist_spec_defense_3);
$reslist['spec_defense'][4]             = explode(',', Config::get()->reslist_spec_defense_4);
//Классофикация исследований
$reslist['spec_tech'][1]                = explode(',', Config::get()->reslist_spec_tech_1);
$reslist['spec_tech'][2]                = explode(',', Config::get()->reslist_spec_tech_2);
$reslist['spec_tech'][3]                = explode(',', Config::get()->reslist_spec_tech_3);
$reslist['spec_tech'][4]                = explode(',', Config::get()->reslist_spec_tech_4);
//Классофикация построек
$reslist['spec_build'][1]               = explode(',', Config::get()->reslist_spec_build_1);
$reslist['spec_build'][2]               = explode(',', Config::get()->reslist_spec_build_2);
$reslist['spec_build'][3]               = explode(',', Config::get()->reslist_spec_build_3);
$reslist['spec_build'][4]               = explode(',', Config::get()->reslist_spec_build_4);
//Листы игровых едениц
$reslist['build']		                = explode(',', Config::get()->reslist_build);
$reslist['allow'][1]	                = explode(',', Config::get()->reslist_allow_1);
$reslist['allow'][3]	                = explode(',', Config::get()->reslist_allow_3);
$reslist['tech']		                = explode(',', Config::get()->reslist_tech);
$reslist['fleet']                       = explode(',', Config::get()->reslist_fleet); 
$reslist['defense']                     = explode(',', Config::get()->reslist_defense); 
$reslist['missile']                     = explode(',', Config::get()->reslist_missile);
$reslist['officier']	                = explode(',', Config::get()->reslist_officier);
$reslist['dmfunc']		                = explode(',', Config::get()->reslist_dmfunc);
$reslist['details']		                = explode(',', Config::get()->reslist_details);
$reslist['minerals']		            = explode(',', Config::get()->reslist_minerals);
$reslist['party']	                    = explode(',', Config::get()->reslist_party);
$reslist['ideologies']	                = explode(',', Config::get()->reslist_ideologies);
$reslist['artifact']                    = explode(',', Config::get()->reslist_artifact);
$reslist['race']		                = explode(',', Config::get()->reslist_race);
$reslist['formgovernment']		        = explode(',', Config::get()->reslist_formgovernment);
$reslist['ethics']		                = explode(',', Config::get()->reslist_ethics);
$reslist['auction']                     = explode(',', Config::get()->reslist_auction);
$reslist['development']                 = explode(',', Config::get()->reslist_development);
$reslist['ars']		                    = explode(',', Config::get()->reslist_ars);
$reslist['premium']	                    = explode(',', Config::get()->reslist_premium);
$reslist['band']	                    = explode(',', Config::get()->reslist_band);
$reslist['fair']		                = explode(',', Config::get()->reslist_fair);
$reslist['bon']		                    = explode(',', Config::get()->reslist_bon);
$reslist['alliance']		            = explode(',', Config::get()->reslist_alliance);
$reslist['achievements']	            = explode(',', Config::get()->reslist_achievements);
//Другие листы игровых едениц
$reslist['domes']                       = explode(',', Config::get()->reslist_domes);               //Щиты
$reslist['orbital_bases']               = explode(',', Config::get()->reslist_orbital_bases);       //Орбитальные базы
//Настройка покупки игровых едениц
$reslist['not_bought']                  = explode(',', Config::get()->reslist_not_bought);          //Не покупается
$resglobal['buy_instantly']             = Config::get()->resglobal_buy_instantly;                   //Ресурс за который происходит покупка единиц
//Планеты
$reslist['planet_no_basic']             = explode(',', Config::get()->reslist_planet_no_basic);      //Планеты, у которых нет базовой добычи
$reslist['shipyard']                    = explode(',', Config::get()->reslist_shipyard);             //Если эти еденицы улучшаются, то верфь не работает
$reslist['lab']                         = explode(',', Config::get()->reslist_lab);                  //Если эти еденицы улучшаются, то исследования не работают
$reslist['min_planet_per_tech']         = explode(',', Config::get()->reslist_min_planet_per_tech);  //Технологии, которые влияют на минимальное колличество планет.
//Боевая система
$reslist['decline_in_battle']           = explode(',', Config::get()->reslist_decline_in_battle);    //Постройки, которые уничтожаются при успешной атаке
$reslist['battle_bonus']                = explode(',', Config::get()->reslist_battle_bonus);         //Еденицы, которые учитывается в симмуляторе
//Ресурсы
$resglobal['stop_product']              = Config::get()->resglobal_stop_product;                     //Ресурс, при недостатке которого вырубает добычу
$resglobal['build_speed']               = Config::get()->resglobal_build_speed;                      //Ресурс, который влияет на скорость построек
$resglobal['tech_speed']                = Config::get()->resglobal_tech_speed;                       //Ресурс, который влияет на скорость исследований
$resglobal['fleet_speed']               = Config::get()->resglobal_fleet_speed;                      //Ресурс, который влияет на скорость флота
$resglobal['defense_speed']             = Config::get()->resglobal_defense_speed;                    //Ресурс, который влияет на скорость обороны
$resglobal['missile_speed']             = Config::get()->resglobal_missile_speed;                    //Ресурс, который влияет на скорость ракет 
$reslist['resources_points']            = explode(',', Config::get()->reslist_resources_points);     //Ресурсы, которые учитывает статистика
$reslist['build_speed_res']             = explode(',', Config::get()->reslist_build_speed_res);      //Ресурсы, которые образуют время создания чего-либо
//Покупка луны
$resglobal['buy_moon_res']              = Config::get()->resglobal_buy_moon_res;                     //Ресурс, за который покупается луна
$resglobal['buy_moon_price']            = Config::get()->resglobal_buy_moon_price;                   //Цена этого ресурса
//Рынок
$resglobal['market_res']                = Config::get()->resglobal_market_res;                       //Ресурс, который используется при торговле на рынке
$reslist['not_market_send']             = explode(',', Config::get()->reslist_not_market_send);      //Не выставляется на продажу
//Флот
$reslist['reducefleet']                 = explode(',', Config::get()->reslist_reducefleet);          //Еденицы, которые учавствуют при своез флота
$reslist['tablefleet']                  = explode(',', Config::get()->reslist_tablefleet);           //Флот, который взлетает с орбиты
//Классофикация флота на орбите
$reslist['tablefleet_combat']           = explode(',', Config::get()->reslist_tablefleet_combat);    //Боевой флот
$reslist['tablefleet_transport']        = explode(',', Config::get()->reslist_tablefleet_transport); //Транспорт
$reslist['tablefleet_recyclers']        = explode(',', Config::get()->reslist_tablefleet_recyclers); //Переработчики
$reslist['tablefleet_special']          = explode(',', Config::get()->reslist_tablefleet_special);   //Особые
//Сектора PvE
$SectorME                               = explode(',', Config::get()->SectorME);