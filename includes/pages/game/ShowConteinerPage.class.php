<?php

/*
 * ╔══╗╔══╗╔╗──╔╗╔═══╗╔══╗╔╗─╔╗╔╗╔╗──╔╗╔══╗╔══╗╔══╗
 * ║╔═╝║╔╗║║║──║║║╔═╗║║╔╗║║╚═╝║║║║║─╔╝║╚═╗║║╔═╝╚═╗║
 * ║║──║║║║║╚╗╔╝║║╚═╝║║╚╝║║╔╗─║║╚╝║─╚╗║╔═╝║║╚═╗──║║
 * ║║──║║║║║╔╗╔╗║║╔══╝║╔╗║║║╚╗║╚═╗║──║║╚═╗║║╔╗║──║║
 * ║╚═╗║╚╝║║║╚╝║║║║───║║║║║║─║║─╔╝║──║║╔═╝║║╚╝║──║║
 * ╚══╝╚══╝╚╝──╚╝╚╝───╚╝╚╝╚╝─╚╝─╚═╝──╚╝╚══╝╚══╝──╚╝
 *
 * @author Tsvira Yaroslav <https://github.com/Yaro2709> @@ Aurum79 aka Чук
 * @info ***
 * @link https://github.com/Yaro2709/New-Star
 * @Basis 2Moons: XG-Project v2.8.0
 * @Basis New-Star: 2Moons v1.8.0
 */

class ShowConteinerPage extends AbstractGamePage
{	
	public static $requireModule = MODULE_CONTAINER;

	function __construct() 
	{
		parent::__construct(); 
	}
	
	function open()
	{
		global $PLANET, $USER, $LNG, $resource, $reslist, $pricelist;
		
        $conts			    	= HTTP::_GP('conts', 1);	

        if($conts > 500){
            $this->printMessage(''.$LNG['cont_msg_limit'].'',true, array("game.php?page=conteiner", 3));	
        }
	
        if($conts >0 && $USER['container'] >= $conts){
            $i = 1; 
            while ($i <= $conts) { 
            
                $GetFactor = 	mt_rand(0,100000); //Фактор
                if($GetFactor <= 10000){
                    $factor = mt_rand(2,10);
                }elseif($GetFactor > 10000 && $GetFactor <= 11000){
                    $factor = mt_rand(10,25);
                }elseif($GetFactor > 11000 && $GetFactor <= 11500){
                    $factor = mt_rand(25,50);
                }elseif($GetFactor > 11000 && $GetFactor <= 11250){
                    $factor = mt_rand(50,75);
                }elseif($GetFactor > 11250 && $GetFactor <= 11350){
                    $factor = mt_rand(75,100);
                }else{
                    $factor = 1;
                }
                
                $GetEvent	= mt_rand(0,100000); //Событие
                if($GetEvent <= 40000){
                    
                    $item = array(901,902,903);
                    $random_keys = array_rand($item);
                    $count = mt_rand(50000,150000) * Config::get()->stat_settings; 
                    $PLANET[''.$resource[$item[$random_keys]].''] += $count * $factor;
                    $item_log = $item[$random_keys];
                    include('includes/subclasses/subclass.ConteinerLog.php');

                }elseif($GetEvent > 40000 && $GetEvent <= 80000){ 
                
                    $item = array(202,203,204,205,401,402,403);
                    $random_keys = array_rand($item); 
                    $count = mt_rand(5,15) * Config::get()->stat_settings; 
                    $sql	= "UPDATE %%PLANETS%% SET ".$resource[$item[$random_keys]]." = ".$resource[$item[$random_keys]]." + ".($count * $factor)." WHERE id = :planetId;";
                    Database::get()->update($sql, array(
                        ':planetId'       => $PLANET["id"],
                    ));
                    $item_log = $item[$random_keys];
                    include('includes/subclasses/subclass.ConteinerLog.php');
	
                }elseif($GetEvent > 80000 && $GetEvent <= 90000){
                    
                    $item = array(206,207,211,213,215,219,404,405,406);
                    $random_keys = array_rand($item); 
                    $count = mt_rand(1,3) * Config::get()->stat_settings; 
                    $sql	= "UPDATE %%PLANETS%% SET ".$resource[$item[$random_keys]]." = ".$resource[$item[$random_keys]]." + ".($count * $factor)." WHERE id = :planetId;";
                    Database::get()->update($sql, array(
                        ':planetId'       => $PLANET["id"],
                    ));
                    $item_log = $item[$random_keys];
                    include('includes/subclasses/subclass.ConteinerLog.php');

                }elseif($GetEvent > 90000 && $GetEvent <= 95000){
                    
                    $item = $reslist['ars'];
                    $random_keys = array_rand($item);
                    $count = 1;	
                    $sql	= "UPDATE %%USERS%% SET ".$resource[$item[$random_keys]]." = ".$resource[$item[$random_keys]]." + ".($count * $factor)." WHERE id = :userId;";
                    Database::get()->update($sql, array(
                        ':userId'       => $USER["id"],
                    ));
                    $item_log = $item[$random_keys];
                    include('includes/subclasses/subclass.ConteinerLog.php');

                }elseif($GetEvent > 95000 && $GetEvent <= 97000){
                    
                    $item = 921;
                    $count = mt_rand(12,46) * Config::get()->stat_settings;
                    $USER[''.$resource[$item].''] += $count * $factor;
                    $item_log = $item;
                    include('includes/subclasses/subclass.ConteinerLog.php');

                }elseif($GetEvent > 97000 && $GetEvent <= 99900){
                    
                    $item = 922;
                    $count = mt_rand(10,25); 	
                    $USER[''.$resource[$item].''] += $count * $factor;
                    $item_log = $item;
                    include('includes/subclasses/subclass.ConteinerLog.php');

                }elseif($GetEvent > 99900 && $GetEvent <= 99950){
                    
                    $item = array(214,216,218,410);
                    $random_keys = array_rand($item); 
                    $count = 1 * Config::get()->stat_settings; 
                    $sql	= "UPDATE %%PLANETS%% SET ".$resource[$item[$random_keys]]." = ".$resource[$item[$random_keys]]." + ".($count * $factor)." WHERE id = :planetId;";
                    Database::get()->update($sql, array(
                        ':planetId'       => $PLANET["id"],
                    ));
                    $item_log = $item[$random_keys];
                    include('includes/subclasses/subclass.ConteinerLog.php');

                }elseif($GetEvent > 99950 && $GetEvent <= 100000){
                    
                    $item = 923;
                    $count = 1; 
                    $USER[''.$resource[$item].''] += $count * $factor;
                    $item_log = $item;
                    include('includes/subclasses/subclass.ConteinerLog.php');

                }else{
   
                    $item = array(901,902,903);
                    $random_keys = array_rand($item);
                    $count = mt_rand(50000,150000) * Config::get()->stat_settings;
                    $PLANET[''.$resource[$item[$random_keys]].''] += $count * $factor;
                    $item_log = $item[$random_keys];
                    include('includes/subclasses/subclass.ConteinerLog.php');
                
                }
                // отнимаем 1 контейнер после открытия
                $USER['container'] -= 1;
                //С помощью оператора ++ увеличиваем $i на единицу; при каждом проходе цикла:
                $i++;
            }
            $this->printMessage(''.$LNG['cont_open'].' '.$conts.'',true, array("game.php?page=conteiner", 3));
        }else{
        $this->printMessage(''.$LNG['cont_not_cont_user'].'',true, array("game.php?page=conteiner", 3));}
    } 
	
	public function show()
	{
		global  $USER, $PLANET, $LNG;
        
        $sql	= "SELECT * FROM %%CONT%% WHERE id_owner = :userId ORDER BY time DESC LIMIT ".$USER['container_set'].";";
        $logs	= Database::get()->select($sql, array(
			':userId'	        => $USER['id']
		));
        
        $sql = "SELECT COUNT(*) as count FROM %%CONT%% WHERE id_owner = :userId AND time > ".(TIMESTAMP-86400).";";
		$sum = Database::get()->selectSingle($sql, array(
			':userId'	        => $USER['id']
		));
        
		$this->tplObj->assign_vars(array(
            'conteiner'		    => $USER['container'],
            'logs'			    => $logs,
            'sum'			    => $sum['count'],
		));
		$this->display('page.conteiner.default.tpl');
	}	
}	
?>