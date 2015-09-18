<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%--
<div class="sidebar-module">
    <img src="${ctx}/static/images/QRCode_for_caliven.png" width="200px" height="200px">
</div>
--%>
<div class="sidebar-module sidebar-module-inset">
    <h4>About</h4>

    <p>
        Etiam porta <em>sem malesuada magna</em> mollis euismod. Cras
        mattis consectetur purus sit amet fermentum. Aenean lacinia
        bibendum nulla sed consectetur.
    </p>
</div>
<div class="sidebar-module">
    <h4>文章归档</h4>
    <ol class="list-unstyled">
        <c:forEach items="${last12Months}" var="month">
            <li><a href="#">${month}</a></li>
        </c:forEach>
    </ol>
</div>
<div class="sidebar-module">
    <h4>小家伙们</h4>
    <object type="application/x-shockwave-flash" style="outline:none;"
            data="${ctx}/static/widgets/hamster.swf?" width="220" height="175">
        <param name="movie" value="${ctx}/static/widgets/hamster.swf?">
        <param name="AllowScriptAccess" value="always">
        <param name="wmode" value="opaque">
    </object>
</div>
<div class="sidebar-module">
    <object type="application/x-shockwave-flash" style="outline:none;"
            data="${ctx}/static/widgets/dog.swf?3?" width="220" height="175">
        <param name="movie" value="${ctx}/static/widgets/dog.swf?3?">
        <param name="AllowScriptAccess" value="always">
        <param name="wmode" value="opaque">
        <param name="bgcolor" value="FFFFFF"/>
    </object>
</div>

<div class="sidebar-module">
    <h4>分类</h4>
    <ol class="list-unstyled">
        <li><a href="#">GitHub</a></li>
        <li><a href="#">Twitter</a></li>
        <li><a href="#">Facebook</a></li>
    </ol>
</div>
<div class="sidebar-module">
    <h4>标签</h4>
    <ol class="list-unstyled">
        <li><a href="#">GitHub</a></li>
        <li><a href="#">Twitter</a></li>
        <li><a href="#">Facebook</a></li>
    </ol>
</div>