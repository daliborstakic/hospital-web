<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doktor - Simptomi</title>
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
			<h1>Prikaz simptoma</h1>
		</div>
		<form action="/Hospital/doktor/pretraziDijagnoze">
			<form:select items="${ simptomi }" itemLabel="naziv"
				path="dijagnoza.simptoms" multiple="true" />
			<input type="submit" class="button" value="Prikaži" /> <input
				type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</form>
		<c:if test="${ not empty dijagnoze }">
			<table>
				<tr>
					<th>Naziv</th>
					<th>Pregledi</th>
				</tr>
				<c:forEach items="${ dijagnoze }" var="dijag">
					<tr>
						<td>${ dijag.getNaziv() }</td>
						<td><a
							href="/Hospital/doktor/prikaziPregledeDijagnoze?idDijagnoza=${ dijag.getIdDijagnoza() }">Pregledi</a></td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<br>
		<c:if test="${ not empty odabranaDijagnoza }">
			<div class="header">
				<h2>Odabrali ste: ${ odabranaDijagnoza.getNaziv() }</h2>
			</div>
			<br>
			<table>
				<tr>
					<th>Ime pacijenta</th>
					<th>Prezime pacijenta</th>
					<th>Datum pregleda</th>
					<th>Dijagnoza</th>
					<th>Tehničar</th>
					<th>Recept</th>
				</tr>
				<c:forEach items="${ odabranaDijagnoza.pregleds }" var="pre">
					<tr>
						<td>${ pre.getPacijent().getIme() }</td>
						<td>${ pre.getPacijent().getPrezime() }</td>
						<td><p class="date">
								<fmt:formatDate type="date" value="${pre.getDatum()}" />
							</p></td>
						<td>${ pre.getDijagnoza().getNaziv() }</td>
						<td>${ pre.getTehnicar().getIme() }&nbsp;${ pre.getTehnicar().getPrezime() }</td>
						<td><a
							href="/Hospital/doktor/prikaziRecept?idRecept=${ pre.getRecept().getIdRecept() }">Detalji</a></td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
	</div>
</body>
</html>