<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%-- 전송값 : ${param.searchUserID} --%>

<sql:setDataSource url="jdbc:mysql://localhost:3306/el_jstl_shop?useSSL=false&serverTimezone=Asia/Seoul&useUnicode=true&characterEncoding=UTF-8&allowPublicKeyRetrieval=true"
	driver="com.mysql.cj.jdbc.Driver" user = "root" password = "1234"  
	var="db" scope="application" />
    
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<title>Document</title>
		<link rel="stylesheet" href="/style/style.css">
		<style>
		div#wrap { width: 600px; padding: 10px; border: 3px solid #aaa; border-radius: 6px; margin: 30px auto; }
		hr { margin: 20px 0px; }		
		table {	width: 100%; border-collapse: collapse;
		} 
		table th {	background-color: rgba(0, 136, 255, 0.1);
		}
		th, td {	padding: 5px 14px; border-bottom: 1px solid #aaa;
		}
		td:nth-child(1) { 	width: 100px; text-align: center;  }
		td:nth-child(2) { 	width: 250px; }
		td:nth-child(3) { 	width: 80px;  text-align: center; }
		td:nth-child(4) { 	width: 170px; text-align: right; }
		div#searchArea {	text-align: right;	margin: 10px;
		}
		input#searchUserID { 	padding: 4px 10px 3px 4px;
		}
		button#btnSbm {	font-weight: bold; 	cursor: pointer;
		}
		</style>
	</head>
	<body>
		<div id="wrap">
			<h1>JSTL_회원 검색</h1>
			<hr>
			
EL 출력결과 : ${param.searchUserID}

<c:if test="${param.searchUserID != '' || param.searchUserID != null}">
	${"1"}
	<sql:query var="lists" dataSource="${db}">
		select num, userID, userAge, joinTM from memberList where userID like ? order by num desc
		<sql:param value="%${param.searchUserID}%" />
	</sql:query>
	
</c:if>

<c:if test="${param.searchUserID == '' || param.searchUserID == null}">

	${"2"}
	<sql:query var="lists" dataSource="${db}">
		 <%-- 쿼리문 작성 --%>
		 select num, userID, userAge, joinTM from memberList order by num desc
	</sql:query>
	
</c:if>
			

			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>ID</th>
						<th>Age</th>
						<th>가입 시간</th>
					</tr>
				</thead>
				<tbody>
<c:forEach var="memberList" items="${lists.rows}">
					<tr>
						<td>${memberList.num}</td>	
						<td>${memberList.userID}</td>
						<td>${memberList.userAge}</td>
						<td>
						<fmt:formatDate value="${memberList.joinTM}"
							type="date" pattern="yyyy-MM-dd" />
						</td>
					</tr>
</c:forEach>		
				</tbody>
			</table>
			<div id="searchArea">
				<label>
					<span>ID 조회</span>
					<input type="text" size="12" id="searchUserID" 
					name="searchUserID" form="searchForm" value="${param.searchUserID}">
				</label>
				<button type="button" id="btnSbm" form="searchForm">검색</button>
			</div>
			
		</div>
		<!-- div#wrap -->
		<form id="searchForm"></form>
		<script src="https://code.jquery.com/jquery-3.6.4.js"
				integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="
				crossorigin="anonymous"></script>
		<script>
		$(function(){
			
			$("#btnSbm").click(function(){
				$("#searchForm").submit();
			});
			

		});
		</script>
	</body>
</html>