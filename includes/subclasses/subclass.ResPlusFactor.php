<?php
//$new_code
foreach($reslist['resstype'][1] as $resP) //проверка всего масива элементов
{
    if(isset($costResources[$resP])) {$PLANET[$resource[$resP]]	+= $costResources[$resP] * $factor_prices; }
}
    
foreach($reslist['resstype'][3] as $resU) //проверка всего масива элементов
{
    if(isset($costResources[$resU])) {$USER[$resource[$resU]]	+= $costResources[$resU] * $factor_prices; }
}
//$new_code