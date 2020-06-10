var $ = jQuery;

var currentDate = new Date();

// Events
var event_start_date = new Date(gon.event_start_date)
var event_end_date = new Date(gon.event_end_date)
// Talks
// var talk_date = new Date(gon.talk_date)
var talk_date = gon.talk_date
// var talk_date_utc = talk_date.toUTCString(); 



var talk_event_start_date = new Date(gon.talk_event_start_date)
var talk_event_end_date = new Date(gon.talk_event_end_date)

$(function() {
  $('input[name="start_date_select"]').daterangepicker({
    singleDatePicker: true,
    showDropdowns: false,
    startDate: event_start_date,
  });
  
  $('input[name="end_date_select"]').daterangepicker({
    singleDatePicker: true,
    showDropdowns: false,
    startDate: event_end_date,
  });
  
  $('input[name="date_select"]').daterangepicker({
    timePicker: true,
    singleDatePicker: true,
    showDropdowns: false,
    minDate: talk_event_start_date,
    maxDate: talk_event_end_date,
    startDate: talk_date,
    timePickerIncrement: 30,
    locale: {
      format: 'MM/DD/YYYY hh:mm A'
    }
  });
});