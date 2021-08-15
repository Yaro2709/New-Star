<?php
// Translated into English by Yaro2709;
// All rights reserved from 2020;
// Company 1367.

//NAVIGATION:
//{IDs_0001} General variables
//{IDs_0002} Introduction
//{IDs_0003} Update
//{IDs_0004} Test for minimum requirements
//{IDs_0005} Connect to the database
//{IDs_0006} Results of connecting to the database
//{IDs_0007} Database creation
//{IDs_0008} Create an account
//{IDs_0009} Complete the installation
//{IDs_0010} Installation summary
//{IDs_0011} Messages
//{IDs_0012} Carousels

//{IDs_0001} General variables
$LNG['game_name']                                    = 'New-Star';
$LNG['nav_lang']                                     = 'Language';
$LNG['footer_up']                                    = 'Back to the top';
$LNG['back']                                         = 'Back';
$LNG['continue']                                     = 'Next';
$LNG['login']                                        = 'Login to the admin panel';
$LNG['title_install']                                = 'Installer';
$LNG['previous']                                     = '';
$LNG['next']                                         = '';
//{IDs_0002} Introduction
$LNG['intro_install']                                = 'Install';
$LNG['intro_welcome']                                = 'Welcome to '.$LNG['game_name'].'!';
$LNG['intro_text']                                   = ''.$LNG['game_name'].' - one of the best engines of web browser strategy, which is based on 2Moons v1.8. '.$LNG['game_name'].' is the most stable and developing engine at the moment. We hope that '.$LNG['game_name'].' will be better than you expect. If you have any questions, consult with us. '.$LNG['game_name'].' is an open source project and is licensed under the GNU GPL v3. Before installation, a small test for compliance with the minimum requirements will be launched. ';
//{IDs_0003} Update
$LNG['upgrade_title']                                = 'Update';
$LNG['upgrade_header']                               = 'Database Update Wizard.';
$LNG['upgrade_text']                                 = 'You have already installed '.$LNG['game_name'].' and just want to update it? Here you can update your old database with a few clicks! ';
$LNG['upgrade_success']                              = 'The database was successfully upgraded to revision %s.';
$LNG['upgrade_nothingtodo']                          = 'No action required, the database has a revision state of %s.';
$LNG['upgrade_available']                            = 'Update is available. The database can be upgraded from the current revision %s to revision %s. ';
$LNG['upgrade_notavailable']                         = 'The most recent revision of %s is used for the database.';
//{IDs_0004} Test for minimum requirements
$LNG['req_head']                                     = 'Required Modules';
$LNG['req_text']                                     = 'Before proceeding with the installation '.$LNG['game_name'].' will check the configuration files of your server for compliance with the necessary requirements for the use of '.$LNG['game_name'].'. Please read the results carefully and do not continue the installation until the verification is completed on all points. If you want to use any of the functions of the modules listed below, you must make sure that the verification is passed.';
$LNG['req_requirements']                             = 'Requirement';
$LNG['req_status']                                   = 'Status';
$LNG['reg_yes']                                      = 'Yes';
$LNG['reg_no']                                       = 'No';
$LNG['reg_writable']                                 = '(CHMOD 777)';
$LNG['reg_not_writable']                             = 'No write permissions';
$LNG['reg_file']                                     = 'Is file "%s" writable?';
$LNG['reg_dir']                                      = 'Is the folder "%s" writable?';
$LNG['req_php_need']                                 = 'Installed version of "PHP"';
$LNG['req_php_need_desc']                            = 'PHP is the server language in which the game is written. '.$LNG['game_name'].' works using PHP v5.6-8.0';
$LNG['reg_gd_need']                                  = 'Installed version of the "gdlib" graphics library';
$LNG['reg_gd_desc']                                  = 'The "gdlib" graphics library is responsible for the dynamic generation of images. Without this library, some software functionality will not be possible. ';
$LNG['reg_pdo_active']                               = 'Support for the extension "PDO"';
$LNG['reg_pdo_desc']                                 = 'You must provide PDO support in PHP.';
$LNG['reg_json_need']                                = 'Is the "JSON" extension available?';
$LNG['reg_iniset_need']                              = 'Is the PHP "ini_set" function active?';
$LNG['reg_global_need']                              = 'Is the "register_globals" parameter disabled?';
$LNG['reg_global_desc']                              = ''.$LNG['game_name'].' will work correctly if this option is enabled. However, it is recommended, for security reasons, to disable register_globals in the PHP settings. ';
$LNG['req_ftp_head']                                 = 'FTP';
$LNG['req_ftp_desc']                                 = 'Please enter your FTP details so that the installer automatically fixes the errors. In addition, you can also manually assign write permissions.';
$LNG['req_ftp_host']                                 = 'FTP host';
$LNG['req_ftp_username']                             = 'FTP login';
$LNG['req_ftp_password']                             = 'FTP password';
$LNG['req_ftp_dir']                                  = 'FTP path to '.$LNG['game_name'].'';
$LNG['req_ftp_send']                                 = 'Set permissions of CHMOD 777';
$LNG['req_ftp_error_data']                           = 'It was not possible to connect to the FTP server with the provided credentials.';
$LNG['req_ftp_error_dir']                            = 'The folder is specified incorrectly.';
//{IDs_0005} Connect to the database
$LNG['step1_head']                                   = 'Setting up database access';
$LNG['step1_text']                                   = ''.$LNG['game_name'].' can be installed on your server, but you must specify the database access settings. If you do not know the access settings for connecting to the database, find out from your hosting provider or contact the technical support '.$LNG['game_name'].' for consultation. When entering data, please check it carefully before proceeding.';
$LNG['step1_mysql_server']                           = 'Database server name';
$LNG['step1_mysql_port']                             = 'Database server port';
$LNG['step1_mysql_dbuser']                           = 'Database user login';
$LNG['step1_mysql_dbpass']                           = 'Database user password';
$LNG['step1_mysql_dbname']                           = 'Database Name';
$LNG['step1_mysql_prefix']                           = 'Table Prefix';
//{IDs_0006} Results of connecting to the database
$LNG['step2_prefix_invalid']                         = 'The database prefix must contain only alphanumeric characters and an underscore.';
$LNG['step2_db_no_dbname']                           = 'The database name is not specified.';
$LNG['step2_db_too_long']                            = 'The specified table prefix is ​​too long. The maximum length is 36 characters. ';
$LNG['step2_db_con_fail']                            = 'There is no database connection. Details are listed below. ';
$LNG['step2_config_exists']                          = 'config.php already exists.';
$LNG['step2_conf_op_fail']                           = 'Write permissions were not set for config.php.';
$LNG['step2_db_done']                                = 'A connection to the database has been established.';
//{IDs_0007} Database creation
$LNG['step3_head']                                   = 'Create database tables';
$LNG['step3_text']                                   = 'Database tables created and populated. Continue to the next step to complete the installation of '.$LNG['game_name'].'.';
$LNG['step3_db_error']                               = 'Failed to create the following tables in the database:';
//{IDs_0008} Create an account
$LNG['step4_head']				                     = 'Administrator Account';
$LNG['step4_text']				                     = 'The installation wizard will now create an administrator account for you. Writes the name of use, your password and your email';
$LNG['step4_admin_name']		                     = 'Use name of Administrator:';
$LNG['step4_admin_name_desc']	                     = 'Type the name to use with the length of 3 to 20 characters';
$LNG['step4_admin_pass']		                     = 'Password of Administrator:';
$LNG['step4_admin_pass_desc']	                     = 'Type a password with a length of 6 to 30 characters';
$LNG['step4_admin_mail']		                     = 'Contact E-mail:';
//{IDs_0009} Complete the installation
$LNG['step6_head']                                   = 'Congratulations! You have set '.$LNG['game_name'].' :) ';
$LNG['step6_text']                                   = 'If you click on the button below, you will be redirected to the admin panel. Take some time to familiarize yourself with the available settings. Please delete the file "includes/ENABLE_INSTALL_TOOL" or rename it before using the game. As long as this file exists, your game is at potential risk of hacking!';
$LNG['step8_need_fields']                            = 'You must fill in all the fields.';
//{IDs_0010} Installation summary
$LNG['sql_close_reason']                             = 'The server is currently unavailable';
$LNG['sql_welcome']                                  = 'Welcome to '.$LNG ['game_name'].' v';
//{IDs_0011} Messages
$LNG['locked_upgrade']                               = 'Database update required! To activate the update process, you must create a file with the name "ENABLE_INSTALL_TOOL" in the "include" folder. The file name must be uppercase. The file itself may be empty. ';
$LNG['locked_install']                               = 'The installer is locked! In the "includes" folder, create a file called "ENABLE_INSTALL_TOOL". The file name must be uppercase. The file itself must be without an extension and may be empty. For security reasons, it is strongly recommended that you rename the file or delete it when the installation is complete. For reliability, you can delete the entire install folder. ';
//{IDs_0012} Carousels
$LNG['carousel_project_head']                        = 'Project.';
$LNG['carousel_project_text']                        = 'The game is based on 2Moons v1.8. We improved it by rewriting more than 30%! ';
$LNG['carousel_mods_head']                           = 'Modifications.';
$LNG['carousel_mods_text']                           = 'We have developed more than 15 new modifications and rewritten more than 10!';
$LNG['carousel_design_head']                         = 'Responsive Design.';
$LNG['carousel_design_text']                         = 'We use the well-known bootstrap.';
$LNG['carousel_support_head']                        = 'Active Support.';
$LNG['carousel_support_text']                        = 'Support is based on the 2Moons forum and on the github project.';
$LNG['carousel_version_info_head']                   = 'Something new?';
$LNG['carousel_version_info_text']                   = 'Of course, yes! But to find out, you need to install the game :) ';