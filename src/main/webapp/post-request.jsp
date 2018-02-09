<%-- 
    Document   : post-request
    Created on : Jan 10, 2018, 8:04:10 PM
    Author     : GOWVIK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="includes/head.jsp" %>
    </head>
    <body>
        <jsp:include page="includes/nav.jsp"></jsp:include>
        <%
            String uid = Helper.getCurrentUser(request);
            if (uid != null && uid.equals("-1")) {

                String query = "Select * from posts where verified = false";
        %>
        <jsp:include page="includes/posts.jsp">
            <jsp:param name="query" value="<%=query%>"/>
            <jsp:param name="redirect" value="post-request.jsp"/>
        </jsp:include>
        <%
            }

        %>
    </body>
</html>
