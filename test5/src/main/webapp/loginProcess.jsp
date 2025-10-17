<%@ page import="com.example.jolup.last.UserDAO" %>
<%@ page session="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String userid = request.getParameter("userid");
    String password = request.getParameter("password");

    UserDAO dao = new UserDAO();
    boolean result = dao.loginUser(userid, password);

    if(result) {
        session.setAttribute("userid", userid); // 세션 저장
        response.sendRedirect("index.jsp"); // 성공 → 메인으로
    } else {
%>
<script>
    alert("로그인 실패! 아이디와 비밀번호를 확인하세요.");
    history.back();
</script>
<%
    }
%>
