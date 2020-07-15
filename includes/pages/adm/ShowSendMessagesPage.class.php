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

class ShowSendMessagesPage extends AbstractAdminPage
{
	public static $requireModule = 0;

	function __construct() 
	{
        if (!allowedTo(str_replace(array(dirname(__FILE__), '\\', '/', '.php'), '', __FILE__))) throw new Exception("Permission error!");
		parent::__construct();
	}
		
	function show()
	{
        global $USER, $LNG;
	
        $ACTION	= HTTP::_GP('action', '');
        if ($ACTION == 'send')
        {
            switch($USER['authlevel'])
            {
                case AUTH_MOD:
                    $class = 'mod';
                break;
                case AUTH_OPS:
                    $class = 'ops';
                break;
                case AUTH_ADM:
                    $class = 'admin';
                break;
                default:
                    $class = '';
                break;
            }

            $Subject	= HTTP::_GP('subject', '', true);
            $Message 	= HTTP::_GP('text', '', true);
            $Key	 	= HTTP::_GP('key', 0);
            $Lang		= HTTP::_GP('globalmessagelang', '');

            if (!empty($Message) && !empty($Subject))
            {
                require 'includes/classes/BBCode.class.php';
                if($Key == 0 || $Key == 2) {
                    $From    	= '<span class="'.$class.'">'.$LNG['user_level_'.$USER['authlevel']].' '.$USER['username'].'</span>';
                    $pmSubject 	= '<span class="'.$class.'">'.$Subject.'</span>';
                    $pmMessage 	= '<span class="'.$class.'">'.BBCode::parse($Message).'</span>';
                    $USERS		= $GLOBALS['DATABASE']->query("SELECT `id`, `username` FROM ".USERS." WHERE `universe` = '".Universe::current()."'".(!empty($Lang) ? " AND `lang` = '".$GLOBALS['DATABASE']->sql_escape($Lang)."'": "").";");
                    while($UserData = $GLOBALS['DATABASE']->fetch_array($USERS))
                    {
                        $sendMessage = str_replace('{USERNAME}', $UserData['username'], $pmMessage);
                        PlayerUtil::sendMessage($UserData['id'], $USER['id'], $From, 50, $pmSubject, $sendMessage, TIMESTAMP, NULL, 1, Universe::current());
                    }
                }

                if($Key == 1 || $Key == 2) {
                    require 'includes/classes/Mail.class.php';
                    $userList	= array();
				
                    $USERS		= $GLOBALS['DATABASE']->query("SELECT `email`, `username` FROM ".USERS." WHERE `universe` = '".Universe::current()."'".(!empty($Lang) ? " AND `lang` = '".$GLOBALS['DATABASE']->sql_escape($Lang)."'": "").";");
                    while($UserData = $GLOBALS['DATABASE']->fetch_array($USERS))
                    {				
                        $userList[$UserData['email']]	= array(
                            'username'	=> $UserData['username'],
                            'body'		=> BBCode::parse(str_replace('{USERNAME}', $UserData['username'], $Message))
                        );
                    }
				
                    Mail::multiSend($userList, strip_tags($Subject));
                }
                exit($LNG['ma_message_sended']);
            } else {
                exit($LNG['ma_subject_needed']);
            }
        }
	
        $sendModes	= $LNG['ma_modes'];
	
        if(Config::get()->mail_active == 0)
        {
            unset($sendModes[1]);
            unset($sendModes[2]);
        }
        
        $this->assign(array(
            'langSelector' => array_merge(array('' => $LNG['ma_all']), $LNG->getAllowedLangs(false)),
            'modes' => $sendModes,
		));
		
		$this->display('page.sendmessages.default.tpl');
	}
}
