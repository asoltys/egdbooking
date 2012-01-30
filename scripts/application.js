$(function() {
  $('#dismiss').click(function() {
    $(this).parent().replaceWith($('#acknowledged').show());
    $.post('/egdbooking/ws/acknowledge_notice.cfm');
  });
});
