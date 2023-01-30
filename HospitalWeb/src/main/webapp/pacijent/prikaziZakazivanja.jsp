<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pacijent - Zakazivanja</title>
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
			<h1>Prikaz zakazivanja</h1>
		</div>
		<br>
		<c:if test="${ not empty zakazivanja }">
			<table>
				<tr>
					<th>Ime doktora</th>
					<th>Prezime doktora</th>
					<th>Specijalizacija doktora</th>
					<th>Datum</th>
					<th>Promeni termin</th>
					<th>Otkaži</th>
				</tr>
				<c:forEach items="${ zakazivanja }" var="zak">
					<tr>
						<td>${ zak.getDoktor().getIme() }</td>
						<td>${ zak.getDoktor().getPrezime() }</td>
						<td>${ zak.getDoktor().getSpecijalizacija().getNaziv() }</td>
						<td><p class="date">
								<fmt:formatDate type="date" value="${zak.getDatum()}" />
							</p></td>
						<td><a
							href="/Hospital/pacijent/odaberiZakazivanje?idZakazivanje=${ zak.getIdZakazivanje() }">Izmeni</a></td>
						<td><a
							href="/Hospital/pacijent/otkaziZakazivanje?idZakazivanje=${ zak.getIdZakazivanje() }">Otkaži</a>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<c:if test="${ not empty zakazivanje }">
			<form action="/Hospital/pacijent/pomeriZakazivanje" method="post">
				<%
				String now = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

				out.print("<input type=\"date\" name=\"datum\" min=\"" + now + "\"/>");
				%>
				<input type="submit" value="Zakaži" class="button"> <input
					type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			</form>
		</c:if>
		<c:if test="${ empty zakazivanja }">
			<h1>Nemate zakazanih pregleda.</h1>
		</c:if>
	</div>
</body>
</html>