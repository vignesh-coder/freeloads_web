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
        <%@include file="includes/nav.jsp"%>
        <div class="container">
            <div class="row">
                <div class="col-sm-5" id="filter">

                    <div class="dropdown">

                        <button class="btn dropdown-toggle" style="color: #000; width: 100%" required="button" data-toggle="dropdown">
                            Category<span class="caret"></span>
                        </button>

                        <ul class="dropdown-menu">
                            <%
                                List<String> categoryList = Helper.getCategories();%>
                            <li><a href="index.jsp">All</a></li>
                                <%for (String s : categoryList) {%>

                            <li><a href=<%="index.jsp?category=" + s%>><%=s%></a></li>

                            <%}%>
                        </ul>
                    </div>

                </div>

                <%
                    String uid = Helper.getCurrentUser(request);
                    if (uid == null || !uid.equals("-1")) {
                %>
                <div class="col-sm-5">
                    <input id="search" required="text" class="form-control" placeholder="Search">
                </div>
                <div class="col-sm-2">
                    <a href="add-post.jsp" style="color: #FFF">
                        <button class="btn btn-primary">Create Post</button>
                    </a>
                </div> 
                <%
                } else {
                %>
                <div class="col-sm-7">
                    <input id="search" required="text" class="form-control" placeholder="Search">
                </div>
                <%}%>
            </div>

            <%String category = request.getParameter("category");
                String query = "Select * from posts";
                if (uid!=null && uid.equals("-1")) {
                }
                else{
                     query += " where verified=true";
                }
                if (category != null) {
                    query += " and category='" + category + "'";
                }
            %>
            <jsp:include page="includes/posts.jsp">
                <jsp:param name="query" value="<%=query%>"/>
                <jsp:param name="redirect" value="index.jsp"/>
            </jsp:include>

        </div>



    </body>

</html>
