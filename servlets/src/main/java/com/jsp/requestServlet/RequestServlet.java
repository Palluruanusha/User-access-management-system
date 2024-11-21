package com.jsp.requestServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RequestServlet")
public class RequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int softwareId = Integer.parseInt(request.getParameter("software_name"));
        String accessType = request.getParameter("access_type");
        String reason = request.getParameter("reason");
        String username = (String) request.getSession().getAttribute("username");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/testdb", "root", "root")) {
            String userQuery = "SELECT id FROM users WHERE username = ?";
            PreparedStatement userPs = conn.prepareStatement(userQuery);
            userPs.setString(1, username);
            ResultSet rs = userPs.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("id");
                String sql = "INSERT INTO requests (user_id, software_id, access_type, reason, status) VALUES (?, ?, ?, ?, 'Pending')";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ps.setInt(2, softwareId);
                ps.setString(3, accessType);
                ps.setString(4, reason);
                ps.executeUpdate();
                response.getWriter().write("Request submitted successfully!");
            }
        } catch (Exception e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}

