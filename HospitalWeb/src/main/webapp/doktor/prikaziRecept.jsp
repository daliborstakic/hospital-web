<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doktor - Recept</title>
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
			<h1>Prikaz recepta</h1>
			<p>
				<b>Opis</b>: ${ recept.getOpis() }
			</p>
		</div>
		<br>
		<c:if test="${ not empty recept }">
			<table>
				<tr>
					<th>Naziv leka</th>
				</tr>
				<c:forEach items="${ recept.getLeks() }" var="lek">
					<tr>
						<td>${ lek.getNaziv() }</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
	</div>
</body>
</html>