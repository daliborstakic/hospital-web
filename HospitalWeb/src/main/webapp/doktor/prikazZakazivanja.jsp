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
<title>Doktor - Unos pregleda</title>
<link rel="stylesheet" href="../style.css" type="text/css" />
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
			<h1>Unos pregleda</h1>
		</div>
		<br>
		<c:if test="${ empty zakazivanja }">
			<h2>Nemate zakazanih pregleda!</h2>
		</c:if>
		<c:if test="${ not empty zakazivanja }">
			<table>
				<tr>
					<th>Ime</th>
					<th>Prezime</th>
					<th>Datum</th>
					<th>Unesi pregled</th>
					<th>Otkaži pregled</th>
				</tr>
				<c:forEach items="${ zakazivanja }" var="zak">
					<tr>
						<td>${ zak.getPacijent().getIme() }</td>
						<td>${ zak.getPacijent().getPrezime() }</td>
						<td><p class="date">
								<fmt:formatDate type="date" value="${zak.getDatum()}" />
							</p></td>
						<td><a
							href="/Hospital/doktor/odaberiZakazivanje?idZakazivanje=${ zak.getIdZakazivanje() }">Unesi</a></td>
						<td><a
							href="/Hospital/doktor/otkaziPregled?idZakazivanje=${ zak.getIdZakazivanje() }">Otkaži</a></td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<br>
		<c:if test="${ not empty zakazivanje }">
			<h2>Odabrani pacijent: ${ zakazivanje.getPacijent().getIme() }
				${ zakazivanje.getPacijent().getPrezime() }</h2>
			<div class="form">
				<form action="/Hospital/doktor/sacuvajPregled" method="post">
					<form:select items="${ dijagnoze }" itemLabel="naziv"
						path="pregled.dijagnoza" class="select" />
					<form:select items="${ lekovi }" itemLabel="naziv" multiple="true"
						path="recept.leks" class="select" />
					<form:select items="${ tehnicari }" path="pregled.tehnicar"
						class="select" />
					<input type="date" name="date" /><input type="text"
						placeholder="Opis" name="opis"><input type="submit"
						class="button" value="Unesi" /> <input type="hidden"
						name="${_csrf.parameterName}" value="${_csrf.token}">
				</form>
			</div>
		</c:if>
	</div>
</body>
</html>
