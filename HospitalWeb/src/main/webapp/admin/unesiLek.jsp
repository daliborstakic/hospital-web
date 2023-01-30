<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Unos leka</title>
<link rel="stylesheet" href="../style.css" type="text/css" />
<link rel="icon" type="image/x-icon" href="../favicon.ico">
</head>
<body>
	<div class="left-menu">
		<ul class="nav-links">
			<li><a href="/Hospital/admin/pocetna">Glavna stranica</a></li>
			<li><a href="/Hospital/admin/unesiDoktora">Unesi doktora</a></li>
			<li><a href="/Hospital/admin/unesiDepartman">Unesi departman</a></li>
			<li><a href="/Hospital/admin/unesiSpecijalizaciju">Unesi
					specijalizaciju</a></li>
			<li><a href="/Hospital/admin/unesiLek">Unesi lekove</a></li>
			<li><a href="/Hospital/admin/unesiTehnicara">Unesi tehničara</a></li>
			<li><a href="/Hospital/admin/generisiIzvestajOPregledima">Generiši
					izveštaj o svim pregledima</a></li>
			<li><a href="/Hospital/admin/generisiIzvestajOZakazivanjima">Generiši
					izveštaj o svim zakazivanjima</a>
			<li><a href="/Hospital/auth/logout">Odjava</a></li>
		</ul>
	</div>
	<div class="right-content">
		<div class="header">
			<h1>Unos leka</h1>
		</div>
		<form action="/Hospital/admin/sacuvajLek" method="post">
			<spring:bind path="lek.naziv">
				<input type="text" placeholder="Naziv" name="${ status.expression }"
					required>
			</spring:bind>
			<input type="submit" value="Sačuvaj"> <input type="hidden"
				name="${_csrf.parameterName}" value="${_csrf.token}">
		</form>
	</div>
</body>
</html>