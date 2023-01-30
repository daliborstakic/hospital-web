<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="s" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta charset="UTF-8" />
<title>Bolnica - Login</title>
<link rel="stylesheet" href="../style.css" type="text/css" />
<link rel="icon" type="image/x-icon" href="../favicon.ico">
</head>
<body>
	<div class="left-menu">
		<ul class="nav-links">
			<li><a href="/Hospital/">Glavna stranica</a></li>
			<li><a href="/Hospital/auth/prikazDoktora">Svi doktori</a></li>
			<li><a href="/Hospital/auth/loginPage">Ulogujte se</a>
		</ul>
	</div>
	<div class="right-content">
		<c:url var="loginUrl" value="/login" />
		<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION.message}">
			<div>
				<p>Invalid username and password.</p>
			</div>
		</c:if>
		<div class="header">
			<h1>Login</h1>
		</div>
		<form action="${loginUrl}" method="post">
			<input type="text" name="username" placeholder="Enter Username"
				required><input type="password" name="password"
				placeholder="Enter Password" required><input type="hidden"
				name="${_csrf.parameterName}" value="${_csrf.token}" /><input
				type="submit" value="Log in" class="button"> <br>
			Nemate nalog? <a href="/Hospital/auth/registerUser">Registrujte
				se</a>
		</form>
	</div>
</body>
</html>