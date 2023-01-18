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
</head>
<body>
	<h1>Unos dijagnoze</h1>
	<form action="/Hospital/doktor/sacuvajDijagnozu" method="post">
		<label>Naziv: </label>
		<spring:bind path="dijagnoza.naziv">
			<input type="text" name="${ status.expression }" required>
		</spring:bind>
		<form:select items="${ simptomi }" multiple="true"
			path="dijagnoza.simptoms" class="select" />
		<input type="submit" value="Sačuvaj"> <input type="hidden"
			name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>
</body>
</html>