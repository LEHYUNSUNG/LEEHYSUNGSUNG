<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String userid = request.getParameter("userid");
    String userpw = request.getParameter("userpw");

    String url = "jdbc:mysql://localhost:3306/company?serverTimezone=UTC";
    String dbid = "root";
    String dbpw = "root1234";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, dbid, dbpw);
        
        String sql = "SELECT username FROM member WHERE userid=? AND userpw=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userid);
        pstmt.setString(2, userpw);
        
        ResultSet rs = pstmt.executeQuery();

        if(rs.next()) {
            // 로그인 성공: 세션에 이름 저장
            session.setAttribute("userName", rs.getString("username"));
            session.setAttribute("userId", userid);
            response.sendRedirect("main.jsp");
        } else {
            // 로그인 실패
            out.println("<script>alert('아이디 또는 비밀번호가 틀립니다.'); history.back();</script>");
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
%>