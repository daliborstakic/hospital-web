<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../style.css" type="text/css">
</head>
<body>
	<div class="wrapper">
		<div class="sidenav">
			<ul class="nav-links">
				<li><a href="/Hospital/doktor/unesiSimptome">Unos simptome</a></li>
				<li><a href="/Hospital/doktor/unesiPregled">Unos pregleda</a></li>
				<li><a href="/Hospital/doktor/unosDijagnoza">Unos dijagnozi</a></li>
			</ul>
		</div>
		<div class="main">
			<h1>Unos dijagnoze</h1>
			<div class="content">
				<form action="/Hospital/doktor/sacuvajDijagnozu" method="post">
					<label>Naziv: </label>
					<spring:bind path="dijagnoza.naziv">
						<input type="text" name="${ status.expression }" required>
					</spring:bind>
					<br> <br> <label>Simptomi: </label>
					<form:select items="${ simptomi }" multiple="true"
						path="dijagnoza.simptoms" itemLabel="naziv" class="select" />
					<br> <br> <input type="submit" value="Sačuvaj"
						class="button"> <input type="hidden"
						name="${_csrf.parameterName}" value="${_csrf.token}">
				</form>
			</div>
		</div>
	</div>
</body>
</html>