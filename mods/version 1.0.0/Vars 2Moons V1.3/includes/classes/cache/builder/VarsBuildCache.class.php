<?php

/**
 *  2Moons 
 *   by Jan-Otto Kröpke 2009-2016
 *
 * For the full copyright and license information, please view the LICENSE
 *
 * @package 2Moons
 * @author Jan-Otto Kröpke <slaver7@gmail.com>
 * @copyright 2009 Lucky
 * @copyright 2016 Jan-Otto Kröpke <slaver7@gmail.com>
 * @licence MIT
 * @version 1.8.0
 * @link https://github.com/jkroepke/2Moons
 */

class VarsBuildCache implements BuildCache
{
	function buildCache()
	{
		$resource		        = array();
		$requeriments	        = array();
		$pricelist		        = array();
		$CombatCaps		        = array();
		$reslist		        = array();
		$ProdGrid		        = array();
        
        $reslist['bonus']		= array();
        
		require_once('includes/vars/Resource.php');
        require_once('includes/vars/Requeriments.php');
        require_once('includes/vars/Pricelist.php');
        require_once('includes/vars/CombatCaps.php');
        require_once('includes/vars/Reslist.php');
        require_once('includes/vars/ProdGrid.php');
		
		return array(
            'resource'		=> $resource,
            'requeriments'	=> $requeriments,
            'pricelist'		=> $pricelist,
            'CombatCaps'	=> $CombatCaps,
			'reslist'		=> $reslist,
			'ProdGrid'		=> $ProdGrid,
		);
	}
}