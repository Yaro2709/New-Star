<?php
//$new_code
$ProdGrid = array(
	1 => array(
        'production' => array(
            901 => '(30 * $BuildLevel * pow((1.1), $BuildLevel)) * (0.1 * $BuildLevelFactor)',
            902 => '0',
            903 => '0',
            911 => '-(10 * $BuildLevel * pow((1.1), $BuildLevel)) * (0.1 * $BuildLevelFactor)'
        ),
    ),

	2 => array(
        'production' => array(
            901 => '0',
            902 => '(20 * $BuildLevel * pow((1.1), $BuildLevel)) * (0.1 * $BuildLevelFactor)',
            903 => '0',
            911 => '-(10 * $BuildLevel * pow((1.1), $BuildLevel)) * (0.1 * $BuildLevelFactor)'
        ),
    ),

	3 => array(
        'production' => array(
            901 => '0',
            902 => '0',
            903 => '(10 * $BuildLevel * pow((1.1), $BuildLevel) * (-0.002 * $BuildTemp + 1.28) * (0.1 * $BuildLevelFactor))',
            911 => '-(30 * $BuildLevel * pow((1.1), $BuildLevel)) * (0.1 * $BuildLevelFactor)'
        ),
    ),

	4 => array(
        'production' => array(
            901 => '0',
            902 => '0',
            903 => '0',
            911 => '(20 * $BuildLevel * pow((1.1), $BuildLevel)) * (0.1 * $BuildLevelFactor)'
        ),
    ),
    
    22 => array(
        'storage' => array(
            901 => 'floor(2.5 * pow(1.8331954764, $BuildLevel)) * 5000',
            902 => '0',
            903 => '0',
            911 => '0'
        ),
    ),

	23 => array(
        'storage' => array(
            901 => '0',
            902 => 'floor(2.5 * pow(1.8331954764, $BuildLevel)) * 5000',
            903 => '0',
            911 => '0'
        ),
    ),

	24 => array(
        'storage' => array(
            901 => '0',
            902 => '0',
            903 => 'floor(2.5 * pow(1.8331954764, $BuildLevel)) * 5000',
            911 => '0'
        ),
    ),

	12 => array(
        'production' => array(
            901 => '0',
            902 => '0',
            903 => '-(10 * $BuildLevel * pow(1.1,$BuildLevel) * (0.1 * $BuildLevelFactor))',
            911 => '(30 * $BuildLevel * pow((1.05), $BuildLevel)) * (0.1 * $BuildLevelFactor)'
        ),
    ),

	212 => array(
        'production' => array(
            901 => '0',
            902 => '0',
            903 => '0',
            911 => '((($BuildTemp + 160) / 6) * (0.1 * $BuildLevelFactor) * $BuildLevel)'
        ),
    )
);
//$new_code