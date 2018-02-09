<%-- 
    Document   : posts
    Created on : Dec 25, 2017, 8:49:39 AM
    Author     : GOWVIK
--%>

<%@page import="com.socialservice.bean.User"%>
<%@page import="com.socialservice.util.DBActions"%>
<%@page import="com.socialservice.bean.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.socialservice.util.Helper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="js/jquery.min.js"></script>
        <script src="js/posts.js"></script>
        <link rel="stylesheet" href="css/posts.css">
    </head>
    <body>
        <div id="feed">
            <table>

                <%
                    String query = request.getParameter("query");
                    String redirect = request.getParameter("redirect");
                    List<Post> posts = DBActions.getPosts(query);
                    if (posts.isEmpty()) {
                        out.print("<h2 class='text-center' style='color:grey; padding-top:40px'>No post.</h2>");
                    }
                    for (int i = posts.size() - 1; i >= 0; i -= 2) {
                %>

                <tr>
                    <% Post post = posts.get(i);

                        String prefix = Helper.getTitle() + "/user_data/" + post.getUserID() + "/";
                        String url = "";
                        if (post.getImages().isEmpty()) {
                            url = "img/placeholder.png";
                        } else {
                            url = prefix + post.getImages().get(0);
                        }
                    %>

                    <td>

                        <h5>

                            <%
                                if (!post.isVerified()) {
                                    out.print("Not Verified <img src='img/not-verified.png'>");
                                }
                            %>
                        </h5>
                        <a href="<%="view-post.jsp?pid=" + post.getPID() + "&redirect=" + redirect%>">

                            <h4 id="title"> <%=post.getTitle()%> </h4>
                            <p><i><%=post.getType()%> </i></p>
                            <p><i><%=post.getCategory()%> </i></p>
                            <img  src="<%=url%>" class="post-img img-thumbnail" onerror="this.src='img/placeholder.png'"/>

                        </a>
                        <a href="<%="profile.jsp?uid=" + post.getUserID() + "&redirect=" + redirect%>">
                            <%
                                User user = DBActions.getUser(post.getUserID());
                                if (user != null) {

                                    out.print("<h4>" + user.getName() + "</h4>");
                                }
                            %>

                        </a>

                    </td>

                    <%
                        if (i - 1 >= 0) {
                            post = posts.get(i - 1);

                            url = "";
                            if (post.getImages().isEmpty()) {
                                url = "img/placeholder.png";
                            } else {
                                url = prefix + post.getImages().get(0);
                            }
                    %>
                    <td>


                        <h5>
                            <%
                                if (!post.isVerified()) {
                                    out.print("Not Verified <img src='img/not-verified.png'>");
                                }
                            %>
                        </h5>
                        <a href=<%="view-post.jsp?pid=" + post.getPID() + "&redirect=" + redirect%>>

                            <h4 id="title"> <%=post.getTitle()%> </h4>
                            <p id="type"><i><%=post.getType()%> </i></p>
                            <p id="category"><i><%=post.getCategory()%> </i></p>
                            <img  src="<%=url%>" class="post-img img-thumbnail" onerror="this.src='img/placeholder.png'"/>
                        </a>
                        <a href="<%="profile.jsp?uid=" + post.getUserID() + "&redirect=" + redirect%>">
                            <%
                                user = DBActions.getUser(post.getUserID());
                                if (user != null) {

                                    out.print("<h4>" + user.getName() + "</h4>");
                                }
                            %>

                        </a>

                    </td>
                    <% } %>
                </tr>
                <% }%>
            </table>
        </div>

    </body>
</html>
