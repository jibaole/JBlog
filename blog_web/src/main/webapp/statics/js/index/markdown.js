$(function () {
    $('.editormd-content').each(function () {
        var divId = $(this).attr('id');
        editormd.markdownToHTML(divId, {
            htmlDecode: "style,script,iframe",
            tocm: true,
            emoji: true,
            taskList: true/*,
             tex: true,
             flowChart: false,
             sequenceDiagram: false*/
        });
    });
});