<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 1. 세션에서 로그인된 아이디 가져오기
    String userid = (String)session.getAttribute("userId");

    if(userid == null) {
        out.println("<script>alert('로그인 후 이용해주세요.'); location.href='login.jsp';</script>");
        return;
    }

    // 2. DB 연결 정보
    String url = "jdbc:mysql://localhost:3306/company?serverTimezone=UTC";
    String dbid = "root";
    String dbpw = "root1234"; 

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbid, dbpw);

        // 3. 회원 삭제 쿼리 실행
        String sql = "DELETE FROM member WHERE userid = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userid);
        
        int result = pstmt.executeUpdate();

        if(result > 0) {
            // 4. 탈퇴 성공 시 세션 삭제(로그아웃) 후 메인으로 이동
            session.invalidate();
%>
            <script>
                alert("회원 탈퇴가 정상적으로 처리되었습니다. 그동안 이용해주셔서 감사합니다.");
                location.href = "list.jsp";
            </script>
<%
        }
    } catch (Exception e) {
        out.println("<script>alert('탈퇴 처리 중 오류 발생: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if(pstmt != null) pstmt.close();
        if(conn != null) conn.close();
    }
%>