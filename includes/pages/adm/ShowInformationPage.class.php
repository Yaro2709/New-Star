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

class ShowInformationPage extends AbstractAdminPage
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
        
        $config = Config::get();
        
        	// @ for open_basedir
        if(@file_exists(ini_get('error_log')))
            $Lines	= count(file(ini_get('error_log')));
        else
            $Lines	= 0;
	
        try {
            $dateTimeZoneServer = new DateTimeZone($config->timezone);
        } catch (Exception $e) {
            $dateTimeZoneServer	= new DateTimeZone(date_default_timezone_get());
        }
	
        try {
            $dateTimeZoneUser	= new DateTimeZone($USER['timezone']);
        } catch (Exception $e) {
            $dateTimeZoneUser	= new DateTimeZone(date_default_timezone_get());
        }
	
        try {
            $dateTimeZonePHP	= new DateTimeZone(ini_get('date.timezone'));
        } catch (Exception $e) {
            $dateTimeZonePHP	= new DateTimeZone(date_default_timezone_get());
        }
	
        $dateTimeServer		= new DateTime("now", $dateTimeZoneServer);
        $dateTimeUser		= new DateTime("now", $dateTimeZoneUser);
        $dateTimePHP		= new DateTime("now", $dateTimeZonePHP);

        $sql	= "SELECT dbVersion FROM %%SYSTEM%%;";

        $dbVersion	= Database::get()->selectSingle($sql, array(), 'dbVersion');
		
		$this->assign(array(
            'info'				=> $_SERVER['SERVER_SOFTWARE'],
            'vPHP'				=> PHP_VERSION,
            'vAPI'				=> PHP_SAPI,
            'vGame'				=> $config->VERSION.(file_exists(ROOT_PATH.'/.git/ORIG_HEAD') ? ' ('.trim(file_get_contents(ROOT_PATH.'/.git/ORIG_HEAD')).')': ''),
            'vMySQLc'			=> $GLOBALS['DATABASE']->getVersion(),
            'vMySQLs'			=> $GLOBALS['DATABASE']->getServerVersion(),
            'root'				=> $_SERVER['SERVER_NAME'],
            'gameroot'			=> $_SERVER['SERVER_NAME'].str_replace('/admin.php', '', $_SERVER['PHP_SELF']),
            'json'				=> function_exists('json_encode') ? ''.$LNG['status_yes'].'' : ''.$LNG['status_no'].'',
            'bcmath'			=> extension_loaded('bcmath') ? ''.$LNG['status_yes'].'' : ''.$LNG['status_no'].'',
            'curl'				=> extension_loaded('curl') ? ''.$LNG['status_yes'].'' : ''.$LNG['status_no'].'',
            'browser'			=> $_SERVER['HTTP_USER_AGENT'],
            'safemode'			=> ini_get('safe_mode') ? ''.$LNG['status_yes'].'' : ''.$LNG['status_no'].'',
            'memory'			=> ini_get('memory_limit'),
            'suhosin'			=> ini_get('suhosin.request.max_value_length') ? ''.$LNG['status_yes'].'' : ''.$LNG['status_no'].'',
            'log_errors'		=> ini_get('log_errors') ? ''.$LNG['status_active'].'' : ''.$LNG['status_deactive'].'',
            'errorlog'			=> ini_get('error_log'),
            'errorloglines'		=> $Lines,
            'dbVersion'         => $dbVersion,
            'php_tz'			=> $dateTimePHP->getOffset() / 3600,
            'conf_tz'			=> $dateTimeServer->getOffset() / 3600,
            'user_tz'			=> $dateTimeUser->getOffset() / 3600,
		));
		
		$this->display('page.information.default.tpl');
	}
}
