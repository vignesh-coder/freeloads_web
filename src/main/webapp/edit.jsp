

<%@page import="com.socialservice.util.DBActions"%>
<%@page import="com.socialservice.bean.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="includes/head.jsp" %>
    </head>
    <body>
        <jsp:include page="includes/nav.jsp"></jsp:include>
        <div class="container">
            <%
                String uid = request.getParameter("uid");
                String redirect = request.getParameter("redirect");
                String currentUser = Helper.getCurrentUser(request);
                if (uid != null && uid.equals(currentUser) && redirect!=null) {
                    User user = DBActions.getUser(uid);
            %>

            <form  method="post" action="UpdateProfile">
                <div class="container">


                    <div class="form-group">
                        <label for="name">Name</label>
                        <input class="form-control" type="text" value="<%=user.getName()%>" name="name" id="name" required="" placeholder="Name">
                    </div>

                    <div class="form-group">
                        <label for="bio">Bio</label>
                        <input class="form-control" type="text" value="<%=user.getBio()%>" name="bio" id="bio" required="" placeholder="Bio">
                    </div>
                    <input required="hidden" style="display: none" name="uid" value="<%=uid%>">
                    <input required="hidden" style="display: none" name="redirect" value="<%=redirect%>">
                    <button required="submit" class="btn btn-primary" style="width: 100%">UPDATE</button>

                </div>
            </form>
            <%
                } else {

                    response.sendRedirect("profile.jsp?uid=" + uid);
                }
            %>
        </div>
    </body>
</html>
