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
	<div class="wrapper">
		<div class="sidenav">
			<ul class="nav-links">
				<li><a href="/Hospital/doktor/unesiSimptome">Unos simptome</a></li>
				<li><a href="/Hospital/doktor/unesiPregled">Unos pregleda</a></li>
				<li><a href="/Hospital/doktor/unosDijagnoza">Unos dijagnozi</a></li>
				<li><a href="/Hospital/doktor/prikaziPreglede">Prikaz
						pregleda</a></li>
			</ul>
		</div>
		<div class="main">
			<h1>Pretraga pregleda</h1>
			<div class="content">
				<div class="table">
					<div class="form">
						<form action="/Hospital/doktor/vratiPreglede">
							<div class="input-field">
								<label>Pretražite pacijenta: </label><input type="text"
									name="pretraga" class="input">&nbsp;<input
									type="submit" class="button" value="Unesi" /> <input
									type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}">
							</div>
						</form>
					</div>
					<br>
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
			</div>
		</div>
	</div>
</body>
</html>