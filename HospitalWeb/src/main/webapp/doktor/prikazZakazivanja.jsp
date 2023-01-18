<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
				<li><a href="/Hospital/doktor/unesiSimptome">Unesi simptome</a></li>
				<li><a href="/Hospital/doktor/unesiPregled">Unesi pregled</a></li>
				<li><a href="/Hospital/pacijent/prikazDoktora">Prikaz
						doktora</a></li>
			</ul>
		</div>
		<div class="main">
			<h1>Unos pregleda</h1>
			<div class="content">
				<div class="table">
					<c:if test="${ not empty zakazivanja }">
						<table>
							<tr>
								<th>Ime</th>
								<th>Prezime</th>
								<th>Datum</th>
								<th>Unesi pregled</th>
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
								</tr>
							</c:forEach>
						</table>
						<c:if test="${ not empty zakazivanje }">
							<h2>Odabrani pacijent: ${ zakazivanje.getPacijent().getIme() }
								${ zakazivanje.getPacijent().getPrezime() }</h2>
							<br>
							<form action="/Hospital/doktor/sacuvajPregled" method="post">
								<label>Odaberite lekove: </label><select name="lekovi" multiple
									class="select">
									<c:forEach items="${ lekovi }" var="lek">
										<option value="${ lek.getIdLek() }" class="select-items">${ lek.getNaziv() }</option>
									</c:forEach>
								</select> <br> <br> <label>Odaberite dijagnozu: </label> <select
									name="dijagnoza" class="select">
									<c:forEach items="${ dijagnoze }" var="dig">
										<option value=${ dig.getIdDijagnoza() } class="select-items">${ dig.getNaziv() }</option>
									</c:forEach>
								</select> <br> <br> <input type="submit" value="Prikaži"
									class="button"> <input type="hidden"
									name="${_csrf.parameterName}" value="${_csrf.token}">
							</form>
						</c:if>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
