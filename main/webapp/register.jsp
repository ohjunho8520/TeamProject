<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
<div class="login-container">
    <h2>회원가입</h2>
    <form action="registerProcess.jsp" method="post">
        <input type="text" name="userid" placeholder="아이디" required>
        <input type="password" name="password" placeholder="비밀번호" required>
        <input type="password" name="passwordConfirm" placeholder="비밀번호 확인" required>
        <input type="text" name="name" placeholder="이름" required>
        <input type="email" name="email" placeholder="이메일" required>
        <input type="tel" name="phone" placeholder="전화번호 (예: 010-1234-5678)" required>

        <button type="submit" class="btn">회원가입</button>
    </form>

    <div class="options">
        <a href="login.jsp">이미 계정이 있으신가요? 로그인</a>
    </div>
</div>
</body>
</html>
