<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>Pending Requests</h2>
    <form action="ApprovalServlet" method="post">
        <% 
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/testdb", "root", "root")) {
                String query = "SELECT r.id, u.username, s.name, r.access_type, r.reason FROM requests r "
                             + "JOIN users u ON r.user_id = u.id "
                             + "JOIN software s ON r.software_id = s.id "
                             + "WHERE r.status = 'Pending'";
                PreparedStatement ps = conn.prepareStatement(query);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String username = rs.getString("username");
                    String softwareName = rs.getString("name");
                    String accessType = rs.getString("access_type");
                    String reason = rs.getString("reason");
                    out.println("<div>");
                    out.println("<p><b>User:</b> " + username + "</p>");
                    out.println("<p><b>Software:</b> " + softwareName + "</p>");
                    out.println("<p><b>Access Type:</b> " + accessType + "</p>");
                    out.println("<p><b>Reason:</b> " + reason + "</p>");
                    out.println("<button name='action' value='approve_" + id + "'>Approve</button>");
                    out.println("<button name='action' value='reject_" + id + "'>Reject</button>");
                    out.println("</div><hr>");
                }
            }
        %>
    </form>

</body>
</html>