package com.socialservice.controller;

import com.socialservice.util.DBConnection;
import com.socialservice.util.Helper;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateProfile extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String bio = request.getParameter("bio");
        String uid = request.getParameter("uid");
        String redirect = request.getParameter("redirect");
        StringBuilder msg = new StringBuilder();
        if (!Helper.isEmpty(name, bio, redirect,uid)) {
            try {
                String query = "UPDATE users SET name=?, bio=? WHERE uid=?";
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, name);
                ps.setString(2, bio);
                ps.setString(3, uid);
                if (ps.executeUpdate() > 0) {
                    response.sendRedirect(redirect);
                } else {
                    msg.append("Profile not updated.").append("\n");
                }
            } catch (ClassNotFoundException | SQLException ex) {
                msg.append(ex.getMessage()).append("\n");
            }
        } else {
            msg.append("Profile not updated.").append("\n");
        }
        if(!response.isCommitted()){
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
