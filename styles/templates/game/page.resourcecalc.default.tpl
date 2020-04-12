{block name="title" prepend}Calculator{/block}
{block name="content"}
<div id="page">

	<div id="content">
<div id="ally_content" class="conteiner">
    <div class="gray_stripe" style="padding-right:0;">
    	Resource Calculator
			<div class="icovavigation" style="float:right">

                <a href="?page=Resourcecalc"><span class="record_btn ico_builds {if $options == 0}record_btn_active{/if}" title="{$LNG.st_buildings}"></span></a>
				<a href="?page=Resourcecalc&options=100"><span class="record_btn ico_tech {if $options == 100}record_btn_active{/if}" title="{$LNG.tech.100}"></span></a>
                <a href="?page=Resourcecalc&options=200"><span class="record_btn ico_fleet {if $options == 200}record_btn_active{/if}" title="{$LNG.pl_fleet}"></span></a>
                <a href="?page=Resourcecalc&options=400"><span class="record_btn ico_shield {if $options == 400}record_btn_active{/if}" title="{$LNG.pl_def}" ></span></a>
                <div class="clear"></div>
            </div>     
		
		</div>

 <table class="battlesim_table" style="width:100%;max-width:100%">
                <tbody><tr>
                    <th colspan="3">{$LNG.tech.$options}</th>
					{if $options < 200}<th>Start Level</th>{/if}
                    <th>{if $options < 200}{$LNG.gouvernor_5}{else}{$LNG.rs_amount}{/if}</th>
                    <th>{$LNG.tech.901}</th>
                    <th>{$LNG.tech.902}</th>
                    <th>{$LNG.tech.903}</th>    
                    <th>{$LNG.tech.911}</th>    
					<th>{$LNG.ov_points}</th>      
                </tr>
                <tr>
                    <td colspan="3"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
										<td></td>
                </tr>
				
                                  {foreach $elementId as $id}
                                                <tr>
                    <td></td>                            
                	<td class="battlesim_img_ship"><img src="{$dpath}gebaeude/{$id}.gif" alt="{$LNG.tech.$id}"></td>
                    <td class="battlesim_name_ship">{if $id == 420 || $id == 421 || $id == 422|| $id == 224|| $id == 229|| $id == 230}<span style="color:#32CD32">{$LNG.tech.$id}</span>{else}{$LNG.tech.$id}{/if}</td>
                    {if $options < 200}<td><input class="fleetDefCountBS" id="s{$id}" size="10" value="0" onBlur="chkval(this)" onKeyUp="chkint(this);berechne('{$id}');" type="text"></td>{/if}
                    <td><input class="fleetDefCountBS" id="i{$id}" size="10" value="0" onBlur="chkval(this)" onKeyUp="chkint(this);berechne('{$id}');" type="text"></td>
                    <td width="13%"><font color="#a47d7a"><span id="met{$id}" >-</span></font></td>
                    <td width="13%"><font color="#5ca6aa"><span id="kris{$id}">-</span></font></td>
                    <td width="13%"><font color="#339966"><span id="deut{$id}">-</span></font></td> 
                    <td width="13%"><font color="#731fab"><span id="ener{$id}">-</span></font></td> 
                    <td width="13%"><span id="l{$id}">-</span></td> 
                </tr>
                  
                    {/foreach}
										
    <tr style="color: #5ca6aa;background: rgba(255,255,255,0.1);border:none;height:25px"> 
  	<td colspan="3">{$LNG.lv_total}</td> 
  	{if $options < 200}<td><span id="sgess">0</span></td> {/if}
  	<td><span id="sges">0</span></td> 
  	<td><font color="#a47d7a"><span id="metres">0</span></font></td> 
  	<td><font color="#5ca6aa"><span id="krisres">0</span></font></td> 
  	<td><font color="#339966"><span id="deutres">0</span></font></td> 
  	<td><font color="#731fab"><span id="enerres">0</span></font></td> 
  	<td><span id="lres">0</span></td> 
    </tr> 
                    
                                   
                            </tbody></table>
                        <div class="clear"></div>

{/block}
{block name="script" append}
<script type="text/javascript"> 
var data = Array(
 {foreach $elementList as $ID => $Element} Array({$ID}, {foreach $Element.costResources as $RessID => $RessAmount}{$RessAmount},{/foreach} -1, {$Element.factor}){if !$Element@last},{/if}{/foreach}    
); 
</script> 
{/block}