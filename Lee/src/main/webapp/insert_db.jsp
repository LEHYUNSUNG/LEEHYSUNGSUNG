<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 1. 한글 깨짐 방지 설정
    request.setCharacterEncoding("UTF-8");

    // 2. insert.jsp에서 보낸 데이터 받아오기 (position 추가됨)
    String name = request.getParameter("name");
    String position = request.getParameter("position"); // 추가된 부분
    String ageStr = request.getParameter("age");
    String dept = request.getParameter("dept");
    String email = request.getParameter("email");

    // 3. DB 연결 정보 (비밀번호: root1234)
    String url = "jdbc:mysql://localhost:3306/company?serverTimezone=UTC";
    String user = "root";
    String password = "root1234"; 

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 4. 드라이버 로드 및 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // 5. SQL 쿼리 수정 (position 컬럼과 ? 하나 추가)
        // 테이블 구조 순서에 맞춰서 쿼리를 작성했습니다.
        String sql = "INSERT INTO employee (name, position, age, dept, email) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        
        // ? 자리에 데이터 채우기 (순서가 매우 중요합니다!)
        pstmt.setString(1, name);
        pstmt.setString(2, position); // 2번째 물음표: 직급
        pstmt.setInt(3, Integer.parseInt(ageStr)); // 3번째 물음표: 나이
        pstmt.setString(4, dept); // 4번째 물음표: 부서
        pstmt.setString(5, email); // 5번째 물음표: 이메일

        // 6. 실행
        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 등록 성공 시 다시 목록(list.jsp)으로 이동
            response.sendRedirect("list.jsp");
        }
    } catch (Exception e) {
        // 에러 발생 시 알림창 띄우고 이전 페이지로 이동
        out.println("<script>alert('등록 실패: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        // 7. 자원 해제
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>