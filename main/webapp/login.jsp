<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
<div class="login-container">
    <h2>로그인</h2>
    <form action="loginProcess.jsp" method="post">
        <input type="text" name="userid" placeholder="아이디" required>
        <input type="password" name="password" placeholder="비밀번호" required>
        <button type="submit" class="btn">로그인</button>
    </form>

    <div class="options">
        <a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a>
    </div>

    <hr>

    <div class="register">
        <p>회원가입을 하시면 다양한 서비스를 이용하실 수 있습니다.</p>
        <button class="btn" onclick="location.href='register.jsp'">회원가입</button>
    </div>
</div>
</body>
</html>