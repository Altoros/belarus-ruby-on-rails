function comment_notify(message) {
    var notice_div = $("#comment_notice");
    notice_div.html(message).hide().slideToggle("slow", function () {
        setTimeout(function () {
            notice_div.slideToggle("slow")
        },2000)
    });
}
