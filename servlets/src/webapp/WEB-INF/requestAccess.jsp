<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>Request Access</h2>
    <form action="RequestServlet" method="post">
        <label for="software_name">Software Name:</label>
        <select id="software_name" name="software_name">
            <%-- Dynamically populate options from database --%>
            <% 
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/testdb", "root", "root")) {
                    String query = "SELECT id, name FROM software";
                    PreparedStatement ps = conn.prepareStatement(query);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        out.println("<option value='" + id + "'>" + name + "</option>");
                    }
                } catch (Exception e) {
                    out.println("<option>Error loading software</option>");
                }
            %>
        </select><br><br>
        <label for="access_type">Access Type:</label>
        <select id="access_type" name="access_type">
            <option value="Read">Read</option>
            <option value="Write">Write</option>
            <option value="Admin">Admin</option>
        </select><br><br>
        <label for="reason">Reason for Request:</label>
        <textarea id="reason" name="reason" rows="4" cols="50"></textarea><br><br>
        <button type="submit">Submit Request</button>
    </form>

</body>
</html>