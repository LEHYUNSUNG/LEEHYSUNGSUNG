<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    // [보안] 로그인 체크
    String userName = (String)session.getAttribute("userName");
    if(userName == null) {
%>
    <script>alert("로그인이 필요합니다."); location.href="login.jsp";</script>
<%
        return;
    }

    // 숫자를 금액 형식(3자리 콤마)으로 포맷팅하기 위한 객체
    DecimalFormat df = new DecimalFormat("#,###");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP SYSTEM - 급여 관리 목록</title>
<style>
    body { margin: 0; font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; }
    .navbar { background-color: #ffffff; border-bottom: 1px solid #ddd; position: sticky; top: 0; z-index: 1000; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
    .nav-container { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; height: 70px; padding: 0 20px; }
    .nav-logo { font-size: 22px; font-weight: bold; color: #0984e3; text-decoration: none; }
    .nav-menu { list-style: none; display: flex; margin: 0; padding: 0; }
    .nav-menu li { margin: 0 15px; }
    .nav-menu a { text-decoration: none; color: #555; font-weight: 500; }
    
    .content-container { max-width: 1200px; margin: 40px auto; padding: 30px; background: #fff; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
    h2 { text-align: center; margin-bottom: 30px; color: #2d3436; }
    
    table { width: 100%; border-collapse: collapse; }
    th, td { padding: 15px; border-bottom: 1px solid #eee; text-align: center; }
    th { background-color: #f1f3f5; color: #495057; font-weight: bold; }
    tr:hover { background-color: #f8f9fa; }

    /* 금액 우측 정렬 및 강조 */
    .price-text { text-align: right; padding-right: 25px; font-family: 'Consolas', monospace; }
    .total-price { color: #d63031; font-weight: bold; }
    
    .btn-edit { padding: 5px 10px; background: #0984e3; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 12px; }
</style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <a href="main.jsp" class="nav-logo">ERP SYSTEM</a>
            <ul class="nav-menu">
                <li><a href="main.jsp">홈</a></li>
                <li><a href="list.jsp">사원명부</a></li>
                <li><a href="insert.jsp">사원등록</a></li>
                <li><a href="salary_list.jsp" style="color:#0984e3;">급여관리</a></li>
            </ul>
            <div style="font-size: 14px;">
                <span style="font-weight:bold; color:#0984e3;"><%= userName %>님</span> 환영합니다.
            </div>
        </div>
    </nav>

    <div class="content-container">
        <h2>💰 전 사원 급여 현황</h2>
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>이름</th>
                    <th>직급</th>
                    <th>기본급(월)</th>
                    <th>식대(월)</th>
                    <th>상여금(연)</th>
                    <th>월 수령액(합계)</th>
                    <th>관리</th>
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
                            int salary = rs.getInt("salary");          // 기본급
                            int bonus = rs.getInt("bonus");            // 상여금
                            int meal = rs.getInt("meal_allowance");    // 식대
                            
                            // 간단한 월 합계 계산 (상여금은 1/12로 계산하거나 제외 가능, 여기선 단순 합계)
                            int totalMonth = salary + meal; 
                %>
                        <tr>
                            <td><%= no %></td>
                            <td><strong><%= rs.getString("name") %></strong></td>
                            <td><%= rs.getString("position") %></td>
                            <td class="price-text">￦<%= df.format(salary) %></td>
                            <td class="price-text">￦<%= df.format(meal) %></td>
                            <td class="price-text" style="color:#00b894;">￦<%= df.format(bonus) %></td>
                            <td class="price-text total-price">￦<%= df.format(totalMonth) %></td>
                            <td>
                                <button type="button" class="btn-edit" 
                                        onclick="location.href='salary.jsp?id=<%= actualId %>&name=<%= rs.getString("name") %>&no=<%= no %>'">
                                    수정
                                </button>
                            </td>
                        </tr>
                <%
                            no++;
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='8'>데이터 로드 오류: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if(rs != null) rs.close(); if(stmt != null) stmt.close(); if(conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>