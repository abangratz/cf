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
        modal: true,
        minWidth: 650,
        minHeight: 500,
      }).load('/calendar_events/new', "event[start]=" + escape(startDate.format('isoDateTime')) + "&event[end]=" + escape(endDate.format('isoDateTime')), function() {
        btn = form.find(':submit');
        var txt = btn.val();
        btn.remove();
        var buttons = {};
        var method = form.find("form").attr('method');
        console.log(method);
        var action = form.find("form").attr('action');
        console.log(action);
        buttons[txt] = function() {
          $.ajax({
            type: method,
            url: action,
            data: form.find('form').serialize() ,
            dataType: 'script',
            success: function (data, status, xhr) {
              $('#calendar').fullCalendar('refetchEvents');
            }

          });
          $(this).dialog('close');
          $(this).dialog('destroy');
        };
        buttons['Cancel'] = function() {
          $(this).dialog('close');
          $(this).dialog('destroy');
        }
        $(this).dialog('option', 'buttons', buttons);
      });
    },
    eventClick: function(event) {
                  window.location.href = '/calendar_events/'+event.id;
                },
    eventRender: function(event, element) {
                   element.qtip({
                     content: {
                                text: event.comment, 
                                title: {
                                  text: event.title,
                                },
                              },
                     style: {
                       tip: 'topLeft'
                     }
                   })
                 },
  });
});
