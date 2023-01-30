<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bolnica - Svi doktori</title>
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
			<h1>Svi lekari</h1>
		</div>
		<br>
		<c:if test="${ not empty doktori }">
			<table>
				<tr>
					<th>Ime doktora</th>
					<th>Prezime doktora</th>
					<th>Specijalizacija doktora</th>
					<th>Departman doktora</th>
				</tr>
				<c:forEach items="${ doktori }" var="dr">
					<tr>
						<td>${ dr.getIme() }</td>
						<td>${ dr.getPrezime() }</td>
						<td>${ dr.getSpecijalizacija().getNaziv() }</td>
						<td>${ dr.getDepartman().getNaziv() }</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<br>
	</div>
</body>
</html>