<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doktor - Unos dijagnoze</title>
<link rel="stylesheet" href="../style.css" type="text/css">
<link rel="icon" type="image/x-icon" href="../favicon.ico">
</head>
<body>
	<div class="left-menu">
		<ul class="nav-links">
			<li><a href="/Hospital/doktor/pocetna">Glavna stranica</a></li>
			<li><a href="/Hospital/doktor/unesiSimptome">Unesi simptome</a></li>
			<li><a href="/Hospital/doktor/unesiPregled">Unesi pregled</a></li>
			<li><a href="/Hospital/doktor/unosDijagnoza">Unesi dijagnozu</a></li>
			<li><a href="/Hospital/doktor/prikaziPreglede">Prikaz
					pregleda</a></li>
			<li><a href="/Hospital/doktor/prikaziSimptome">Prikaz
					simptoma</a></li>
			<li><a href="/Hospital/auth/logout">Odjava</a></li>
		</ul>
	</div>
	<div class="right-content">
		<div class="header">
			<h1>Unos dijagnoze</h1>
		</div>
		<form action="/Hospital/doktor/sacuvajDijagnozu" method="post">
			<spring:bind path="dijagnoza.naziv">
				<input type="text" placeholder="Naziv" name="${ status.expression }"
					required>
			</spring:bind>
			<form:select items="${ simptomi }" multiple="true"
				path="dijagnoza.simptoms" itemLabel="naziv" class="select" />
			<input type="submit" value="Sačuvaj" class="button"> <input
				type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</form>
	</div>
</body>
</html>