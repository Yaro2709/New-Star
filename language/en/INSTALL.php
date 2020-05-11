<?php
// Translated into English by Yaro2709;
// All rights reserved from 2020;
// Company 1367.

$LNG['back']					                     = 'Back';
$LNG['continue']				                     = 'Continue';
$LNG['continueUpgrade']			                     = 'Upgrade!';
$LNG['login']					                     = 'Login';

$LNG['menu_intro']				                     = 'Introduction';
$LNG['menu_install']			                     = 'Installation';
$LNG['menu_license']			                     = 'License';
$LNG['menu_upgrade']			                     = 'Upgrade';

$LNG['title_install']			                     = 'Installation';

$LNG['intro_lang']				                     = 'Language';
$LNG['intro_install']			                     = 'To installation';
$LNG['intro_welcome']			                     = 'Hello user of New-Star!';
$LNG['intro_text']				                     = 'The New-Star is one of the best projects of OGame.<br>The New-Star is the newest and most stable of XNova currently developed. New-Star is remarkable for its ease of stability, flexibility, dynamism, quality and utilization. we always expect to be better than your expectations.<br><br>The installation system will guide you through the installation or upgrading from a previous version to the latest one. Each question, a problem, please dont hesitate to ask our development and support in case of doubt!<br><br>The New-Star is an Open Source project, licensed under the GNU GPL v3. For this to be verified, please click the link above where it refers to "lincense"<br><br>Before the installation can be started a small test to see if your plan/domain has all the requirements to support the New-Star';
$LNG['intro_upgrade_head']		                     = 'New-Star already installed?';
$LNG['intro_upgrade_text']		                     = '<p>You have already installed New-Star and want easy updating?</p><p>Here you can update your old database with just a few clicks!</p>';

$LNG['upgrade_success']			                     = 'Update of the database successfully. Database is now available on the revision %s.';
$LNG['upgrade_nothingtodo']		                     = 'No action is required. Database is already up to revision %s.';
$LNG['upgrade_back']			                     = 'Back';
$LNG['upgrade_intro_welcome']	                     = 'Welcome to the database upgrader!';
$LNG['upgrade_available']		                     = 'Available updates for your database! The database is at the revision %s and can update to revision %s.<br><br>Please choose from the following menu to the first SQL update to install:';
$LNG['upgrade_notavailable']	                     = 'The used revision %s is the latest for your database.';
$LNG['upgrade_required_rev']	                     = 'The Updater can work only from revision r2579 (New-Star v1. 7) or later.';

$LNG['licence_head']			                     = 'License terms';
$LNG['licence_desc']			                     = 'Please read the license terms below. Use the scroll bar to see all the contents of the document';
$LNG['licence_accept']			                     = 'To continue the installation of New-Star, you need to agree to the terms and conditions of lincense of New-Star';
$LNG['licence_need_accept']		                     = 'If you want to continue with the installation, will s that accept the terms of license';

$LNG['req_head']				                     = 'System requirements';
$LNG['req_desc']				                     = 'Before the installation proceed, New-Star will be some tests to verify that your server supports the New-Star, so ensure that the New-Star can be installed. Its suggested that you read carefully the results, and do not proceed until all these be checked.';
$LNG['reg_yes']					                     = 'Yes';
$LNG['reg_no']					                     = 'No';
$LNG['reg_found']				                     = 'Found';
$LNG['reg_not_found']			                     = 'Not found';
$LNG['reg_writable']			                     = 'Recordable';
$LNG['reg_not_writable']		                     = 'Not recordable';
$LNG['reg_file']				                     = 'The file &raquo;%s&laquo; Is recordable?';
$LNG['reg_dir']					                     = 'The folder &raquo;%s&laquo; Is recordable?';
$LNG['req_php_need']			                     = 'Installed version of the scripting language &raquo;PHP&laquo;';
$LNG['req_php_need_desc']		                     = '<strong>Required</strong> — PHP is the language code base of New-Star. This is the required PHP version 5.2.5 or higher so that all modules work correctly';
$LNG['reg_gd_need']				                     = 'Installed version of the GD PHP Script &raquo;gdlib&laquo;';
$LNG['reg_gd_desc']				                     = '<strong>Optional</strong> — Graphic processing library &raquo;gdlib&laquo; Is responsible for the generation of dynamic images. They work without some of the features of the software.';
$LNG['reg_json_need']			                     = 'Extension &raquo;JSON&laquo; avaliable?';
$LNG['reg_iniset_need']			                     = 'PHP function &raquo;ini_set&laquo; avaliable?';
$LNG['reg_global_need']			                     = 'register_globals disabled?';
$LNG['reg_global_desc']			                     = 'New-Star will also work, if this configuration is installed on your server. However, it is recommended for security reasons, disable "register_globals" in PHP installation, if that is possible.';
$LNG['req_ftp_head']			                     = 'Insert information of FTP';
$LNG['req_ftp_desc']			                     = 'Write your information from FTP so New-Star automatically fix problems. Alternatively, you can also manually assign permissions to write.';
$LNG['req_ftp_host']			                     = 'Hostname';
$LNG['req_ftp_username']		                     = 'User name';
$LNG['req_ftp_password']		                     = 'Password';
$LNG['req_ftp_dir']				                     = 'Directory of New-Star';
$LNG['req_ftp_send']			                     = 'Send';
$LNG['req_ftp_error_data']		                     = 'The information provided does not allow you to connect to the FTP server, so this link failed';
$LNG['req_ftp_error_dir']		                     = 'The story that directory you entered is invalid or not existing';
$LNG['reg_pdo_active']			                     = 'Support &raquo;PDO&laquo; Extension';
$LNG['reg_pdo_desc']			                     = '<strong>Prerequisite</strong> — You need to provide support for PDO in PHP.';

$LNG['step1_head']				                     = 'Configure the installation database';
$LNG['step1_desc']				                     = 'Now that it has been determined that New-Star can be installed on your server, s should provide some information. If you dont know how to run a link database, contact your hosting provider first or with the New-Star forum for help and support. When you insert the data, checks were introduced properly';
$LNG['step1_mysql_server']		                     = 'Database server or DSN';
$LNG['step1_mysql_port']		                     = 'Database port';
$LNG['step1_mysql_dbuser']		                     = 'Database user';
$LNG['step1_mysql_dbpass']		                     = 'Database Password';
$LNG['step1_mysql_dbname']		                     = 'Database name';
$LNG['step1_mysql_prefix']		                     = 'Table prefix:';

$LNG['step2_prefix_invalid']	                     = 'The prefix of the database must contain alphanumeric characters and underscore as last character';
$LNG['step2_db_no_dbname']		                     = 'You dont specified the name for the database';
$LNG['step2_db_too_long']		                     = 'The table prefix is too long. Must contain at most 36 characters';
$LNG['step2_db_con_fail']		                     = 'There is an error in the link to database. The details will be displayed below';
$LNG['step2_conf_op_fail']		                     = "config.php can't be written!";
$LNG['step2_conf_create']		                     = 'config.php created successfully!';
$LNG['step2_config_exists']		                     = 'config.php already exists!';
$LNG['step2_db_done']			                     = 'The connection to the database was successful!';

$LNG['step3_head']				                     = 'Create database tables';
$LNG['step3_desc']				                     = 'The tables needed for the New-Star database already have been created and populated with default values. To go to the next step, conclude the installation of New-Star';
$LNG['step3_db_error']			                     = 'Failed to create the database tables:';

$LNG['step4_head']				                     = 'Administrator account';
$LNG['step4_desc']				                     = 'The installation wizard will now create an administrator account for you. Writes the name of use, your password and your email';
$LNG['step4_admin_name']		                     = 'Use name of Administrator:';
$LNG['step4_admin_name_desc']	                     = 'Type the name to use with the length of 3 to 20 characters';
$LNG['step4_admin_pass']		                     = 'Password of Administrator:';
$LNG['step4_admin_pass_desc']	                     = 'Type a password with a length of 6 to 30 characters';
$LNG['step4_admin_mail']		                     = 'Contact E-mail:';

$LNG['step6_head']				                     = 'Installation completed!';
$LNG['step6_desc']				                     = 'You installed with success the New-Star system';
$LNG['step6_info_head']			                     = 'Getting and using the New-Star now!';
$LNG['step6_info_additional']	                     = 'If clicking the button below, will s are redirected to the page of administration .AI will be a good advantage to get ares to explore New-Star administrator tools.<br/><br/><strong>Please delete the &raquo;includes/ENABLE_INSTALL_TOOL&laquo; or modify the filename. With the existence of this file, you can cause your game at risk by allowing someone rewrite the installation!</strong>';

$LNG['step8_need_fields']		                     = 'You must fill in all fields.';

$LNG['sql_close_reason']		                     = 'The game is closed';
$LNG['sql_welcome']				                     = 'Welcome to New-Star v';