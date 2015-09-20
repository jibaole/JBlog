$(function () {
    $('#back-to-top').click(function () {
        $('html, body').animate({
            scrollTop: 0
        }, 500);
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

function initscroll(){
    //window.removeEventListener('scroll', this.boundMouseLeaveHandler);
    //$(window).off('scroll'); //取消滚动监听
    var height = document.body.offsetHeight;
    var p = 0, t = 0, isHidden = true, scrollTop = 0;
    $(window).scroll(function () {
        p = $(this).scrollTop();
        isHidden = $('#back-to-top').is(':hidden');
        scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
        if (t <= p) { //下滚
            // 滚动到最底下时显示返回顶部按钮
            //if($(document).scrollTop() + $(window).height() >= $(document).height()){
            if (scrollTop >= (height - 1000)) {
                if (isHidden == true) {
                    showOrHide('show');
                }
            } else {
                showOrHide('hide');
            }
        } else { //上滚
            if (scrollTop <= 200) {
                showOrHide('hide');
            } else {
                showOrHide('show');
            }
        }
        setTimeout(function () {
            t = p;
        }, 0);
    });
}

/**
 * 显示或影藏
 * @param type
 */
function showOrHide(type) {
    $('#back-to-top').animate({
        opacity: type
    }, "slow");
}

function blogscroll(fn) {
    var beforeScrollTop = document.body.scrollTop, fn = fn || function () {
        };
    window.addEventListener("scroll", function () {
        var afterScrollTop = document.body.scrollTop,
            delta = afterScrollTop - beforeScrollTop;
        if (delta === 0) return false;
        fn(delta > 0 ? "down" : "up");
        beforeScrollTop = afterScrollTop;
    }, false);
}

