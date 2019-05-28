<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />

		<title>Insert title here</title>

		<link rel="shortcut icon" href="../image/star.png" />
		<link rel="apple-touch-icon" href="../image/star.png" />
		
		<!--모바일 웹 페이지 설정 끝 -->
		<!-- [if lt IE 9]>
		<script src="../js/html5shiv.js"></script> 
		<![endif]-->
	</head>
	<body>
		<h4><c:out value="${exception.getMessage()}"></c:out></h4>
		
		<ul>
			<c:forEach items="${exception.getStackTrae()}" var="stack">
				<li><c:out value="${stack}"></c:out></li>
			</c:forEach>
		</ul>
		
	</body>
</html>