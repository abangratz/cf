$(document).ready(function(){
  $(".datepicker").datepicker();
  $("#start_date, #start_time, #end_date, #end_time").calendricalDateTimeRange();
  $("#calendar").fullCalendar({
    theme: true,
    header: {
      left:  'prev,next today',
      center: 'title',
      right: 'month, agendaWeek, agendaDay'
    },
    editable: true,
    selectable: true,
    events: '/calendar_events.json',
    select: function(startDate, endDate, allDay, jsEvent, view) {
      var form = $("#dialog").dialog({
        title: "Add Event",
        modal: true
      }).load('/calendar_events/new', function() {
        form = $(this).find('form');
        form.find(':text:first').focus();
        starts_date = $('#start_date');
        starts_date.val(startDate.format('isoDate'));
        starts_time = $('#start_time');
        starts_time.val(startDate.format('HH:MM'));
        ends_date = $('#end_date');
        ends_date.val(endDate.format('isoDate'));
        ends_time = $('#end_time');
        ends_time.val(endDate.format('HH:MM'));
      });
    },
    eventClick: function(event) {
                  window.location.href = '/calendar_events/'+event.id;
                },
  });
});
