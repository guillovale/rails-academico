var initialize_calendar;
initialize_calendar = function() {
  $('.calendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      header: {
        //left: 'prev,next today',
        center: 'Horario',
        //right: 'month,agendaWeek,agendaDay'
	right: 'agendaWeek'
      },
	dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      events: '/events.json',
	weekends: false,
	 events: [
        {
            title: 'Eventos',
            start: '2017-02-09',
            description: 'This is a cool event'
        }
        // more events here

    ],


	resources: [
        { id: 'a', title: 'Paralelo A' },
        { id: 'b', title: 'Paralelo B' },
        { id: 'c', title: 'Paralelo C' },
        { id: 'd', title: 'Paralelo D' }
    ],

      select: function(start, end) {
	//title = prompt("Event Title:")
		
	
        $.getScript('/events/new', function() {});

        calendar.fullCalendar('unselect');
      },

	dayClick: function() {
        alert('ok!');
    },


	defaultView: 'agendaWeek',
    	height: 500,
	slotMinutes: 30,
	minTime: "07:00:00",
    maxTime: "22:00:00",
      eventDrop: function(event, delta, revertFunc) {
        event_data = { 
          event: {
            id: event.id,
            start: event.start.format(),
            end: event.end.format()
          }
        };
        $.ajax({
            url: event.update_url,
            data: event_data,
            type: 'PATCH'
        });
      },


      eventClick: function(event, jsEvent, view) {
        $.getScript(event.edit_url, function() {});
      }
    });
  })
};
$(document).on('turbolinks:load', initialize_calendar);
