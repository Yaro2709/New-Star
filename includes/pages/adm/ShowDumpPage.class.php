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
        
        switch($_REQUEST['action'])
        {
            case 'dump':
                $dbTables	= HTTP::_GP('dbtables', array());
                if(empty($dbTables)) {
                    $this->printMessage($LNG['du_not_tables_selected'], true, array('game.php?page=dump', 3));
                }
			
                $fileName	= '2MoonsBackup_'.date('d_m_Y_H_i_s', TIMESTAMP).'.sql';
                $filePath	= 'includes/backups/'.$fileName;
		
                require 'includes/classes/SQLDumper.class.php';
		
                $dump	= new SQLDumper;
                $dump->dumpTablesToFile($dbTables, $filePath);
                
                $this->printMessage((sprintf($LNG['du_success'], 'includes/backups/'.$fileName)), true, array('game.php?page=dump', 3));
                
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
