{block name="title" prepend}{$LNG.lm_overview}{/block}
{block name="script" append}{/block}
{block name="content"}
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="card mb-4 shadow-sm">
        <h5 class="card-header">{$LNG.ov_header_hello}</h5>
        <div class="card-body overflow-auto" style="max-height: 415px;">
            <p class="card-text">{$LNG.ov_text_hello}</p>
            <p class="card-text">{sprintf($LNG['ov_text_donat'], P27204681)}</p>
            <div>
                <a href="https://github.com/Yaro2709/New-Star">
                    <button type="button" class="btn btn-primary">GitHub</button>
                </a>
                <a href="https://2moons.de/index.php?thread/1050-new-star-free-download-info/">
                    <button type="button" class="btn btn-primary">2Moons</button>
                </a>
                <a href="https://discord.gg/pu7faEb">
                    <button type="button" class="btn btn-primary">Discord</button>
                </a>
            </div>
        </div>
    </div>
    <div class="album">
        <div class="row">
            <div class="col-md-6">
                <div class="card mb-4 shadow-sm">
                    <h5 class="card-header">GitHub</h5>
                    <div class="card-body overflow-auto" style="max-height: 415px;">
                        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/octicons/2.0.2/octicons.min.css">
                        <link rel="stylesheet" href="scripts/base/github-activity/src/github-activity.css">
                        <link rel="stylesheet" href="scripts/base/github-activity/src/github-activity_my.css">
                        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/mustache.js/0.7.2/mustache.min.js"></script>
                        <script type="text/javascript" src="scripts/base/github-activity/src/github-activity.js"></script>
                        <div id="feed"></div>
                        <script>
                            GitHubActivity.feed({
                                username: "Yaro2709",
                                repository: "New-Star", 
                                selector: "#feed",
                                limit: 20 
                            });
                        </script>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mb-4 shadow-sm">
                    <h5 class="card-header">{$LNG.ov_header_statistics}</h5>
                    <div class="list-group overflow-auto" style="max-height: 415px;">
                        <button type="button" class="list-group-item list-group-item-action">{$LNG.ov_statistics_backups}
                            <span class="badge badge-primary badge-pill">{$filecount}</span>
                        </button>
                        <button type="button" class="list-group-item list-group-item-action">{$LNG.ov_statistics_user}
                            <span class="badge badge-primary badge-pill">{$user}</span>
                        </button>
                        <button type="button" class="list-group-item list-group-item-action">{$LNG.ov_statistics_userinactive}
                            <span class="badge badge-primary badge-pill">{$userinactive}</span>
                        </button>
                        <button type="button" class="list-group-item list-group-item-action">{$LNG.ov_statistics_useronline}
                            <span class="badge badge-primary badge-pill">{$useronline}</span>
                        </button>
                        <button type="button" class="list-group-item list-group-item-action">{$LNG.ov_statistics_planet}
                            <span class="badge badge-primary badge-pill">{$planet}</span>
                        </button>
                        <button type="button" class="list-group-item list-group-item-action">{$LNG.ov_statistics_supportticks}
                            <span class="badge badge-primary badge-pill">{$supportticks}</span>
                        </button>
                        <button type="button" class="list-group-item list-group-item-action">{$LNG.ov_statistics_log}
                            <span class="badge badge-primary badge-pill">{$log}</span>
                        </button>
                        <button type="button" class="list-group-item list-group-item-action">{$LNG.ov_statistics_cron}
                            <span class="badge badge-primary badge-pill">{$cron}</span>
                        </button>
                        <button type="button" class="list-group-item list-group-item-action">{$LNG.ov_statistics_news}
                            <span class="badge badge-primary badge-pill">{$news}</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.ov_header_credits}</h5>
        <div class="card-body">
            <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link active" id="pills-New-Star-tab" data-toggle="pill" href="#pills-New-Star" role="tab" aria-controls="pills-New-Star" aria-selected="true">New-Star</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="pills-SteemNova-tab" data-toggle="pill" href="#pills-SteemNova" role="tab" aria-controls="pills-SteemNova" aria-selected="false">SteemNova</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="pills-War-Space-tab" data-toggle="pill" href="#pills-War-Space" role="tab" aria-controls="pills-War-Space" aria-selected="false">War-Space</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="pills-2Moons-tab" data-toggle="pill" href="#pills-2Moons" role="tab" aria-controls="pills-2Moons" aria-selected="false">2Moons</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="pills-Xnova-Revolution-tab" data-toggle="pill" href="#pills-Xnova-Revolution" role="tab" aria-controls="pills-Xnova-Revolution" aria-selected="false">Xnova-Revolution</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="pills-XG-proyect-tab" data-toggle="pill" href="#pills-XG-proyect" role="tab" aria-controls="pills-XG-proyect" aria-selected="false">XG-proyect</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="pills-Thank-you-tab" data-toggle="pill" href="#pills-Thank-you" role="tab" aria-controls="pills-Thank-you" aria-selected="false">Thank you</a>
                </li>
            </ul>
            <div class="tab-content" id="pills-tabContent">
                <div class="tab-pane fade show active" id="pills-New-Star" role="tabpanel" aria-labelledby="pills-New-Star-tab">
                    <table class="table table-dark table-hover">
                        <thead>
                            <tr>
                                <th>{$LNG.ov_credits_name}</th>
                                <th>{$LNG.ov_credits_rights}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Yaro2709 (Yaro.slav2709)</td>
                                <td>{$LNG.ov_rights_founder_developer}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane fade" id="pills-SteemNova" role="tabpanel" aria-labelledby="pills-SteemNova-tab">
                    <table class="table table-dark table-hover">
                        <thead>
                            <tr>
                                <th>{$LNG.ov_credits_name}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>IntinteDAO</td>
                            </tr>
                            <tr>
                                <td>mys</td>
                            </tr>
                            <tr>
                                <td>dotevo</td>
                            </tr>
                            <tr>
                                <td>Flugschwein</td>
                            </tr>
                            <tr>
                                <td>Qwatayean</td>
                            </tr>
                            <tr>
                                <td>gregariomansa</td>
                            </tr>
                            <tr>
                                <td>MWFIAE</td>
                            </tr>
                            <tr>
                                <td>Ravikin</td>
                            </tr>
                            <tr>
                                <td>sarmaticus</td>
                            </tr>
                            <tr>
                                <td>z3ll1337</td>
                            </tr>
                            <tr>
                                <td>Pope19</td>
                            </tr>
                            <tr>
                                <td>louis-88</td>
                            </tr>
                            <tr>
                                <td>etaletai13</td>
                            </tr>
                            <tr>
                                <td>donpepe0</td>
                            </tr>
                            <tr>
                                <td>deanlogic</td>
                            </tr>
                            <tr>
                                <td>cryptoriddlerUIO</td>
                            </tr>
                            <tr>
                                <td>tonyviroos</td>
                            </tr>
                            <tr>
                                <td>Rishi556</td>
                            </tr>
                            <tr>
                                <td>MarekPas</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane fade" id="pills-War-Space" role="tabpanel" aria-labelledby="pills-War-Space-tab">
                    <table class="table table-dark table-hover">
                        <thead>
                            <tr>
                                <th>{$LNG.ov_credits_name}</th>
                                <th>{$LNG.ov_credits_rights}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Yaro2709 (Yaro.slav2709)</td>
                                <td>{$LNG.ov_rights_founder_developer}</td>
                            </tr>
                            <tr>
                                <td>lal</td>
                                <td>{$LNG.ov_rights_founder_developer}</td>
                            </tr>
                            <tr>
                                <td>lol</td>
                                <td>{$LNG.ov_rights_artist_designer}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>  
                <div class="tab-pane fade" id="pills-2Moons" role="tabpanel" aria-labelledby="pills-2Moons-tab">
                    <table class="table table-dark table-hover">
                        <thead>
                            <tr>
                                <th>{$LNG.ov_credits_name}</th>
                                <th>{$LNG.ov_credits_rights}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Jan</td>
                                <td>{$LNG.ov_rights_founder_developer}</td>
                            </tr>
                            <tr>
                                <td>Slaver</td>
                                <td>{$LNG.ov_rights_founder_developer}</td>
                            </tr>
                            <tr>
                                <td>Robbyn</td>
                                <td>{$LNG.ov_rights_supervisor}</td>
                            </tr>
                            
                            <tr>
                                <td>Lyon</td>
                                <td>{$LNG.ov_rights_admin}</td>
                            </tr>
                            <tr>
                                <td>Freak1992</td>
                                <td>{$LNG.ov_rights_admin}</td>
                            </tr>
                            <tr>
                                <td>Buggy666</td>
                                <td>{$LNG.ov_rights_moder}</td>
                            </tr>
                            <tr>
                                <td>Z3roCooL</td>
                                <td>{$LNG.ov_rights_interpreter}</td>
                            </tr>
                            <tr>
                                <td>QwataKayean</td>
                                <td>{$LNG.ov_rights_interpreter}</td>
                            </tr>
                            <tr>
                                <td>Yoda</td>
                                <td>{$LNG.ov_rights_interpreter}</td>
                            </tr>
                            <tr>
                                <td>HaloRaptor33</td>
                                <td>{$LNG.ov_rights_interpreter}</td>
                            </tr>
                            <tr>
                                <td>scofield06</td>
                                <td>{$LNG.ov_rights_interpreter}</td>
                            </tr>
                            <tr>
                                <td>InquisitorEA</td>
                                <td>{$LNG.ov_rights_interpreter}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane fade" id="pills-Xnova-Revolution" role="tabpanel" aria-labelledby="pills-Xnova-Revolution-tab">
                    <table class="table table-dark table-hover">
                        <thead>
                            <tr>
                                <th>{$LNG.ov_credits_name}</th>
                                <th>{$LNG.ov_credits_rights}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Brayan Narváez (Prinick)</td>
                                <td>{$LNG.ov_rights_founder_developer}</td>
                            </tr>
                            <tr>
                                <td>Zorrogris</td>
                                <td>{$LNG.ov_rights_host}</td>
                            </tr>
                            <tr>
                                <td>D4rk0ur</td>
                                <td>{$LNG.ov_rights_host}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane fade" id="pills-XG-proyect" role="tabpanel" aria-labelledby="pills-XG-proyect-tab">
                    <table class="table table-dark table-hover">
                        <thead>
                            <tr>
                                <th>{$LNG.ov_credits_name}</th>
                                <th>{$LNG.ov_credits_rights}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>angelus_ira</td>
                                <td>{$LNG.ov_rights_opt}</td>
                            </tr>
                            <tr>
                                <td>cyberrichy</td>
                                <td>{$LNG.ov_rights_opt}</td>
                            </tr>
                            <tr>
                                <td>Neko</td>
                                <td>{$LNG.ov_rights_prog}</td>
                            </tr>
                            <tr>
                                <td>PowerMaster</td>
                                <td>{$LNG.ov_rights_test}</td>
                            </tr>
                            <tr>
                                <td>zorro2666</td>
                                <td>{$LNG.ov_rights_test}</td>
                            </tr>
                            <tr>
                                <td>Calzon</td>
                                <td>{$LNG.ov_rights_test}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane fade" id="pills-Thank-you" role="tabpanel" aria-labelledby="pills-Thank-you-tab">
                    <table class="table table-dark table-hover">
                        <thead>
                            <tr>
                                <th>{$LNG.ov_credits_thank_you}</th>
                                <th>{$LNG.ov_credits_thank_you_very_much}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>lucky<br>Giogio<br>killer99<br>kmti212<br>sharpshooter<br>Naruto<br>Metusalem<br>Meikel<br>Phil<br>Schnippi<br>Inforcer<br>Vobi<br>Onko<br>Sycrog<br>Raito<br>Chlorel<br>e-Zobar<br>Flousedid</td>
                                <td>aurum79 (Чук)<br>reemo<br>mimikri<br>Danter14</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</main>
{/block}