<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pacijent - Glavna stranica</title>
<link rel="stylesheet" href="../style.css" type="text/css" />
<link rel="icon" type="image/x-icon" href="../favicon.ico">
</head>
<body>
	<div class="left-menu">
		<ul class="nav-links">
			<li><a href="/Hospital/pacijent/pocetna">Glavna stranica</a></li>
			<li><a href="/Hospital/pacijent/zakaziPregled">Zakaži
					pregled</a></li>
			<li><a href="/Hospital/pacijent/prikaziZakazivanja">Zakazivanja</a></li>
			<li><a href="/Hospital/pacijent/prikaziPreglede">Pregledi</a>
			<li><a href="/Hospital/auth/logout">Odjava</a></li>
		</ul>
	</div>
	<div class="right-content">
		<div class="header">
			<h1>Omiljeni doktori</h1>
		</div>
		<br>
		<c:if test="${ not empty omiljeni }">
			<table>
				<tr>
					<th>Ime doktora</th>
					<th>Prezime doktora</th>
					<th>Specijalizacija doktora</th>
					<th>Departman doktora</th>
					<th>Brzo zakazivanje</th>
				</tr>
				<c:forEach items="${ omiljeni }" var="omilj">
					<tr>
						<td>${ omilj.getDoktor().getIme() }</td>
						<td>${ omilj.getDoktor().getPrezime() }</td>
						<td>${ omilj.getDoktor().getSpecijalizacija().getNaziv() }</td>
						<td>${ omilj.getDoktor().getDepartman().getNaziv() }</td>
						<td><a
							href="/Hospital/pacijent/odaberiDoktora?idDoktor=${ omilj.getDoktor().getIdDoktor() }">Zakaži</a></td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<br>
		<div class="notification">
			<c:if test="${ not empty obavestenja }">
				<c:forEach items="${ obavestenja }" var="obav">
					<h2>${ obav.getPoruka() }</h2>
				</c:forEach>
				<br>
				<a href="/Hospital/pacijent/obrisiObavestenja">Obriši
					obavestenja</a>
			</c:if>
			<br>
			<c:if test="${ empty obavestenja }">
				<h2>Nemate obaveštenja!</h2>
			</c:if>
		</div>
	</div>
</body>
</html>