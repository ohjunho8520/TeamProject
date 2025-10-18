<%@ page import="com.example.jolup.last.UserDAO" %>
<%@ page import="com.example.jolup.last.ValidationUtil" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    // 파라미터 받기
    String userid = request.getParameter("userid");
    String password = request.getParameter("password");
    String passwordConfirm = request.getParameter("passwordConfirm");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    // 서버사이드 검증
    StringBuilder errorMsg = new StringBuilder();
    boolean hasError = false;

    // 아이디 검증
    if (!ValidationUtil.isValidUserId(userid)) {
        errorMsg.append("아이디는 영문, 숫자 8~12자여야 합니다.\\n");
        hasError = true;
    }

    // 비밀번호 검증
    if (!ValidationUtil.isValidPassword(password)) {
        errorMsg.append("비밀번호는 8~16자이며, 영문, 숫자, 특수문자를 모두 포함해야 합니다.\\n");
        hasError = true;
    }

    // 비밀번호 확인
    if (!password.equals(passwordConfirm)) {
        errorMsg.append("비밀번호가 일치하지 않습니다.\\n");
        hasError = true;
    }

    // 이름 검증
    if (!ValidationUtil.isValidName(name)) {
        errorMsg.append("이름은 한글 2~10자 또는 영문 2~30자로 입력해주세요.\\n");
        hasError = true;
    }

    // 이메일 검증
    if (!ValidationUtil.isValidEmail(email)) {
        errorMsg.append("올바른 이메일 형식이 아닙니다.\\n");
        hasError = true;
    }

    // 전화번호 검증
    if (!ValidationUtil.isValidPhone(phone)) {
        errorMsg.append("올바른 전화번호 형식이 아닙니다.\\n");
        hasError = true;
    }

    // SQL Injection 체크 (추가 보안)
    if (ValidationUtil.containsSqlSpecialChars(userid) ||
            ValidationUtil.containsSqlSpecialChars(name)) {
        errorMsg.append("입력값에 허용되지 않는 문자가 포함되어 있습니다.\\n");
        hasError = true;
    }

    // 에러가 있으면 이전 페이지로
    if (hasError) {
%>
<script>
    alert("<%= errorMsg.toString() %>");
    history.back();
</script>
<%
        return;
    }

    // XSS 방지를 위한 이스케이프 처리
    name = ValidationUtil.escapeHtml(name);

    // DAO를 통한 회원가입 처리
    UserDAO dao = new UserDAO();

    // 아이디 중복 체크
    if (dao.isUserIdExist(userid)) {
%>
<script>
    alert("이미 사용중인 아이디입니다. 다른 아이디를 입력해주세요.");
    history.back();
</script>
<%
} else {
    // 회원가입 시도
    boolean result = dao.registerUser(userid, password, name, email, phone);

    if(result) {
        // 성공 시 세션에 메시지 저장 (선택사항)
        session.setAttribute("registerSuccess", "회원가입이 완료되었습니다. 로그인해주세요.");
%>
<script>
    alert("회원가입이 성공적으로 완료되었습니다!");
    location.href = "login.jsp";
</script>
<%
} else {
%>
<script>
    alert("회원가입 중 오류가 발생했습니다. 다시 시도해주세요.");
    history.back();
</script>
<%
        }
    }
%>