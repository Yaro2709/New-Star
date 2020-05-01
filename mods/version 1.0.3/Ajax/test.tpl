{*Аякс POST запросы*}
<script type="text/javascript">  
//Посылает Аяксом любой post запрос, которы находится на странице в <form>
//Вставлять код  конец страницы            
$("form").submit(function(e) {

    e.preventDefault(); // avoid to execute the actual submit of the form.

    var form = $(this);
    var url = form.attr('action');

    $.ajax({
           type: "POST",
           url: url,
           data: form.serialize(), // serializes the form's elements.
           //success: function(data)
           //{
              // alert(data); // show response from the php script.
           //}
         });
})
</script> 
{*Аякс загрузка контента, то есть страниц*}
<script>  
    function showContent(link) {  
  
        var cont = document.getElementById('contentBody');  
        var loading = document.getElementById('loading');  
  
        cont.innerHTML = loading.innerHTML;  
  
        var http = createRequestObject();  
        if( http )   
        {  
            http.open('get', link);  
            http.onreadystatechange = function ()   
            {  
                if(http.readyState == 4)   
                {  
                    cont.innerHTML = http.responseText;  
                }  
            }  
            http.send(null);      
        }  
        else   
        {  
            document.location = link;  
        }  
    }  
  
    // создание ajax объекта  
    function createRequestObject()   
    {  
        try { return new XMLHttpRequest() }  
        catch(e)   
        {  
            try { return new ActiveXObject('Msxml2.XMLHTTP') }  
            catch(e)   
            {  
                try { return new ActiveXObject('Microsoft.XMLHTTP') }  
                catch(e) { return null; }  
            }  
        }  
    }  
</script>  
<body>  
    <p>Какую страницу желаете открыть?</p>  
      
    <form>  
        <input onclick="showContent('game.php?page=buildings')" type="button" value="Страница 1">  
        <input onclick="showContent('game.php?page=buildings')" type="button" value="Страница 2">  
    </form>  
      
    <div id="contentBody">  
    </div>  
  
    <div id="loading" style="display: none">  
    Идет загрузка...  
    </div>    
</body>  