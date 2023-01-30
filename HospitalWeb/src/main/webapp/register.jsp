<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="icon" type="image/x-icon" href="favicon.ico">
<html>
<head>
<meta charset="UTF-8" />
<title>Bolnica - Register</title>
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
		<div class="header">
			<h1>Register</h1>
		</div>
		<form action="/Hospital/auth/register" method="post">
			<spring:bind path="pacijent.ime">
				<input type="text" placeholder="Ime" name="${ status.expression }"
					value="${ status.value }" required>
			</spring:bind>
			<spring:bind path="pacijent.prezime">
				<input type="text" placeholder="Prezime"
					name="${ status.expression }" value="${ status.value }" required>
			</spring:bind>
			<spring:bind path="user.username">
				<input type="text" placeholder="Username"
					name="${ status.expression }" value="${ status.value }" required>
			</spring:bind>
			<spring:bind path="user.password">
				<input type="password" placeholder="Password"
					name="${ status.expression }" value="${ status.value }" required>
			</spring:bind>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input type="submit" value="Registruj se">
			Imate nalog? <a href="/Hospital/auth/loginPage">Ulogujte se</a>
		</form>
	</div>
</body>
</html>