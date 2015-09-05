jQuery(document).ready(function () {

    /* Fullscreen background */
    $.backstretch(_ctx + "/static/styles/account/img/backgrounds/1.jpg");

    /* Form validation */
    $('.login-form input[type="text"], .login-form input[type="password"], .login-form textarea').on('focus', function () {
        $(this).removeClass('input-error');
        $('[data-toggle="popover"]').popover('destroy');
    });

    $('#login-form').on('submit', function (e) {
        var flag = false;
        $(this).find('input[type="text"], input[type="password"]').each(function () {
            if ($.trim($(this).val()) == "") {
                flag = true;
                e.preventDefault();
                $(this).addClass('input-error');
                // 显示Bootstrap popover弹出框
                $(this).popover('show');
            } else {
                $(this).removeClass('input-error');
                // 注销Bootstrap popover弹出框
                $(this).popover('destroy');
            }
        });
    });
});

/**
 * 异步提交登录
 */
/*
function login(){
    var flag = false;
    $('#login-form').find('input[type="text"], input[type="password"]').each(function(){
        if ($.trim($(this).val()) == "") {
            flag = true;
            $(this).addClass('input-error');
            // 显示Bootstrap popover弹出框
            $(this).popover('show');
        }else{
            $(this).removeClass('input-error');
            // 注销Bootstrap popover弹出框
            $(this).popover('destroy');
        }
    });
    if(!flag){
        $('#login-form').ajaxSubmit(function(result){
            alert(result);
        });
    }
}
*/
