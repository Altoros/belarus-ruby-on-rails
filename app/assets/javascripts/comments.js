$(document).ready(function() {
    $('#new_comment').live('ajax:success', function(e, data, textStatus, xhr) {
        appendComment(data.create_status, data.form_html, data.comment_html, data.comments_count)
    })

    $('.comment-delete-link').live('ajax:success', function(e, data, textStatus, xhr) {
        deleteComment(data.comment_div_id, data.comments_count)
    })

    $('.comment-edit-link').live('ajax:success', function(e, data, textStatus, xhr) {
        var commentDiv = $(e.target).closest('.comment_wrapper')
        appendCommentForm(commentDiv, data.form_html)
    })

    $('.edit_comment').live('ajax:success', function(e, data, textStatus, xhr) {
        var commentDiv = $(e.target).closest('.comment_wrapper')
        updateComment(data.update_status, data.content_html, commentDiv)
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

    $('#new_comment').closest('.to_comment').replaceWith(formHTML)
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
        },2000)
    });
}

function updateCommentsCount(count) {
    $('span.comments', '.iteminfo').text(count)
    $('h3 > span', 'div.comments').text(count)
}

