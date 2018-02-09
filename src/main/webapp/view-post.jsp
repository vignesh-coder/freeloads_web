
<%@page import="com.socialservice.bean.User"%>
<%@page import="com.socialservice.util.DBActions"%>
<%@page import="com.socialservice.bean.Post"%>
<%@page import="com.socialservice.util.Helper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="includes/head.jsp" %>
    </head>
    <body>

        <%
            String pid = request.getParameter("pid");
            String job = request.getParameter("job");

            String redirect = request.getParameter("redirect");
            if (redirect == null) {
                redirect = "index.jsp";
            }
            Post post = null;
            User user = null;
            if (pid != null) {
                if (job != null) {

                    String uid = Helper.getCurrentUser(request);
                    if (uid != null && uid.equals("-1")) {
                        if (job.equals("publish")) {
                            DBActions.publishPost(pid);
                        } else {
                            DBActions.deletePost(request, pid, uid);
                            response.sendRedirect(redirect);
                        }
                    }
                }
                post = DBActions.getPost(pid);
                if (post != null) {
                    user = DBActions.getUser(post.getUserID());
                }
            }
            if (post != null && user != null) {

        %>

        <jsp:include page="includes/nav.jsp"></jsp:include>
            <div class="container" style="padding-bottom: 30px">
                <br>
                <div id="myCarousel" class="carousel" data-ride="carousel" >
                    <!-- Indicators -->
                    <ol class="carousel-indicators">
                    <%                        String uid = Helper.getCurrentUser(request);

                        if (uid == null) {
                            uid = "";
                        }
                        if (!post.isVerified() && !post.getUserID().equals(uid) && !uid.equals("-1")) {

                            response.sendRedirect("index.jsp");
                        }
                        for (int i = 0; i < post.getImages().size(); i++) {
                            if (i == 0) {
                    %>
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                        <%
                        } else {%>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                        <%
                                }
                            }%>
                </ol>

                <!-- Wrapper for slides -->
                <div class="carousel-inner" role="listbox">
                    <%                        for (int i = 0; i < post.getImages().size(); i++) {

                            String prefix = Helper.getTitle() + "/user_data/" + post.getUserID() + "/";
                            String url = prefix + post.getImages().get(i);

                            if (i == 0) {
                    %>
                    <img class='item active' src="<%=url%>" onerror="this.src='img/placeholder.png'">
                    <%
                    } else {%>
                    <img class='item' src="<%=url%>" align="middle" onerror="this.src='img/placeholder.png'">
                    <%
                            }

                        }%>


                </div>

                <!-- Left and right controls -->
                <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>


            <div class="card text-center" >
                <ul class="list-group">
                    <li class="list-group-item" style="border: 1px solid #999999;">
                        <h3><%=post.getTitle()%></h3>
                        <h4><%=post.getDesc()%></h4>
                        <h5>
                            <%
                                if (post.isVerified()) {
                                    out.print("Verified <img src='img/verified.png'>");
                                } else {
                                    out.print("Not Verified <img src='img/not-verified.png'>");
                                }
                            %>
                        </h5>
                    </li>

                    <li class="list-group-item" style="border: 1px solid #999999;">
                        <strong>Category</strong> : <%=post.getCategory()%>
                    </li>
                    <li class="list-group-item" style="border: 1px solid #999999;">
                        <strong>Posted by</strong>: <a href="<%="profile.jsp?uid="+user.getUid()%>"><%=user.getName()%></a>
                    </li>
                    <li class="list-group-item" style="border: 1px solid #999999;">
                        <strong>Post type</strong>: <%=post.getType()%>
                    </li>
                    <li class="list-group-item" style="border: 1px solid #999999;">
                        <strong>Contact Number</strong>: <%=post.getContact()%>
                    </li>

                </ul>
            </div>


            <%
                String userType = Helper.getUserType(request);
                String currUser = Helper.getCurrentUser(request);
                if (userType != null) {

                    if (userType.equals("admin") && !post.isVerified()) {

            %>
            <a href="<%="view-post.jsp?pid=" + post.getPID() + "&job=publish&redirect=" + redirect%>">
                <button class="btn btn-sm btn-primary">Publish</button>
            </a>
            <%
                }
                if (userType.equals("admin") || post.getUserID().equals(currUser)) {

            %>
            <a href="<%="view-post.jsp?pid=" + post.getPID() + "&job=delete&redirect=" + redirect%>">
                <button class="btn btn-sm btn-danger">Delete</button>
            </a>
            <%
                    }

                }
            %>

        </div>

        <%
            } else {
                if (!response.isCommitted()) {
                    response.sendRedirect(redirect);
                }
            }


        %>
    </body>
    <style>
        .carousel-inner .item{ 
            height:300px;
            background-size:cover;
            background-position: center center;

            margin: -50px auto 0;
        }


    </style>
</html>
