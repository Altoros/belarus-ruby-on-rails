$(document).ready(function(){
    $('#meetup-read-more').click(function(e) {
        e.preventDefault()
        $('#meetup-omission').hide()
        $('#meetup-read-more').hide()
        $('#meetup-description-full').slideDown('slow')
    })
})
