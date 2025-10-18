<%@ page import="com.example.jolup.last.UserDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String name  = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    if (name == null || email == null || phone == null ||
            name.trim().isEmpty() || email.trim().isEmpty() || phone.trim().isEmpty()) {
%>
<script>
    alert("이름, 이메일, 전화번호를 모두 입력하세요.");
    history.back();
</script>
<%
        return;
    }

    UserDAO dao = new UserDAO();
    String userid = dao.findUserId(name.trim(), email.trim(), phone.trim());

    if (userid != null) {
%>
<script>
    alert("회원님의 아이디는 '<%= userid %>' 입니다.");
    location.href = "login.jsp";
</script>
<%
} else {
%>
<script>
    alert("일치하는 회원정보가 없습니다. 입력 내용을 다시 확인하세요.");
    history.back();
</script>
<%
    }
%>
