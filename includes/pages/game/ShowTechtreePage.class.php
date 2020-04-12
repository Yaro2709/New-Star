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


class ShowTechtreePage extends AbstractGamePage
{
    public static $requireModule = MODULE_TECHTREE;

    function __construct()
    {
        parent::__construct();
    }
    //code_update
	function show()
	{
		global $resource, $requeriments, $LNG, $reslist, $USER, $PLANET;
		
		$RequeriList	= array();

		$elementID		= array_merge(array(0), $reslist['build']);
		$elementID1		= array_merge(array(100), $reslist['tech']);
		$elementID3		= array_merge(array(200), $reslist['fleet']);
		$elementID4		= array_merge(array(400), $reslist['defense']);
		$elementID5		= array_merge(array(600), $reslist['officier']);
		//Исследования
		foreach($elementID1 as $Element)
		{			
			if(!isset($resource[$Element])) {
				$TechTreeList2[$Element]	= $Element;
			
			} else {
				$RequeriList	= array();
				if(isset($requeriments[$Element]))
				{
					foreach($requeriments[$Element] as $requireID => $RedCount)
					{
						$RequeriList[$requireID]	= array('count' => $RedCount, 'own' => (isset($PLANET[$resource[$requireID]])) ? $PLANET[$resource[$requireID]] : $USER[$resource[$requireID]]);
					}
				}
				
				$TechTreeList2[$Element]	= $RequeriList;
			}
		}
		//Постройки
		foreach($elementID as $Element)
		{			
			if(!isset($resource[$Element])) {
				$TechTreeList[$Element]	= $Element;
			
			} else {
				$RequeriList	= array();
				if(isset($requeriments[$Element]))
				{
					foreach($requeriments[$Element] as $requireID => $RedCount)
					{
						$RequeriList[$requireID]	= array('count' => $RedCount, 'own' => (isset($PLANET[$resource[$requireID]])) ? $PLANET[$resource[$requireID]] : $USER[$resource[$requireID]]);
					}
				}
				
				$TechTreeList[$Element]	= $RequeriList;
			}
		}
		//Флот
		foreach($elementID3 as $Element)
		{			
			if(!isset($resource[$Element])) {
				$TechTreeList3[$Element]	= $Element;
			
			} else {
				$RequeriList	= array();
				if(isset($requeriments[$Element]))
				{
					foreach($requeriments[$Element] as $requireID => $RedCount)
					{
						$RequeriList[$requireID]	= array('count' => $RedCount, 'own' => (isset($PLANET[$resource[$requireID]])) ? $PLANET[$resource[$requireID]] : $USER[$resource[$requireID]]);
					}
				}
				
				$TechTreeList3[$Element]	= $RequeriList;
			}
		}
		//Оборона
		foreach($elementID4 as $Element)
		{			
			if(!isset($resource[$Element])) {
				$TechTreeList4[$Element]	= $Element;
			
			} else {
				$RequeriList	= array();
				if(isset($requeriments[$Element]))
				{
					foreach($requeriments[$Element] as $requireID => $RedCount)
					{
						$RequeriList[$requireID]	= array('count' => $RedCount, 'own' => (isset($PLANET[$resource[$requireID]])) ? $PLANET[$resource[$requireID]] : $USER[$resource[$requireID]]);
					}
				}
				
				$TechTreeList4[$Element]	= $RequeriList;
			}
		}
		//Офицеры
		foreach($elementID5 as $Element)
		{			
			if(!isset($resource[$Element])) {
				$TechTreeList5[$Element]	= $Element;
			
			} else {
				$RequeriList	= array();
				if(isset($requeriments[$Element]))
				{
					foreach($requeriments[$Element] as $requireID => $RedCount)
					{
						$RequeriList[$requireID]	= array('count' => $RedCount, 'own' => (isset($PLANET[$resource[$requireID]])) ? $PLANET[$resource[$requireID]] : $USER[$resource[$requireID]]);
					}
				}
				
				$TechTreeList5[$Element]	= $RequeriList;
			}
		}
        
		$this->tplObj->loadscript("techtree.js");
		$this->tplObj->assign_vars(array(
			'TechTreeList'		=> $TechTreeList,
			'TechTreeList2'		=> $TechTreeList2,
			'TechTreeList3'		=> $TechTreeList3,
			'TechTreeList4'		=> $TechTreeList4,
			'TechTreeList5'		=> $TechTreeList5,
		));

		$this->display('page.techtree.default.tpl');
	}
    //code_update
}