<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 1. 한글 깨짐 방지
    request.setCharacterEncoding("UTF-8");

    // 2. join.jsp에서 보낸 데이터들 받아오기
    String userid = request.getParameter("userid");
    String userpw = request.getParameter("userpw");
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    // 3. DB 연결 정보
    String url = "jdbc:mysql://localhost:3306/company?serverTimezone=UTC";
    String dbid = "root";
    String dbpw = "root1234"; // 대리님 MySQL 비밀번호 확인!

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbid, dbpw);

        // 4. SQL 쿼리 작성 (member 테이블에 저장)
        // 주의: DB에 email, phone 컬럼이 미리 추가되어 있어야 합니다!
        String sql = "INSERT INTO member (userid, userpw, username, email, phone) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        
        pstmt.setString(1, userid);
        pstmt.setString(2, userpw);
        pstmt.setString(3, username);
        pstmt.setString(4, email);
        pstmt.setString(5, phone);

        // 5. 실행
        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 가입 성공 시 알림창 띄우고 로그인 페이지로 이동
%>
            <script>
                alert("회원가입이 완료되었습니다! 로그인해 주세요.");
                location.href = "login.jsp";
            </script>
<%
        }
    } catch (Exception e) {
        // 아이디 중복 등으로 에러 발생 시
        out.println("<script>alert('가입 실패: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>