<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${ctx}/static/js/jquery/jquery.min.js"></script>
<script src="${ctx}/static/editor.md/lib/marked.min.js"></script>
<script src="${ctx}/static/editor.md/lib/prettify.min.js"></script>
<script src="${ctx}/static/editor.md/lib/raphael.min.js"></script>
<script src="${ctx}/static/editor.md/lib/underscore.min.js"></script>
<script src="${ctx}/static/editor.md/lib/sequence-diagram.min.js"></script>
<script src="${ctx}/static/editor.md/lib/flowchart.min.js"></script>
<script src="${ctx}/static/editor.md/lib/jquery.flowchart.min.js"></script>
<script src="${ctx}/static/editor.md/editormd.js"></script>

<div id="editormd-view-${blog.id}" class="editormd-content" bid="${blog.id}">
    <textarea style="display: none;" id="content-${blog.id}">
        <c:out value="${blog.content}" escapeXml="true"/>
    </textarea>
</div>

<script type="text/javascript">
    $(function () {
        $('.editormd-content').each(function () {
            var divId = $(this).attr('id');
            var bId = $(this).attr('bId');
            var content = $('#content-' + bId).text();
            editormd.markdownToHTML(divId, {
                markdown: content,//+"\r\n" + $("#append-test").text(),
                //htmlDecode      : true,       // 开启 HTML 标签解析，为了安全性，默认不开启
                htmlDecode: "style,script,iframe",  // you can filter tags decode
                //toc             : false,
                tocm: true,    // Using [TOCM]
                //tocContainer    : "#custom-toc-container", // 自定义 ToC 容器层
                //gfm             : false,
                //tocDropdown     : true,
                markdownSourceCode: false, // 是否保留 Markdown 源码，即是否删除保存源码的 Textarea 标签
                emoji: true,
                taskList: true,
                tex: true,  // 默认不解析
                flowChart: true,  // 默认不解析
                sequenceDiagram: true  // 默认不解析
            });
        });

    });
</script>