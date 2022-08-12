<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE html>
<html lang="en">
    <head>
 
        <title>Paulo Test - RSA Express</title>
        <link rel="icon" type="image/x-icon" href="images/logo-square.png">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
       <link rel="stylesheet" type="text/css" href="styles/main.css">

       <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> 
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>

        <script type="text/javascript" src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>  
        <script src="main.js"></script>    

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

        <link rel="Stylesheet" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />  
        <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

        <!-- Maps-->
        <script type="text/javascript" src="//cdn.syncfusion.com/17.4.0.46/js/web/ej.web.all.min.js "></script>
        <script src="//cdn.syncfusion.com/js/assets/external/jsrender.min.js" type="text/javascript"></script>    
    

        <script type="text/javascript">

        $(document).ready(function() {  
            // That is just to demonstrate an Ajax function reading a file
            // The Ajax could read a a json and then parse  the values
            $.ajax({
                url: "model/file.txt",
                success: function (result,status,xhr) {
                    console.log(result);
                    $("#textData").html(result);
                }
            });

            $('#MyTable').DataTable( {  
                "language": {
                "info": "Showing page _START_ to _END_ of _TOTAL_ RTO records",
                },
                initComplete: function () {  
                    this.api().columns().every( function () {  
                        var column = this;  
                        var select = $('<select><option value=""></option></select>')  
                            .appendTo( $(column.footer()).empty() )  
                            .on( 'change', function () {  
                                var val = $.fn.dataTable.util.escapeRegex(  
                                    $(this).val()  
                                );  
                                 //to select and search from grid  
                                column  
                                    .search( val ? '^'+val+'$' : '', true, false )  
                                    .draw();  
                            } );  
        
                        column.data().unique().sort().each( function ( d, j ) {  
                            select.append( '<option value="'+d+'">'+d+'</option>' )  
                        } );  
                    } );  
                }  
            } );  

            $( "#dialog" ).dialog({
            autoOpen: false,
            maxWidth:600,
                maxHeight: 500,
                width: 600,
                height: 500,
            show: {
                effect: "blind",
                duration: 1000
            },
            hide: {
                effect: "explode",
                duration: 1000
            }
            });
        
            $( ".opener" ).on( "click", function() {
                var currentRow = $(this).closest("tr");
                var lat = currentRow.find(".latitude").html(); // get latitude
                var lon = currentRow.find(".longitude").html(); // get longitude
                $('.mapC').html(lat + '/' + lon);

                $("#containerMap").ejMap({                
                    centerPosition: [parseFloat(lat),parseFloat(lon)],
                    zoomSettings: {
                    level: 15,
                    },
                    layers: [{
                            layerType: 'osm'
                    }]

                    });

                    $("#containerMap").ejMap("navigateTo", parseFloat(lat), parseFloat(lon), 15);

                $( "#dialog" ).dialog( "open" );
            });

        } );  

        </script>

    </head>
<BODY>

    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
          <div class="navbar-header">
            <a class="navbar-brand" href="#">RSA Express</a>
          </div>
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Home</a></li>
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#">Page 1
              <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li><a href="#">Page 1-1</a></li>
                <li><a href="#">Page 1-2</a></li>
                <li><a href="#">Page 1-3</a></li>
              </ul>
            </li>
            <li><a href="#">Page 2</a></li>
            <li><a href="#">Page 3</a></li>
          </ul>
        </div>
      </nav>

    <header class="page-header header container-fluid">

<% 	
Dim cnnConnection  ' ADO connection 	
Dim rst  ' ADO recordset 	
Set cnnConnection = Server.CreateObject("ADODB.Connection") 	
 	
' DSN 	
cnnConnection.Open "DRIVER={MySQL ODBC 8.0 ANSI Driver};SERVER=localhost:3306;DATABASE=paulo_eot;UID=root;PASSWORD=gmw7nyz9;"

'simple query as there is no parameters used here otherwise a better treatment to avoid SQL injections'
Set rst = cnnConnection.Execute("SELECT * FROM QLD_RTO_Locations")
 	
%>

<!-- That is used to show the map inside a DialogBox -->
<div id="dialog" title="RTO Location">
    <div class="mapC"></div> 
    <div  style="width:400px; height: inherit;z-index: 0;min-height:350px;" id="containerMap"></div>
</div>

<p id="textData"></p>

<div class="row">
    <div class="col-md-6 bk_green">First column (1/2) using Bootstrap</div>
    <div class="col-md-6 bk_yellow">Second column (2/2) using Bootstrap</div>
</div>
<br />

<div class="row">
    <div class="col-md-12">
        <table id="MyTable" class="table table-hover table-striped">
            <!-- Define the size of the columns -->
            <colgroup>
                <col span="1" style="width: 5%;">
                <col span="1" style="width: 35%;">
                <col span="1" style="width: 40%;">
                <col span="1" style="width: 10%;">
                <col span="1" style="width: 10%;">

             </colgroup>
            <thead>
            <tr  class="table-primary">
                <th scope="col">#</th>
                <th  scope="col">Name</th>
                <th scope="col">Address</th>
                <th scope="col">Latitude</th>
                <th scope="col">Longitute</th>
                <th scope="col" class="no-sort">Map</th>
            </tr>
            </thead>
            <tbody>
            <% 	
            Do While Not rst.EOF 	
             %> 	
             <tr> 	
              <th class="rtoId"><%= rst.Fields("rtoID").Value %></td> 	
              <td><%= rst.Fields("rtoName").Value %></td> 	
              <td><%= rst.Fields("rtoAddress").Value %></td> 	
              <td class="latitude"><%= rst.Fields("latitude").Value %></td> 	
              <td class="longitude"><%= rst.Fields("longitude").Value %></td> 	
              <td><button type="button" class="opener btn btn-success">Map</button></td>
             </tr> 	
             <% 	
             rst.MoveNext 	
            Loop 

            ' Close our recordset and connection and dispose of the objects. It is important to close all objects and unload them just to avoid memory leak
            rst.Close 
            Set rst = Nothing 
            cnnConnection.Close 
            Set cnnConnection = Nothing 	
            %> 	
            
        </tbody>
        </table>
    </div>  
  </div>

</body>

</html>

