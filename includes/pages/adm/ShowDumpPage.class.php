<?php

/*
 * ╔══╗╔══╗╔╗──╔╗╔═══╗╔══╗╔╗─╔╗╔╗╔╗──╔╗╔══╗╔══╗╔══╗
 * ║╔═╝║╔╗║║║──║║║╔═╗║║╔╗║║╚═╝║║║║║─╔╝║╚═╗║║╔═╝╚═╗║
 * ║║──║║║║║╚╗╔╝║║╚═╝║║╚╝║║╔╗─║║╚╝║─╚╗║╔═╝║║╚═╗──║║
 * ║║──║║║║║╔╗╔╗║║╔══╝║╔╗║║║╚╗║╚═╗║──║║╚═╗║║╔╗║──║║
 * ║╚═╗║╚╝║║║╚╝║║║║───║║║║║║─║║─╔╝║──║║╔═╝║║╚╝║──║║
 * ╚══╝╚══╝╚╝──╚╝╚╝───╚╝╚╝╚╝─╚╝─╚═╝──╚╝╚══╝╚══╝──╚╝
 *
 * @author Tsvira Yaroslav <https://github.com/Yaro2709> @@ Ala
 * @info ***
 * @link https://github.com/Yaro2709/New-Star
 * @Basis 2Moons: XG-Project v2.8.0
 * @Basis New-Star: 2Moons v1.8.0
 */

class ShowDumpPage extends AbstractAdminPage
{
	public static $requireModule = 0;

	function __construct() 
	{
        if (!allowedTo(str_replace(array(dirname(__FILE__), '\\', '/', '.php'), '', __FILE__))) throw new Exception("Permission error!");
		parent::__construct();
	}
		
	function show()
	{
        global $LNG;
        
        if(!isset($_REQUEST['action'])){
            $_REQUEST['action'] = '';
        }
        
        switch($_REQUEST['action'])
        {
            case 'dump':
                $dbTables	= HTTP::_GP('dbtables', array());
                if(empty($dbTables)) {
                    $this->printMessage($LNG['du_not_tables_selected'], true, array('admin.php?page=dump', 3));
                }
			
                $fileName	= 'Backup_'.date('d_m_Y_H_i_s', TIMESTAMP).'.sql';
                $filePath	= 'includes/backups/';
		
                require 'includes/classes/SQLDumper.class.php';
                require 'includes/config.php';
		
                $dump	= new SQLDumper($database);
                $dump->backUpAdmin($dbTables);
                $dump->setFileDir($filePath);
                $dump->setFileName($fileName);
                $dump->saveToFile();
                
                $this->printMessage((sprintf($LNG['du_success'], 'includes/backups/'.$fileName)), true, array('admin.php?page=dump', 3));
                
            break;
            default:
                $dumpData['perRequest']		= 100;

                $dumpData		= array();

                $prefixCounts	= strlen(DB_PREFIX);

                $dumpData['sqlTables']	= array();
                $sqlTableRaw			= $GLOBALS['DATABASE']->query("SHOW TABLE STATUS FROM `".DB_NAME."`;");

                while($table = $GLOBALS['DATABASE']->fetchArray($sqlTableRaw))
                {
                    if(DB_PREFIX == substr($table['Name'], 0, $prefixCounts))
                    {
                        $dumpData['sqlTables'][]	= $table['Name'];
                    }
                }
                
                $this->assign(array(
                    'dumpData'	=> $dumpData,
                ));
		
                $this->display('page.dump.default.tpl');
            break;
        }
	}
}
