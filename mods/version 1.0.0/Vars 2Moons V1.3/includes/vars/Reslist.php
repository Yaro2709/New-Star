<?php
//$new_code
$reslist['ressources']          = array(901, 902, 903, 911, 921);
$reslist['res_production']      = array(901 => 0, 902 => 0, 903 => 0, 911 => 0);
$reslist['resstype'][1]         = array(901, 902, 903);
$reslist['resstype'][2]         = array(911);
$reslist['resstype'][3]         = array(921);

$reslist['prod']                = array(1, 2, 3, 4, 12, 212);
$reslist['storage']             = array(22, 23, 24);
$reslist['one']  	            = array(407, 408, 409, 411);
$reslist['build']               = array(1, 2, 3, 4, 6, 12, 14, 15, 21, 22, 23, 24, 31, 33, 34, 44, 41, 42, 43);
$reslist['allow']               = array(1 => array(1, 2, 3, 4, 6, 12, 14, 15, 21, 22, 23, 24, 31, 33, 34, 44), 3 => array(12, 14, 21, 22, 23, 24, 34, 41, 42, 43));
$reslist['tech']                = array(106, 108, 109, 110, 111, 113, 114, 115, 117, 118, 120, 121, 122, 123, 124, 131, 132, 133, 199);
$reslist['fleet']               = array(202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220);
$reslist['defense']             = array(401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411);
$reslist['missile']             = array(502, 503);
$reslist['officier']            = array(601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615);
$reslist['dmfunc'] 	            = array(701, 702, 703, 704, 705, 706, 707);

$reslist['lab']                 = array(31); //единицы, которые объединяются в сеть
$reslist['planet_no_basic']     = array(3); //планеты, у которых нет базовой добычи
$reslist['shipyard']            = array(21); //нет верфя - ничего не построешь
$reslist['shipyard_no_build']   = array(15,21); //если эти еденицы улучшаются, то верфь не работает
//$new_code