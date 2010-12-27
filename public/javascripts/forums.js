jQuery(document).ready(function($) {
  $("#groups-list").sortable(
      {
        axis: 'y',
        dropOnEmpty: false,
        cursor: 'crosshair',
        items: 'tr:not(.header)',
        opacity: 0.4,
        scroll: true,
        update: function(){
          $.ajax({
            type: 'post',
            data: $('#groups-list').sortable('serialize'),
            dataType: 'script',
            complete: function(request){
              $("#groups-list").effect('highlight');
            },
            url: '/administration/forum_groups/prioritize'
          })
        }
      }
      );
  $("#forum-list").sortable(
      {
        axis: 'y',
        dropOnEmpty: false,
        cursor: 'crosshair',
        items: 'tr:not(.header)',
        opacity: 0.4,
        scroll: true,
        update: function(){
          var update_url = $("#forum-list").attr('data-prioritize-url');
          $.ajax({
            type: 'post',
            data: $('#forum-list').sortable('serialize'),
            dataType: 'script',
            complete: function(request){
              $("#forum-list").effect('highlight');
            },
            url: update_url
          })
        }
      }
      );
});

