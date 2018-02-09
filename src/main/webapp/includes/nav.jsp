<%-- 
    Document   : nav.jsp
    Created on : 6 Dec, 2017, 3:24:13 PM
    Author     : GOWVIK
--%>

<%@page import="com.socialservice.util.Helper"%>
<%@page import="com.socialservice.bean.User"%>
<%@page import="com.socialservice.util.DBActions"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body style="width: 100%" >
        <nav class="navbar navbar-inverse navbar-static-top" role="navigation" >
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" style="color: #FFF "href="index.jsp"><%=Helper.getTitle()%></a>
                </div>
                <ul class="nav navbar-nav navbar-right" role="navigation" style="background-color: #000">

                    <%

                        String userId = Helper.getCurrentUser(request);

                        if (userId != null) {
                            DBActions actions = new DBActions();
                            User user = actions.getUser(userId);
                            if (user != null || userId.equals("-1")) {
                    %>


                    <%if (userId.equals("-1")) {%>
                    <li>
                        <a>
                            <span class="glyphicon glyphicon-user"></span> Admin
                        </a>
                    </li>
                    <li>
                        <a href="post-request.jsp">
                            <span class="glyphicon glyphicon-dashboard"></span> Post Request
                        </a>
                    </li>
                    <%} else {%>
                    <li>
                        <a href="<%="profile.jsp?uid=" + userId%>">
                            <span class="glyphicon glyphicon-user"></span> <%= user.getName()%> 
                        </a>

                    </li>
                    <%}%>
                    <li>
                        <a href="logout.jsp">
                            <span class="glyphicon glyphicon-log-out"></span> Log out
                        </a>
                    </li>

                    <%}
                    } else {%>
                    <li>
                        <a>
                            <span class="glyphicon glyphicon-user"></span> Guest</a>

                    </li>
                    <li><a href="auth.jsp?required=signup" style="width:auto;"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
                    <li><a href="auth.jsp?required=login" style="width:auto;"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                        <%}%>
                </ul>
            </div>
        </nav>





    </body>
    <style>
        /* Full-width input fields */
        input[required=text], input[required=password] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        /* Set a style for all buttons */
        button {
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 100%;
        }

        /* Extra styles for the cancel button */
        .cancelbtn {
            padding: 14px 20px;
            background-color: #f44336;
        }

        /* Float cancel and signup buttons and add an equal width */
        .cancelbtn,.signupbtn {float:left;width:50%}

        /* Add padding to container elements */
        .custom_container {
            padding: 16px;
        }

        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            padding-top: 60px;
        }

        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
            border: 1px solid #888;
            width: 80%; /* Could be more or less, depending on screen size */
        }

        /* The Close Button (x) */
        .close {
            position: absolute;
            right: 35px;
            top: 15px;
            color: #000;
            font-size: 40px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: red;
            cursor: pointer;
        }

        /* Clear floats */
        .clearfix::after {
            content: "";
            clear: both;
            display: table;
        }

        /* Change styles for cancel button and signup button on extra small screens */
        @media screen and (max-width: 300px) {
            .cancelbtn, .signupbtn {
                width: 100%;
            }
        }
    </style>

</html>
