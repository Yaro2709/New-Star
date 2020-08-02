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
            
            foreach($reslist['prod'] as $ProdID)
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
            
            foreach($reslist['prod'] as $ProdID)
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
		
		$ressIDs		= array_merge(array(), $reslist['resstype'][1], $reslist['resstype'][2]);

		$productionList	= array();

        if($PLANET[''.$resource[$resglobal['stop_product']].'_used'] != 0) {
            $prodLevel	= min(1, $PLANET[''.$resource[$resglobal['stop_product']].''] / abs($PLANET[''.$resource[$resglobal['stop_product']].'_used']));
        } else {
            $prodLevel	= 0;
        }

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

        $storage	        = array();
		$basicProduction	= array();
		$totalProduction	= array();
		$bonusProduction	= array();
		$dailyProduction	= array();
		$weeklyProduction	= array();
        
        foreach($reslist['resstype'][1] as $resP)
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
        
        foreach($reslist['resstype'][2] as $resS)
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
