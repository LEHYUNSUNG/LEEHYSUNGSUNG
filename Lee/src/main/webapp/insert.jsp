<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // [보안] 세션 확인: 로그인하지 않은 사용자는 로그인 페이지로 강제 이동
    String userName = (String)session.getAttribute("userName");
    if(userName == null) {
%>
    <script>
        alert("로그인한 사용자만 사원 등록이 가능합니다.");
        location.href = "login.jsp";
    </script>
<%
        return; // 로그인 안 되어 있으면 아래 코드를 실행하지 않고 중단
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP SYSTEM - 사원 등록</title>
<style>
    body { margin: 0; font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; }
    .navbar { background-color: #ffffff; border-bottom: 1px solid #ddd; position: sticky; top: 0; z-index: 1000; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
    .nav-container { max-width: 1100px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; height: 70px; padding: 0 20px; }
    .nav-logo { font-size: 22px; font-weight: bold; color: #0984e3; text-decoration: none; }
    .nav-menu { list-style: none; display: flex; margin: 0; padding: 0; }
    .nav-menu li { margin: 0 15px; }
    .nav-menu a { text-decoration: none; color: #555; font-weight: 500; }
    .nav-auth { font-size: 14px; }
    .user-name { font-weight: bold; color: #0984e3; }

    .content-container { max-width: 600px; margin: 50px auto; padding: 40px; background: #fff; border-radius: 12px; box-shadow: 0 8px 20px rgba(0,0,0,0.1); }
    h2 { text-align: center; color: #2d3436; margin-bottom: 30px; }
    .form-group { margin-bottom: 20px; }
    .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: #636e72; }
    .form-group input { width: 100%; padding: 12px; border: 1px solid #dfe6e9; border-radius: 6px; box-sizing: border-box; }
    .btn-submit { width: 100%; padding: 15px; background: #0984e3; color: #fff; border: none; border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer; transition: 0.3s; }
    .btn-submit:hover { background: #074b83; }
</style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <a href="main.jsp" class="nav-logo">ERP SYSTEM</a>
            <ul class="nav-menu">
                <li><a href="main.jsp">홈</a></li>
                <li><a href="list.jsp">사원명부</a></li>
                <li><a href="insert.jsp" style="color:#0984e3;">사원등록</a></li>
            </ul>
            <div class="nav-auth">
                <span class="user-name"><%= userName %>님</span> 접속 중
            </div>
        </div>
    </nav>

    <div class="content-container">
        <h2>👤 신규 사원 등록</h2>
        <form action="insert_db.jsp" method="post">
            <div class="form-group">
                <label>이름</label>
                <input type="text" name="name" required placeholder="성함을 입력하세요">
            </div>
            <div class="form-group">
                <label>직급</label>
                <input type="text" name="position" required placeholder="예: 대리">
            </div>
            <div class="form-group">
                <label>나이</label>
                <input type="number" name="age" required placeholder="숫자만 입력">
            </div>
            <div class="form-group">
                <label>부서</label>
                <input type="text" name="dept" required placeholder="예: IT지원팀">
            </div>
            <div class="form-group">
                <label>이메일</label>
                <input type="email" name="email" required placeholder="example@company.com">
            </div>
            <button type="submit" class="btn-submit">사원 등록하기</button>
        </form>
    </div>
</body>
</html>