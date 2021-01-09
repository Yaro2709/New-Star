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

//$new_code
if(isset($BonusElement[$Element]))
{
    foreach($BonusElement[$Element] as $ID => $Count)
    {
        if(isset($PLANET[$resource[$ID]])){
            if($PLANET[$resource[$ID]] + $Count * $amount * $bonus < 0){
                $this->printMessage(''.$LNG['bd_notres'].'', true, array('game.php?page=details', 2));
            }else{
                $sql	= 'UPDATE %%PLANETS%% SET
                '.$resource[$ID].' = '.$resource[$ID].' + '.$Count.' * '.$amount.' * '.$bonus.'
                WHERE id = :Id;';
                    
                Database::get()->update($sql, array(
                    ':Id'	=> $PLANET['id']
                ));  
                $PLANET[''.$resource[$ID].''] += $Count * $amount * $bonus;
            }
        }else{
            if($USER[$resource[$ID]] + $Count * $amount * $bonus < 0){
                $this->printMessage(''.$LNG['bd_notres'].'', true, array('game.php?page=details', 2));
            }else{
                $sql	= 'UPDATE %%USERS%% SET
                '.$resource[$ID].' = '.$resource[$ID].' + '.$Count.' * '.$amount.' * '.$bonus.'
                WHERE id = :Id;';
                    
                Database::get()->update($sql, array(
                    ':Id'	=> $USER['id']
                ));
                $USER[''.$resource[$ID].''] += $Count * $amount * $bonus;
            }
        }
    }
}
//$new_code