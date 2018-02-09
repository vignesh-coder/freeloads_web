
<%@page import="java.net.URLDecoder"%>
<%@page import="com.socialservice.util.Helper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="includes/head.jsp" %>
    </head>
    <body>
        <jsp:include page="includes/nav.jsp"></jsp:include>
        <%
            String msg = URLDecoder.decode(request.getQueryString(), "UTF-8");
            %>
            <h3><%=msg%></h3>
    </body>
</html>
