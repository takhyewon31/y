<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href='../assets/css/calendar/fullcalendar.css?var=1' rel='stylesheet' />
        <link href='../assets/css/calendar/fullcalendar.print.css?var=1' rel='stylesheet' media='print' />
        
        <script src='../assets/js/calendar/jquery-1.10.2.js?var=1'></script>
        <script src='../assets/js/calendar/jquery-ui.custom.min.js?var=1'></script>
        <script src='../assets/js/calendar/fullcalendar.js?var=1'></script>
        <script>
        $(document).ready(function () {
                $('#calendar').fullCalendar({
                    editable: true,
                	selectable: true,
                	selectHelper: true,
                    eventLimit: true,
                    events: "../CalendarJsonServlet",
                    
                });
        });
        </script>
    </head>
    <body>
        <div id="calendar"></div>
    </body>
</html>
