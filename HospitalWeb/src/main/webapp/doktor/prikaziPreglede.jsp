<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doktor - Pregledi</title>
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
			<h1>Pretraga pregleda</h1>
		</div>
		<form action="/Hospital/doktor/vratiPreglede">
			<input type="text" placeholder="Pretražite pacijenta:"
				name="pretraga" required><input type="submit" class="button"
				value="Unesi" /> <input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}">
		</form>
		<c:if test="${ not empty pregledi }">
			<table>
				<tr>
					<th>Ime pacijenta</th>
					<th>Prezime pacijenta</th>
					<th>Datum pregleda</th>
					<th>Dijagnoza</th>
					<th>Tehničar</th>
					<th>Recept</th>
				</tr>
				<c:forEach items="${ pregledi }" var="pre">
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