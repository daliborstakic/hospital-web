<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../style.css" type="text/css" />
</head>
<body>
	<c:if test="${ not empty doktori }">
		<table>
			<tr>
				<th>Ime doktora</th>
				<th>Prezime doktora</th>
				<th>Specijalizacija doktora</th>
				<th>Departman doktora</th>
				<th>Omiljeni</th>
			</tr>
			<c:forEach items="${ doktori }" var="dr">
				<tr>
					<td>${ dr.getIme() }</td>
					<td>${ dr.getPrezime() }</td>
					<td>${ dr.getSpecijalizacija().getNaziv() }</td>
					<td>${ dr.getDepartman().getNaziv() }</td>
					<td><a
						href="/Hospital/pacijent/omiljenDoktor?idDoktor=${ dr.getIdDoktor() }">Omiljeni</a></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>