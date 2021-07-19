{block name="title" prepend}bugtrack{/block}
{block name="content"}
<br>
<br>
<br>
<br>
<table style="min-width:424px;width:60%;" >
{if $authlevel > 2}<tr><th colspan="7"> -._.-. Cangelog .-._.- </th></tr>

<tr><td colspan="7"><form action="game.php?page=Bugtrack" method="post">
  {$dank}   {$name2}<br>
	   
<p>change @ {$dattum}  /  {$zeeit}  <br>

<input type="text" name="email" size="80%" maxlength="300" ></p>
 
<p>Details<br />
<textarea name="name"  value="n/a" size="80%" rows="10" style="background:rgba(13, 16, 20, 0.95);"></textarea>
</p>
 
<input type="Submit" name="" value="speichern">
 
</form></td></tr>
{/if}
<br>
<br>
 	
<tr><th colspan="7"><center>- Changes - since: 14.09.2017 -</center></th></tr>
		<tr>
		<th colspan="1">USER</th>
		<th colspan="1">Date</th>
		<th colspan="1">Time</th>
		<th colspan="2">Change</th>
		<th colspan="2">Detail</th>
		</tr>

{$tabelle}
</tr>
</table>
{/block}