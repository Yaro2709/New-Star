<nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
    <a class="navbar-brand col-md-3 col-lg-2 mr-0 px-3" href="#">
        <img src="./styles/resource/images/icons/192.png" alt="" width="30" height="30" class="d-inline-block align-text-top">
        New-Star
    </a>
    <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-toggle="collapse" data-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    {if $authlevel == $smarty.const.AUTH_ADM}
    <div class="form-control-dark w-100">               
        <select name="uni" id="universe" class="form-control changeAction select">{html_options options=$universeSelect selected=$UNI}</select>
    </div>
    {/if}
    <script>
    $(document).ready(function(){
        $('.select').change(function(){
            window.location.href = "/uni"+ $(this).val() +"/admin.php";
        });
    });
    </script>
    <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
            <a class="nav-link" href="/admin.php?page=logout">{$LNG.lm_logout}</a>
        </li>
    </ul>
</nav>