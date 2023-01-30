<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pacijent - Recept</title>
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
			<h1>Prikaz recepta</h1>
		</div>
		<p>Opis: ${ recept.getOpis() }</p>
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