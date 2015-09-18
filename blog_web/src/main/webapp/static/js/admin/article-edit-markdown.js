/**
 * Created by Caliven on 2015/7/11.
 */
$(function () {
    setInterval(autosave, 60000);
    $('#publishTime').datetimepicker({
        language: 'zh-CN',
        format: "yyyy-mm-dd hh:ii",
        autoclose: true,
        todayBtn: true
    });

    var oldLength = $('#content').text().length;
    $('#content').markdown({
        language: 'zh',
        height: '500',
        /*hiddenButtons: 'cmdPreview',*/
        footer: '<div id="markdown-footer" class="well" style="display:none;"></div>' +
        '<small id="markdown-tips" class="text-success text-left">&nbsp;</small>',
        onChange: function (e) {
            var newLength = document.getElementById("content").value.length;
            console.info($('#content').text() + "===" + newLength + "--" + oldLength);
            if ((newLength - oldLength) >= 10) {
                oldLength = newLength;
                autosave();
            } else if ((oldLength - newLength) >= 10) {
                oldLength = newLength;
                autosave();
            }
            /*var content = e.parseContent(),
             content_length = (content.match(/\n/g) || []).length + content.length

             if (content == '') {
             $('#markdown-footer').hide()
             } else {
             $('#markdown-footer').show().html(content)
             }

             if (content_length > 140) {
             $('#markdown-tips').removeClass('text-success').addClass('text-danger').html(content_length - 140 + ' character surplus.')
             } else {
             $('#markdown-tips').removeClass('text-danger').addClass('text-success').html(140 - content_length + ' character left.')
             }*/
        }
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
                    '<a class="delete" href="javascript:void(0);" onclick="delFile(' + file.fileId + ',\''+file.fileRealName+'\')" title="删除">' +
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
});

function autosave() {
    var contentLength = document.getElementById("content").value.length;
    if (contentLength <= 0) {
        return;
    }
    setCateIds();
    $('#markdown-tips').text('正在保存...');
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
        $('#markdown-tips').text(tips);
        $('#markdown-tips').fadeToggle("slow", "linear").fadeIn('slow');

        var url = _ctx + "/admin/article/save";
        $('#saveForm').attr('action', url);
        var isDraft = $('#isDraft').val();
        if ('' == isDraft) {
            $('#isDraft').val('true');
        }
    });
}

function setDraft(isDraft) {
    beforeSave(isDraft);
    autosave();
}

function beforeSave(isDraft) {
    setCateIds();
    $('#isDraft').val(isDraft);
}

function setCateIds() {
    var cateIds = new Array;
    $('.cate-div input[type="checkbox"]:checked').each(function (i) {
        cateIds[i] = $(this).val();
    });
    $('#cateIds').val(cateIds.join(','));
}

function switchDiv(dom, type) {
    var divId = type == 1 ? 'leftDiv' : 'rightDiv';
    $('.btn-group-sm .btn-default').removeClass('select-btn');
    $('.switch-div').hide();
    $(dom).addClass('select-btn');
    $('#' + divId).show();
}

function switchStatus(dom) {
    var val = $(dom).val();
    if (3 == val) {
        $('#pwdDiv').show();
    } else {
        $('#pwdDiv').hide();
    }
}


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