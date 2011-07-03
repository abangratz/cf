$(document).ajaxSend(function(e, xhr, options) {
  var token = $("meta[name='csrf-token']").attr("content");
  xhr.setRequestHeader("X-CSRF-Token", token);
});
$(document).ready(function() {
  $("#rostertable").tablesorter();
  $("#mainmenu a").button();
  $("a.button").button();
  $("input.button").button();
  $("#tabs").tabs();
});
