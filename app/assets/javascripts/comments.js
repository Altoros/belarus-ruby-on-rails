$(document).ready(function() {
    $('#new-article-comment-wrapper').on('ajax:success', '.new_comment', function(e, data, textStatus, xhr) {
        appendComment(data.create_status, data.form_html, data.comment_html, data.comments_count)
    })

    $(document).on('ajax:success', '.comment-delete-link', function(e, data, textStatus, xhr) {
        deleteComment(data.comment_div_id, data.comments_count)
    })

    $(document).on('ajax:success', '.comment-edit-link', function(e, data, textStatus, xhr) {
        var commentDiv = $(e.target).closest('.comment_wrapper')
        appendCommentForm(commentDiv, data.form_html)
    })

    $(document).on('ajax:success', '.edit_comment', function(e, data, textStatus, xhr) {
        var commentDiv = $(e.target).closest('.comment_wrapper')
        updateComment(data.update_status, data.content_html, commentDiv)
    })

    $(document).on('ajax:before', '.comment-answer-link', function() {
        $(this).hide()
    })

    $(document).on('ajax:success', '.comment-answer-link', function(e, data, textStatus, xhr) {
        var commentDiv = $(e.target).closest('.comment_wrapper')
        appendNestedCommentForm(commentDiv, data.form_html)
    })

    $(document).on('ajax:success', '.new_comment_comments_form', function(e, data, textStatus, xhr) {
        var commentDiv = $(e.target).closest('.comment_wrapper')
        appendNestedComment(commentDiv, data.create_status, data.form_html, data.comment_html, data.comments_count)
    })

    $(document).on('click', '.cancel-comment-link', function(e) {
        e.preventDefault()
        $(this).closest('.comment_wrapper').fadeOut('slow', function() {
            $(this).closest('.nested_comments_box').siblings('span').find('.comment-answer-link').fadeIn()
            $(this).remove()
        })
    })
})

function appendComment(status, formHTML, commentHTML, count) {
    if (status) {
        var commentDiv = $(commentHTML)
        $("#comments").append(commentDiv)
        commentDiv.hide().fadeIn("slow")

        commentNotify(I18n.t('articles.comment_added'))
        updateCommentsCount(count)
    }

    $('.new_comment', '#new-article-comment-wrapper').closest('.to_comment').replaceWith(formHTML)
}

function appendNestedComment(commentDiv, status, formHTML, commentHTML, count) {
    if (status) {
        commentDiv.fadeOut('slow', function() {
            commentDiv.replaceWith(commentHTML).fadeIn('slow')
        })

        commentNotify(I18n.t('articles.comment_added'))
        updateCommentsCount(count)
        commentDiv.closest('.nested_comments_box').siblings('span').find('.comment-answer-link').show()
    } else {
        commentDiv.html(formHTML).find('form').addClass('new_comment_comments_form')
    }
}

function deleteComment(id, count) {
    if (id) {
        var commentDiv = $("#" + id)
        commentDiv.fadeOut("slow", function(){
            commentDiv.remove()
        });

        commentNotify(I18n.t('articles.comment_deleted'))
        updateCommentsCount(count)
    }
}

function appendCommentForm(commentDiv, formHTML) {
    if (commentDiv && formHTML) {
        commentDiv.slideToggle("fast", function () {
            commentDiv.html(formHTML).hide().slideToggle("fast");
        });
    }
}

function appendNestedCommentForm(commentDiv, formHTML) {
    if (commentDiv && formHTML) {
        var newDiv = commentDiv.clone()
        newDiv.removeAttr('id').addClass('nested_comment').html(formHTML).hide()
        newDiv.find('form').addClass('new_comment_comments_form')
        commentDiv.children('.comment').children('.nested_comments_box').append(newDiv)
        newDiv.slideDown()
    }
}

function updateComment(status, content, commentDiv) {
    if (content && commentDiv) {
        if (status) {

            commentDiv.fadeOut('slow', function() {
                commentDiv.replaceWith(content)
            })
            commentNotify(I18n.t('articles.comment_updated'));
        } else {
            appendCommentForm(commentDiv, content)
        }
    }
}

function commentNotify(message) {
    var notice_div = $("#comment_notice");
    notice_div.html(message).hide().slideToggle("slow", function () {
        setTimeout(function () {
            notice_div.slideToggle("slow")
        }, 2000)
    });
}

function updateCommentsCount(count) {
    $('span.comments', '.iteminfo').text(count)
    $('h3 > span', 'div.comments').text(count)
}

