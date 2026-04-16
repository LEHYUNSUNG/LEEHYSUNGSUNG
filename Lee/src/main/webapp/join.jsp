<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 관리 시스템 - 회원가입</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; background-color: #f1f3f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .join-container { background: #fff; padding: 40px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); width: 400px; }
    h2 { text-align: center; color: #2d3436; margin-bottom: 30px; }
    .form-group { margin-bottom: 15px; }
    .form-group label { display: block; margin-bottom: 5px; font-weight: bold; color: #4b6584; }
    input[type="text"], input[type="password"], input[type="email"] { width: 100%; padding: 12px; border: 1px solid #dfe6e9; border-radius: 6px; box-sizing: border-box; }
    
    /* 주소 영역 스타일 */
    .address-group { display: flex; gap: 5px; margin-bottom: 5px; }
    .btn-address { padding: 10px; background: #636e72; color: #fff; border: none; border-radius: 6px; cursor: pointer; white-space: nowrap; font-size: 13px; }
    .btn-address:hover { background: #2d3436; }

    .btn-submit { width: 100%; padding: 15px; background: #0984e3; color: #fff; border: none; border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer; margin-top: 20px; }
    .btn-submit:hover { background: #074b83; }
</style>
<script>
    // 카카오 주소 찾기 함수
    function findAddr() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 도로명 주소와 우편번호 입력
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById('address').value = data.roadAddress;
                // 상세주소 칸으로 포커스 이동
                document.getElementById('address_detail').focus();
            }
        }).open();
    }
</script>
</head>
<body>

<div class="join-container">
    <h2>📝 회원가입</h2>
    <form action="join_db.jsp" method="post">
        <div class="form-group">
            <label>아이디</label>
            <input type="text" name="userid" required>
        </div>
        <div class="form-group">
            <label>비밀번호</label>
            <input type="password" name="userpw" required>
        </div>
        <div class="form-group">
            <label>이름</label>
            <input type="text" name="username" required>
        </div>

        <div class="form-group">
            <label>주소</label>
            <div class="address-group">
                <input type="text" id="postcode" name="postcode" placeholder="우편번호" readonly>
                <button type="button" class="btn-address" onclick="findAddr()">주소 검색</button>
            </div>
            <input type="text" id="address" name="address" placeholder="기본 주소" readonly style="margin-bottom: 5px;">
            <input type="text" id="address_detail" name="address_detail" placeholder="상세 주소를 입력하세요">
        </div>
        <div class="form-group">
            <label>이메일</label>
            <input type="email" name="email">
        </div>
        <div class="form-group">
            <label>전화번호</label>
            <input type="text" name="phone" placeholder="010-0000-0000">
        </div>

        <button type="submit" class="btn-submit">가입하기</button>
    </form>
</div>

</body>
</html>