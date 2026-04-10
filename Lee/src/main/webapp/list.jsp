<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 관리 시스템 - 목록</title>
<style>
    /* 1. 기본 폰트 및 배경 */
    body {
        margin: 0;
        font-family: 'Malgun Gothic', sans-serif;
        background-color: #f8f9fa;
        color: #333;
    }

    /* 2. 쇼핑몰 스타일 상단 메뉴바 (Navigation Bar) */
    .navbar {
        background-color: #ffffff;
        border-bottom: 1px solid #ddd;
        position: sticky;
        top: 0;
        z-index: 1000;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    }
    .nav-container {
        max-width: 1100px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        height: 70px;
        padding: 0 20px;
    }
    .nav-logo {
        font-size: 22px;
        font-weight: bold;
        color: #0984e3;
        text-decoration: none;
    }
    .nav-menu {
        list-style: none;
        display: flex;
        margin: 0;
        padding: 0;
    }
    .nav-menu li { margin: 0 15px; }
    .nav-menu a {
        text-decoration: none;
        color: #555;
        font-weight: 500;
        transition: 0.3s;
    }
    .nav-menu a:hover { color: #0984e3; }
    
    .nav-auth a {
        text-decoration: none;
        font-size: 14px;
        color: #333;
        margin-left: 10px;
    }
    /* 회원가입 버튼 강조 */
    .btn-signup {
        background: #333; 
        color: #fff !important; 
        padding: 8px 15px; 
        border-radius: 4px;
        transition: 0.3s;
    }
    .btn-signup:hover { background: #555; }

    /* 3. 메인 컨텐츠 영역 */
    .content-container {
        max-width: 1000px;
        margin: 40px auto;
        padding: 30px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }
    h2 {
        text-align: center;
        margin-bottom: 30px;
        color: #2d3436;
    }

    /* 4. 테이블 스타일 */
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }
    th, td {
        padding: 15px;
        border-bottom: 1px solid #eee;
        text-align: center;
    }
    th {
        background-color: #f1f3f5;
        color: #495057;
        font-weight: bold;
    }
    tr:hover { background-color: #f8f9fa; }
    
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
                <a href="login.jsp">로그인</a>
                <a href="join.jsp" class="btn-signup">회원가입</a>
            </div>
        </div>
    </nav>

    <div class="content-container">
        <h2>📋 전체 사원 명부</h2>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>직급</th>
                    <th>이름</th>
                    <th>나이</th>
                    <th>부서</th>
                    <th>이메일</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // DB 연결 정보 (비밀번호: root1234로 설정됨)
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
                %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><strong><%= rs.getString("name") %></strong></td>
                            <td><%= rs.getInt("age") %></td>
                            <td><%= rs.getString("dept") %></td>
                            <td><%= rs.getString("email") %></td>
                        </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5' class='error-msg'>데이터를 불러오는 중 오류 발생: " + e.getMessage() + "</td></tr>");
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