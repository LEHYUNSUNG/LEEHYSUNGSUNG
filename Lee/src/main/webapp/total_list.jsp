<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String userName = (String)session.getAttribute("userName");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP SYSTEM - 전체 사원 명부</title>
<style>
    body { margin: 0; font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; display: flex; }
    
    /* 사이드바 생략 (기존 sidebar 스타일과 동일하게 사용하세요) */
    .sidebar { width: 260px; height: 100vh; background: #fff; border-right: 1px solid #e1e4e8; position: fixed; }
    
    /* 메인 콘텐츠 */
    .main-content { margin-left: 260px; flex-grow: 1; padding: 40px; }

    /* ★ 사진 속 코드 구조 반영 스타일 ★ */
    .content-card { 
        background-color: #fff; 
        border-radius: 12px; 
        border: 1px solid #e1e4e8; 
        overflow: hidden; 
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }
    
    .card-header { 
        padding: 20px 25px; 
        border-bottom: 1px solid #f1f1f1; 
    }
    
    .card-title { 
        margin: 0; 
        font-weight: 700; 
        color: #333; 
        font-size: 18px; 
        display: flex; 
        align-items: center; 
        gap: 10px; 
    }
    
    .table-wrapper { 
        padding: 0; /* 사진처럼 헤더 배경색이 꽉 차도록 설정 */
    }

    table { 
        width: 100%; 
        border-collapse: collapse; 
    }
    
    /* 사진 속 th 스타일 */
    thead tr { 
        background-color: #fafbfc; 
    }
    
    th { 
        padding: 18px 10px; 
        border-bottom: 1px solid #eee; 
        color: #888; 
        font-size: 13px; 
        font-weight: 600; 
        text-align: center; 
    }
    
    td { 
        padding: 20px 10px; 
        border-bottom: 1px solid #f1f1f1; 
        text-align: center; 
        color: #444; 
        font-size: 14px; 
    }

    /* 버튼 스타일 */
    .btn-action {
        padding: 6px 12px;
        background: #00bc8c;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 12px;
        font-weight: bold;
    }
</style>
</head>
<body>

    <div class="sidebar">
        <div style="padding: 25px 20px; font-weight: 800; color: #0062ff; font-size: 22px;">ERP SYSTEM</div>
        </div>

    <div class="main-content">
        <div class="content-card">
            <div class="card-header">
                <h2 class="card-title">📋 전체 사원 명부</h2>
            </div>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>탈 퇴</th>
                            <th>번 호</th>
                            <th>이 름</th>
                            <th>직 급</th>
                            <th>부 서</th>
                            <th>연 봉 관 리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            int no = 1;
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/company?serverTimezone=UTC", "root", "root1234");
                                stmt = conn.createStatement();
                                rs = stmt.executeQuery("SELECT * FROM employee ORDER BY id ASC");

                                while(rs.next()) {
                                    int actualId = rs.getInt("id");
                                    String name = rs.getString("name");
                        %>
                            <tr>
                                <td><input type="checkbox" onclick="if(confirm('삭제하시겠습니까?')) location.href='delete_db.jsp?id=<%= actualId %>';"></td>
                                <td><%= no %></td>
                                <td><b><%= name %></b></td>
                                <td><%= rs.getString("position") %></td>
                                <td><%= rs.getString("dept") %></td>
                                <td>
                                    <button type="button" class="btn-action" 
                                            onclick="location.href='salary.jsp?id=<%= actualId %>&name=<%= name %>&no=<%= no %>'">
                                        조회
                                    </button>
                                </td>
                            </tr>
                        <%
                                    no++;
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='6'>오류 발생: " + e.getMessage() + "</td></tr>");
                            } finally {
                                if(conn != null) conn.close();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>