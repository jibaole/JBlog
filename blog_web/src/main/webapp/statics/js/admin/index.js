$(function () {
    //loadPage();
    $('#navbar .dropdown').click(function(){
        $(this).removeClass('dropdown-select');
    });
});

function createLoding(){
    var div = '<div id="loading" class="loading">加载中...</div>';
    $('body').append(div);
}
function removeLoding(){
    $('#loading').remove();
}

/**
 * 跳转到子页面
 * @param dom
 */
function goto(dom) {
    $('.sidebar > ul > li').removeClass('active');
    $(dom).addClass('active');
    $("#navigation").val($(dom).attr("url"));
    loadPage();
}

/**
 * 加载子页面
 */
function loadPage() {
    var navigation = $("#navigation").val();
    if (undefined == navigation || "" == navigation) {
        alert("url异常，请联系liuzhihuil@163.com!");
        return;
    }
    createLoding();
    var url = _ctx + "/admin/" + navigation;
    var data = {navigation: navigation};
    $.get(url, data, function (result) {
        $("#resultDiv").html(result);
        removeLoding();
    });
}