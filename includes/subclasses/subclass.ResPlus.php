<?php
//$new_code
foreach($reslist['resstype'][1] as $resP) //проверка всего масива элементов
{
    if(isset($costResources[$resP])) {$PLANET[$resource[$resP]]	+= $costResources[$resP]; }
}
    
foreach($reslist['resstype'][3] as $resU) //проверка всего масива элементов
{
    if(isset($costResources[$resU])) {$USER[$resource[$resU]]	+= $costResources[$resU]; }
}
//$new_code