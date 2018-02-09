package com.socialservice.controller;

import com.socialservice.util.DBConnection;
import com.socialservice.util.Helper;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Authenticate extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        StringBuilder msg = new StringBuilder();
        try {

            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (email.equals("admin") && password.equals("admin")) {

                Helper.setCurrentUser(request, "-1", "admin");
            } else {

                String query = "select uid,email,password from users where email = '" + email + "' and password = PASSWORD('" + password + "')";
                Connection con = DBConnection.getConnection();

                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(query);
                if (rs.next()) {

                    Helper.setCurrentUser(request, rs.getInt(1) + "", "user");

                } else {
                    msg.append("Email or Password is wrong");
                    response.sendRedirect("auth.jsp?required=login&msg=" + msg);
                }
            }
            String redirect = request.getParameter("redirect");
            if (redirect == null) {
                redirect = "index.jsp";
            }
            if(!response.isCommitted())
                response.sendRedirect(redirect);

        } catch (IOException | ClassNotFoundException | SQLException ex) {
            msg.append(ex.getMessage()).append("\n");
            response.sendRedirect("error.jsp?" + msg);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}
