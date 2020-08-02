<?php

/*
 * ╔══╗╔══╗╔╗──╔╗╔═══╗╔══╗╔╗─╔╗╔╗╔╗──╔╗╔══╗╔══╗╔══╗
 * ║╔═╝║╔╗║║║──║║║╔═╗║║╔╗║║╚═╝║║║║║─╔╝║╚═╗║║╔═╝╚═╗║
 * ║║──║║║║║╚╗╔╝║║╚═╝║║╚╝║║╔╗─║║╚╝║─╚╗║╔═╝║║╚═╗──║║
 * ║║──║║║║║╔╗╔╗║║╔══╝║╔╗║║║╚╗║╚═╗║──║║╚═╗║║╔╗║──║║
 * ║╚═╗║╚╝║║║╚╝║║║║───║║║║║║─║║─╔╝║──║║╔═╝║║╚╝║──║║
 * ╚══╝╚══╝╚╝──╚╝╚╝───╚╝╚╝╚╝─╚╝─╚═╝──╚╝╚══╝╚══╝──╚╝
 *
 * @author Aurum79 aka Чук
 * @info ***
 * @link https://github.com/Yaro2709/New-Star
 * @Basis 2Moons: XG-Project v2.8.0
 * @Basis New-Star: 2Moons v1.8.0
 */

class ShowMarketPage extends AbstractGamePage
{
	public static $requireModule = MODULE_MARKET;
    
	function __construct() 
	{
		parent::__construct();
	}
    
	function show()
	{
		global $USER, $PLANET, $LNG, $resource, $reslist, $resglobal, $THEME;
        
        $db			= Database::get();
		$lot		= array();
        //Ресурсы, которые принадлежат планете
        $Planet_list = array_diff(array_merge($reslist['resstype'][1], $reslist['fleet'], $reslist['defense']), $reslist['not_market_send']);
		foreach($Planet_list as $sellID)
		{
			if ($PLANET[$resource[$sellID]] == 0)
				continue;	
			$lot[]	= array(
				'id'	=> $sellID,
				'count'	=> $PLANET[$resource[$sellID]],
			);
		}
        //Ресусры, которые принадлежат игроку
        $User_list = array_diff(array_merge($reslist['ars']), $reslist['not_market_send']);
        foreach($User_list as $sellID)
		{
			if ($USER[$resource[$sellID]] == 0)
				continue;	
			$lot[]	= array(
				'id'	=> $sellID,
				'count'	=> $USER[$resource[$sellID]],
			);
		}
        //Запрос на все лоты, которые выставлены, кроме тех, которые принадлежат игроку
		$sql ='SELECT * FROM %%MARKET%%  WHERE id_owner != :userID;';
		$markets = $db->select($sql, array(
			':userID'	=> $USER['id']
		));
		//Запрос через foreach
		$market	= array();
		foreach($markets as $lotID)
		{	
			$Popup		= '<a href="#" data-tooltip-content="<table class=\'reducefleet_table\'>';
			$text	    = '';
			$Datalot	= array();
			$lotz		= explode(';', $lotID['lot']);
			foreach($lotz as $Item => $Group)
			{
				if (empty($Group))continue;	
				$res	= explode(',', $Group);
					$Popup	 .= '<tr><td class=\'reducefleet_img_ship\'><img src=\''.$THEME->getTheme().'gebaeude/'.$res[0].'.gif\'></td><td class=\'reducefleet_name_ship\'>'.$LNG['tech'][$res[0]].': <span class=\'reducefleet_count_ship\'>'.pretty_number($res[1]).'</span></td></tr>';
					$Datalot[]	= floatToString($res[1]).' '.$LNG['tech'][$res[0]];}
                    $text	.= implode('; ', $Datalot);
                    $Popup  .= '</table>" class="tooltip">'.$LNG['market_lot'].'</a><span class="textForBlind"> ('.$text.')</span>';
                    $market[]	= array(
                        'lot'		 => $Popup,
                        'class'		 => $lotID['class'],
                        'id'		 => $lotID['id'],
                        'price'	     => $lotID['price'],
                        'time'		 => _date($LNG['php_tdformat'],$lotID['time']),
                    );
		}	
		//Показываем лоты, которые принадлежат игроку
		$sql ='SELECT * FROM %%MARKET%%  WHERE id_owner = :userID; ';
		$u = $db->select($sql, array(
			':userID'	=> $USER['id']
		));		
        //Запрос через foreach
		$u_lot	= array();
		foreach($u as $lotID)
		{	
			$Popup		= '<a href="#" data-tooltip-content="<table class=\'reducefleet_table\'>';
			$text	= '';
			$Datalot	= array();
			$lotz		= explode(';', $lotID['lot']);
			foreach($lotz as $Item => $Group)
			{
				if (empty($Group))continue;	
				$res	= explode(',', $Group);
				$Popup	 .= '<tr><td class=\'reducefleet_img_ship\'><img src=\''.$THEME->getTheme().'gebaeude/'.$res[0].'.gif\'></td><td class=\'reducefleet_name_ship\'>'.$LNG['tech'][$res[0]].': <span class=\'reducefleet_count_ship\'>'.pretty_number($res[1]).'</span></td></tr>';
				$Datalot[]	= floatToString($res[1]).' '.$LNG['tech'][$res[0]];}
                $text	.= implode('; ', $Datalot);
                $Popup  .= '</table>" class="tooltip">'.$LNG['market_lot'].'</a><span class="textForBlind"> ('.$text.')</span>';
                $u_lot[]	= array(
                    'lot'		 => $Popup,
                    'class'		 => $lotID['class'],
                    'id'		 => $lotID['id'],
                    'price'	     => $lotID['price'],
                    'time_off'   => $lotID['time']+172800,
                    'time'		 => _date($LNG['php_tdformat'],$lotID['time']),
                );
		}	
        //Конец
        $this->tplObj->loadscript("market.js");
		$cookie = isset($_COOKIE['open_market']) ? 	$_COOKIE['open_market'] : 1;
		$this->assign(array(
            'class_name' => array(
				1 => $LNG['market_all'], 
				2 => $LNG['tech'][900],
				3 => $LNG['tech'][200],
                4 => $LNG['tech'][400],
                5 => $LNG['tech'][2000]),
            'cookie'        => $cookie,
			'lot'		    => $lot,
			'market'	    => $market,
			'u_lot'		    => $u_lot,
			'timestamp'	    => TIMESTAMP,
            'res'	        => $resglobal['market_res'],
		));
        
		$this->display('page.market.tpl');
	}
	
	function add()
	{
		global  $PLANET,$USER, $LNG, $resource, $reslist;
        
		$db				= Database::get();
		$lot		    = array();
		$price          = HTTP::_GP('price',0);
        $class          = HTTP::_GP('class',0);
        
		$add_lot = array_diff(array_merge($reslist['resstype'][1], $reslist['fleet'], $reslist['defense']), $reslist['not_market_send']);
		
		foreach ($add_lot as $id => $lotID)
		{
			$amount						 = max(0, floor(HTTP::_GP('lot'.$lotID, 0.0, 0.0)));
			if ($amount < 1) continue;
			if ($amount > $PLANET[$resource[$lotID]]) continue;
			$lot[]	= $lotID.','.floatToString($amount);
			$PLANET[$resource[$lotID]]	-= $amount;
			
			$sql =  "UPDATE %%PLANETS%% SET
                ".$resource[$lotID]."=".$resource[$lotID]."-:amount 
                WHERE id = :planetID;";
                
			$db->update($sql, array(
                ':planetID'		=> $PLANET['id'],
                ':amount'		=> $amount
			));
		}
        
        $add_lot = array_diff(array_merge($reslist['ars']), $reslist['not_market_send']);
        
        foreach ($add_lot as $id => $lotID)
		{
			$amount	= max(0, floor(HTTP::_GP('lot'.$lotID, 0.0, 0.0)));
			if ($amount < 1) continue;
			if ($amount > $USER[$resource[$lotID]]) continue;
			$lot[]	= $lotID.','.floatToString($amount);
			$USER[$resource[$lotID]]	-= $amount;
			
			$sql =  "UPDATE %%USERS%% SET
                ".$resource[$lotID]."=".$resource[$lotID]."-:amount 
                WHERE id = :userId;";
                
			$db->update($sql, array(
                ':userId'			=> $USER['id'],
                ':amount'			=> $amount
			));
		}
		
		if (empty($lot) || $price == 0){
			$this->printMessage($LNG['market_indicated'], array(array( 
                'label'	=> $LNG['sys_forward'],
                'url'	=> 'game.php?page=market'
			)));
		}
			
		$sql = 'INSERT INTO %%MARKET%% SET class = :class, id_owner = :id_owner, id_planet = :id_planet, lot = :lot, price = :price, time = :time;';
		$db->insert($sql, array(
            ':class'		=> $class,
			':id_owner'		=> $USER['id'],
			':id_planet'	=> $PLANET['id'],
			':time'			=> TIMESTAMP,
			':lot'			=> implode(';', $lot),
			':price'		=> round($price),
		));	
		
		$this->printMessage($LNG['market_exposed'], array(array( 
			'label'	=> $LNG['sys_forward'],
			'url'	=> 'game.php?page=market'
		)));
	}
	
	function sell() 
	{
		global $PLANET, $USER, $LNG, $resource, $reslist, $resglobal;
        
		$db				= Database::get();
		$id	            = HTTP::_GP('id', 0);
		$selling        = $db->selectSingle("SELECT * FROM %%MARKET%% WHERE id = :ID;", array(':ID' => $id));
		
		if($USER[$resource[$resglobal['market_res']]] < $selling['price']){
            $this->printMessage($LNG['market_not_enough_money'], array(array( 
                'label'	=> $LNG['sys_forward'],
                'url'	=> 'game.php?page=market')
            ));
        }else{		
			$sell_lot = explode(';', $selling['lot']);
			
            foreach ($sell_lot as $sell => $id)
            {
				$res	= explode(',', $id);

                if(in_array($res[0], array_diff(array_merge($reslist['resstype'][1], $reslist['fleet'], $reslist['defense']), $reslist['not_market_send']))){

                    $PLANET[$resource[$res[0]]]	+= $res[1];
                    
                    $sql =  "UPDATE %%PLANETS%% SET
                        ".$resource[$res[0]]." = ".$resource[$res[0]]." + :amount 
                        WHERE id = :planetID;";
                        
                    $db->update($sql, array(
                        ':planetID'			=> $PLANET['id'],
                        ':amount'			=> $res[1]
                    ));
                    
                }elseif(in_array($res[0], array_diff(array_merge($reslist['ars']), $reslist['not_market_send']))){
                    
					$USER[$resource[$res[0]]]	+= $res[1];
					
                    $sql =  "UPDATE %%USERS%% SET
                        ".$resource[$res[0]]."=".$resource[$res[0]]."+:amount 
                        WHERE id = :userId;";
                        
                    $db->update($sql, array(
                        ':userId'			=> $USER['id'],
                        ':amount'			=> $res[1]
                    ));
                }
            }	
            
            $USER[$resource[$resglobal['market_res']]] -= $selling['price'];
        
            $sql =  "UPDATE %%USERS%% SET ".$resource[$resglobal['market_res']]." = ".$resource[$resglobal['market_res']]." + :amount WHERE id = :userID;";
            $db->update($sql, array(
                ':userID'=> $selling['id_owner'],
                ':amount'=> $selling['price']
            ));
        
            $sql = "DELETE FROM %%MARKET%% WHERE id = :lotId;";
            $db->delete($sql, array(
                ':lotId'	=> $selling['id']
            ));
        
            $this->printMessage($LNG['market_buy'], array(array( 
                'label'	=> $LNG['sys_forward'],
                'url'	=> 'game.php?page=market')
            ));	
		}
	}
	
	function cancel_lot() 
	{
		global  $PLANET,$USER, $LNG, $resource, $reslist;
		
        $db			= Database::get();
		$id	        = HTTP::_GP('id', 0);
		$cancel     = $db->selectSingle("SELECT * FROM %%MARKET%% WHERE id = :ID;", array(':ID' => $id));
		$cancel_lot = explode(';', $cancel['lot']);
		
		foreach ($cancel_lot as $sell => $id)
		{
			$res	= explode(',', $id);
            
            if(in_array($res[0], array_diff(array_merge($reslist['resstype'][1], $reslist['fleet'], $reslist['defense']), $reslist['not_market_send']))){
                
                $PLANET[$resource[$res[0]]]	+= $res[1];
                
                $sql =  "UPDATE %%PLANETS%% SET
                    ".$resource[$res[0]]."=".$resource[$res[0]]."+:amount 
                    WHERE id = :planetID;";
            
                $db->update($sql, array(
                    ':planetID'			=> $PLANET['id'],
                    ':amount'			=> $res[1]
                ));
                
            }elseif(in_array($res[0], array_diff(array_merge($reslist['ars']), $reslist['not_market_send']))){
                
                $USER[$resource[$res[0]]]	+= $res[1];
                
                $sql =  "UPDATE %%USERS%% SET
                    ".$resource[$res[0]]."=".$resource[$res[0]]."+:amount 
                    WHERE id = :userId;";
            
                $db->update($sql, array(
                    ':userId'			=> $USER['id'],
                    ':amount'			=> $res[1]
                ));
            }
		}	
        
		$sql = "DELETE FROM %%MARKET%% WHERE id = :lotId;";
		$db->delete($sql, array(
			':lotId'	=> $cancel['id']
		));
        
		$this->printMessage($LNG['market_take_off'], array(array( 
			'label'	=> $LNG['sys_forward'],
			'url'	=> 'game.php?page=market'
		)));	
	}
}