/**
 * Created by Caliven on 2015/7/11.
 */

/**
 * 对Date的扩展，将 Date 转化为指定格式的String
 * @param fmt
 * @returns {*}
 * @constructor
 */
Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1,               //月份
        "d+": this.getDate(),                    //日
        "h+": this.getHours(),                   //小时
        "m+": this.getMinutes(),                 //分
        "s+": this.getSeconds(),                 //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds()             //毫秒
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};

// 是否保存
var hasSaved = true;
var articleEditor;
$(function () {

    // 写文章时，每一分钟自动保存一次文章
    setInterval(initAutoSave, 60000);

    articleEditor = editormd("article-editormd", {
        width: "100%",
        height: 740,
        path: _ctx + "/statics/editor.md/lib/",
        codeFold: true,
        saveHTMLToTextarea: true,
        searchReplace: true,
        watch: true,
        htmlDecode: "style,script,iframe|on*",
        emoji: true,
        taskList: true,
        tocm: true,
        // 图片上传
        imageUpload: true,
        imageFormats: ["jpg", "JPG", "jpeg", "JPEG", "gif", "GIF", "png", "PNG", "bmp", "BMP", "webp", "WEBP"],
        //imageUploadURL: _ctx + "/admin/file/upload-single",
        imageUploadURL: _ctx + "/admin/qiniu/upload?blogId=" + $('#tmpBlogId').val(),
        // 当文章区域有变更时，更改是否保存标示
        onchange: function () {
            hasSaved = false;
        },
        // 全屏
        onfullscreen: function () {
            $('#top-nav,.form-control-feedback').hide();
        },
        // 退出全屏
        onfullscreenExit: function () {
            $('#top-nav,.form-control-feedback').show();
        },

        // 自定义工具栏
        toolbarIcons: function () {
            // 默认所有按钮
            var btnArry = editormd.toolbarModes["full"];
            // 自定义按钮
            btnArry.push('|');
            btnArry.push('moreIcon'); // 更多按钮
            btnArry.push('draftIcon');// 草稿按钮
            btnArry.push('saveIcon'); // 发表按钮
            return btnArry;
        },
        // 自定义按钮图标（指定一个FontAawsome的图标类）
        toolbarIconsClass: {
            moreIcon: "fa-bookmark",
            draftIcon: "fa-floppy-o",
            saveIcon: "fa-paper-plane"
        },
        // 自定义工具栏按钮的事件处理
        toolbarHandlers: {
            /**
             * @param {Object}      cm         CodeMirror对象
             * @param {Object}      icon       图标按钮jQuery元素对象
             * @param {Object}      cursor     CodeMirror的光标对象，可获取光标所在行和位置
             * @param {String}      selection  编辑器选中的文本
             */
            moreIcon: function (cm, icon, cursor, selection) {
                // 替换选中文本，如果没有选中文本，则直接插入
                cm.replaceSelection("<!--more-->");
                // 如果当前没有选中的文本，将光标移到要输入的位置
                if (selection === "") {
                    cm.setCursor(cursor.line, cursor.ch + 1);
                }
            },
            draftIcon: function (cm, icon, cursor, selection) {
                saveDraft();
            },
            saveIcon: function (cm, icon, cursor, selection) {
                $('#save-btn').trigger('click');
            }
        },
        // 自定义按钮的提示文本（即title属性）
        lang: {
            toolbar: {
                moreIcon: "插入更多标示，文章在首页只显示更多标示前的文字，在文章详细页会显示全部",
                draftIcon: "存草稿",
                saveIcon: "发表文章"
            }
        }
    });

    // 左侧功能栏显示影藏
    $('#menu-span').click(function () {
        if ($('#article-right-div').is(':hidden')) {
            $('#article-left-div').addClass('col-sm-9');
            $('#article-right-div').addClass('col-sm-3').css('display', 'block');
            articleEditor.unwatch();
        } else {
            $('#article-left-div').removeClass('col-sm-9');
            $('#article-right-div').removeClass('col-sm-3').css('display', 'none');
            articleEditor.watch();
        }
    });

    // 日期控件
    $('#publishTime').datetimepicker({
        language: 'zh-CN',
        format: "yyyy-mm-dd hh:ii",
        autoclose: true,
        todayBtn: true
    });

    // 表单验证
    $('#saveForm').bootstrapValidator({
        message: '值无效',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            title: {
                validators: {
                    notEmpty: {
                        message: '标题不能为空'
                    },
                    stringLength: {
                        min: 0,
                        max: 250,
                        message: '标题长度不能超过250位'
                    }
                }
            },
            createdDate: {
                validators: {
                    date: {
                        format: 'YYYY-MM-DD h:m',
                        message: '格式不正确 [2015-01-01 01:01]'
                    }
                }
            }
        }
    });

    // 文件上传
    $('#fileupload').fileupload({
        dataType: 'json',
        done: function (e, data) {
            var result = data.result;
            if (result.error != null && 'error' == result.error) {
                var fileHtml = '<li id="error"><div class="info">上传失败，重试下!</div></li>';
                $("#uploaded-files").append(fileHtml);
                return;
            } else {
                $('#error').remove();
            }
            $.each(data.result, function (index, file) {
                appendFile(file);
            });
        },
        dropZone: $('#upload-area')
    });

    // 存草稿
    $('#draft-btn').click(function () {
        saveDraft();
    });

    // 发布文章
    $('#saveForm').on('submit', function (e) {
        save();
    });

    // 关闭窗口时弹出确认提示
    $(window).bind('beforeunload', function () {
        // 只有在标识变量hasSaved为false时，才弹出确认提示
        if (hasSaved == false)
            return '文章有变更内容尚未保存';
    });
});

/**
 * 追加文件
 * @param file
 */
function appendFile(file) {
    var fileHtml =
        '<li id="file_' + file.id + '">' +
        '<a class="insert" target="_blank" href="' + file.filePath + '" title="' + file.fileRealName + ' (' + file.fileName + ')">' + file.fileRealName + '&nbsp;(' + file.fileName + ')</a>' +
        '<div class="info">' + file.fileSize + ' Kb&nbsp;&nbsp;' +
        '<a class="delete" href="javascript:;" onclick="delFile(' + file.id + ',\'' + file.fileRealName + '\')" title="删除"><i class="i-del"></i></a>' +
        '</div>' +
        '</li>';
    $("#uploaded-files").append(fileHtml);
}

/**
 * 存草稿
 */
function saveDraft() {
    var isDraft = $('#isDraft').val();
    $('#isDraft').val(true);
    autosave();
}

/**
 * 自动保存任务
 */
function initAutoSave() {
    var isDraft = $('#isDraft').val();
    if ('false' != isDraft) {
        $('#isDraft').val(true);
    } else {
        $('#isDraft').val(false);
    }
    autosave();
}

/**
 * 发表文章
 */
function save() {
    setCateIds();
    hasSaved = true;
    $('#isDraft').val(false);
    $('#htmlContent').text(articleEditor.getHTML());

    $('.editormd-menu').find('#save-tips').remove();
    $('.editormd-menu').append('<li id="save-tips" style="padding-left: 15px;color: green;">发布中...</li>');
    $('#save-btn').text('发布中...').attr('disabled', true);

}

/**
 * 自动保存
 */
function autosave() {
    var content = $('#content').html();
    if (undefined == content || '' == $.trim(content)) {
        return;
    }

    setCateIds();
    if ('' == $('#title').val()) {
        $('#title').val('无标题 - [ ' + new Date().Format("yyyy-MM-dd hh:mm:ss") + ' ]');
    }
    var isDraft = $('#isDraft').val();
    $('#content').text(content);
    $('#htmlContent').text(articleEditor.getHTML());

    var url = _ctx + "/admin/article/autosave";
    $('#saveForm').attr('action', url);
    $('#saveForm').ajaxSubmit(function (result) {
        var tips = 'true' == isDraft ? '草稿' : '';
        var id = result.id;
        var status = result.status;
        var tipsHtml = '';
        if (true == status) {
            hasSaved = true;
            tips = '已自动保存' + tips + '(' + result.date + ')';
            tipsHtml = '<li id="save-tips" style="padding-left: 15px;color: green;">' + tips + '</li>';
        } else {
            hasSaved = false;
            tips = '自动保存' + tips + '失败,请手动保存(' + result.date + ')';
            tipsHtml = '<li id="save-tips" style="padding-left: 15px;color: red;">' + tips + '</li>';
        }
        // 在按钮操作栏最后提示结果
        $('.editormd-menu').find('#save-tips').remove();
        $('.editormd-menu').append(tipsHtml);

        if (id != null && '' != id && 'null' != id) {
            $('#blogId').val(id);
        }

        // 将表单url重置为手动保存url
        var url = _ctx + "/admin/article/save";
        $('#saveForm').attr('action', url);
        if ('' == isDraft) {
            $('#isDraft').val('true');
        }
    });
}

/**
 * 设置类别id
 */
function setCateIds() {
    var cateIds = new Array;
    $('.cate-div input[type="checkbox"]:checked').each(function (i) {
        cateIds[i] = $(this).val();
    });
    $('#cateIds').val(cateIds.join(','));
}

/**
 * 切换div
 * @param dom
 * @param type
 */
function switchDiv(dom, type) {
    var divId = type == 1 ? 'leftDiv' : 'rightDiv';
    $('.btn-group-sm .btn-default').removeClass('select-btn');
    $('.switch-div').hide();
    $(dom).addClass('select-btn');
    $('#' + divId).show();
}

/**
 * 公开度选择
 * @param dom
 */
function switchStatus(dom) {
    var val = $(dom).val();
    if (3 == val) {
        $('#pwdDiv').show();
    } else {
        $('#pwdDiv').hide();
    }
}

/**
 * 删除文件
 * @param id
 * @param fileName
 */
function delFile(id, fileName) {
    if (confirm('确定要删除文件' + fileName + '吗？')) {
        var url = _ctx + '/admin/qiniu/delete';
        $.get(url, {id: id}, function (result) {
            var status = result.status;
            if ('success' == status) {
                $('#file_' + id).fadeToggle("slow", "linear", function () {
                    $(this).remove();
                    flushBadge();
                });
            } else {
                alert('删除失败!');
            }
        });
    }
}

/**
 * 刷新文件个数
 */
function flushBadge() {
    var fileCount = $('#uploaded-files li').length;
    $('#file-badge').text(fileCount);
}