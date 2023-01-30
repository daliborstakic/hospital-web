<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pacijent - Pregledi</title>
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
			<h1>Prikaz pregleda</h1>
		</div>
		<br>
		<c:if test="${ empty pregledi }">
			<h2>Nemate preglede!</h2>
		</c:if>
		<c:if test="${ not empty pregledi }">
			<table>
				<tr>
					<th>Ime doktora</th>
					<th>Prezime doktora</th>
					<th>Tehničar</th>
					<th>Dijagnoza</th>
					<th>Datum pregleda</th>
					<th>Recept</th>
				</tr>
				<c:forEach items="${ pregledi }" var="pre">
					<tr>
						<td>${ pre.getDoktor().getIme() }</td>
						<td>${ pre.getDoktor().getPrezime() }</td>
						<td>${ pre.getTehnicar().getIme() }&nbsp;${ pre.getTehnicar().getPrezime() }</td>
						<td>${ pre.getDijagnoza().getNaziv() }</td>
						<td><p class="date">
								<fmt:formatDate type="date" value="${pre.getDatum()}" />
							</p></td>
						<td><a
							href="/Hospital/pacijent/prikaziRecept?idRecept=${ pre.getRecept().getIdRecept() }">Recept</a></td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
	</div>
</body>
</html>
