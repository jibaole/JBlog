!function(){"use strict";function e(){c.classList.remove("disabled"),n.classList.remove("disabled"),l.scrollLeft<=0&&c.classList.add("disabled"),l.scrollLeft+l.clientWidth+5>=l.scrollWidth&&n.classList.add("disabled")}function t(e){l.scrollLeft+=e}var n=document.querySelector(".scrollindicator.scrollindicator--right"),c=document.querySelector(".scrollindicator.scrollindicator--left"),l=document.querySelector(".docs-navigation"),i=40;l.addEventListener("scroll",e),e(),n.addEventListener("click",t.bind(null,i)),n.addEventListener("tap",t.bind(null,i)),c.addEventListener("click",t.bind(null,-i)),c.addEventListener("tap",t.bind(null,-i))}(),function(){"use strict";var e=document.querySelectorAll('[href=""]');Array.prototype.forEach.call(e,function(e){e.addEventListener("click",function(e){e.preventDefault()})})}();
$(function () {
    var isPlay = false;
    /*$(window).scroll(function () {
        var scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
        console.info(scrollTop+'===');
        if (scrollTop <= 200) {
            $('#back-to-top').animate({
                opacity: "hide"
            }, "slow");
        } else {
            $('#back-to-top').animate({
                opacity: "show"
            }, "slow");
        }
    });*/

    // 在网页中双击暂停或播放音乐
    $('body').dblclick(function () {
        $('#music')[0].pause();
        $('#play-music').find('i').text('play_arrow');
        isPlay = true;
    });
    // 播放、暂停音乐
    $('#play-music').click(function(){
        if (isPlay) {
            $('#music')[0].pause();
            $(this).find('i').text('play_arrow');
            isPlay = false;
        } else {
            $('#music')[0].play();
            $('#music')[0].volume = 0.2;
            $(this).find('i').text('pause');
            isPlay = true;
        }
    });
});