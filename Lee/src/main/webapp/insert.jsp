<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 관리 시스템 - 등록</title>
<style>
    /* 1. 기본 스타일 (list.jsp와 통일) */
    body {
        margin: 0;
        font-family: 'Malgun Gothic', sans-serif;
        background-color: #f8f9fa;
        color: #333;
    }

    /* 2. 상단 메뉴바 (list.jsp와 동일) */
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

    /* 3. 입력 폼 컨테이너 */
    .form-container {
        max-width: 500px;
        margin: 60px auto;
        padding: 40px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    }
    h2 {
        text-align: center;
        margin-bottom: 30px;
        color: #2d3436;
    }

    /* 4. 입력 항목 스타일 */
    .form-group {
        margin-bottom: 20px;
    }
    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #495057;
    }
    .form-group input, .form-group select {
        width: 100%;
        padding: 12px;
        border: 1px solid #ced4da;
        border-radius: 6px;
        box-sizing: border-box; /* 패딩이 너비에 포함되도록 */
        font-size: 14px;
    }
    .form-group input:focus {
        outline: none;
        border-color: #0984e3;
        box-shadow: 0 0 5px rgba(9, 132, 227, 0.2);
    }

    /* 5. 등록 버튼 */
    .btn-submit {
        width: 100%;
        padding: 15px;
        background-color: #0984e3;
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: 0.3s;
        margin-top: 10px;
    }
    .btn-submit:hover {
        background-color: #074696;
    }
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
                <li><a href="#">급여관리</a></li>
                <li><a href="#">공지사항</a></li>
            </ul>
        </div>
    </nav>

    <div class="form-container">
        <h2>👤 신규 사원 등록</h2>
        
        <form action="insert_db.jsp" method="post">
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" placeholder="이름을 입력하세요" required>
            </div>
            
            <div class="form-group">
                   <label>직급</label>
                   <input type="text" name="position" placeholder="대리" required> 
            </div>

             <div class="form-group">
                   <label>직급</label>
             <select name="position" required> 
                    <option value="인턴">인턴</option>
                    <option value="사원">사원</option>
                    <option value="주임">주임</option>
                    <option value="대리">대리</option>
                    <option value="과장">과장</option>
                    <option value="차장">차장</option>
                    <option value="부장">부장</option>
                    <option value="이사">이사</option>
                    <option value="상무">상무</option>
                    <option value="전무">전무</option>
                    <option value="사장">사장</option>
             </select>
             </div>
            
            <div class="form-group">
                <label for="age">나이</label>
                <input type="number" id="age" name="age" placeholder="나이를 입력하세요" required>
            </div>
            
            <div class="form-group">
                <label for="dept">부서</label>
                <select id="dept" name="dept">
                    <option value="개발자">개발자팀</option>
                    <option value="영업">영업팀</option>
                    <option value="인사">인사팀</option>
                    <option value="기획">기획팀</option>
                    <option value="마게팅">마게팅팀</option>
                    <option value="PM">PM팀</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" placeholder="example@email.com">
            </div>
            
            <button type="submit" class="btn-submit">사원 등록하기</button>
        </form>
    </div>

</body>
</html>