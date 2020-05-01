<?php
//$new_code
#
# MOD BY Aurum79 aka Чук
#
class ShowBonusPage extends AbstractGamePage 
{
	public static $requireModule = MODULE_BONUS;
    
	function __construct() 
	{
		parent::__construct();
	}
	
	function show()
	{		
		global $USER, $PLANET,  $LNG, $resource;
        
		if($USER['bonus_time'] > TIMESTAMP)		
			$this->redirectTo('game.php');
        
		$bonus = array(
			901	=> rand(100000,200000),
			902	=> rand(100000,200000),
			903	=> rand(100000,200000),
		);
        
		foreach($bonus as $id => $key)
		{
			$PLANET[$resource[$id]]	+= $bonus[$id];
		}
        
		$time			 = (TIMESTAMP + 86400);
        
		$db = Database::get();
		$sql = 'UPDATE %%USERS%% SET bonus_time = :time WHERE id = :userID;';
			$db->update($sql, array(
				':time'		   => $time,
				':userID'	   => $USER['id']
			));
            
		$bonusList	= array();
        
		foreach($bonus as $id => $key)
		{
			$bonusList[$id]	= array(
				'bonus'		=> $key,
			);
		}
        
		$this->tplObj->assign_vars(array(
			'bonusList'				=> $bonusList,
		));
		$this->display('page.bonus.default.tpl');
	}	
}
//$new_code