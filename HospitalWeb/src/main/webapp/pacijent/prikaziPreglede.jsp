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
<title>Insert title here</title>
<link rel="stylesheet" href="../style.css" type="text/css" />
</head>
<body>
	<div class="wrapper">
		<div class="sidenav">
			<ul class="nav-links">
				<li><a href="/Hospital/pacijent/zakaziPregled">Zakaži
						pregled</a></li>
				<li><a href="/Hospital/pacijent/prikaziZakazivanja">Zakazivanja</a></li>
				<li><a href="/Hospital/pacijent/prikazDoktora">Svi doktori</a></li>
				<li><a href="/Hospital/pacijent/prikaziPreglede">Pregledi</a>
			</ul>
		</div>
		<div class="main">
			<h1>Prikaz pregleda</h1>
			<div class="content">
				<div class="table">
					<c:if test="${ empty pregledi }">
						<h2>Nemate preglede!</h2>
					</c:if>
					<c:if test="${ not empty pregledi }">
						<table>
							<tr>
								<th>Ime doktora</th>
								<th>Prezime doktora</th>
								<th>Tehničar</th>
								<th>Dijagonza</th>
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
			</div>
		</div>
	</div>
</body>
</html>
