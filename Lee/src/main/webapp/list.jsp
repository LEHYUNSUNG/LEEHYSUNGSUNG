<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
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
    
    /* 인증 영역 스타일 */
    .nav-auth { display: flex; align-items: center; font-size: 14px; }
    .user-name { font-weight: bold; color: #0984e3; margin-right: 5px; }
    .btn-logout { margin-left:10px; color:#d63031; text-decoration:none; font-weight: bold; }
    /* 회원탈퇴 버튼 스타일: 작고 깔끔하게 */
    .btn-withdraw { margin-left:15px; color:#b2bec3; text-decoration:none; font-size: 12px; transition: 0.3s; }
    .btn-withdraw:hover { color:#ff7675; text-decoration: underline; }

    .content-container { max-width: 1100px; margin: 40px auto; padding: 30px; background-color: #fff; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
    h2 { text-align: center; margin-bottom: 30px; color: #2d3436; }
    table { width: 100%; border-collapse: collapse; }
    th, td { padding: 15px; border-bottom: 1px solid #eee; text-align: center; }
    th { background-color: #f1f3f5; color: #495057; }
    tr:hover { background-color: #f8f9fa; }
    .btn-salary { padding: 6px 12px; background: #00bc8c; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 12px; }
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
                <li><a href="salary_list.jsp">급여관리</a></li>
            </ul>
            <div class="nav-auth">
                <% if(userName != null) { %>
                    <span class="user-name"><%= userName %>님</span>
                    <a href="logout.jsp" class="btn-logout">로그아웃</a>
                    <a href="withdraw_db.jsp" class="btn-withdraw" 
                       onclick="return confirm('정말 회원을 탈퇴하시겠습니까? 계정 정보가 완전히 삭제됩니다.')">회원탈퇴</a>
                <% } else { %>
                    <a href="login.jsp" style="text-decoration:none;">로그인</a>
                <% } %>
            </div>
        </div>
    </nav>

    <div class="content-container">
        <h2>📋 전체 사원 명부</h2>
        <table>
            <thead>
                <tr>
                    <th>탈퇴</th>
                    <th>번호</th> 
                    <th>이름</th>
                    <th>직급</th>
                    <th>부서</th>
                    <th>연봉관리</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/company?serverTimezone=UTC", "root", "root1234");
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM employee ORDER BY id ASC");

                        int no = 1; 
                        while(rs.next()) {
                            int actualId = rs.getInt("id"); 
                            String name = rs.getString("name");
                %>
                        <tr>
                            <td><input type="checkbox" onclick="if(confirm('사원 정보를 삭제하시겠습니까?')) location.href='delete_db.jsp?id=<%= actualId %>'; else this.checked=false;"></td>
                            <td><%= no %></td> 
                            <td><strong><%= name %></strong></td>
                            <td><%= rs.getString("position") %></td>
                            <td><%= rs.getString("dept") %></td>
                            <td>
                                <button type="button" class="btn-salary" 
                                        onclick="location.href='salary.jsp?id=<%= actualId %>&name=<%= name %>&no=<%= no %>'">
                                    연봉조회
                                </button>
                            </td>
                        </tr>
                <%
                            no++; 
                        }
                    } catch (Exception e) { out.println(e.getMessage()); }
                    finally { if(rs!=null) rs.close(); if(stmt!=null) stmt.close(); if(conn!=null) conn.close(); }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>