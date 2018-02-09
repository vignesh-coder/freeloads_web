<%-- 
    Document   : login
    Created on : Dec 21, 2017, 6:13:45 PM
    Author     : GOWVIK
--%>

<%@page import="java.net.URLDecoder"%>
<%@page import="com.socialservice.util.DBActions"%>
<%@page import="com.socialservice.util.Helper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <%@include file="includes/head.jsp" %>
    </head>
    <body>

        <jsp:include page="includes/nav.jsp"></jsp:include>
        <%            String required = request.getParameter("required");
            required = required == null ? "" : required;
            String msg = request.getParameter("msg");
            msg = msg == null ? "" : msg;
            String redirect = request.getParameter("redirect");
            redirect = redirect == null ? "index.jsp" : redirect;
        %>
        <div class="container">

            <h2 class="text-center text-muted"><%=Helper.getTitle()%></h2>
            <div class="tab-content" style="padding-top: 15px">

                <div id="login" class="tab-pane fade <%if (required.equals("login")) {%> in active <%}%>">
                    <h3 class="text-center text-muted">Login to your account</h3>
                    <p style="color:red"><b><%=msg%></b></p>
                    <div class="container">
                        <form  method="post" action="Authenticate">



                            <div class="form-group">
                                <label for="email">Email</label>
                                <input class="form-control" type="text" name="email" id="email" required="" placeholder="Enter Your Email">
                            </div>

                            <div class="form-group">
                                <label for="password">Password</label>
                                <input class="form-control" type="password" name="password" id="password" required="" placeholder="Create Password">
                            </div>
                            <p>New user?<a href="<%="auth.jsp?required=signup&redirect=" + redirect%>"> create an account</a></p>
                            <input type="hidden" name="redirect" value="<%=redirect%>">

                            <button required="submit" class="btn btn-primary" style="width: 100%">Login</button>


                        </form>
                        <h3 class="text-center">or</h3>
                        <a href="index.jsp"><button class="btn btn-primary" style="width: 100%">Continue as Guest</button></a>
                    </div>


                </div>
                <div id="signup" class="tab-pane fade <%if (required.equals("signup")) {%>in active <%}%>">
                    <h3 class="text-center text-muted">Create your FreeLoads account</h3>
                    <form  method="post" action="CreateUser">
                        <div class="container">


                            <div class="form-group">
                                <label for="name">Name</label>
                                <input class="form-control" type="text" name="name" id="name" required="" placeholder="Enter Your Name">
                            </div>

                            <div class="form-group">
                                <label for="email">Email</label>
                                <input class="form-control" type="email" name="email" id="email" required="" placeholder="Enter Your Email">
                            </div>

                            <div class="form-group">
                                <label for="password">Password</label>
                                <input class="form-control" type="password" name="password" id="password" required="" placeholder="Create Password">
                            </div>

                            <input required="hidden" style="display: none" name="redirect" value="<%=redirect%>">
                            <p>Have an account?<a href="<%="auth.jsp?required=login&redirect=" + redirect%>"> Log In</a></p>
                            <button required="submit" class="btn btn-primary" style="width: 100%">Sign up</button>

                        </div>
                    </form>
                </div>
            </div>
        </div>

    </body>

</html>
