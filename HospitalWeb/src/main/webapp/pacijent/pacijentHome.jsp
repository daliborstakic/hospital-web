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
			<h1>Omiljeni doktori</h1>
			<div class="content">
				<c:if test="${ not empty omiljeni }">
					<div class="table">
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
					</div>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>