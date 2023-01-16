<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Unos tehnicara</h1>
	<form action="/Hospital/admin/sacuvajTehnicara" method="post">
		<label>Ime: </label>
		<spring:bind path="tehnicar.ime">
			<input type="text" name="${status.expression }" required>
		</spring:bind>
		<br> <br> <label>Prezime: </label>
		<spring:bind path="tehnicar.prezime">
			<input type="text" name="${status.expression }" required>
		</spring:bind>
		<br> <br> <label>Departman: </label> <select
			name="departman">
			<c:forEach items="${ departmani }" var="dep">
				<option value="${ dep.getIdDepartman() }">${ dep.getNaziv() }</option>
			</c:forEach>
		</select> <br> <br> <input type="submit" value="Sačuvaj"> <input
			type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<br>
	</form>
</body>
</html>