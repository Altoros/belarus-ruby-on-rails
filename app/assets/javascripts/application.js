// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function update_edit_article_action() {
    jQuery('.edit_article input[name="_method"]').val('delete');
}

function comment_notify(message) {
    var notice_div = $("#comment_notice");
    notice_div.html(message).hide().slideToggle("slow", function () {
        setTimeout(function () {
            notice_div.slideToggle("slow")
        },2000)
    });
}

jQuery(document).ready(function(){
    VK.init({
        apiId: 2323414,
        onlyWidgets: true
    });
    VK.Widgets.Group("vk_groups", {
        mode: 0,
        width: "250",
        height: "250"
    }, 26128021);

    new TWTR.Widget({
        id: 'twitter_feed',
        version: 2,
        type: 'search',
        search: '#hacby',
        interval: 30000,
        title: 'Что пишут о',
        subject: 'Belarus Ruby on Rails',
        width: 250,
        height: 300,
        theme: {
            shell: {
                background: '#6b0000',
                color: '#ffffff'
            },
            tweets: {
                background: '#ffffff',
                color: '#884467',
                links: '#6b0000'
            }
        },
        features: {
            scrollbar: false,
            loop: true,
            live: true,
            hashtags: true,
            timestamp: true,
            avatars: true,
            toptweets: true,
            behavior: 'default'
        }
    }).render().start();
});
