<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 1. 한글 깨짐 방지 및 파라미터 수집
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id"); // 수정할 사원의 실제 DB ID
    String baseSalary = request.getParameter("base_salary");
    String bonus = request.getParameter("bonus");
    String mealAllowance = request.getParameter("meal_allowance");

    // 2. DB 연결 정보
    String url = "jdbc:mysql://localhost:3306/company?serverTimezone=UTC";
    String dbUser = "root";
    String dbPass = "root1234";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 3. 드라이버 로드 및 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPass);

        // 4. SQL 쿼리 작성 (해당 사원의 연봉 정보를 업데이트)
        // 테이블에 컬럼이 없다면 ALTER TABLE로 미리 추가해두어야 합니다!
        String sql = "UPDATE employee SET salary = ?, bonus = ?, meal_allowance = ? WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        
        pstmt.setString(1, baseSalary);
        pstmt.setString(2, bonus);
        pstmt.setString(3, mealAllowance);
        pstmt.setString(4, id);

        // 5. 실행
        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 성공 시 알림창 후 목록으로 이동
%>
            <script>
                alert("연봉 정보가 성공적으로 반영되었습니다.");
                location.href = "list.jsp";
            </script>
<%
        }
    } catch (Exception e) {
        // 오류 발생 시 메시지 출력
        out.println("<script>alert('저장 중 오류 발생: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        // 6. 자원 해제
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>