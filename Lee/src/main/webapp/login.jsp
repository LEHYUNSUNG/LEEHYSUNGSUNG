<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; background-color: #f1f3f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .login-container { background: #fff; padding: 40px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); width: 350px; }
    h2 { text-align: center; color: #333; }
    input { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
    .btn-login { width: 100%; padding: 12px; background: #2d3436; color: #fff; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; }
    .link-group { text-align: center; margin-top: 15px; font-size: 14px; }
    .link-group a { color: #0984e3; text-decoration: none; }
</style>
</head>
<body>
    <div class="login-container">
        <h2>ERP LOGIN</h2>
        <form action="login_db.jsp" method="post">
            <input type="text" name="userid" placeholder="아이디" required>
            <input type="password" name="userpw" placeholder="비밀번호" required>
            <button type="submit" class="btn-login">로그인</button>
        </form>
        <div class="link-group">
            아직 회원이 아니신가요? <a href="join.jsp">회원가입</a>
        </div>
    </div>
</body>
</html>