package com.socialservice.controller;

import com.socialservice.util.DBConnection;
import com.socialservice.util.Helper;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CreateUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        StringBuilder msg = new StringBuilder();

        if (!Helper.isEmpty(name, email, password)) {

            try {
                Connection connection = DBConnection.getConnection();
                if (connection != null) {

                    try {

                        String query = " insert into users (name,email,password)"
                                + " values ( ?, ?, PASSWORD(?))";

                        PreparedStatement ps = connection.prepareStatement(query,
                                Statement.RETURN_GENERATED_KEYS);

                        ps.setString(1, name);
                        ps.setString(2, email);
                        ps.setString(3, password);

                        ps.executeUpdate();

                        ResultSet rs = ps.getGeneratedKeys();

                        if (rs.next()) {
                            Helper.setCurrentUser(request, rs.getInt(1) + "", "user");
                            String redirect = request.getParameter("redirect");
                            if (redirect == null) {
                                redirect = "index.jsp";
                            }
                            response.sendRedirect(redirect);
                        } else {
                            msg.append("user not added").append("\n");
                        }

                        connection.close();

                    } catch (SQLException ex) {
                        msg.append(ex.getMessage()).append("\n");
                    }
                } else {
                    msg.append("cannot create database connection").append("\n");
                }
            } catch (IOException | ClassNotFoundException | SQLException ex) {
                msg.append(ex.getMessage()).append("\n");
            }
        } else {
            msg.append("cannot fetch values").append("\n");
        }

        if (!response.isCommitted()) {
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
