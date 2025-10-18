<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기</title>
    <link rel="stylesheet" href="css/register.css"><!-- 기존 스타일 재사용 -->
    <style>
        .login-container { max-width: 420px; }
        .field { margin-bottom: 12px; }
        .field input { width: 100%; padding: 10px; box-sizing: border-box; }
        .btn { width: 100%; padding: 12px; cursor: pointer; }
        .options { margin-top: 10px; text-align:center; }
    </style>
</head>
<body>
<div class="login-container">
    <h2>아이디 찾기</h2>
    <form action="findIdProcess.jsp" method="post" onsubmit="return validateFindId()">
        <div class="field">
            <input type="text" name="name" id="name" placeholder="이름(실명)" required maxlength="30">
        </div>
        <div class="field">
            <input type="email" name="email" id="email" placeholder="이메일" required maxlength="100">
        </div>
        <div class="field">
            <input type="text" name="phone" id="phone" placeholder="전화번호 (예: 010-1234-5678)" required maxlength="20">
        </div>
        <button type="submit" class="btn">아이디 찾기</button>
    </form>
    <div class="options">
        <a href="login.jsp">로그인으로 돌아가기</a>
    </div>
</div>

<script>
    function validateFindId() {
        const name  = document.getElementById('name').value.trim();
        const email = document.getElementById('email').value.trim();
        const phone = document.getElementById('phone').value.trim();

        if (!name || !email || !phone) {
            alert('이름, 이메일, 전화번호를 모두 입력하세요.');
            return false;
        }
        // 아주 가벼운 포맷 체크 (필요 없으면 제거 가능)
        const phoneOk = /^[0-9\\-]{9,20}$/.test(phone);
        if (!phoneOk) {
            alert('전화번호 형식을 확인하세요. 예) 010-1234-5678');
            return false;
        }
        return true;
    }
</script>
</body>
</html>
