// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function update_edit_custom_news_action() {
    jQuery('.edit_custom_news input[name="_method"]').val('delete');
}

function comment_notify(message) {
    var notice_div = $("#comment_notice");
    notice_div.html(message).hide().slideToggle("slow", function () {
        setTimeout(function () {
            notice_div.slideToggle("slow")
        },2000)
    });
}