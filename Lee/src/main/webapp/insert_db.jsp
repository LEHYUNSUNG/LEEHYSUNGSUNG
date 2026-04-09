<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 1. 한글 깨짐 방지 설정
    request.setCharacterEncoding("UTF-8");

    // 2. insert.jsp에서 보낸 데이터 받아오기
    String name = request.getParameter("name");
    String ageStr = request.getParameter("age");
    String dept = request.getParameter("dept");
    String email = request.getParameter("email");

    // 3. DB 연결 정보 (비밀번호 확인!)
    String url = "jdbc:mysql://localhost:3306/company?serverTimezone=UTC";
    String user = "root";
    String password = "root1234"; // 대리님 MySQL 비번

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 4. 드라이버 로드 및 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // 5. SQL 쿼리 작성 (PreparedStatement 사용 - 보안 및 오타 방지)
        String sql = "INSERT INTO employee (name, age, dept, email) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        
        // ? 자리에 데이터 채우기
        pstmt.setString(1, name);
        pstmt.setInt(2, Integer.parseInt(ageStr));
        pstmt.setString(3, dept);
        pstmt.setString(4, email);

        // 6. 실행
        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 등록 성공 시 다시 목록(list.jsp)으로 이동
            response.sendRedirect("list.jsp");
        }
    } catch (Exception e) {
        out.println("<script>alert('등록 실패: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>