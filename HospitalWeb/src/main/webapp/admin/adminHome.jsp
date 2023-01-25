<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Glavna stranica</title>
<link rel="stylesheet" href="../style.css" type="text/css" />
<link rel="icon" type="image/x-icon" href="../favicon.ico">
</head>
<body>
	<div class="left-menu">
		<ul class="nav-links">
			<li><a href="/Hospital/admin/pocetna">Glavna stranica</a></li>
			<li><a href="/Hospital/admin/unesiDoktora">Unesi doktora</a></li>
			<li><a href="/Hospital/admin/unesiDepartman">Unesi departman</a></li>
			<li><a href="/Hospital/admin/unesiSpecijalizaciju">Unesi
					specijalizaciju</a></li>
			<li><a href="/Hospital/admin/unesiLek">Unesi lekove</a></li>
			<li><a href="/Hospital/admin/unesiTehnicara">Unesi tehničara</a></li>
			<li><a href="/Hospital/admin/generisiIzvestajOPregledima">Generiši
					izveštaj o svim pregledima</a></li>
			<li><a href="/Hospital/admin/generisiIzvestajOZakazivanjima">Generiši
					izveštaj o svim zakazivanjima</a>
		</ul>
	</div>
	<div class="right-content">
		<div class="header">
			<h1>Dobrodošli na Admin stranicu!</h1>
		</div>
		<br>
		<h2>Dobrodošli na naš portal za bolnicu!</h2>
		<p>Naša bolnička zajednica je posvećena osiguravanju najvišeg
			kvalitete zdravstvene skrbi za sve naše pacijente. Naši stručnjaci su
			vrhunski u svom području i pridržavaju se najnovijih medicinskih
			standarda. Naš portal pruža pacijentima pristup informacijama o našim
			uslugama, liječnicima, pregledima i procedurama, kao i online
			rezervacijama i plaćanjima. Također, pacijenti mogu pristupiti svom
			elektroničkom kartonu i komunicirati s našim liječnicima putem naše
			sigurne online platforme. Hvala što ste odabrali našu bolnicu za
			svoje zdravstvene potrebe.</p>
		<br>
	</div>
</body>
</html>