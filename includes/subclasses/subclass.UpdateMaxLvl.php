<?php
//$new_code
if (($pricelist[$Element]['max']) < $USER[$resource[$Element]]){
	$this->printMessage("".$LNG['bd_maxlevel']."", true, array($href, 2));
}
//$new_code