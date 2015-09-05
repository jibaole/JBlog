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
</div><%--
<div class="sidebar-module">
    <h4>Elsewhere</h4>
    <ol class="list-unstyled">
        <li><a href="#">GitHub</a></li>
        <li><a href="#">Twitter</a></li>
        <li><a href="#">Facebook</a></li>
    </ol>
</div>
<div class="sidebar-module">
    <h4>Blogroll</h4>
    <ol class="list-unstyled">
        <li><a href="#">GitHub</a></li>
        <li><a href="#">Twitter</a></li>
        <li><a href="#">Facebook</a></li>
    </ol>
</div>--%>