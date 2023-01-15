<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="s" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta charset="UTF-8" />
<title>Bolnica - Login</title>
<link rel="stylesheet" href="style.css" type="text/css" />
</head>
<body>
	<c:url var="loginUrl" value="/login" />
	<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION.message}">
		<div>
			<p>Invalid username and password.</p>
		</div>
	</c:if>
	<form action="${loginUrl}" method="post">
		<table>
			<tr>
				<td>Username</td>
				<td><input type="text" name="username"
					placeholder="Enter Username" required></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name="password"
					placeholder="Enter Password" required></td>
			</tr>
			<tr>
				<td>Remember Me:</td>
				<td><input type="checkbox" name="remember-me" /></td>
			</tr>
			<tr>
				<td><input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /></td>
				<td><input type="submit" value="Log in"></td>
			</tr>
		</table>
		Nemate nalog? <a href="/Hospital/auth/registerUser">Registrujte se</a>
	</form>
</body>
</html>