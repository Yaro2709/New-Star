{include file="ins_header.tpl"}
{include file="ins_nav.tpl"}
<main role="main" class="container">
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.req_head}</h5>
        <div class="card-body">
            <p class="card-text">{$LNG.req_text}</p>
            <div class="mb-3">  
                <table class="table table-dark table-hover">
                    <thead>
                        <tr>
                            <th scope="col">{$LNG.req_requirements}</th>
                            <th scope="col">{$LNG.req_status}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><p>{$LNG.req_php_need}</p><p class="desc">{$LNG.req_php_need_desc}</p></td>
                            <td>{$PHP}</td>
                        </tr>
                        <tr>
                            <td><p>{$LNG.reg_global_need}</p><p class="desc">{$LNG.reg_global_desc}</p></td>
                            <td>{$global}</td>
                        </tr>
                        <tr>
                            <td><p>{$LNG.reg_pdo_active}</p><p class="desc">{$LNG.reg_pdo_desc}</p></td>
                            <td>{$pdo}</td>
                        </tr>
                        <tr>
                            <td><p>{$LNG.reg_gd_need}</p><p class="desc">{$LNG.reg_gd_desc}</p></td>
                            <td>{$gdlib}</td>
                        </tr>
                        <tr>
                            <td><p>{$LNG.reg_json_need}</p></td>
                            <td>{$json}</td>
                        </tr>
                        <tr>
                            <td><p>{$LNG.reg_iniset_need}</p></td>
                            <td>{$iniset}</td>
                        </tr>
                        {$dir}
                        {$config}
                    </tbody>
                </table> 
            </div>
            {$done}
        </div>
    </div>
    {if $ftp != 0}
    <div class="card mb-3">
        <h5 class="card-header">{$LNG.req_ftp_head}</h5>
        <div class="card-body">
            <p class="card-text">{$LNG.req_ftp_desc}</p>
            <form action="index.php?mode=install&step=4" method="post"> 
            <input type="hidden" name="post" value="1">
                <div class="mb-3">  
                    <div class="form-group">
                        <label for="host">{$LNG.req_ftp_host}</label>
                        <input type="text" name="host" class="form-control" id="host">
                    </div>
                    <div class="form-group">
                        <label for="user">{$LNG.req_ftp_username}</label>
                        <input type="text" name="user" class="form-control" id="user">
                    </div>
                    <div class="form-group">
                        <label for="pass">{$LNG.req_ftp_password}</label>
                        <input type="password" name="pass" class="form-control" id="pass">
                    </div>
                    <div class="form-group">
                        <label for="path">{$LNG.req_ftp_dir}</label>
                        <input type="text" name="path" class="form-control" id="path">
                    </div>
                </div>
                <button type="button" onclick="submitftp();" class="btn btn-primary">{$LNG.req_ftp_send}</button>
            </form>
        </div>
    </div>
    {/if}
</main>
{include file="ins_footer.tpl"}