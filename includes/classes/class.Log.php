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
 
class Log
{
	private $data	= array();

	function __construct($mode) {
		$this->data['mode']		= $mode;
		$this->data['admin']	= Session::load()->userId;
		$this->data['uni']		= Universe::getEmulated();
	}
	public function __set($key, $value){
		$this->data[$key] = $value;
	}
	public function __get($key){
        return $this->__isset($key) ? $this->data[$key] : null;
    }
	public function __isset($key){
        return isset($this->data[$key]);
    }
	function save() {
		$data = serialize(array($this->data['old'], $this->data['new']));
		$uni = (empty($this->data['universe']) ? $this->data['uni'] : $this->data['universe']);
		$GLOBALS['DATABASE']->query("INSERT INTO ".LOG." (`id`,`mode`,`admin`,`target`,`time`,`data`,`universe`) VALUES 
		(NULL , ".$GLOBALS['DATABASE']->sql_escape($this->data['mode']).", ".$GLOBALS['DATABASE']->sql_escape($this->data['admin']).", '".$GLOBALS['DATABASE']->sql_escape($this->data['target'])."', ".TIMESTAMP." , '".$GLOBALS['DATABASE']->sql_escape($data)."', '".$uni."');");
	}
}