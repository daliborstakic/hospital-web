<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Unos tehničara</title>
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
		</ul>
	</div>
	<div class="right-content">
		<div class="header">
			<h1>Unos tehničara</h1>
		</div>
		<form action="/Hospital/admin/sacuvajTehnicara" method="post">
			<spring:bind path="tehnicar.ime">
				<input type="text" placeholder="Ime" name="${status.expression }"
					required>
			</spring:bind>
			<spring:bind path="tehnicar.prezime">
				<input type="text" placeholder="Prezime"
					name="${status.expression }" required>
			</spring:bind>
			<select name="departman">
				<c:forEach items="${ departmani }" var="dep">
					<option value="${ dep.getIdDepartman() }">${ dep.getNaziv() }</option>
				</c:forEach>
			</select><input type="submit" value="Sačuvaj"> <input type="hidden"
				name="${_csrf.parameterName}" value="${_csrf.token}"> <br>
		</form>
	</div>
</body>
</html>