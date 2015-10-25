/**
 * Created by Caliven on 2015/7/11.
 */
var articleEditor;
$(function () {
    //setInterval(autosave, 60000);
    articleEditor = editormd("article-editormd", {
        width: "100%",
        height: 740,
        path: _ctx + "/static/editor.md/lib/",
        //theme : "dark",
        //previewTheme : "dark",
        //editorTheme : "pastel-on-dark",
        //markdown : md,
        codeFold: true,
        //syncScrolling : false,
        saveHTMLToTextarea: true,    // 保存 HTML 到 Textarea
        searchReplace: true,
        watch: false,                // 关闭实时预览
        htmlDecode: "style,script,iframe|on*",            // 开启 HTML 标签解析，为了安全性，默认不开启
        //toolbar  : false,             //关闭工具栏
        //previewCodeHighlight : false, // 关闭预览 HTML 的代码块高亮，默认开启
        emoji: true,
        taskList: true,
        tocm: true,         // Using [TOCM]
        tex: true,                   // 开启科学公式TeX语言支持，默认关闭
        flowChart: true,             // 开启流程图支持，默认关闭
        sequenceDiagram: true,       // 开启时序/序列图支持，默认关闭,
        //dialogLockScreen : false,   // 设置弹出层对话框不锁屏，全局通用，默认为true
        //dialogShowMask : false,     // 设置弹出层对话框显示透明遮罩层，全局通用，默认为true
        //dialogDraggable : false,    // 设置弹出层对话框不可拖动，全局通用，默认为true
        //dialogMaskOpacity : 0.4,    // 设置透明遮罩层的透明度，全局通用，默认值为0.1
        //dialogMaskBgColor : "#000", // 设置透明遮罩层的背景颜色，全局通用，默认为#fff
        imageUpload: true,
        imageFormats: ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
        imageUploadURL: _ctx + "/admin/file/upload-single",
        /* onload: function () {
         console.log('onload', this);
         //this.fullscreen();
         //this.unwatch();
         //this.watch().fullscreen();

         //this.setMarkdown("#PHP");
         //this.width("100%");
         //this.height(480);
         //this.resize("100%", 640);
         },*/
        onfullscreen: function () {
            $('#top-nav,#article-right-div').hide();
        },
        onfullscreenExit: function () {
            $('#top-nav,#article-right-div').show();
        },
        toolbarIcons: function () {
            var btnArry = editormd.toolbarModes["full"];
            btnArry.push('moreIcon');
            return btnArry;
        },
        toolbarIconsClass: {
            moreIcon: "fa-tag"  // 指定一个FontAawsome的图标类
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

                //var cursor    = cm.getCursor();     //获取当前光标对象，同cursor参数
                //var selection = cm.getSelection();  //获取当前选中的文本，同selection参数

                // 替换选中文本，如果没有选中文本，则直接插入
                cm.replaceSelection("<!--more-->");

                // 如果当前没有选中的文本，将光标移到要输入的位置
                if (selection === "") {
                    cm.setCursor(cursor.line, cursor.ch + 1);
                }

            }
        },
        lang: {
            toolbar: {
                moreIcon: "插入更多标示，文章在首页只显示更多标示前的文字，在文章详细页会显示全部"// 自定义按钮的提示文本，即title属性
            }
        }
    });

    $('#publishTime').datetimepicker({
        language: 'zh-CN',
        format: "yyyy-mm-dd hh:ii",
        autoclose: true,
        todayBtn: true
    });

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
                var fileHtml =
                    '<li id="file_' + file.fileId + '">' +
                    '<a class="insert" target="_blank" href="###" title="点击插入文件 \'' + file.fileRealName + '\'">' + file.fileRealName + '</a>' +
                    '<div class="info">' +
                    file.fileSize + ' Kb&nbsp;&nbsp;' +
                    '<a class="file" target="_blank" href="' + _ctx + '/admin/file/edit/' + file.fileId + '" title="编辑">' +
                    '<i class="i-edit"></i>' +
                    '</a>' +
                    '<a class="delete" href="javascript:void(0);" onclick="delFile(' + file.fileId + ',\'' + file.fileRealName + '\')" title="删除">' +
                    '<i class="i-del"></i>' +
                    '</a>' +
                    '</div>' +
                    '</li>';
                $("#uploaded-files").append(fileHtml);
            });
        },
        /*progressall: function (e, data) {
         var progress = parseInt(data.loaded / data.total * 100, 10);
         $('#progress .bar').css(
         'width',
         progress + '%'
         );
         },*/
        dropZone: $('#upload-area')
    });

    /**
     * 发布文章
     */
    $('#saveForm').on('submit', function (e) {
        beforeSave(false);
        //var htmlContent = articleEditor.getHTML();// 获取 Textarea 保存的 HTML 源码
        //console.log(htmlContent);
        //$('#htmlContent').text(htmlContent);
        $('#save-btn').text('发布中...').attr('disabled', true);
    });

    /**
     * 存草稿
     */
    $('#draft-btn').click(function () {
        beforeSave(true);
        autosave();
    });
});

/**
 * 自动保存
 */
function autosave() {

    setCateIds();
    $('#content').text($('#editor').html());

    var url = _ctx + "/admin/article/autosave";
    $('#saveForm').attr('action', url);
    $('#saveForm').ajaxSubmit(function (result) {
        var tips;
        var id = result.id;
        var status = result.status;
        if (true == status) {
            tips = '已保存(' + result.date + ')';
        } else {
            tips = '自动保存失败,请手动保存(' + result.date + ')';
        }
        if (id != null && '' != id && 'null' != id) {
            $('#blogId').val(id);
        }

        var url = _ctx + "/admin/article/save";
        $('#saveForm').attr('action', url);
        var isDraft = $('#isDraft').val();
        if ('' == isDraft) {
            $('#isDraft').val('true');
        }
    });
}

/**
 * 发布文章预处理
 * @param isDraft
 */
function beforeSave(isDraft) {
    setCateIds();
    $('#isDraft').val(isDraft);
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
    var tmpBlogId = $('#tmpBlogId').val();
    if (tmpBlogId == '') {
        if (confirm('确定要删除文件' + fileName + '吗？')) {
            deleteFile(id);
        }
    } else {
        deleteFile(id);
    }
}

function deleteFile(id) {
    var url = _ctx + '/admin/file/del';
    $.post(url, {id: id}, function (result) {
        var status = result.status;
        if ('success' == status) {
            $('#file_' + id).fadeToggle("slow", "linear", function () {
                $(this).remove();
            });
        } else {
            alert('删除失败!');
        }
    });
}