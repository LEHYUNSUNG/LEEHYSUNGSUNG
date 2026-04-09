<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>아이디 중복 체크</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; text-align: center; padding: 20px; }
    .result-msg { margin: 20px 0; font-weight: bold; }
    .btn-use { background: #0984e3; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; }
</style>
<script>
    // 이 아이디를 사용하겠다고 확정했을 때 부모 창(join.jsp)으로 값을 전달하는 함수
    function sendId(userid) {
        opener.document.getElementsByName("userid")[0].value = userid;
        opener.document.getElementsByName("userid")[0].readOnly = true; // 수정 불가하게 고정
        window.close(); // 팝업창 닫기
    }
</script>
</head>
<body>
<%
    String userid = request.getParameter("userid");
    
    String url = "jdbc:mysql://localhost:3306/company?serverTimezone=UTC";
    String dbid = "root";
    String dbpw = "root1234"; // 대리님 비밀번호 확인!

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    boolean isDuplicate = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbid, dbpw);
        
        String sql = "SELECT userid FROM member WHERE userid = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userid);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            isDuplicate = true; // 이미 아이디가 존재함
        }
%>
    <h3>아이디 중복 확인</h3>
    <div class="result-msg">
        <% if (isDuplicate) { %>
            <span style="color: #d63031;">[<%= userid %>]는 이미 사용 중인 아이디입니다.</span>
            <form action="check_id.jsp" method="get" style="margin-top:10px;">
                <input type="text" name="userid" placeholder="새 아이디 입력" required>
                <button type="submit">다시 확인</button>
            </form>
        <% } else { %>
            <span style="color: #00b894;">[<%= userid %>]는 사용 가능한 아이디입니다.</span><br><br>
            <button class="btn-use" onclick="sendId('<%= userid %>')">사용하기</button>
        <% } %>
    </div>
<%
    } catch (Exception e) {
        out.println("오류 발생: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
</body>
</html>