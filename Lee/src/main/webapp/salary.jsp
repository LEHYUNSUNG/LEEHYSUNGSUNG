<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // [보안] 로그인 체크
    String userName = (String)session.getAttribute("userName");
    if(userName == null) {
%>
    <script>
        alert("로그인이 필요합니다."); 
        location.href="login.jsp";
    </script>
<%
        return;
    }

    // list.jsp에서 전달받은 파라미터들
    String empId = request.getParameter("id");    // DB 수정용 (실제 ID)
    String empName = request.getParameter("name");  // 이름 표시용
    String empNo = request.getParameter("no");      // 목록과 일치시킨 순번
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP SYSTEM - 연봉 관리</title>
<style>
    /* 기본 레이아웃 */
    body { margin: 0; font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; }
    .navbar { background-color: #ffffff; border-bottom: 1px solid #ddd; height: 70px; display: flex; align-items: center; justify-content: center; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
    
    .content-container { max-width: 500px; margin: 50px auto; padding: 30px; background: #fff; border-radius: 12px; box-shadow: 0 8px 20px rgba(0,0,0,0.1); }
    h2 { text-align: center; color: #2d3436; margin-bottom: 25px; }
    
    /* 상단 사원 정보 박스 */
    .info-box { background: #e1f5fe; padding: 15px; border-radius: 8px; margin-bottom: 25px; text-align: center; font-weight: bold; color: #0288d1; border: 1px solid #b3e5fc; }
    
    /* 입력 폼 스타일 */
    .form-group { margin-bottom: 20px; }
    .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: #444; }
    .form-group input { width: 100%; padding: 12px; border: 1px solid #dfe6e9; border-radius: 6px; box-sizing: border-box; font-size: 16px; outline: none; }
    .form-group input:focus { border-color: #0984e3; box-shadow: 0 0 5px rgba(9, 132, 227, 0.2); }

    /* ★ 숫자 입력창 화살표(스피너) 제거 CSS ★ */
    /* Chrome, Safari, Edge, Opera */
    input::-webkit-outer-spin-button,
    input::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
    /* Firefox */
    input[type=number] {
        -moz-appearance: textfield;
    }

    /* 하단 버튼 그룹 */
    .btn-group { display: flex; gap: 10px; margin-top: 30px; }
    .btn { flex: 1; padding: 15px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; transition: 0.3s; font-size: 15px; }
    .btn-save { background: #0984e3; color: white; }
    .btn-back { background: #636e72; color: white; }
    .btn:hover { opacity: 0.9; transform: translateY(-1px); }
</style>
</head>
<body>

    <div class="navbar">
        <strong style="color:#0984e3; font-size:20px;">ERP SYSTEM SALARY MANAGEMENT</strong>
    </div>

    <div class="content-container">
        <h2>💰 연봉 정보 수정</h2>
        
        <div class="info-box">
            대상 사원: <%= empName %> (번호: <%= empNo %>)
        </div>

        <form action="salary_db.jsp" method="post">
            <input type="hidden" name="id" value="<%= empId %>">
            
            <div class="form-group">
                <label>기본급 (월 단위)</label>
                <input type="number" name="base_salary" placeholder="숫자만 입력하세요" required>
            </div>
            
            <div class="form-group">
                <label>연봉 (연 단위)</label>
                <input type="number" name="bonus" placeholder="숫자만 입력하세요" required>
            </div>
            
            <div class="form-group">
                <label>식대 (월)</label>
                <input type="number" name="meal_allowance" value="100000" placeholder="숫자만 입력하세요">
            </div>

            <div class="btn-group">
                <button type="button" class="btn btn-back" onclick="location.href='list.jsp'">목록으로</button>
                <button type="submit" class="btn btn-save">정보 저장하기</button>
            </div>
        </form>
    </div>

</body>
</html>