'use strict';

var tbl = document.getElementById('daily_entry');
var add_btn = document.getElementById('add_job');
var day_btn = document.getElementById('day_button');
var workdate = document.getElementById('workdate');
var workday = document.getElementById('day_index');
var week_ending = document.getElementById('week_ending');
var reset_buttons = document.getElementById('day_class_reset');


// function that stops the user from submitting the form when they press Enter
function disableEnter(e){
    var eve = e || window.event;
    var keycode = eve.keyCode || eve.which || eve.charCode;
  
    if (keycode == 13) {
      eve.cancelBubble = true;
      eve.returnValue = false;

      if (eve.stopPropagation) {   
        eve.stopPropagation();
        eve.preventDefault();
      }
      return false;
    }
}

// Adds another job to the employee
// - clones the row that button was clicked
// - inserts that row into the table (before the next index)
// - hides duplicate name/title value; leave last button to add another row
function my_row(selected){
    var row = selected.parentElement.parentElement;
    var cloned = row.cloneNode(true);
    var row_index = row.rowIndex+1;
    var parent = row.parentNode;
    var newrow = parent.insertBefore(cloned, tbl.rows[row_index]);
    row.getElementsByClassName('add_job')[0].style.visibility = "hidden";
    newrow.getElementsByClassName('hide_title')[0].style.visibility = "hidden";
    newrow.getElementsByClassName('hide_name')[0].style.visibility = "hidden";
    newrow.getElementsByClassName('reg')[0].value = "";
    newrow.getElementsByClassName('ot')[0].value = "";
    newrow.getElementsByClassName('dt')[0].value = "";
    calculate_hours();
}

// changes the string value to a number
function hours(value){
    if (isNaN(value) || value === ""){
        return 0;
    }
    return parseFloat(value);
}

function reset_button_class(){
    var buttons = reset_buttons.children;
    for(var i = 0; i < buttons.length; i++){
        buttons[i].className = "another_day";
    }
}
// calculates each rows hours - updates total/grand total
function calculate_hours(){
    var grand_total = 0;
    var grand_reg = 0;
    var grand_ot = 0;
    var grand_dt = 0;

    console.log(tbl.rows.length);

    for(var r = 1; r < tbl.rows.length - 1; r++){
        var row = tbl.rows[r];
        
        var reg = row.getElementsByClassName("reg")[0]
        var ot = row.getElementsByClassName("ot")[0]
        var dt = row.getElementsByClassName("dt")[0]

        var reg_val = hours(reg.value);
        var ot_val = hours(ot.value);
        var dt_val = hours(dt.value);

        if (reg_val > 0){reg.value = reg_val.toFixed(2)};
        if (ot_val > 0){ot.value = ot_val.toFixed(2)};
        if (dt_val > 0){dt.value = dt_val.toFixed(2)};


        var total = reg_val + ot_val  + dt_val ;

        grand_reg += reg_val;
        grand_ot += ot_val;
        grand_dt += dt_val;
        
        if (total > 0){
            row.getElementsByClassName("employee_total")[0].innerText = total.toFixed(2);
        }
        

        grand_total += total;
    }

    document.getElementById("reg_total").innerText = grand_reg.toFixed(2);
    document.getElementById("ot_total").innerText = grand_ot.toFixed(2);
    document.getElementById("dt_total").innerText = grand_dt.toFixed(2);
    document.getElementById("daily_total").innerText = grand_total.toFixed(2);
}

// nav bar - day click, adds date to work day.
function what_day_is_it(btn){
    workday.value = btn.value;
    reset_button_class();
    apply_workdate();
    btn.className = "current_day";
}

function apply_workdate(){

    var datediff = workday.value;
    datediff -= 1;
    var dayDate = new Date(week_ending.value);
    dayDate.setDate(dayDate.getDate() - datediff);
    workdate.value = dayDate.toDateString();
}

apply_workdate();



