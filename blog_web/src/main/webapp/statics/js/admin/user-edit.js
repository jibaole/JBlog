/**
 * Created by Caliven on 2015/7/5.
 */
$(function () {
    $('#saveForm').bootstrapValidator({
        message: '值无效',
        //container: 'tooltip',
        //container: '#errors',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            username: {
                container: '#usernameMessage',
                validators: {
                    notEmpty: {
                        message: '用户名不能为空'
                    },
                    stringLength: {
                        min: 3,
                        max: 20,
                        message: '用户名长度为3-20位'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9_]+$/,
                        message: '用户名只能由字母、数字、下划线组成'
                    },
                    different: {
                        field: 'password',
                        message: '用户名和密码不能相同'
                    },
                    remote: {
                        type: 'POST',
                        url: _ctx + '/admin/user/check_username',
                        message: '用户名已被使用',
                        delay: 1000
                    }
                }
            },
            nickname: {
                container: '#nicknameMessage',
                validators: {
                    stringLength: {
                        min: 2,
                        max: 10,
                        message: '昵称长度为2-10位'
                    }
                }
            },
            email: {
                container: '#emailMessage',
                validators: {
                    notEmpty: {
                        message: '邮箱不能为空'
                    },
                    emailAddress: {
                        message: '输入的不是一个有效的邮箱地址'
                    }
                }
            },
            password: {
                container: '#passwordMessage',
                validators: {
                    notEmpty: {
                        message: '密码不能为空'
                    },
                    stringLength: {
                        min: 5,
                        max: 20,
                        message: '密码长度为5-20位'
                    },
                    different: {
                        field: 'username',
                        message: '密码不能与用户名相同'
                    }
                }
            },
            confirmPassword: {
                container: '#confirmPasswordMessage',
                validators: {
                    notEmpty: {
                        message: '确认密码不能为空'
                    },
                    identical: {
                        field: 'password'
                    },
                    different: {
                        field: 'username',
                        message: '密码不能与用户名相同'
                    }
                }
            },
            url: {
                container: '#urlMessage',
                validators: {
                    uri: {
                        allowLocal: false,//不允许输入locahost本地地址
                        message: '输入的不是一个有效的URL地址'
                    }
                }
            },
            roles: {
                container: '#rolesMessage',
                validators: {
                    notEmpty: {
                        message: '用户组不能为空'
                    }
                }
            }
        }
    });
});