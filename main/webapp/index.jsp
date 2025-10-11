<%@ page session="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>전시회 소개</title>
    <!-- 외부 CSS 연결 -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<header class="top-header">
    <div class="nav">
        <%
            String userid = (String) session.getAttribute("userid");
            if (userid == null) {
        %>
        <a href="login.jsp">로그인</a>
        <a href="register.jsp">회원가입</a>
        <%
        } else {
        %>
        <span><strong><%= userid %></strong>님 환영합니다!</span>
        <a href="logout.jsp">로그아웃</a>
        <%
            }
        %>
    </div>
</header>

<div class="background">
    <div class="title">내가 갔던 전시회 사진임</div>
    <div class="info">
        From 2025 to Now<br>
        2025.10.03 - 205.10.03 | 개멋진차
    </div>
    <a href="detail.jsp" class="button">전시회 일정 보러가기</a>
</div>
</body>
</html>
