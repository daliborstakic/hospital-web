<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../style.css" type="text/css" />
</head>
<body>
	<div class="wrapper">
		<div class="sidenav">
			<ul class="nav-links">
				<li><a href="/Hospital/pacijent/zakaziPregled">Zakaži
						pregled</a></li>
				<li><a href="/Hospital/pacijent/prikaziZakazivanja">Prikaz
						zakazivanja</a></li>
				<li><a href="/Hospital/pacijent/prikazDoktora">Prikaz
						doktora</a></li>
			</ul>
		</div>
		<div class="main">
			<h1>Zakazivanje pregleda</h1>
			<div class="content">
				<div class="table">
					<form action="/Hospital/pacijent/prikaziDoktoreZaZakazivanje"
						method="get">
						<label>Odaberi specijalizaciju: </label> <select
							name="specijalizacija" class="select">
							<c:forEach items="${ specijalizacije }" var="spec">
								<option value="${ spec.getIdSpecijalizacija() }"
									class="select-items">${ spec.getNaziv() }</option>
							</c:forEach>
						</select> <input type="submit" value="Prikaži" class="button"> <input
							type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}">
					</form>
					<br>
					<c:if test="${ not empty doktori }">
						<table>
							<tr>
								<th>Ime</th>
								<th>Prezime</th>
								<th>Specijalizacija</th>
								<th>Departman</th>
								<th>Zakazivanje</th>
							</tr>
							<c:forEach items="${ doktori }" var="dr">
								<tr>
									<td>${ dr.getIme() }</td>
									<td>${ dr.getPrezime() }</td>
									<td>${ dr.getSpecijalizacija().getNaziv() }</td>
									<td>${ dr.getDepartman().getNaziv() }</td>
									<td><a
										href="/Hospital/pacijent/odaberiDoktora?idDoktor=${ dr.getIdDoktor() }">Zakaži</a></td>
								</tr>
							</c:forEach>
						</table>
					</c:if>
					<c:if test="${ not empty doktor }">
						<h2>Vaš odabrani lekar je: ${ doktor.getIme() } ${ doktor.getPrezime() }</h2>
						<form action="/Hospital/pacijent/sacuvajZakazivanje" method="post">
							<label>Datum: </label><input type="date" name="datum"> <input
								type="submit" value="Zakaži" class="button"> <input
								type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}">
						</form>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</body>
</html>