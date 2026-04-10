<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; background-color: #f1f3f5; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
    .join-container { background: #fff; padding: 40px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); width: 450px; }
    h2 { text-align: center; color: #333; margin-bottom: 30px; }
    
    .input-group { display: flex; gap: 10px; margin-bottom: 10px; }
    input { width: 100%; padding: 12px; margin: 5px 0; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
    label { font-size: 14px; font-weight: bold; display: block; margin-top: 10px; }
    
    .btn-side { width: 110px; background-color: #636e72; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 13px; font-weight: bold; }
    .btn-side:hover { background-color: #2d3436; }

    #auth-section { display: none; margin-top: 10px; padding: 15px; background-color: #f8f9fa; border-radius: 5px; border: 1px dashed #adb5bd; }

    .btn-join { width: 100%; padding: 15px; background: #0984e3; color: #fff; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; font-size: 16px; margin-top: 20px; }
    .btn-join:hover { background: #074696; }
</style>

<script>
    function openIdCheck() {
        const userid = document.getElementsByName("userid")[0].value;
        if (userid === "") {
            alert("확인할 아이디를 먼저 입력해주세요!");
            return;
        }
        const url = "check_id.jsp?userid=" + userid;
        window.open(url, "chkid", "width=400, height=300, menubar=no, toolbar=no");
    }

    function validateForm() {
        const pw = document.getElementById("userpw").value;
        const pwConfirm = document.getElementById("userpw_confirm").value;
        
        // 대문자, 특수문자 포함 정규식 (8자 이상)
        const pwRegex = /^(?=.*[A-Z])(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[0-9]).{8,}$/;

        if (!pwRegex.test(pw)) {
            alert("비밀번호 규칙을 확인해주세요.\n(8자 이상, 대문자 및 특수문자 포함)");
            return false;
        }

        if (pw !== pwConfirm) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }
        
        return true; 
    }

    function requestAuth() {
        const phone = document.getElementById("phone_input").value;
        if(phone === "") { alert("전화번호를 입력해주세요!"); return; }
        alert(phone + " 번호로 인증번호가 발송되었습니다! (테스트 번호: 1234)");
        document.getElementById("auth-section").style.display = "block";
    }

    function checkAuth() {
        const authNum = document.getElementById("auth_num").value;
        if(authNum === "1234") {
            alert("인증에 성공했습니다.");
            document.getElementById("auth-section").style.display = "none";
            document.getElementById("phone_input").readOnly = true; 
            document.getElementById("auth_btn").innerText = "인증 완료";
            document.getElementById("auth_btn").disabled = true;
            document.getElementById("auth_btn").style.background = "#00b894";
        } else {
            alert("인증번호가 틀렸습니다.");
        }
    }
</script>
</head>
<body>
    <div class="join-container">
        <h2>회원가입</h2>
        <form action="join_db.jsp" method="post" onsubmit="return validateForm()">
            
            <label>아이디</label>
            <div class="input-group">
                <input type="text" name="userid" placeholder="아이디 입력" required>
                <button type="button" class="btn-side" onclick="openIdCheck()">중복 체크</button>
            </div>
            
            <label>비밀번호</label>
            <input type="password" id="userpw" name="userpw" 
                   placeholder="8자 이상, 대문자 및 특수문자 포함" required>
            
            <label>비밀번호 확인</label>
            <input type="password" id="userpw_confirm" placeholder="비밀번호 재입력" required>
            
            <label>이름</label>
            <input type="text" name="username" placeholder="성함 입력" required>

            <label>이메일</label>
            <input type="email" name="email" placeholder="example@email.com" required>
            
            <label>전화번호</label>
            <div class="input-group">
                <input type="tel" id="phone_input" name="phone" placeholder="010-0000-0000" required>
                <button type="button" id="auth_btn" class="btn-side" onclick="requestAuth()">인증 요청</button>
            </div>

            <div id="auth-section">
                <p style="margin: 0 0 10px 0; font-size: 12px; color: #d63031;">인증번호 4자리(1234)를 입력하세요.</p>
                <div class="input-group">
                    <input type="text" id="auth_num" placeholder="인증번호">
                    <button type="button" class="btn-side" style="background-color: #00b894;" onclick="checkAuth()">확인</button>
                </div>
            </div>
            
            <button type="submit" class="btn-join">회원가입 완료</button>
        </form>
    </div>
</body>
</html>