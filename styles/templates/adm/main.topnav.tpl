<div class="container-fluid">
    <div class="row">
        <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
            <div class="sidebar-sticky pt-3">
                <ul class="nav flex-column">
                    {*************БЛОК №1*************}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php">{$LNG.lm_overview}</a>
                    </li>
                    {if allowedTo('ShowInformationPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=information">{$LNG.lm_information}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowConfigUniPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=ConfigUni">{$LNG.lm_configuni}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowModulePage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=module">{$LNG.lm_module}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowCronjobPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=cronjob">{$LNG.lm_cronjob}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowDumpPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=dump">{$LNG.lm_dump}</a>
                    </li>
                    {/if}
                    
                    {*************БЛОК №2*************}
                    {if allowedTo('ShowUniversePage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=universe">{$LNG.lm_universe}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowRightsPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=rights">{$LNG.lm_rights}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowResetPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=reset">{$LNG.lm_reset}</a>
                    </li>
                    {/if}
                    
                    {*************БЛОК №3*************}
                    {if allowedTo('ShowCreatePage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=create">{$LNG.lm_create}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowAccountEditorPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=AccountEditor">{$LNG.lm_accounteditor}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowBanPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=ban">{$LNG.lm_ban}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowGiveawayPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=giveaway">{$LNG.lm_giveaway}</a>
                    </li>
                    {/if}
                     
                    {*************БЛОК №4*************}
                    {if allowedTo('ShowSupportPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=support">{$LNG.lm_support}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowActivePage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=active">{$LNG.lm_active}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowFlyingFleetPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=FlyingFleet">{$LNG.lm_flyingfleet}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowNewsPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=news">{$LNG.lm_news}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowMessageListPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=MessageList">{$LNG.lm_messagelist}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowSearchPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=search">{$LNG.lm_search}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowMultiIPPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=MultiIP">{$LNG.lm_multiip}</a>
                    </li>
                    {/if}
                    
                    {*************БЛОК №5*************}
                    {if allowedTo('ShowSendMessagesPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=SendMessages">{$LNG.lm_sendmessages}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowLogPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=log">{$LNG.lm_log}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowPasswordPage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=password">{$LNG.lm_password}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowClearCachePage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=ClearCache">{$LNG.lm_clearcache}</a>
                    </li>
                    {/if}
                    {if allowedTo('ShowStatUpdatePage.class')}
                    <li class="nav-item">
                        <a class="nav-link" href="admin.php?page=StatUpdate">{$LNG.lm_statupdate}</a>
                    </li>
                    {/if}
                </ul>
            </div>
        </nav>
