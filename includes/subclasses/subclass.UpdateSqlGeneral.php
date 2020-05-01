<?php
//$new_code
$sql	= 'UPDATE %%USERS%% SET
        '.$resource[$Element].' = :newPost
        WHERE
        id = :userId;';

Database::get()->update($sql, array(
	':newPost'	=> $USER[$resource[$Element]],
	':userId'	=> $USER['id']
));
//$new_code