jQuery(document).ready(function () {
    /* Fullscreen background */
    $.backstretch(_qiniu + "/statics/styles/account/img/backgrounds/1.jpg");
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
            var username = $.trim($('#username').val());
            var password = $.trim($('#password').val());
            if ('' != username && '' != password) {
                $('#login-btn').text('登录中...').attr('disabled', true);
            }
        });
    });
});