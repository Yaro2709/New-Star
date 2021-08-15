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

class ShowNewsPage extends AbstractAdminPage
{
	public static $requireModule = 0;

	function __construct() 
	{
        if (!allowedTo(str_replace(array(dirname(__FILE__), '\\', '/', '.php'), '', __FILE__))) throw new Exception("Permission error!");
		parent::__construct();
	}
		
	function show()
	{
        global $LNG, $USER;
        
        if(!isset($_GET['action'])){
            $_GET['action'] = '';
        }
        
        if(!isset($_GET['key'])){
            $_GET['key'] = '';
        }

        if($_GET['action'] == 'send') {
            $edit_id 	= HTTP::_GP('id', 0);
            $title 		= $GLOBALS['DATABASE']->sql_escape(HTTP::_GP('title', '', true));
            $text 		= $GLOBALS['DATABASE']->sql_escape(HTTP::_GP('text', '', true));
            $query		= ($_GET['key'] == 2) ? "INSERT INTO ".NEWS." (`id` ,`user` ,`date` ,`title` ,`text`) VALUES ( NULL , '".$USER['username']."', '".TIMESTAMP."', '".$title."', '".$text."');" : "UPDATE ".NEWS." SET `title` = '".$title."', `text` = '".$text."', `date` = '".TIMESTAMP."' WHERE `id` = '".$edit_id."' LIMIT 1;";
		
            $GLOBALS['DATABASE']->query($query);
        } elseif($_GET['action'] == 'delete' && isset($_GET['id'])) {
            $GLOBALS['DATABASE']->query("DELETE FROM ".NEWS." WHERE `id` = '".HTTP::_GP('id', 0)."';");
        }

        $query = $GLOBALS['DATABASE']->query("SELECT * FROM ".NEWS." ORDER BY id ASC");

        $NewsList	= array();
        
        while ($u = $GLOBALS['DATABASE']->fetch_array($query)) {
            $NewsList[]	= array(
                'id'		=> $u['id'],
                'title'		=> $u['title'],
                'date'		=> _date($LNG['php_tdformat'], $u['date'], $USER['timezone']),
                'user'		=> $u['user'],
                'confirm'	=> sprintf($LNG['nws_confirm'], $u['title']),
            );
        }

        if($_GET['action'] == 'edit' && isset($_GET['id'])) {
            $News = $GLOBALS['DATABASE']->getFirstRow("SELECT id, title, text FROM ".NEWS." WHERE id = '".$GLOBALS['DATABASE']->sql_escape($_GET['id'])."';");
            $this->assign(array(	
                'key'			=> 1,
                'nws_head'		=> sprintf($LNG['nws_head_edit'], $News['title']),
                'news_id'		=> $News['id'],
                'news_title'	=> $News['title'],
                'news_text'		=> $News['text'],
            ));
        } elseif($_GET['action'] == 'create') {
            $this->assign(array(	
                'key'			=> 2,
                'nws_head'		=> '',
                'news_id'		=> '',
                'news_title'	=> '',
                'news_text'		=> '',
                'nws_head'		=> $LNG['nws_head_create'],
            ));
        }
	
        $this->assign(array(	
            'NewsList'		=> $NewsList,
        ));
	
        $this->display('page.news.default.tpl');
	}
}
