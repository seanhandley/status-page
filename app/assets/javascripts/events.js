// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//Function for setting the resolved time and date when the resolved box is checked, and remove if unchecked again.
  $(document).ready(function() {
    current_time = GetDateTime();
    $("#event_resolved").click(function() {
      if($(this).is(':checked')){
        $('#resolved_time').html('<input id="resolved_at" name="event[resolved_at]" type="hidden" value="' + current_time + '"/>');
      }else{
        $('#resolved_time').html("");
      }
    });
  });
  
//Get the current date
function GetDateTime()
{
    var param1 = new Date(); 
    //Little bit of fiddling to get a leading 0 on our months
    var month = param1.getMonth()+1;
    if (month < 10)
    {
        month = "0" + month; 
    };      
    var param2 = param1.getFullYear() + '-' + month + '-' + param1.getDate() + ' ' + param1.getHours() + ':' + param1.getMinutes() + ':' + param1.getSeconds();
    return param2;
}