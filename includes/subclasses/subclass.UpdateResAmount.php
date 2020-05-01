<?php
//$new_code
foreach($reslist['resstype'][1] as $resPM)
{
    if(isset($costResources[$resPM])) {
        if($PLANET[$resource[$resPM]] < $costResources[$resPM]* $amount){
            $this->printMessage("".$LNG['bd_notres']."", true, array($href, 2));
        }
    }
}
        
foreach($reslist['resstype'][3] as $resUM)
{
    if(isset($costResources[$resUM])) {
        if($USER[$resource[$resUM]] < $costResources[$resUM]* $amount){
            $this->printMessage("".$LNG['bd_notres']."", true, array($href, 2));
        }
    }
}
        
foreach($reslist['resstype'][1] as $resP)
{
    if(isset($costResources[$resP])) {$PLANET[$resource[$resP]]	-= $costResources[$resP]* $amount; }
}
        
foreach($reslist['resstype'][3] as $resU)
{
    if(isset($costResources[$resU])) {$USER[$resource[$resU]]	-= $costResources[$resU]* $amount; }
}
//$new_code