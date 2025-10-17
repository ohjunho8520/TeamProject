<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="css/register.css">
</head>
<body>
<div class="login-container">
    <h2>회원가입</h2>
    <form action="registerProcess.jsp" method="post" onsubmit="return validateForm()">
        <!-- 아이디 -->
        <input type="text" name="userid" id="userid" placeholder="아이디" required
               maxlength="12" onkeyup="validateUserId()">
        <div class="validation-msg" id="userid-msg">영문, 숫자 8~12자</div>

        <!-- 비밀번호 -->
        <input type="password" name="password" id="password" placeholder="비밀번호" required
               maxlength="16" onkeyup="validatePassword()">
        <div class="validation-msg" id="password-msg">영문, 숫자, 특수문자 포함 8~16자</div>

        <!-- 비밀번호 확인 -->
        <input type="password" name="passwordConfirm" id="passwordConfirm"
               placeholder="비밀번호 확인" required onkeyup="validatePasswordConfirm()">
        <div class="validation-msg" id="password-confirm-msg"></div>

        <!-- 이름 -->
        <input type="text" name="name" id="name" placeholder="이름" required
               onkeyup="validateName()">
        <div class="validation-msg" id="name-msg">한글 2~10자 또는 영문 2~30자</div>

        <!-- 이메일 -->
        <div class="email-container">
            <input type="text" name="emailId" id="emailId" placeholder="이메일" required>
            <span>@</span>
            <input type="text" name="emailDomain" id="emailDomain" placeholder="직접입력" required>
            <select id="domainSelect" onchange="selectDomain()">
                <option value="">직접입력</option>
                <option value="naver.com">naver.com</option>
                <option value="daum.net">daum.net</option>
                <option value="gmail.com">gmail.com</option>
                <option value="hanmail.net">hanmail.net</option>
                <option value="kakao.com">kakao.com</option>
            </select>
        </div>

        <!-- 전화번호 -->
        <div class="phone-container">
            <input type="text" name="phone1" id="phone1" maxlength="3"
                   onkeyup="moveToNext(this, 'phone2', 3)">
            <span>-</span>
            <input type="text" name="phone2" id="phone2" maxlength="4" placeholder="0000"
                   onkeyup="moveToNext(this, 'phone3', 4)">
            <span>-</span>
            <input type="text" name="phone3" id="phone3" maxlength="4" placeholder="0000">
        </div>

        <!-- 숨겨진 필드 (실제 전송용) -->
        <input type="hidden" name="email" id="email">
        <input type="hidden" name="phone" id="phone">

        <button type="submit" class="btn">회원가입</button>
    </form>

    <div class="options">
        <a href="login.jsp">이미 계정이 있으신가요? 로그인</a>
    </div>
</div>

<script>
    // 아이디 검증
    function validateUserId() {
        const userid = document.getElementById('userid').value;
        const msg = document.getElementById('userid-msg');
        const input = document.getElementById('userid');

        // 영문, 숫자만 허용 (입력 제한)
        const cleaned = userid.replace(/[^a-zA-Z0-9]/g, '');
        if (cleaned !== userid) {
            input.value = cleaned;
            return;
        }

        if (userid.length < 8) {
            msg.textContent = '아이디는 최소 8자 이상이어야 합니다.';
            msg.className = 'validation-msg error';
            input.className = 'error';
        } else if (userid.length > 12) {
            msg.textContent = '아이디는 최대 12자까지 가능합니다.';
            msg.className = 'validation-msg error';
            input.className = 'error';
        } else if (!/^[a-zA-Z0-9]{8,12}$/.test(userid)) {
            msg.textContent = '영문과 숫자만 사용 가능합니다.';
            msg.className = 'validation-msg error';
            input.className = 'error';
        } else {
            msg.textContent = '사용 가능한 아이디입니다.';
            msg.className = 'validation-msg success';
            input.className = 'success';
        }
    }

    // 비밀번호 검증
    function validatePassword() {
        const password = document.getElementById('password').value;
        const msg = document.getElementById('password-msg');
        const input = document.getElementById('password');

        const hasLetter = /[a-zA-Z]/.test(password);
        const hasNumber = /[0-9]/.test(password);
        const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(password);

        if (password.length < 8) {
            msg.textContent = '비밀번호는 최소 8자 이상이어야 합니다.';
            msg.className = 'validation-msg error';
            input.className = 'error';
        } else if (password.length > 16) {
            msg.textContent = '비밀번호는 최대 16자까지 가능합니다.';
            msg.className = 'validation-msg error';
            input.className = 'error';
        } else if (!hasLetter || !hasNumber || !hasSpecial) {
            msg.textContent = '영문, 숫자, 특수문자를 모두 포함해야 합니다.';
            msg.className = 'validation-msg error';
            input.className = 'error';
        } else {
            msg.textContent = '안전한 비밀번호입니다.';
            msg.className = 'validation-msg success';
            input.className = 'success';
        }

        // 비밀번호 확인도 다시 검증
        if (document.getElementById('passwordConfirm').value) {
            validatePasswordConfirm();
        }
    }

    // 비밀번호 확인 검증
    function validatePasswordConfirm() {
        const password = document.getElementById('password').value;
        const passwordConfirm = document.getElementById('passwordConfirm').value;
        const msg = document.getElementById('password-confirm-msg');
        const input = document.getElementById('passwordConfirm');

        if (!passwordConfirm) {
            msg.textContent = '';
            input.className = '';
        } else if (password !== passwordConfirm) {
            msg.textContent = '비밀번호가 일치하지 않습니다.';
            msg.className = 'validation-msg error';
            input.className = 'error';
        } else {
            msg.textContent = '비밀번호가 일치합니다.';
            msg.className = 'validation-msg success';
            input.className = 'success';
        }
    }

    // 이름 검증
    function validateName() {
        const name = document.getElementById('name').value;
        const msg = document.getElementById('name-msg');
        const input = document.getElementById('name');

        const koreanPattern = /^[가-힣]{2,10}$/;
        const englishPattern = /^[a-zA-Z\s]{2,30}$/;

        if (name.length === 0) {
            msg.textContent = '한글 2~10자 또는 영문 2~30자';
            msg.className = 'validation-msg';
            input.className = '';
        } else if (koreanPattern.test(name) || englishPattern.test(name.trim())) {
            msg.textContent = '올바른 이름 형식입니다.';
            msg.className = 'validation-msg success';
            input.className = 'success';
        } else {
            msg.textContent = '한글 2~10자 또는 영문 2~30자로 입력해주세요.';
            msg.className = 'validation-msg error';
            input.className = 'error';
        }
    }

    // 이메일 도메인 선택
    function selectDomain() {
        const select = document.getElementById('domainSelect');
        const domainInput = document.getElementById('emailDomain');

        if (select.value) {
            domainInput.value = select.value;
            domainInput.readOnly = true;
        } else {
            domainInput.value = '';
            domainInput.readOnly = false;
            domainInput.focus();
        }
    }

    // 전화번호 자동 이동
    function moveToNext(current, nextId, maxLength) {
        // 숫자만 허용
        current.value = current.value.replace(/[^0-9]/g, '');

        if (current.value.length >= maxLength) {
            const nextInput = document.getElementById(nextId);
            if (nextInput) {
                nextInput.focus();
            }
        }
    }

    // 폼 전송 전 최종 검증
    function validateForm() {
        // 아이디 검증
        const userid = document.getElementById('userid').value;
        if (!/^[a-zA-Z0-9]{8,12}$/.test(userid)) {
            alert('아이디는 영문, 숫자 8~12자여야 합니다.');
            return false;
        }

        // 비밀번호 검증
        const password = document.getElementById('password').value;
        const hasLetter = /[a-zA-Z]/.test(password);
        const hasNumber = /[0-9]/.test(password);
        const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(password);

        if (password.length < 8 || password.length > 16 || !hasLetter || !hasNumber || !hasSpecial) {
            alert('비밀번호는 8~16자이며, 영문, 숫자, 특수문자를 모두 포함해야 합니다.');
            return false;
        }

        // 비밀번호 확인
        const passwordConfirm = document.getElementById('passwordConfirm').value;
        if (password !== passwordConfirm) {
            alert('비밀번호가 일치하지 않습니다.');
            return false;
        }

        // 이름 검증
        const name = document.getElementById('name').value;
        const koreanPattern = /^[가-힣]{2,10}$/;
        const englishPattern = /^[a-zA-Z\s]{2,30}$/;

        if (!koreanPattern.test(name) && !englishPattern.test(name.trim())) {
            alert('이름은 한글 2~10자 또는 영문 2~30자로 입력해주세요.');
            return false;
        }

        // 이메일 조합
        const emailId = document.getElementById('emailId').value;
        const emailDomain = document.getElementById('emailDomain').value;

        if (!emailId || !emailDomain) {
            alert('이메일을 완전히 입력해주세요.');
            return false;
        }

        const email = emailId + '@' + emailDomain;
        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (!emailPattern.test(email)) {
            alert('올바른 이메일 형식이 아닙니다.');
            return false;
        }

        document.getElementById('email').value = email;

        // 전화번호 조합
        const phone1 = document.getElementById('phone1').value;
        const phone2 = document.getElementById('phone2').value;
        const phone3 = document.getElementById('phone3').value;

        if (!phone1 || !phone2 || !phone3) {
            alert('전화번호를 모두 입력해주세요.');
            return false;
        }

        if (!/^01[016789]$/.test(phone1) || !/^\d{3,4}$/.test(phone2) || !/^\d{4}$/.test(phone3)) {
            alert('올바른 전화번호 형식이 아닙니다.');
            return false;
        }

        document.getElementById('phone').value = phone1 + '-' + phone2 + '-' + phone3;

        return true;
    }

    // 페이지 로드 시 첫 번째 전화번호 칸에 010 기본값 설정
    window.onload = function() {
        document.getElementById('phone1').value = '010';
    }
</script>
</body>
</html>