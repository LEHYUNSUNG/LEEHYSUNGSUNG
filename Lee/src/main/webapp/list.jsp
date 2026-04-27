<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String userName = (String)session.getAttribute("userName");
    if(userName == null) userName = "사용자"; 
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ERP SYSTEM - 홈</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    :root {
        --primary-blue: #0062ff;
        --bg-gray: #f8f9fc;
        --sidebar-width: 260px;
        --border-color: #e3e6f0;
    }

    body { margin: 0; font-family: 'Noto Sans KR', sans-serif; background-color: var(--bg-gray); display: flex; overflow-x: hidden; }
    
    /* 사이드바 스타일 */
    .sidebar { width: var(--sidebar-width); height: 100vh; background-color: #fff; border-right: 1px solid var(--border-color); position: fixed; display: flex; flex-direction: column; overflow-y: auto; z-index: 1000; }
    .sidebar-logo { padding: 30px 25px; }
    .logo-text { font-size: 24px; font-weight: 900; color: var(--primary-blue); letter-spacing: -1px; }
    
    .sidebar-btn-area { padding: 0 20px 25px; }
    .btn-start { width: 100%; padding: 14px; background-color: var(--primary-blue); color: #fff; border: none; border-radius: 8px; font-weight: 700; cursor: pointer; font-size: 15px; display: flex; align-items: center; justify-content: center; gap: 10px; transition: 0.3s; box-shadow: 0 4px 10px rgba(0, 98, 255, 0.2); }
    .btn-start:hover { background-color: #0052d4; transform: translateY(-2px); }
    
    .contract-count { margin-top: 12px; font-size: 13px; color: #858796; text-align: center; }
    .count-num { color: var(--primary-blue); font-weight: 700; }
    
    .sidebar-menu { list-style: none; padding: 10px 0; margin: 0; flex-grow: 1; }
    .menu-item { padding: 14px 25px; display: flex; align-items: center; cursor: pointer; color: #6e707e; text-decoration: none; font-size: 15px; transition: 0.2s; font-weight: 500; position: relative; }
    .menu-item:hover { background-color: #f8f9fc; color: var(--primary-blue); }
    .menu-item.active { background-color: #f0f7ff; color: var(--primary-blue); font-weight: 700; }
    .menu-item.active::after { content: ''; position: absolute; right: 0; width: 4px; height: 100%; background: var(--primary-blue); }
    .menu-icon { width: 25px; margin-right: 12px; font-size: 17px; text-align: center; opacity: 0.8; }
    
    .has-sub::after { content: '\f107'; font-family: 'Font Awesome 6 Free'; font-weight: 900; position: absolute; right: 25px; font-size: 12px; transition: 0.3s; color: #d1d3e2; }
    .has-sub.open::after { transform: rotate(180deg); }
    .submenu { list-style: none; padding: 5px 0; background-color: #fafafa; display: none; }
    .submenu li a { padding: 10px 20px 10px 62px; display: block; color: #858796; text-decoration: none; font-size: 14px; transition: 0.2s; font-weight: 500; }
    .submenu li a:hover { color: var(--primary-blue); }

    /* 메인 콘텐츠 영역 */
    .main-content { margin-left: var(--sidebar-width); flex-grow: 1; padding: 40px; }
    .dashboard-card { background-color: #fff; border-radius: 12px; border: 1px solid var(--border-color); padding: 30px; margin-bottom: 30px; box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.05); }
    .card-title { font-size: 18px; font-weight: 800; color: #2e2f37; margin-bottom: 25px; display: flex; align-items: center; justify-content: space-between; }
    .title-sub { font-size: 12px; color: #b7b9cc; font-weight: 400; }

    /* 자주 쓰는 기능 */
    .quick-list { display: flex; gap: 25px; }
    .quick-item { flex: 1; text-align: center; text-decoration: none; color: #4e4e4e; transition: 0.3s; padding: 25px; border-radius: 12px; background: #f8f9fc; border: 1px solid transparent; }
    .quick-item:hover { background-color: #fff; border-color: var(--primary-blue); transform: translateY(-5px); box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
    .quick-icon-box { font-size: 40px; color: var(--primary-blue); margin-bottom: 15px; }
    .quick-text { font-size: 16px; font-weight: 700; }

    /* 계약현황 스타일 */
    .status-list { display: flex; justify-content: space-around; align-items: center; border-top: 1px solid #f1f3f9; padding-top: 35px; }
    .status-item { text-align: center; flex: 1; }
    .status-label { font-size: 14px; font-weight: 700; color: #858796; margin-bottom: 12px; display: flex; align-items: center; justify-content: center; gap: 8px; }
    .status-dot { width: 10px; height: 10px; border-radius: 50%; display: inline-block; }
    .status-count { font-size: 32px; font-weight: 900; color: #2e2f37; }

    /* 하단 레이아웃 */
    .bottom-row { display: flex; gap: 30px; }
    .billing-card { flex: 2; }
    .support-card { flex: 1; }
    .billing-content { display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 20px 0; border-top: 1px solid #f1f3f9; }
    .btn-pay { padding: 12px 30px; background-color: #f0f3ff; color: var(--primary-blue); border: none; border-radius: 8px; font-weight: 700; cursor: pointer; transition: 0.2s; }
    .btn-pay:hover { background-color: var(--primary-blue); color: #fff; }

    .sidebar-footer { padding: 25px; border-top: 1px solid #f1f3f9; background: #fff; }
    .user-info { font-size: 14px; font-weight: 700; margin-bottom: 12px; display: flex; align-items: center; gap: 8px; }
    .footer-links { display: flex; gap: 15px; }
    .footer-link { font-size: 13px; color: #b7b9cc; text-decoration: none; transition: 0.2s; }
    .footer-link:hover { color: #e74a3b; }
</style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-logo"><div class="logo-text">ERP SYSTEM</div></div>
        <div class="sidebar-btn-area">
            <button class="btn-start" onclick="location.href='insert.jsp'"><i class="fa-solid fa-file-signature"></i> 계약 시작하기</button>
            <div class="contract-count">남은 계약건수 <span class="count-num" id="totalCount">0</span>건</div>
        </div>
        <nav class="sidebar-menu">
            <a href="main.jsp" class="menu-item active"><i class="fa-solid fa-house menu-icon"></i> 홈</a>
            
            <div class="menu-item has-sub" onclick="toggleSub(this)"><i class="fa-solid fa-folder-open menu-icon"></i> 문서함</div>
            <ul class="submenu">
                <li><a href="my_documents.jsp">내 문서함</a></li>
                <li><a href="external_documents.jsp">외부계약서</a></li>
                <li><a href="trash_bin.jsp">휴지통</a></li>
            </ul>

            <a href="bulk_send.jsp" class="menu-item"><i class="fa-solid fa-envelopes-bulk menu-icon"></i> 대량발송</a>
            
            <a href="link_signature.jsp" class="menu-item"><i class="fa-solid fa-link menu-icon"></i> 링크서명</a>
            <a href="#" class="menu-item"><i class="fa-solid fa-scroll menu-icon"></i> 공문발송</a>
            
            <div class="menu-item has-sub" onclick="toggleSub(this)"><i class="fa-solid fa-file-lines menu-icon"></i> 템플릿 관리</div>
            <ul class="submenu">
                <li><a href="#">내 템플릿</a></li>
                <li><a href="#">서식자료실</a></li>
            </ul>
            
            <div class="menu-item has-sub" onclick="toggleSub(this)"><i class="fa-solid fa-users menu-icon"></i> 사원 명부</div>
            <ul class="submenu">
                <li><a href="total_list.jsp">전체 사원 명부</a></li> 
                <li><a href="insert.jsp">사원 등록</a></li>
                <li><a href="salary_list.jsp">급여 관리</a></li>
            </ul>
            <a href="#" class="menu-item"><i class="fa-solid fa-gear menu-icon"></i> 설정</a>
        </nav>
        
        <div class="sidebar-footer">
            <div class="user-info">
                <i class="fa-solid fa-circle-user" style="color: #d1d3e2; font-size: 18px;"></i>
                <span><%= userName %>님</span>
            </div>
            <div class="footer-links">
                <a href="logout.jsp" class="footer-link">로그아웃</a>
                <a href="withdraw_db.jsp" class="footer-link" onclick="return confirm('탈퇴하시겠습니까?')">회원탈퇴</a>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="dashboard-card">
            <div class="card-title">자주 쓰는 기능</div>
            <div class="quick-list">
                <a href="insert.jsp" class="quick-item">
                    <div class="quick-icon-box"><i class="fa-solid fa-rocket"></i></div>
                    <span class="quick-text">계약 시작하기</span>
                </a>
                <a href="my_documents.jsp" class="quick-item">
                    <div class="quick-icon-box"><i class="fa-solid fa-box-archive"></i></div>
                    <span class="quick-text">내 문서함</span>
                </a>
                <a href="bulk_send.jsp" class="quick-item">
                    <div class="quick-icon-box"><i class="fa-solid fa-envelope-open-text"></i></div>
                    <span class="quick-text">대량발송</span>
                </a>
            </div>
        </div>

        <div class="dashboard-card">
            <div class="card-title">계약현황 <span class="title-sub">(최근 1개월 기준)</span></div>
            <div class="status-list">
                <div class="status-item">
                    <span class="status-label"><span class="status-dot" style="background:#ff4d4f;"></span>작성중 ></span>
                    <div class="status-count">0</div>
                </div>
                <div class="status-item">
                    <span class="status-label"><span class="status-dot" style="background:#1890ff;"></span>진행중 ></span>
                    <div class="status-count">0</div>
                </div>
                <div class="status-item">
                    <span class="status-label"><span class="status-dot" style="background:#52c41a;"></span>완료 ></span>
                    <div class="status-count">0</div>
                </div>
                <div class="status-item">
                    <span class="status-label"><span class="status-dot" style="background:#bfbfbf;"></span>서명거부 ></span>
                    <div class="status-count">0</div>
                </div>
            </div>
        </div>

        <div class="bottom-row">
            <div class="dashboard-card billing-card">
                <div class="card-title">요금제 정보</div>
                <div class="billing-content">
                    <p style="color: #b7b9cc; font-size: 14px; margin-bottom: 20px;">이용 중인 요금제가 없습니다.</p>
                    <button class="btn-pay">결제하기</button>
                </div>
            </div>

            <div class="dashboard-card support-card">
                <div class="card-title">고객센터</div>
                <div style="font-size: 26px; font-weight: 900; color: #2e2f37; margin-bottom: 10px;">1234-5678</div>
                <p style="font-size: 12px; color: #858796; margin-bottom: 20px;">평일 09:30 - 18:30 (주말 휴무)</p>
                <div style="display:flex; gap:10px;">
                    <button class="btn-pay" style="flex:1; background:#f8f9fc; color:#4e4e4e;">이용가이드 ></button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 사이드바 서브메뉴 토글 로직
        function toggleSub(obj) {
            obj.classList.toggle('open');
            var submenu = obj.nextElementSibling;
            if (submenu.style.display === 'block') { 
                submenu.style.display = 'none'; 
            } else { 
                submenu.style.display = 'block'; 
            }
        }
    </script>
</body>
</html>