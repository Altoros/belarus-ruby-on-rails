$(document).ready(function(){
  var video;

  video = $('.video');

  video.children('.video-frame').hide();

  video.on('click', '.spoiler', function() {
    var link, link_text;
    link = $(this);
    link.parent().children('.video-frame').toggle();

    link_text = link.text();
    if (link_text === ' + ') {
      return link.text(" - ");
    } else {
      return link.text(" + ");
    }

  });
});
