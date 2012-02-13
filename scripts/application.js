jQuery.noConflict();
(function($) {
  $(function() {
    $(".datepicker").datepicker({
			showOn: "button",
      dateFormat: 'mm/dd/yy'
		});

    $('#dismiss').click(function() {
      $(this).parent().replaceWith($('#acknowledged').show());
      $.post('/egdbooking/ws/acknowledge_notice.cfm');
    });
  });
})(jQuery);
