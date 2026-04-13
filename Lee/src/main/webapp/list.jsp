<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 세션에서 로그인한 사용자 이름을 가져옵니다.
    String userName = (String)session.getAttribute("userName");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 관리 시스템 - 목록</title>
<style>
    body { margin: 0; font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; color: #333; }
    .navbar { background-color: #ffffff; border-bottom: 1px solid #ddd; position: sticky; top: 0; z-index: 1000; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
    .nav-container { max-width: 1100px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; height: 70px; padding: 0 20px; }
    .nav-logo { font-size: 22px; font-weight: bold; color: #0984e3; text-decoration: none; }
    .nav-menu { list-style: none; display: flex; margin: 0; padding: 0; }
    .nav-menu li { margin: 0 15px; }
    .nav-menu a { text-decoration: none; color: #555; font-weight: 500; transition: 0.3s; }
    .nav-menu a:hover { color: #0984e3; }
    
    .nav-auth { display: flex; align-items: center; font-size: 14px; }
    .nav-auth a { text-decoration: none; color: #333; margin-left: 10px; }
    .user-name { font-weight: bold; color: #0984e3; margin-right: 5px; }
    .btn-signup { background: #333; color: #fff !important; padding: 8px 15px; border-radius: 4px; transition: 0.3s; }

    /* 추가: 회원탈퇴 텍스트 버튼 스타일 */
    .btn-withdraw { color: #b2bec3 !important; font-size: 12px; transition: 0.3s; }
    .btn-withdraw:hover { color: #d63031 !important; }

    .content-container { max-width: 1100px; margin: 40px auto; padding: 30px; background-color: #fff; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
    h2 { text-align: center; margin-bottom: 30px; color: #2d3436; }
    
    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    th, td { padding: 15px; border-bottom: 1px solid #eee; text-align: center; }
    th { background-color: #f1f3f5; color: #495057; font-weight: bold; }
    tr:hover { background-color: #f8f9fa; }
    
    .del-check { transform: scale(1.2); cursor: pointer; }
    .error-msg { color: red; text-align: center; padding: 20px; }
</style>
</head>
<body>

    <nav class="navbar">
        <div class="nav-container">
            <a href="main.jsp" class="nav-logo">ERP SYSTEM</a>
            <ul class="nav-menu">
                <li><a href="main.jsp">홈</a></li>
                <li><a href="list.jsp" style="color:#0984e3;">사원명부</a></li>
                <li><a href="insert.jsp">사원등록</a></li>
                <li><a href="#">급여관리</a></li>
                <li><a href="#">공지사항</a></li>
            </ul>
            <div class="nav-auth">
                <% if(userName == null) { %>
                    <a href="login.jsp">로그인</a>
                    <a href="join.jsp" class="btn-signup">회원가입</a>
                <% } else { %>
                    <span class="user-name"><%= userName %>님</span>
                    <a href="logout.jsp" style="margin-left:15px; color:#d63031; font-weight:bold;">로그아웃</a>
                    <a href="withdraw_db.jsp" class="btn-withdraw" 
                       onclick="return confirm('정말 회원 탈퇴를 하시겠습니까? 계정이 영구 삭제됩니다.')">회원탈퇴</a>
                <% } %>
            </div>
        </div>
    </nav>

    <div class="content-container">
        <h2>📋 전체 사원 명부</h2>
        
        <table>
            <thead>
                <tr>
                    <th>탈퇴</th> <th>ID</th>
                    <th>이름</th>
                    <th>직급</th>
                    <th>나이</th>
                    <th>부서</th>
                    <th>이메일</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String url = "jdbc:mysql://localhost:3306/company?serverTimezone=UTC";
                    String user = "root";
                    String password = "root1234"; 

                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, user, password);
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM employee ORDER BY id DESC");

                        while(rs.next()) {
                            int id = rs.getInt("id");
                %>
                        <tr>
                            <td>
                                <input type="checkbox" class="del-check" 
                                       onclick="if(confirm('정말 삭제하시겠습니까?')) { location.href='delete_db.jsp?id=<%= id %>'; } else { this.checked=false; }">
                            </td>
                            <td><%= id %></td>
                            <td><strong><%= rs.getString("name") %></strong></td>
                            <td><%= rs.getString("position") %></td>
                            <td><%= rs.getInt("age") %></td>
                            <td><%= rs.getString("dept") %></td>
                            <td><%= rs.getString("email") %></td>
                        </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='7' class='error-msg'>오류 발생: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if(rs != null) rs.close();
                        if(stmt != null) stmt.close();
                        if(conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>