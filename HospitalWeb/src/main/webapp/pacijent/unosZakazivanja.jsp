<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pacijent - Zakazivanje</title>
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
			<h1>Zakazivanje pregleda</h1>
		</div>
		<form action="/Hospital/pacijent/prikaziDoktoreZaZakazivanje"
			method="get">
			<select name="specijalizacija" class="select">
				<c:forEach items="${ specijalizacije }" var="spec">
					<option value="${ spec.getIdSpecijalizacija() }"
						class="select-items">${ spec.getNaziv() }</option>
				</c:forEach>
			</select> <input type="submit" value="Prikaži" class="button"> <input
				type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</form>
		<c:if test="${ not empty doktori }">
			<table>
				<tr>
					<th>Ime</th>
					<th>Prezime</th>
					<th>Specijalizacija</th>
					<th>Departman</th>
					<th>Zakazivanje</th>
					<th>Omiljeni</th>
				</tr>
				<c:forEach items="${ doktori }" var="dr">
					<tr>
						<td>${ dr.getIme() }</td>
						<td>${ dr.getPrezime() }</td>
						<td>${ dr.getSpecijalizacija().getNaziv() }</td>
						<td>${ dr.getDepartman().getNaziv() }</td>
						<td><a
							href="/Hospital/pacijent/odaberiDoktora?idDoktor=${ dr.getIdDoktor() }">Zakaži</a></td>
						<td><a
							href="/Hospital/pacijent/omiljenDoktor?idDoktor=${ dr.getIdDoktor() }">Omiljeni</a></td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<br>
		<c:if test="${ not empty doktor }">
			<h2>Vaš odabrani lekar je: ${ doktor.getIme() } ${ doktor.getPrezime() }</h2>
			<form action="/Hospital/pacijent/sacuvajZakazivanje" method="post">
				<input type="date" name="datum"> <input type="submit"
					value="Zakaži" class="button"> <input type="hidden"
					name="${_csrf.parameterName}" value="${_csrf.token}">
			</form>
		</c:if>
	</div>
</body>
</html>