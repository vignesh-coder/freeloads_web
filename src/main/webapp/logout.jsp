<%-- 
    Document   : logout
    Created on : Dec 23, 2017, 8:42:04 PM
    Author     : GOWVIK
--%>

<%@page import="com.socialservice.util.Helper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="includes/head.jsp" %>
    </head>
    <body>
        <%
            Helper.logout(request);
            response.sendRedirect("auth.jsp?required=login");
        %>
    </body>
</html>
