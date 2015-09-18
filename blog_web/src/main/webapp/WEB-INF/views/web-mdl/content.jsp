<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

    <link rel="stylesheet" href="${ctx}/static/editor.md/css/editormd.preview.css">
<div id="editormd-view">
    <textarea style="display: none;"><c:out value="${blog.content}" escapeXml="true"/></textarea>

<script src="${ctx}/static/js/jquery/jquery.min.js"></script>
<script src="${ctx}/static/editor.md/lib/marked.min.js"></script>
<script src="${ctx}/static/editor.md/lib/prettify.min.js"></script>
<script src="${ctx}/static/editor.md/lib/raphael.min.js"></script>
<script src="${ctx}/static/editor.md/lib/underscore.min.js"></script>
<script src="${ctx}/static/editor.md/lib/sequence-diagram.min.js"></script>
<script src="${ctx}/static/editor.md/lib/flowchart.min.js"></script>
<script src="${ctx}/static/editor.md/lib/jquery.flowchart.min.js"></script>
<script src="${ctx}/static/editor.md/editormd.js"></script>

<script type="text/javascript">
    var editormdContent = editormd.markdownToHTML('editormd-view', {
        htmlDecode: "style,script,iframe",
        tocm: true,  // Using [TOCM]
        emoji: true,
        taskList: true,
        tex: true,  // 默认不解析
        flowChart: true,  // 默认不解析
        sequenceDiagram: true   // 默认不解析
    });
    // 计算页面的实际高度，iframe自适应会用到
    function calcPageHeight(doc) {
        var cHeight = Math.max(doc.body.clientHeight, doc.documentElement.clientHeight);
        var sHeight = Math.max(doc.body.scrollHeight, doc.documentElement.scrollHeight);
        var height = Math.max(cHeight, sHeight);
        return height;
    }
    /*window.onload = function () {
        var height = calcPageHeight(document)
        parent.document.getElementById('iframepage_${blog.id}').style.height = (height + 8) + 'px'
    }*/
</script>
