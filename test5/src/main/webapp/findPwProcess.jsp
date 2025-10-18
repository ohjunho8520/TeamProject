<%@ page import="com.example.jolup.last.UserDAO" %>
<%@ page import="com.example.jolup.last.MailUtil" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userid = request.getParameter("userid");
    String name   = request.getParameter("name");
    String email  = request.getParameter("email");
    String phone  = request.getParameter("phone");

    if (userid == null || name == null || email == null || phone == null ||
            userid.trim().isEmpty() || name.trim().isEmpty() ||
            email.trim().isEmpty() || phone.trim().isEmpty()) {
%>
<script>
    alert("아이디, 이름, 이메일, 전화번호를 모두 입력하세요.");
    history.back();
</script>
<%
        return;
    }

    userid = userid.trim();
    name   = name.trim();
    email  = email.trim();
    phone  = phone.trim();

    UserDAO dao = new UserDAO();

    // 본인 확인 (userid+name+email+phone 일치)
    boolean verified = dao.verifyUserIdentity(userid, name, email, phone);
    if (!verified) {
%>
<script>
    alert("입력하신 정보와 일치하는 사용자가 없습니다.");
    history.back();
</script>
<%
        return;
    }

    // 임시 비밀번호 (숫자 8자리, 선행 0 허용)
    String tempPw = String.format("%08d", (int)(Math.random() * 100_000_000));

    // 이메일 본문 (HTML)
    String subject = "[JOLUP] 임시 비밀번호 안내";
    String body = ""
            + "<div style='font-family:Arial,Helvetica,sans-serif; line-height:1.6;'>"
            + "  <h2>임시 비밀번호 안내</h2>"
            + "  <p>안녕하세요, <b>" + name + "</b> 님.</p>"
            + "  <p>요청하신 계정(<b>" + userid + "</b>)의 임시 비밀번호는 다음과 같습니다.</p>"
            + "  <p style='font-size:20px; font-weight:bold;'>임시 비밀번호: <code>" + tempPw + "</code></p>"
            + "  <p>보안을 위해 <b>로그인 후 반드시 비밀번호를 변경</b>해 주세요.</p>"
            + "  <hr>"
            + "  <p>※ 본 메일은 발신 전용입니다.</p>"
            + "</div>";

    try {
        // 1) 먼저 메일 발송을 시도
        MailUtil.sendMail(email, subject, body);

        // 2) 메일이 성공적으로 나갔으면 DB에 임시 비밀번호 해시로 업데이트
        boolean updated = dao.updatePasswordWithTemp(userid, tempPw);
        if (!updated) {
%>
<script>
    alert("비밀번호 갱신 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
    history.back();
</script>
<%
        return;
    }
%>
<script>
    alert("임시 비밀번호를 이메일로 발송했습니다. 로그인 후 반드시 비밀번호를 변경하세요.");
    location.href = "login.jsp";
</script>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script>
    alert("이메일 발송 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
    history.back();
</script>
<%
    }
%>
