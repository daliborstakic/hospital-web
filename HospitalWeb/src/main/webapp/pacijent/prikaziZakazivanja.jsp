<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<c:if test="${ not empty zakazivanja }">
		<table>
			<tr>
				<th>Ime doktora</th>
				<th>Prezime doktora</th>
				<th>Specijalizacija doktora</th>
				<th>Datum</th>
				<th>Promeni termin</th>
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
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<c:if test="${ not empty zakazivanje }">
		<form action="/Hospital/pacijent/pomeriZakazivanje" method="post">
			<label>Datum: </label><input type="date" name="datum"> <input
				type="submit" value="Zakaži" class="button"> <input
				type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</form>
	</c:if>
	<c:if test="${ empty zakazivanja }">
		<h1>Nemate zakazanih pregleda.</h1>
	</c:if>
</body>
</html>