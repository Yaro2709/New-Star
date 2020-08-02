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

class ShowTechtreePage extends AbstractGamePage
{
    public static $requireModule = MODULE_TECHTREE;

    function __construct()
    {
        parent::__construct();
    }

	function show()
	{
		global $USER, $PLANET, $resource, $reslist, $LNG, $pricelist, $requeriments;

        $elementID1		= array_merge(array(0), $reslist['build']);
		$elementID2		= array_merge(array(100), $reslist['tech']);
		$elementID3		= array_merge(array(200), $reslist['fleet']);
		$elementID4		= array_merge(array(400), $reslist['defense']);
		$elementID5		= array_merge(array(600), $reslist['officier']);
        $elementID		= array_merge($elementID1, $elementID2, $elementID3, $elementID4, $elementID5);

		foreach($elementID as $Element)
		{	
			if(!isset($resource[$Element])) {
				$TechTreeList[$Element]	= $Element;
			} else {
				$RequeriList	= array();
                $factor = $pricelist[$Element]['factorTechnologie'];
				if(isset($requeriments[$Element]))
				{
					foreach($requeriments[$Element] as $requireID => $RedCount)
					{
						$RequeriList[$requireID]	= array(
                            'count' => ceil($RedCount * (eval("return $factor;"))),
                            'own' => (isset($PLANET[$resource[$requireID]])) ? $PLANET[$resource[$requireID]] : $USER[$resource[$requireID]]);
					}
				}
				$TechTreeList[$Element]	= $RequeriList;
			}
		}
        
		$this->tplObj->loadscript("techtree.js");
		$this->assign(array(
            'elementID1'		=> $elementID1,
            'elementID2'		=> $elementID2,
            'elementID3'		=> $elementID3,
            'elementID4'		=> $elementID4,
            'elementID5'		=> $elementID5,
			'TechTreeList'		=> $TechTreeList,
		));

		$this->display('page.techtree.default.tpl');
	}
}