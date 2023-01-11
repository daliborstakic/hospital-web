<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../style.css" type="text/css" />
</head>
<body>
	<h1>Jovan Miric</h1>
	<c:if test="${not empty doktori }">
		<p>Nesto ima</p>
		<table border="1">
			<c:forEach items="${ doktori }" var="doktor">
				<tr>
					<td>${ doktor.getIme() }</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>