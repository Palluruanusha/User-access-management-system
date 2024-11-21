<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>Create Software</h2>
    <form action="SoftwareServlet" method="post">
        <label for="name">Software Name:</label>
        <input type="text" id="name" name="name" required><br><br>
        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="4" cols="50"></textarea><br><br>
        <label for="access_levels">Access Levels:</label><br>
        <input type="checkbox" id="read" name="access_levels" value="Read"> Read<br>
        <input type="checkbox" id="write" name="access_levels" value="Write"> Write<br>
        <input type="checkbox" id="admin" name="access_levels" value="Admin"> Admin<br><br>
        <button type="submit">Create</button>
    </form>

</body>
</html>