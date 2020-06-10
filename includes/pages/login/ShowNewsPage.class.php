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

class ShowNewsPage extends AbstractLoginPage
{
	public static $requireModule = 0;

    function __construct()
    {
        parent::__construct();
    }
	
	function show() 
	{
		global $LNG;
        
        $NEWS = array(0,1,2,3,4,5,6,7);

		$sql = "SELECT id, date, title, text, user FROM %%NEWS%% ORDER BY id DESC;";
		$newsResult = Database::get()->select($sql);

		$newsList	= array();
		
		foreach ($newsResult as $newsRow)
		{
            if(in_array($newsRow['id'], $NEWS)){
                
                $newsRow['title'] = $LNG['head'][$newsRow['id']];
                $newsRow['text']  = $LNG['text'][$newsRow['id']];
                
            }
            
			$newsList[]	= array(
                'id'    => $newsRow['id'],
				'title' => $newsRow['title'],
				'from' 	=> sprintf($LNG['news_from'], _date($LNG['php_tdformat'], $newsRow['date']), $newsRow['user']),
				'text' 	=> makebr($newsRow['text']),
			);
		}
		
		$this->assign(array(
			'newsList'	=> $newsList,
		));
		
		$this->display('page.news.default.tpl');
	}
}