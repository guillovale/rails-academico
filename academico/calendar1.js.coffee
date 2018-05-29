$(document).ready -> 
  $('#calendar').fullCalendar
    editable: false,
    columnFormat: {
      month: 'dddd', 
      week: 'dddd d', 
      day: 'ddd' 
    }
    buttonText: {
      today:    'hoy',
      month:    'month',
      week:     'week',
      day:      'day'
    }

    minTime: "08:00:00"
    maxTime: "23:00:00"
    header:
      left: 'prev,next today', 
      center: 'Horario', 
      right: ''
    firstDay: 1

    selectable: true
    selectHelper: true
    select: (start, end) ->
      title = prompt("Event Title:")
      eventData = undefined
      if title
        eventData =
          title: title
          start: start
          end: end
        $("#calendar").fullCalendar "renderEvent", eventData, true # stick? = true
      $("#calendar").fullCalendar "unselect"


    defaultView: 'agendaWeek',
    allDaySlot: false,
    height: 500, 
    slotMinutes: 30, 
    eventSources: [{ 
      url: '/events', 
    }], 
    timeFormat: 'h:mm t{ - h:mm t} ', 
    dragOpacity: "0.5" 
    eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc) -> 
      updateEvent(event); 
    eventResize: (event, dayDelta, minuteDelta, revertFunc) -> 
      updateEvent(event); 

updateEvent = (the_event) -> 
  $.update "/events/" + the_event.id, 
    event: 
      title: the_event.title, 
      starts_at: "" + the_event.start, 
      ends_at: "" + the_event.end, 
      description: the_event.description
