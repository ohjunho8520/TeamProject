<%@ page session="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.invalidate(); // 세션 초기화
    response.sendRedirect("index.jsp"); // 로그아웃 후 메인으로 이동
%>
