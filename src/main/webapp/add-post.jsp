<%-- 
    Document   : create-post
    Created on : 6 Dec, 2017, 6:04:42 PM
    Author     : GOWVIK
--%>

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
            String user = Helper.getCurrentUser(request);
            if (user == null) {
                response.sendRedirect("auth.jsp?required=login&redirect=create-post.jsp");
            }
        %>

        <div class="container">
            <form method="post" action="AddPost" enctype="multipart/form-data">

                <label>Type</label>
                <div class="radio">
                    <label>
                        <input type="radio" name="type" id="denote" checked="" value="Donate">Donate
                    </label>

                </div>

                <div class="radio">
                    <label><input type="radio" name="type" id="need" value="Need">Need</label>
                </div>

                <div class="form-group">
                    <label for="category">Category</label>
                    <select name="category" class="form-control" id="category" required="">
                        <%
                            List<String> categories = Helper.getCategories();
                            for (String s : categories) {
                        %>
                        <option value="<%=s%>"><%=s%></option>  
                        <%  } %>

                    </select>
                </div>
                <div class="form-group">
                    <label for="title">Title</label>
                    <input type="text" class="form-control" name="title" id="title" required="">
                </div>
                <div class="form-group">
                    <label for="desc">Description</label>
                    <textarea class="form-control"  rows="5" name="desc" id="desc" required=""></textarea>
                </div>
                <div class="form-group">
                    <label for="address">Address</label>
                    <textarea class="form-control"  rows="5" name="address" id="address" required=""></textarea>
                </div>
                <div class="form-group">
                    <label for="contact">Contact Number</label>
                    <input class="form-control" type="number" name="contact" id="contact" required="">
                </div>

                <label>Images</label>
                <% for (int i = 1; i <= 4; i++) {%>
                <div class="form-group">
                    <input accept="image/*" type="file" name="<%= "image" + i%>">
                </div>
                <% }%>

                <button required="submit" class="btn btn-primary" style="width: 100%">Post</button>
            </form>
            <br>
        </div>
    </body>
</html>
