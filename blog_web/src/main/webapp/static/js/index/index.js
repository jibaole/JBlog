$(function () {
    $(window).scroll(function () {
        var scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
        if (scrollTop <= 200) {
            $('#back-to-top').animate({
                opacity: "hide"
            }, "slow");
        } else {
            $('#back-to-top').animate({
                opacity: "show"
            }, "slow");
        }
    });

    $('.editormd-content').each(function () {
        var divId = $(this).attr('id');
        editormd.markdownToHTML(divId, {
            htmlDecode: "style,script,iframe",
            tocm: true,
            emoji: true,
            taskList: true,
            tex: true,
            flowChart: true,
            sequenceDiagram: true
        });
    });
});