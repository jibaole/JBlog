/**
 * Created by Caliven on 2015/7/11.
 */
$(function () {
    //setInterval(autosave, 60000);
    function initToolbarBootstrapBindings() {
        var fonts = ['Serif', 'Sans', 'Arial', 'Arial Black', 'Courier',
                'Courier New', 'Comic Sans MS', 'Helvetica', 'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma', 'Times',
                'Times New Roman', 'Verdana'],
            fontTarget = $('[title=Font]').siblings('.dropdown-menu');
        $.each(fonts, function (idx, fontName) {
            fontTarget.append($('<li><a data-edit="fontName ' + fontName + '" style="font-family:\'' + fontName + '\'">' + fontName + '</a></li>'));
        });
        $('a[title]').tooltip({container: 'body'});
        $('.dropdown-menu input').click(function () {
            return false;
        }).change(function () {
            $(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle');
        }).keydown('esc', function () {
            this.value = '';
            $(this).change();
        });
        $('[data-role=magic-overlay]').each(function () {
            var overlay = $(this), target = $(overlay.data('target'));
            overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
        });
        if ("onwebkitspeechchange"  in document.createElement("input")) {
            var editorOffset = $('#editor').offset();
            //$('#voiceBtn').css('position','absolute').offset({top: editorOffset.top, left: editorOffset.left+$('#editor').innerWidth()-35});
        } else {
            $('#voiceBtn').hide();
        }
    };

    function showErrorAlert(reason, detail) {
        var msg = '';
        if (reason === 'unsupported-file-type') {
            msg = "Unsupported format " + detail;
        } else {
            console.log("error uploading file", reason, detail);
        }
        $('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>' +
            '<strong>File upload error</strong> ' + msg + ' </div>').prependTo('#alerts');
    };

    initToolbarBootstrapBindings();

    $('#editor').wysiwyg({fileUploadError: showErrorAlert});

    window.prettyPrint && prettyPrint();

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
        $('#content').text($('#editor').html());
        $('#login-btn').text('发布中...').attr('disabled', true);
    });
    /**
     * 存草稿
     */
    $('#draft-btn').click(function(){
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