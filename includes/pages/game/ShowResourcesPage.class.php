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

class ShowResourcesPage extends AbstractGamePage
{
	public static $requireModule = MODULE_RESSOURCE_LIST;

	function __construct() 
	{
		parent::__construct();
	}
    
    function AllPlanets()
	{
		global $reslist, $resource, $USER, $PLANET, $LNG;
		$db = Database::get();
		$action = HTTP::_GP('action','');
			
		if ($action == 'on'){
            
            $sql = "UPDATE %%PLANETS%% SET
				last_update 		= :last_update
				WHERE id_owner = :userID;";
			$db->update($sql, array(
				':last_update'	=> TIMESTAMP,
				':userID'		=> $USER['id']
            ));	
            
            foreach($reslist['prod'] as $ProdID) //проверка всего масива элементов
            { 
                $sql .= "UPDATE %%PLANETS%% SET
                    ".$resource[$ProdID]."_porcent = '11'
					WHERE id_owner = :userID;";
                $db->update($sql, array(
                    ':last_update'	=> TIMESTAMP,
                    ':userID'		=> $USER['id']
                ));	
            }

			$PLANET['last_update']	= TIMESTAMP;
			$this->ecoObj->setData($USER, $PLANET);
			$this->ecoObj->ReBuildCache();
			list($USER, $PLANET)	= $this->ecoObj->getData();
			$PLANET['eco_hash'] = $this->ecoObj->CreateHash();
			$this->save();
			
			$sql	= 'SELECT * FROM %%PLANETS%% WHERE id = :planetId;';
			$getPlanet = Database::get()->selectSingle($sql, array(
				':planetId'		=> $PLANET['id'],
			));
			
			$this->printMessage($LNG['res_cl_activate'], true, array('game.php?page=resources', 2));
            
		}elseif ($action == 'off'){
            
            $sql = "UPDATE %%PLANETS%% SET
				last_update 		= :last_update
				WHERE id_owner = :userID;";
			$db->update($sql, array(
				':last_update'	=> TIMESTAMP,
				':userID'		=> $USER['id']
            ));	
            
            foreach($reslist['prod'] as $ProdID) //проверка всего масива элементов
            { 
                $sql .= "UPDATE %%PLANETS%% SET
                    ".$resource[$ProdID]."_porcent = '0'
					WHERE id_owner = :userID;";
                $db->update($sql, array(
                    ':last_update'	=> TIMESTAMP,
                    ':userID'		=> $USER['id']
                ));	
            }
            
			$this->ecoObj->setData($USER, $PLANET);
			$this->ecoObj->ReBuildCache();
			list($USER, $PLANET)	= $this->ecoObj->getData();
			$PLANET['eco_hash'] = $this->ecoObj->CreateHash();
			$this->save();
			
			$sql	= 'SELECT * FROM %%PLANETS%% WHERE id = :planetId;';
			$getPlanet = Database::get()->selectSingle($sql, array(
				':planetId'		=> $PLANET['id'],
			));
			
			$this->printMessage($LNG['res_cl_dactivate'], true, array('game.php?page=resources', 2));
		}
		
	}
	
	function send()
	{
		global $resource, $USER, $PLANET;
		if ($USER['urlaubs_modus'] == 0)
		{
			$updateSQL	= array();
			if(!isset($_POST['prod']))
				$_POST['prod'] = array();


			$param	= array(':planetId' => $PLANET['id']);
			
			foreach($_POST['prod'] as $resourceId => $Value)
			{
				$FieldName = $resource[$resourceId].'_porcent';
				if (!isset($PLANET[$FieldName]) || !in_array($Value, range(0, 10)))
					continue;
				
				$updateSQL[]	= $FieldName." = :".$FieldName;
				$param[':'.$FieldName]		= (int) $Value;
				$PLANET[$FieldName]			= $Value;
			}

			if(!empty($updateSQL))
			{
				$sql	= 'UPDATE %%PLANETS%% SET '.implode(', ', $updateSQL).' WHERE id = :planetId;';

				Database::get()->update($sql, $param);

				$this->ecoObj->setData($USER, $PLANET);
				$this->ecoObj->ReBuildCache();
				list($USER, $PLANET)	= $this->ecoObj->getData();
				$PLANET['eco_hash'] = $this->ecoObj->CreateHash();
			}
		}

		$this->save();
		$this->redirectTo('game.php?page=resources');
	}
	function show()
	{
		global $LNG, $ProdGrid, $resource, $reslist, $USER, $PLANET, $resglobal;

		$config	= Config::get();

        //$new_code
        foreach(array_merge($reslist['resstype'][1], $reslist['resstype'][2]) as $res) {		
            $basicIncome[$res]	= $config->{$resource[$res].'_basic_income'};
        }
        
        foreach($reslist['planet_no_basic'] as $planetNoBasic) {
            foreach(array_merge($reslist['resstype'][1], $reslist['resstype'][2]) as $res) {
                if($USER['urlaubs_modus'] == 1 || $PLANET['planet_type'] == $planetNoBasic){
                    $basicIncome[$res]	= 0;
                }
            }
        }
        
        include('includes/subclasses/subclass.Temp.php');
        //$new_code
		/* $old_code
        
        if($USER['urlaubs_modus'] == 1 || $PLANET['planet_type'] != 1)
		{
			$basicIncome[901]	= 0;
			$basicIncome[902]	= 0;
			$basicIncome[903]	= 0;
			$basicIncome[911]	= 0;
		}
		else
		{		
			$basicIncome[901]	= $config->{$resource[901].'_basic_income'};
			$basicIncome[902]	= $config->{$resource[902].'_basic_income'};
			$basicIncome[903]	= $config->{$resource[903].'_basic_income'};
			$basicIncome[911]	= $config->{$resource[911].'_basic_income'};
		}
        
		$temp	= array(
			901	=> array(
				'plus'	=> 0,
				'minus'	=> 0,
			),
			902	=> array(
				'plus'	=> 0,
				'minus'	=> 0,
			),
			903	=> array(
				'plus'	=> 0,
				'minus'	=> 0,
			),
			911	=> array(
				'plus'	=> 0,
				'minus'	=> 0,
			)
		);
        $old_code */
		
		$ressIDs		= array_merge(array(), $reslist['resstype'][1], $reslist['resstype'][2]);

		$productionList	= array();
        /* $old_code
		if($PLANET['energy_used'] != 0) {
			$prodLevel	= min(1, $PLANET['energy'] / abs($PLANET['energy_used']));
		} else {
			$prodLevel	= 0;
		}
        $old_code */
        //$new_code
        //foreach($reslist['resstype'][2] as $resS) {
        if($PLANET[''.$resource[$resglobal['stop_product']].'_used'] != 0) {
            $prodLevel	= min(1, $PLANET[''.$resource[$resglobal['stop_product']].''] / abs($PLANET[''.$resource[$resglobal['stop_product']].'_used']));
        } else {
            $prodLevel	= 0;
        }
        //}
        //$new_code

		/* Data for eval */
        /* $old_code
		$BuildEnergy		= $USER[$resource[113]];
        $old_code */
		$BuildTemp          = $PLANET['temp_max'];
        
		foreach($reslist['prod'] as $ProdID)
		{
			if(isset($PLANET[$resource[$ProdID]]) && $PLANET[$resource[$ProdID]] == 0)
				continue;

			if(isset($USER[$resource[$ProdID]]) && $USER[$resource[$ProdID]] == 0)
				continue;

			$productionList[$ProdID]	= array(
				'production'	=> $reslist['res_production'], //временно!!!
				'elementLevel'	=> $PLANET[$resource[$ProdID]],
				'prodLevel'		=> $PLANET[$resource[$ProdID].'_porcent'],
			);

			/* Data for eval */
			$BuildLevel			= $PLANET[$resource[$ProdID]];
			$BuildLevelFactor	= $PLANET[$resource[$ProdID].'_porcent'];

			foreach($ressIDs as $ID) 
			{
				if(!isset($ProdGrid[$ProdID]['production'][$ID]))
					continue;

				$Production	= eval(ResourceUpdate::getProd($ProdGrid[$ProdID]['production'][$ID]));

				if(in_array($ID, $reslist['resstype'][2]))
				{
					$Production	*= $config->energySpeed;
				}
				else
				{
					$Production	*= $prodLevel * $config->resource_multiplier;
				}
				
				$productionList[$ProdID]['production'][$ID]	= $Production;
				
				if($Production > 0) {
					if($PLANET[$resource[$ID]] == 0) continue;
					
					$temp[$ID]['plus']	+= $Production;
				} else {
					$temp[$ID]['minus']	+= $Production;
				}
			}
		}
        //$new_code
        $storage	        = array();
		$basicProduction	= array();
		$totalProduction	= array();
		$bonusProduction	= array();
		$dailyProduction	= array();
		$weeklyProduction	= array();
        
        foreach($reslist['resstype'][1] as $resP)//проверка всего масива элементов
        { 
            $storage	        += array(
			$resP => ($PLANET[$resource[$resP].'_max']));
            
            $basicProduction	+= array(
			$resP => $basicIncome[$resP] * $config->resource_multiplier);
            
            $totalProduction	+= array(
			$resP => $PLANET[$resource[$resP].'_perhour'] + $basicProduction[$resP]);
            
            $bonusProduction	+= array(
			$resP => $temp[$resP]['plus'] * ($USER['factor']['Resource'] + $USER['factor']['P'.$resource[$resP].'']));
            
            $dailyProduction	+= array(
			$resP => $totalProduction[$resP] * 24);
		
            $weeklyProduction	+= array(
			$resP => $totalProduction[$resP] * 168);
        }
        
        foreach($reslist['resstype'][2] as $resS)//проверка всего масива элементов
        { 
            $basicProduction	+= array(
			$resS => $basicIncome[$resS] * $config->resource_multiplier);
            
            $totalProduction	+= array(
			$resS => $PLANET[$resource[$resS]] + $basicProduction[$resS] + $PLANET[$resource[$resS].'_used']);
            
            $bonusProduction	+= array(
			$resS => $temp[$resS]['plus'] * $USER['factor']['S'.$resource[$resS].'']);
            
            $dailyProduction	+= array(
			$resS => $totalProduction[$resS]);
		
            $weeklyProduction	+= array(
			$resS => $totalProduction[$resS]);
        }
        
        //$new_code
        /*$old_code
		$storage	= array(
			901 => shortly_number($PLANET[$resource[901].'_max']),
			902 => shortly_number($PLANET[$resource[902].'_max']),
			903 => shortly_number($PLANET[$resource[903].'_max']),
		);
		
		$basicProduction	= array(
			901 => $basicIncome[901] * $config->resource_multiplier,
			902 => $basicIncome[902] * $config->resource_multiplier,
			903	=> $basicIncome[903] * $config->resource_multiplier,
			911	=> $basicIncome[911] * $config->energySpeed,
		);
		
		$totalProduction	= array(
			901 => $PLANET[$resource[901].'_perhour'] + $basicProduction[901],
			902 => $PLANET[$resource[902].'_perhour'] + $basicProduction[902],
			903	=> $PLANET[$resource[903].'_perhour'] + $basicProduction[903],
			911	=> $PLANET[$resource[911]] + $basicProduction[911] + $PLANET[$resource[911].'_used'],
		);
		
		$bonusProduction	= array(
			901 => $temp[901]['plus'] * ($USER['factor']['Resource'] + $USER['factor']['Pmetal']),
			902 => $temp[902]['plus'] * ($USER['factor']['Resource'] + $USER['factor']['Pcrystal']),
			903	=> $temp[903]['plus'] * ($USER['factor']['Resource'] + $USER['factor']['Pdeuterium']),
			911	=> $temp[911]['plus'] * $USER['factor']['Senergy'],
		);
		
		$dailyProduction	= array(
			901 => $totalProduction[901] * 24,
			902 => $totalProduction[902] * 24,
			903	=> $totalProduction[903] * 24,
			911	=> $totalProduction[911],
		);
		
		$weeklyProduction	= array(
			901 => $totalProduction[901] * 168,
			902 => $totalProduction[902] * 168,
			903	=> $totalProduction[903] * 168,
			911	=> $totalProduction[911],
		);
		$old_code*/	
		$prodSelector	= array();
		
		foreach(range(10, 0) as $percent) {
			$prodSelector[$percent]	= ($percent * 10).'%';
		}
		
		$this->assign(array(
            'resstype1'         => $reslist['resstype'][1],
            'resstype2'         => $reslist['resstype'][2],
			'header'			=> sprintf($LNG['rs_production_on_planet'], $PLANET['name']),
			'prodSelector'		=> $prodSelector,
			'productionList'	=> $productionList,
			'basicProduction'	=> $basicProduction,
			'totalProduction'	=> $totalProduction,
			'bonusProduction'	=> $bonusProduction,
			'dailyProduction'	=> $dailyProduction,
			'weeklyProduction'	=> $weeklyProduction,
			'storage'			=> $storage,
		));
		
		$this->display('page.resources.default.tpl');
	}
}
