<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta charset="UTF-8" />
<title>Bolnica - Register</title>
<link rel="stylesheet" href="style.css" type="text/css" />
</head>
<body>
	<form action="/Hospital/auth/register" method="post">
		<label>Ime: </label>
		<spring:bind path="pacijent.ime">
			<input type="text" name="${ status.expression }"
				value="${ status.value }">
			<br>
		</spring:bind>
		<label>Prezime: </label>
		<spring:bind path="pacijent.prezime">
			<input type="text" name="${ status.expression }"
				value="${ status.value }">
			<br>
		</spring:bind>
		<label>Username: </label>
		<spring:bind path="user.username">
			<input type="text" name="${ status.expression }"
				value="${ status.value }">
			<br>
		</spring:bind>
		<label>Password: </label>
		<spring:bind path="user.password">
			<input type="password" name="${ status.expression }"
				value="${ status.value }">
			<br>
		</spring:bind>
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" /> <input type="submit" value="Registruj se">
	</form>
</body>
</html>