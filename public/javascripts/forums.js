jQuery(document).ready(function($) {
  $("a.navbutton").button();
  $("input:submit").button();
  if (mySettings) { $('#topic_body').markItUp(mySettings); }
  $("#drag-list").sortable(
      {
        axis: 'y',
        dropOnEmpty: false,
        cursor: 'crosshair',
        items: 'tr:not(.header)',
        opacity: 0.4,
        scroll: true,
        update: function(){
          var update_url = $(this).attr('data-prioritize-url');
          $.ajax({
            type: 'post',
            data: $('#drag-list').sortable('serialize'),
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

