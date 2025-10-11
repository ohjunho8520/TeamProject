<%@ page import="com.example.jolup.last.UserDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String userid = request.getParameter("userid");
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    UserDAO dao = new UserDAO();

    if (dao.isUserIdExist(userid)) {
%>
<script>
    alert("이미 사용중인 아이디입니다. 다른 아이디를 입력해주세요.");
    history.back();
</script>
<%
} else {
    boolean result = dao.registerUser(userid, password, name, email, phone);

    if(result) {

        response.sendRedirect("login.jsp"); // 회원가입 성공 → 로그인 페이지로 이동
    } else {
%>
<script>
    alert("회원가입 실패! 다시 시도해주세요.");
    history.back();
</script>
<%
        }
    }
%>
