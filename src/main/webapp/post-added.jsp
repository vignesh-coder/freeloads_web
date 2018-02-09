<%-- 
    Document   : success.jsp
    Created on : Jan 9, 2018, 5:42:21 PM
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
        <jsp:include page="includes/nav.jsp"></jsp:include>
        <div class="container">
            <div class="center-block">
                <h2 class="text-center">Congrats! Your post has been added and submitted for review.</h2>
                <a href="index.jsp">
                    <button class="btn btn-primary">Go to Home page</button>
                </a>
            </div>
        </div>
    </body>
</html>
