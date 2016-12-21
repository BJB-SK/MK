$(function() {

refresh();

  /**
   * Refresh the whole table.
   */
  function refresh() {
    var dayString = 'now';
    var dayString = '02/19/2016';

    var start = new Date(dayString);
    start.setHours(0,0,0,0);

    var end = new Date(dayString);
    end.setHours(23,59,59,999);

alert(start + ':' + end);


    // var today = new Date();

    $('#schedule .day').each(function() {
      var dayDate = $(this).attr('date');
      // console.log(dayDate);
      if (dayDate === currentDate) {

        var now = today.getTime();
        console.log(now);
        $(this).find('.slots').each(function() {
          // console.log($(this).attr('start'));
        });
      }

    });
  }

});
