<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Unos specijalizacije</h1>
	<form action="/Hospital/admin/sacuvajSpecijalizaciju" method="post">
		<label>Naziv: </label>
		<spring:bind path="specijalizacija.naziv">
			<input type="text" name="${ status.expression }">
		</spring:bind>
		<input type="submit" value="Sačuvaj"> <input type="hidden"
			name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>
</body>
</html>