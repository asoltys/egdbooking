jQuery.noConflict();
(function($) {
  $(function() {
    $(".datepicker").datepicker({
			showOn: "button",
      dateFormat: 'mm/dd/yy',
      changeYear: true,
      onClose: function(dateText, inst) { 
        $(this).focus();
      }
		});

    $(".ui-datepicker-trigger").attr("title", t.calendarInstructions);

    $('#dismiss').click(function() {
      $(this).parent().replaceWith($('#acknowledged').show());
      $.post('../ws/acknowledge_notice.cfm');
    });
  });
})(jQuery);
