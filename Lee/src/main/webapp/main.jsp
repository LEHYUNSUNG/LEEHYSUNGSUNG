<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웹 페이지 만들기</title>
<style>
    /* 1. 배경 설정 (부드러운 그라데이션) */
    body, html {
        height: 100%;
        margin: 0;
        font-family: 'Pretendard', 'Malgun Gothic', sans-serif;
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        display: flex;
        align-items: center;
        justify-content: center;
    }

    /* 2. 메인 카드 박스 */
    .main-card {
        background-color: rgba(255, 255, 255, 0.9); /* 반투명 흰색 */
        padding: 60px 80px;
        border-radius: 20px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        text-align: center;
        max-width: 600px;
        backdrop-filter: blur(10px); /* 배경 흐림 효과 (고급스러움) */
    }

    /* 3. 제목 및 문구 */
    h1 {
        color: #2d3436;
        font-size: 2.5rem;
        margin-bottom: 10px;
    }

    p {
        color: #636e72;
        font-size: 1.1rem;
        margin-bottom: 30px;
    }

    /* 4. 자주 쓰는 메인 버튼 */
    .btn-main {
        display: inline-block;
        padding: 15px 40px;
        background-color: #0984e3;
        color: white;
        text-decoration: none;
        font-weight: bold;
        border-radius: 30px;
        transition: 0.3s ease;
        box-shadow: 0 4px 15px rgba(9, 132, 227, 0.3);
    }

    .btn-main:hover {
        background-color: #74b9ff;
        transform: translateY(-3px); /* 마우스 올리면 살짝 위로 */
    }
</style>
</head>
<body>

    <div class="main-card">
        <h1>웹 페이지 만들기</h1>
        
        <a href="list.jsp" class="btn-main">확인하기</a>
    </div>

</body>
</html>