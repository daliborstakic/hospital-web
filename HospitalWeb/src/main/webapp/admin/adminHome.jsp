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
</head>
<body>
	<div class="header">
		<div class="sidenav">
			<ul class="nav-links">
				<li><a href="/Hospital/admin/unesiDoktora">Unesi doktora</a></li>
				<li><a href="/Hospital/admin/unesiDepartman">Unesi
						departman</a></li>
				<li><a href="/Hospital/admin/unesiSpecijalizaciju">Unesi
						specijalizaciju</a></li>
				<li><a href="/Hospital/admin/unesiLek">Unesi lekove</a></li>
				<li><a href="/Hospital/admin/unesiTehnicara">Unesi
						tehničara</a></li>
			</ul>
		</div>
	</div>
</body>
</html>