/**
 * @preserve
 * FullCalendar v1.4.7
 * http://arshaw.com/fullcalendar/
 *
 * Use fullcalendar.css for basic styling.
 * For event drag & drop, required jQuery UI draggable.
 * For event resizing, requires jQuery UI resizable.
 *
 * Copyright (c) 2009 Adam Shaw
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 *
 * Date: Mon Jul 5 16:07:40 2010 -0700
 *
 */
/* 툴팁 띄우기
   $(function() {

  $('#calendar').fullCalendar({
    defaultView: 'month',

    eventRender: function(eventObj, $el) {
      $el.popover({
        title: eventObj.cine,
        content: eventObj.cine,
        trigger: 'hover',
        placement: 'top',
        container: 'body'
      });
    },
  });

}); */
/* 화면 메뉴*/
	$(document).ready(function() {
	
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		var calendar = $('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month'
			},
			events: "http://localhost:8000/fullcalendar/events.php",
			
            eventRender: function(event, element, view) {
				    if (event.allDay === 'true') {
				     event.allDay = true;
				    } else {
				     event.allDay = false;
				    }
				   },
			/*prompt 대신 띄워주는 것. 값은 아직 selected만 넣었습니다.*/
            selectable: true,
			selectHelper: true, 
			select: function(start, end, allDay) {
				var title = ($('#cine option:selected').val());
				if (title) {
					
					calendar.fullCalendar('renderEvent',
						{
							title: title,
							start: start,
							end: end,
							
						}),
                /*새일정 추가.*/
				$.ajax({
					url: 'http://localhost:8000/fullcalendar/add_events.php',
					data: 'title='+ title+'&start='+ start +'&end='+ end +'&url='+ url ,
					type: "POST",
					success: function(json) {
					alert('Added Successfully');
					}
				});
						
					calendar.fullCalendar('renderEvent',
						{
							title: title,
							start: start,
							end: end,
							allDay: allDay
				}),
				true // make the event "stick"
				}
				calendar.fullCalendar('unselect');
				},
            /*일정 갱신.*/
			editable: true,
			eventDrop: function(event, delta) {
				   var start = $.fullCalendar.formatDate(event.start, ""); 
				   var end = $.fullCalendar.formatDate(event.end, "");
				   $.ajax({
				   url: 'http://localhost:8000/fullcalendar/update_events.php',
				   data: 'title='+ event.title+'&start='+ start +'&end='+ end +'&id='+ event.id ,
				   type: "POST",
				   success: function(json) {
				    alert("Updated Successfully");
				   }
				   });
				   },
            eventResize: function(event) {
				   var start = $.fullCalendar.formatDate(event.start, "");
				   var end = $.fullCalendar.formatDate(event.end, "");
				   $.ajax({
				    url: 'http://localhost:8000/fullcalendar/update_events.php',
				    data: 'title='+ event.title+'&start='+ start +'&end='+ end +'&id='+ event.id ,
				    type: "POST",
				    success: function(json) {
				     alert("Updated Successfully");
				    }
				   });
				   }
		});
		
		$(document).ready(function() {
            /*입력버튼*/
			$('#btn').click(function() {
			});
		
			/* fullCalendar ( 'removeEventSources', optionalSourcesArray ) 삭제 기능 구현X*/ 
		});
		   // Get the modal
        var modal = document.getElementById('myModal');
 
        // Get the button that opens the modal
        var btn = document.getElementById("myBtn");
 
        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];                                          
 
        // When the user clicks on the button, open the modal 
        btn.onclick = function() {
            modal.style.display = "block";
        }
 
        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
            modal.style.display = "none";
        }
 
        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

	});
    
	