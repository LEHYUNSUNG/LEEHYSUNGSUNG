<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 1. 값 받아오기
    String name = request.getParameter("name");
    String position = request.getParameter("position");
    String ageStr = request.getParameter("age");
    String dept = request.getParameter("dept");
    String email = request.getParameter("email");

    // 2. 나이(age) 값 예외 처리 (하얀 화면의 주범!)
    int age = 0;
    if(ageStr != null && !ageStr.isEmpty()) {
        try {
            age = Integer.parseInt(ageStr);
        } catch(NumberFormatException e) {
            out.println("<script>alert('나이는 숫자만 입력 가능합니다.'); history.back();</script>");
            return;
        }
    }

    String url = "jdbc:mysql://localhost:3306/company?serverTimezone=UTC";
    String user = "root";
    String password = "root1234"; 

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // SQL 문 확인: name 다음 position 순서가 맞는지 보세요!
        String sql = "INSERT INTO employee (name, position, age, dept, email) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        
        pstmt.setString(1, name);
        pstmt.setString(2, position);
        pstmt.setInt(3, age);
        pstmt.setString(4, dept);
        pstmt.setString(5, email);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 성공하면 알림창 띄우고 이동
            out.println("<script>alert('성공적으로 등록되었습니다!'); location.href='list.jsp';</script>");
        }
    } catch (Exception e) {
        // 하얀 화면 대신 에러 상세 내용을 팝업으로 띄움
        String msg = e.getMessage().replace("'", ""); 
        out.println("<script>alert('에러 발생: " + msg + "'); history.back();</script>");
        e.printStackTrace(); 
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
        if (conn != null) try { conn.close(); } catch(Exception e) {}
    }
%>