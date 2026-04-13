<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 1. list.jsp의 체크박스에서 보낸 사원 번호(id)를 받습니다.
    String id = request.getParameter("id");

    // 2. DB 연결 정보 (비밀번호 확인!)
    String url = "jdbc:mysql://localhost:3306/company?serverTimezone=UTC";
    String user = "root";
    String password = "root1234"; 

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 3. 드라이버 로드 및 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // 4. SQL 쿼리 작성 (해당 ID를 가진 사원 삭제)
        String sql = "DELETE FROM employee WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        
        // 5. 실행
        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 삭제 성공 시 알림창을 띄우고 다시 목록(list.jsp)으로 이동
%>
            <script>
                alert("해당 사원이 명부에서 삭제되었습니다.");
                location.href = "list.jsp";
            </script>
<%
        } else {
            // 삭제할 데이터가 없는 경우
            out.println("<script>alert('삭제 실패: 해당 사원을 찾을 수 없습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        // 오류 발생 시 에러 메시지 출력
        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        // 6. 자원 해제
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>