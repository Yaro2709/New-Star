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

class ShowCronjobPage extends AbstractAdminPage
{
	public static $requireModule = 0;

	function __construct() 
	{
        if (!allowedTo(str_replace(array(dirname(__FILE__), '\\', '/', '.php'), '', __FILE__))) throw new Exception("Permission error!");
		parent::__construct();
	}

    function getCronjobTimes($row,$max)
    {
        $arr = explode(',',$row);
        if (count($arr) > 1)
            return $arr;
	
        if (substr($arr[0],0,(2-strlen($arr[0]))) == '*/')
            return range(0,$max,(int) substr($arr[0],(2-strlen($arr[0]))));
        else
            return $arr[0];
    }

    function checkPostData($column,$max)
    {
        $all = HTTP::_GP($column.'_all', 0);
        if ($all)
            return '*';
	
        $post = HTTP::_GP($column, array());
        $post = array_filter($post, 'is_numeric');
        if (empty($post))
            return false;
	
        $check = array(2,3,5,6,7,10,14,15,20,30);
        $result = array();
        foreach ($check as $i)
        {
            if ($i <= $max && range(0, $max, $i) == $post)
                $result[] = $i;
        }
        if (!empty($result))
            return '*/'.max($result);
        else
            return implode(',',$post);
    }

    function ShowCronjobEdit($post_id)
    {
        global $LNG;

        $post_name 		= 	HTTP::_GP('name', '');
        $post_min 		= 	$this->checkPostData('min', 59);
        $post_hours 	= 	$this->checkPostData('hours', 23);
        $post_month 	= 	$this->checkPostData('month', 12);
        $post_dow 		= 	$this->checkPostData('dow', 6);
        $post_dom 		= 	$this->checkPostData('dom', 31);
        $post_class 	= 	HTTP::_GP('class', '');
        $error_msg 		= 	array();
	
        if ($post_name == '')
            $error_msg[] = $LNG['cron_error_name'];
        if ($post_min === false)
            $error_msg[] = $LNG['cron_error_min'];
        if ($post_hours === false)
            $error_msg[] = $LNG['cron_error_hours'];
        if ($post_month === false)
            $error_msg[] = $LNG['cron_error_month'];
        if ($post_dow === false)
            $error_msg[] = $LNG['cron_error_dow'];
        if ($post_dom === false)
            $error_msg[] = $LNG['cron_error_dom'];
        if ($post_class == '')
            $error_msg[] = $LNG['cron_error_class'];
        elseif (!file_exists('includes/classes/cronjob/'.$post_class.'.class.php')) 
            $error_msg[] = $LNG['cron_error_filenotfound'].'includes/classes/cronjobs/'.$post_class.'.class.php';
	
        if (count($error_msg) == 0)
        {
            if ($post_id != 0){
                $GLOBALS['DATABASE']->query("UPDATE ".CRONJOBS." SET name = '".$GLOBALS['DATABASE']->sql_escape($post_name)."', min = '".$post_min."', hours = '".$post_hours."', month = '".$post_month."', dow = '".$post_dow."', dom = '".$post_dom."', class = '".$GLOBALS['DATABASE']->sql_escape($post_class)."' WHERE cronjobID = $post_id;");
            }else{
                $GLOBALS['DATABASE']->query("INSERT INTO ".CRONJOBS." SET name = '".$GLOBALS['DATABASE']->sql_escape($post_name)."', min = '".$post_min."', hours = '".$post_hours."', month = '".$post_month."', dow = '".$post_dow."', dom = '".$post_dom."', class = '".$GLOBALS['DATABASE']->sql_escape($post_class)."';");
            }
            HTTP::redirectTo('admin.php?page=cronjob');
        } else {
            $this->ShowCronjobDetail($post_id,$error_msg);
        }
    }

    function ShowCronjobDelete($cronjobId) {
        $GLOBALS['DATABASE']->query("DELETE FROM ".CRONJOBS." WHERE cronjobID = ".$cronjobId.";");
        $GLOBALS['DATABASE']->query("DELETE FROM ".CRONJOBS_LOG." WHERE cronjobId = ".$cronjobId.";");
        HTTP::redirectTo('admin.php?page=cronjob');
    }

    function ShowCronjobLock($cronjobId) {
        $GLOBALS['DATABASE']->query("UPDATE ".CRONJOBS." SET `lock` = MD5(UNIX_TIMESTAMP()) WHERE cronjobID = ".$cronjobId.";");
        HTTP::redirectTo('admin.php?page=cronjob');
    }

    function ShowCronjobUnlock($cronjobId) {
        $GLOBALS['DATABASE']->query("UPDATE ".CRONJOBS." SET `lock` = NULL WHERE cronjobID = ".$cronjobId.";");
        HTTP::redirectTo('admin.php?page=cronjob');
    }

    function ShowCronjobEnable($cronjobId) {
        $GLOBALS['DATABASE']->query("UPDATE ".CRONJOBS." SET `isActive` = ".HTTP::_GP('enable', 0)." WHERE cronjobID = ".$cronjobId.";");
        HTTP::redirectTo('admin.php?page=cronjob');
    }

    function show() 
    {
        $cronId = HTTP::_GP('id', 0);
        
        switch (HTTP::_GP('action', 'overview')) {
            case 'edit':
                $this->ShowCronjobEdit($cronId);
            break;
            case 'delete':
                $this->ShowCronjobDelete($cronId);
            break;
            case 'lock':
                $this->ShowCronjobLock($cronId);
            break;
            case 'unlock':
                $this->ShowCronjobUnlock($cronId);
            break;
            case 'detail':
                $this->ShowCronjobDetail($cronId);
            break;
            case 'enable':
                $this->ShowCronjobEnable($cronId);
            break;
        }

        $data    = $GLOBALS['DATABASE']->query("SELECT * FROM ".CRONJOBS.";");
	
        $CronjobArray = array();
        while ($CronjobRow = $GLOBALS['DATABASE']->fetch_array($data))
        {			
            $CronjobArray[]	= array(
                'id'			=> $CronjobRow['cronjobID'],
                'isActive'		=> $CronjobRow['isActive'],
                'name'			=> $CronjobRow['name'],
                'min'			=> $CronjobRow['min'],
                'hours'			=> $CronjobRow['hours'],
                'dom'			=> $CronjobRow['dom'],
                'month'			=> $this->getCronjobTimes($CronjobRow['month'],12),
                'dow'			=> $this->getCronjobTimes($CronjobRow['dow'],6),
                'class'			=> $CronjobRow['class'],
                'nextTime'		=> $CronjobRow['nextTime'],
                'lock'			=> !empty($CronjobRow['lock']),
            );
        }

        $this->assign(array(
            'CronjobArray'	=> $CronjobArray,
        ));
        $this->display('page.cronjob.default.tpl');
    }
    
    function ShowCronjobDetail($detail,$error_msg=NULL) 
    {
        $avalibleCrons	= array();
	
        $dir = new DirectoryIterator('includes/classes/cronjob/');
        foreach ($dir as $fileinfo) {
            if ($fileinfo->isFile() && $fileinfo->getBasename('.class.php') != $fileinfo->getFilename()) {
                $avalibleCrons[]	= $fileinfo->getBasename('.class.php');
            }
        }
	
        $this->assign(array(	
            'avalibleCrons' => $avalibleCrons
        ));
	
        if ($detail != 0)
        {
            $CronjobRow   	= $GLOBALS['DATABASE']->uniquequery("SELECT * FROM ".CRONJOBS." WHERE cronjobID = ".$detail."");
            $this->assign(array(	
                'id'			=> $CronjobRow['cronjobID'],
                'name'			=> isset($_POST['name'])?HTTP::_GP('name', ''):$CronjobRow['name'],
                'min'			=> isset($_POST['min_all'])?array(0 => '*'):(isset($_POST['min'])?HTTP::_GP('min', array()):$this->getCronjobTimes($CronjobRow['min'],59)),
                'hours'			=> isset($_POST['hours_all'])?array(0 => '*'):(isset($_POST['hours'])?HTTP::_GP('hours', array()):$this->getCronjobTimes($CronjobRow['hours'],23)),
                'dom'			=> isset($_POST['dom_all'])?array(0 => '*'):(isset($_POST['dom'])?HTTP::_GP('dom', array()):$this->getCronjobTimes($CronjobRow['dom'],31)),
                'month'			=> isset($_POST['month_all'])?array(0 => '*'):(isset($_POST['month'])?HTTP::_GP('month', array()):$this->getCronjobTimes($CronjobRow['month'],12)),
                'dow'			=> isset($_POST['dow_all'])?array(0 => '*'):(isset($_POST['dow'])?HTTP::_GP('dow', array()):$this->getCronjobTimes($CronjobRow['dow'],6)),
                'class'			=> isset($_POST['class'])?HTTP::_GP('class', ''):$CronjobRow['class'],
                'error_msg'		=> $error_msg,
            ));
        } else {
            $this->assign(array(	
                'id'			=> 'add',
                'name'			=> HTTP::_GP('name', ''),
                'min'			=> isset($_POST['min_all'])?array(0 => '*'):HTTP::_GP('min', array()),
                'hours'			=> isset($_POST['hours_all'])?array(0 => '*'):HTTP::_GP('hours', array()),
                'dom'			=> isset($_POST['dom_all'])?array(0 => '*'):HTTP::_GP('dom', array()),
                'month'			=> isset($_POST['month_all'])?array(0 => '*'):HTTP::_GP('month', array()),
                'dow'			=> isset($_POST['dow_all'])?array(0 => '*'):HTTP::_GP('dow', array()),
                'class'			=> HTTP::_GP('class', ''),
                'error_msg'		=> $error_msg,
            ));
        }
        $this->display("page.cronjobDetail.default.tpl");
    }
}