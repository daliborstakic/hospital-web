<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/Hospital/pacijent/sacuvajZakazivanje" method="post">
		<label>Datum: </label> <input type="date" name="datum"> ${ idDoktor }
		<input type="submit" value="Sačuvaj"><input type="hidden"
			name="idDoktor" value="${ idDoktor }"><input type="hidden"
			name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>
</body>
</html>