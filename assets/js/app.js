// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import jQuery from 'jquery';
import _ from 'lodash';
window.jQuery = window.$ = jQuery; // Bootstrap requires a global "$" object.
import "bootstrap";


// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

// implemented professor Tuck's lecture notes from both spring 2018 and fall 2018.
$(function () {

  function update_buttons() {
    $('.manage-button').each( (_, bb) => {
      let user_id = $(bb).data('user-id');
      let manage = $(bb).data('manage');
      if (manage != "") {
        $(bb).text("unmanage this user");
      }
      else {
        $(bb).text("manage this user");
      }
   });
 }

  function set_button(user_id, value) {
    $('.manage-button').each( (_, bb) => {
      if (user_id == $(bb).data('user-id')) {
        $(bb).data('manage', value);
      }
    });
    update_buttons();
  }

  function manage(user_id) {
    let text = JSON.stringify({
      management: {
          manager_id: current_user_id,
          underling_id: user_id
      },
  });

    $.ajax(management_path, {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => { set_button(user_id, resp.data.id); },
    });
  }

  function unmanage(user_id, management_id) {
    $.ajax(management_path + "/" + management_id, {
      method: "delete",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: () => { set_button(user_id, ""); },
    });
  }

function manage_click(ev) {
  let btn = $(ev.target);
  let management_id = btn.data('manage');
  let user_id = btn.data('user-id');

  console.log(user_id)

  if (management_id != "") {
    unmanage(user_id, management_id);
  }
  else {
    manage(user_id);
  }
}

function init_manage() {
  if (!$('.manage-button')) {
    return;
  }

  $(".manage-button").click(manage_click);

  update_buttons();
}



  function update(task_id) {
    $.ajax(`ajax/timeblocks/${task_id}`, {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: (resp) => {

        let display = _.map(resp.data, get_time())
        $('#show-time').html(display)
      },
    });
  }

  function get_time(timeblock) {
    let start = new Date(timeblock.start)
    let end = new Date(timeblock.end)
    return '<div><p>Start on: <%= start %></p><br><p> End on: <%= end %></p></div>';
  }



  $('#start-button').click((ev) => {
    let current_time = new Date($.now())
    console.log(current_time)
    $('#start-button').addClass("disabled")
    $('#working_on').text('You are currently working on this task')
    console.log($('#working_on').text('You are currently working on this task'))
    $('#stop-button').removeClass("disabled")
    $('#stop-button').attr('data-start', current_time)
  })

  $('delete').click((ev) => {

  })

  $('#stop-button').click((ev) => {
    $('#working_on').text('You have completed this task')
    let current_time = new Date($.now())
    $('#stop-button').addClass("disabled")
    let start_time = new Date($('#stop-button').attr('data-start'))
    console.log(current_time)

    let task_id = $('#stop-button').attr('data-task-id')
    console.log(task_id)
    let text = JSON.stringify({
      timeblock: {
        start: start_time,
        end: current_time,
        task_id: parseInt(task_id),
      },
    });

    $.ajax('ajax/timeblocks', {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => {
        update(task_id);
      },
    });
  });

  $(init_manage);
})
