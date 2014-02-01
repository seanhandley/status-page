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
};

//Function for getting and setting the current status.
//This should only update or change when the active partial is shown as we dont want it to take into account the statu
//of scheduled or resolved alerts

$(document).ready(function() {
    if ($("#active-event-area").length) {
        current_status = GetCurrentStatus();
        $("#current-status-text").text(current_status);
    }
});

function GetCurrentStatus()
{
    var current_status
    var statuses = [];
    statuses = $(".active-event-status").map(function(){
       return this.innerHTML;
    }).get();
    
    if (jQuery.inArray("Critcal", statuses) != -1) {
        current_status = "Critcal";
    }else if (jQuery.inArray("Warning", statuses) != -1){
        current_status = "Warning";
    }else if (jQuery.inArray("Minor", statuses) != -1){
        current_status = "Minor";
    }else if (jQuery.inArray("Informational", statuses != -1)){
        current_status = "Informational";
    };
    
    return current_status;
};

