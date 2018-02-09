<%@page import="com.socialservice.bean.User"%>
<%@page import="com.socialservice.util.DBActions"%>
<%@page import="com.socialservice.bean.Post"%>
<%@page import="com.socialservice.util.Helper"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <%@include file="includes/head.jsp" %>
    </head>

    <body>

        <jsp:include page="includes/nav.jsp"></jsp:include>


        <%
            String uid = request.getParameter("uid");
            String currentUser = Helper.getCurrentUser(request);

            if (currentUser == null) {
                currentUser = "-1";
            }

            if (uid != null) {
                String query = "Select * from posts where userid = " + uid;
                String redirect = "profile.jsp?uid=" + uid;
                if (currentUser == null) {
                    currentUser = "";
                }
                if (uid.equals(currentUser) || currentUser.equals("-1")) {
                    query += " and verified = false";
                } else {
                    query += " and verified = true";
                }

                User user = DBActions.getUser(uid);
                if (user != null) {

        %>
        <div class="container">
            <h2 style="color: #006699"><%=user.getName()%></h2>
            <h4><%=user.getBio()%></h4>
            <%

                int currUser = Integer.parseInt(currentUser);
                if (user.getUid() == currUser) {

            %>

            <a href="<%="edit.jsp?uid=" + currUser + "&redirect=profile.jsp?uid=" + uid%>">
                <button class="btn btn-primary" style="width: 10%">EDIT</button>
            </a>
            <%
                }

            %>
            <hr style="height:1px;background-color:#737373;" />
            <jsp:include page="includes/posts.jsp">
                <jsp:param name="query" value="<%=query%>" />
                <jsp:param name="redirect" value="<%=redirect%>"/>
            </jsp:include>
        </div>
        <%} else {
                    response.sendRedirect("index.jsp");
                }
            } else {
                response.sendRedirect("index.jsp");
            }

        %>
    </body>

    <style>
        table {border-collapse: collapse;}
        #filter td    {padding: 6px;}
        #feed td {
            padding-bottom: 50px;
            padding-left: 200px;
        }
        #feed tr{
            width: 100%;
        }
        a{

            text-decoration: none;

        }
        a:hover{
            text-decoration: none;
        }
        table tr td img {
            max-width:250px;
            max-height:250px;
        }
    </style>
</html>
