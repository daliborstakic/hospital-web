<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doktor - Početna stranica</title>
<link rel="stylesheet" href="../style.css" type="text/css">
</head>
<body>
	<div class="left-menu">
		<ul class="nav-links">
			<li><a href="/Hospital/doktor/unesiSimptome">Unesi simptome</a></li>
			<li><a href="/Hospital/doktor/unesiPregled">Unesi pregled</a></li>
			<li><a href="/Hospital/doktor/unosDijagnoza">Unesi dijagnozu</a></li>
			<li><a href="/Hospital/doktor/prikaziPreglede">Prikaz
					pregleda</a></li>
		</ul>
	</div>
	<div class="right-content">
		<div class="header">
			<h1>Današnja zakazivanja</h1>
		</div>
		<br>
		<c:if test="${ empty zakazivanja }">
			<h3>Danas nemate zakazane preglede!</h3>
		</c:if>
		<c:if test="${ not empty zakazivanja }">
			<table>
				<tr>
					<th>Ime pacijenta</th>
					<th>Prezime pacijenta</th>
					<th>Datum</th>
				</tr>
				<c:forEach items="${ zakazivanja }" var="zakaz">
					<tr>
						<td>${ zakaz.getPacijent().getIme() }</td>
						<td>${ zakaz.getPacijent().getPrezime() }</td>
						<td>${ zakaz.getDatum() }</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<br>
		<div class="notification">
			<c:if test="${ not empty obavestenja }">
				<c:forEach items="${ obavestenja }" var="obav">
					<h2>${ obav.getPoruka() }</h2>
				</c:forEach>
				<a href="/Hospital/doktor/obrisiObavestenja">Obriši obavestenja</a>
			</c:if>
			<c:if test="${ empty obavestenja }">
				<h2>Nemate obaveštenja!</h2>
			</c:if>
		</div>
	</div>
</body>
</html>