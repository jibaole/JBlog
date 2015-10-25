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

    // 在网页中双击暂停或播放音乐
    $('body').dblclick(function () {
        $('#music')[0].pause();
        $('#play-music').find('i').text('play_arrow');
        isPlay = true;
    });
});

var isPlay = false;
/**
 * 播放、暂停音乐
 * @param dom
 */
function play(dom) {
    if (isPlay) {
        $('#music')[0].pause();
        $(dom).find('i').text('play_arrow');
        isPlay = false;
    } else {
        $('#music')[0].play();
        $('#music')[0].volume = 0.2;
        $(dom).find('i').text('pause');
        isPlay = true;
    }
}