package com.jsp.requestapprove;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ApprovalServlet")
public class ApprovalServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String[] parts = action.split("_");
        String decision = parts[0]; // "approve" or "reject"
        int requestId = Integer.parseInt(parts[1]);

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/testdb", "root", "root")) {
            String sql = "UPDATE requests SET status = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, decision.equals("approve") ? "Approved" : "Rejected");
            ps.setInt(2, requestId);
            ps.executeUpdate();
            response.getWriter().write("Request " + decision + "d successfully!");
        } catch (Exception e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}

