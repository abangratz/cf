$(document).ready(function(){
  $(".datepicker").datepicker();
  $("#start_date, #start_time, #end_date, #end_time").calendricalDateTimeRange();
  $("#edit-sub")
    .bind("ajax:success", function(event, data, status, xhr) {
      id = $('#subscription_id').val();
      console.log(id);
      row_id = "#subscription_row_"+id;
      console.log($(row_id).find('td'));
      $(row_id).find('td:nth-child(1)').text($('#subscription_character_name').val());
      $(row_id).find('td:nth-child(2)').text($('#subscription_primary_role').val());
      $(row_id).find('td:nth-child(3)').text($('#subscription_secondary_role').val());
      $(row_id).find('td:nth-child(4)').text($('#subscription_tertiary_role').val());
      $(row_id).find('td:nth-child(5)').text($('#subscription_commitment').val());
      if (data.confirmed) {
        $("#subscription_row_"+data.id).find('td:nth-child(6)').find('input[type=checkbox]').attr('checked', 'checked');
      }
      else {
        $("#subscription_row_"+data.id).find('td:nth-child(6)').find('input[type=checkbox]').removeAttr('checked');
      }

    });
  $("input.confirmation_box").bind('click', function() {
    var tokenname = $("meta[name='csrf-param']").attr('content')
    var token = $("meta[name='csrf-token']").attr('content');
    $.ajax({
      type: 'post',
      url: $(this).attr('data-url'), 
      success: function(event, data, status, xhr) { 
      if (data.confirmed) {
        $("#subscription_row_"+data.id).find('td:nth-child(6)').find('input[type=checkbox]').attr('checked', 'checked');
      }
      else {
        $("#subscription_row_"+data.id).find('td:nth-child(6)').find('input[type=checkbox]').removeAttr('checked');
      }
      }, 
      data: {'authenticity_token': token},
      dataType: 'json',
    })
  });
  $("#calendar").fullCalendar({
    allDaySlot: false,
    defaultView: 'agendaWeek',
    firstHour: 15,
    theme: true,
    header: {
      left:  'prev,next today',
      center: 'title',
      right: 'month, agendaWeek, agendaDay'
    },
    editable: true,
    selectable: {
      month: false,
      '': true
    },
    events: '/calendar_events.json',
    select: function(startDate, endDate, allDay, jsEvent, view) {
      if (allDay) return;
      var form = $("#dialog").dialog({
        title: "Add Event",
        modal: true,
        minWidth: 650,
        minHeight: 500,
        autoOpen: false,
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
            dataType: 'json',
            success: function(data, status, xhr) {
              $('#dialog').dialog('close');
              $('#dialog').dialog('destroy');
              $('#dialog').html('<h2>Creation of event successful!');
              $('#dialog').dialog({
                modal: true,
                title: "Event created",
                hide: { effect: 'fadeOut', duration: 8000 }
              });
              $('#calendar').fullCalendar('refetchEvents');
              setTimeout(function() {
                $('#dialog').dialog('close');
                $('#dialog').dialog('destroy');
              }, 2000);
            },
            error: function(xhr, status, errorThrown) {
                     errors = $.parseJSON(xhr.responseText);
                     form.dialog('close');
                     form.dialog('destroy');
                     $('#dialog').html('<h1>Error</h1><p>The following error(s) prevented saving the event:</p><dl></dl>');
                     var errorList = $('#dialog').find('dl');
                     $.each(errors, function( field, fieldErrors) {
                       errorList.append('<dt>' + field + '</dt>')
                       var errorDef = document.createElement('dd');
                       var fieldErrorList = document.createElement('ol');
                       $.each(fieldErrors, function() {
                         $(fieldErrorList).append('<li>' + this + '</li>')
                       });
                       $(errorDef).append(fieldErrorList);
                       $(errorList).append(errorDef);
                     });
                     $("#dialog").addClass('ui-state-error');
                     $("#dialog").dialog({
                       modal: true, 
                       title: "Error",
                       buttons: {
                         OK: function() {$(this).dialog('close'); $(this).dialog('destroy');$('#dialog').removeClass('ui-state-error');}
                       }
                     });
                   }
          });
        };
        buttons['Cancel'] = function() {
          $(this).dialog('close');
          $(this).dialog('destroy');
        }
        $(this).dialog('option', 'buttons', buttons);
        $(this).dialog('open');
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
                                  text: event.title + (event.location ? ' @ ' + event.location : ''),
                                },
                              },
                     style: {
                       tip: 'topLeft'
                     }
                   })
                 },
  });
});
