$(document).ready(function(){
    $('#meetup-read-more').click(function(e) {
        e.preventDefault()
        $('#meetup-description-short').hide()
        $('#meetup-read-more').hide()
        $('#meetup-description-full').slideDown('slow')
    })
})
