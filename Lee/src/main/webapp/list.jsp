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
        --border-color: #ebedf3;
    }

    body { margin: 0; font-family: 'Noto Sans KR', sans-serif; background-color: var(--bg-gray); display: flex; overflow-x: hidden; }
    
    /* 사이드바 스타일 */
    .sidebar { width: var(--sidebar-width); height: 100vh; background-color: #fff; border-right: 1px solid var(--border-color); position: fixed; display: flex; flex-direction: column; overflow-y: auto; z-index: 1000; }
    .sidebar-logo { padding: 30px 25px; }
    .logo-text { font-size: 24px; font-weight: 900; color: var(--primary-blue); letter-spacing: -1px; }
    .sidebar-btn-area { padding: 0 20px 25px; }
    .btn-start { width: 100%; padding: 14px; background-color: var(--primary-blue); color: #fff; border: none; border-radius: 8px; font-weight: 700; cursor: pointer; font-size: 15px; display: flex; align-items: center; justify-content: center; gap: 10px; transition: 0.3s; }
    .sidebar-menu { list-style: none; padding: 10px 0; margin: 0; flex-grow: 1; }
    .menu-item { padding: 14px 25px; display: flex; align-items: center; cursor: pointer; color: #64748b; text-decoration: none; font-size: 15px; transition: 0.2s; font-weight: 500; position: relative; }
    .menu-item.active { background-color: #f0f4ff; color: var(--primary-blue); font-weight: 700; }
    .menu-item.active::after { content: ''; position: absolute; right: 0; width: 4px; height: 100%; background: var(--primary-blue); }
    .menu-icon { width: 25px; margin-right: 12px; font-size: 17px; text-align: center; }
    
    .submenu { list-style: none; display: none; background: #fcfdfe; }
    .submenu li a { padding: 10px 20px 10px 62px; display: block; color: #858796; text-decoration: none; font-size: 14px; }

    /* 메인 콘텐츠 영역 */
    .main-content { margin-left: var(--sidebar-width); flex-grow: 1; padding: 40px; }
    .dashboard-card { background-color: #fff; border-radius: 12px; border: 1px solid var(--border-color); padding: 25px 30px; margin-bottom: 30px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03); }
    .card-title { font-size: 17px; font-weight: 700; color: #2e2f37; margin-bottom: 25px; display: flex; align-items: center; gap: 8px; }
    .title-sub { font-size: 12px; color: #94a3b8; font-weight: 400; }

    /* 자주 쓰는 기능 */
    .quick-list { display: flex; gap: 20px; }
    .quick-item { flex: 1; text-align: center; text-decoration: none; color: #333; transition: 0.2s; padding: 25px; border-radius: 12px; background: #fff; border: 1px solid var(--border-color); }
    .quick-item:hover { border-color: var(--primary-blue); transform: translateY(-3px); box-shadow: 0 6px 20px rgba(0, 98, 255, 0.1); }
    .quick-icon-box { font-size: 44px; color: var(--primary-blue); margin-bottom: 15px; }
    .quick-text { font-size: 15px; font-weight: 700; }

    /* 계약현황 스타일 */
    .status-container { display: flex; gap: 15px; margin-top: 5px; }
    .status-box { flex: 1; background: #fff; border: 1px solid var(--border-color); border-radius: 10px; padding: 20px; cursor: pointer; transition: 0.2s; position: relative; }
    .status-box:hover { border-color: var(--primary-blue); background: #f0f7ff; }
    
    .status-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 15px; }
    .status-label-group { display: flex; align-items: center; gap: 8px; }
    .status-icon { font-size: 14px; }
    .status-label { font-size: 14px; font-weight: 700; color: #64748b; }
    .status-arrow { font-size: 12px; color: #cbd5e1; }
    
    .status-value { font-size: 32px; font-weight: 900; color: #1e293b; text-align: left; }
    .status-unit { font-size: 15px; font-weight: 500; color: #94a3b8; margin-left: 4px; }

    .color-draft { color: #f59e0b; }
    .color-ing { color: #3b82f6; }
    .color-complete { color: #10b981; }
    .color-reject { color: #ef4444; }

    /* 하단 레이아웃 */
    .bottom-row { display: flex; gap: 30px; }
    .billing-card { flex: 2; }
    .support-card { flex: 1; }
    .btn-pay { padding: 12px 30px; background-color: #f0f3ff; color: var(--primary-blue); border: none; border-radius: 8px; font-weight: 700; cursor: pointer; }
</style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-logo"><div class="logo-text">ERP SYSTEM</div></div>
        <div class="sidebar-btn-area">
            <button class="btn-start" onclick="location.href='insert.jsp'"><i class="fa-solid fa-file-signature"></i> 계약 시작하기</button>
        </div>
        <nav class="sidebar-menu">
            <a href="list.jsp" class="menu-item active"><i class="fa-solid fa-house menu-icon"></i> 홈</a>
            <div class="menu-item" onclick="toggleSub(this)"><i class="fa-solid fa-folder-open menu-icon"></i> 문서함</div>
            <ul class="submenu">
                <li><a href="my_documents.jsp">내 문서함</a></li>
                <li><a href="external_documents.jsp">외부계약서</a></li>
                <li><a href="trash_bin.jsp">휴지통</a></li>
            </ul>
            <a href="bulk_send.jsp" class="menu-item"><i class="fa-solid fa-envelopes-bulk menu-icon"></i> 대량발송</a>
            <a href="link_signature.jsp" class="menu-item"><i class="fa-solid fa-link menu-icon"></i> 링크서명</a>
            <a href="official_letter_list.jsp" class="menu-item"><i class="fa-solid fa-scroll menu-icon"></i> 공문발송</a>
            
            <!-- 사이드바 템플릿 관리 메뉴 -->
            <div class="menu-item" onclick="toggleSub(this)"><i class="fa-regular fa-copy menu-icon"></i> 템플릿 관리 <i class="fa-solid fa-chevron-down" style="font-size: 10px; margin-left: auto;"></i></div>
            <ul class="submenu">
                <li><a href="my_templates.jsp">내 템플릿</a></li>
                <li><a href="template_library.jsp">서식자료실</a></li>
                <li><a href="template_management.jsp">서식관리</a></li>
            </ul>

            <a href="#" class="menu-item"><i class="fa-solid fa-stamp menu-icon"></i> 사인/도장</a>            
            <div class="menu-item" onclick="toggleSub(this)"><i class="fa-solid fa-gear menu-icon"></i> 설정 <i class="fa-solid fa-chevron-down" style="font-size: 10px; margin-left: auto;"></i></div>
        </nav>
    </div>

    <div class="main-content">
        <!-- 자주 쓰는 기능 카드 -->
        <div class="dashboard-card">
            <div class="card-title">자주 쓰는 기능</div>
            <div class="quick-list">
                <a href="insert.jsp" class="quick-item">
                    <div class="quick-icon-box"><i class="fa-solid fa-file-signature"></i></div>
                    <span class="quick-text">계약 시작하기</span>
                </a>
                <a href="my_documents.jsp" class="quick-item">
                    <div class="quick-icon-box"><i class="fa-solid fa-folder-tree"></i></div>
                    <span class="quick-text">내 문서함</span>
                </a>
                <!-- 수정됨: 내 템플릿 링크 연결 -->
                <a href="my_templates.jsp" class="quick-item">
                    <div class="quick-icon-box"><i class="fa-regular fa-copy"></i></div>
                    <span class="quick-text">내 템플릿</span>
                </a>
            </div>
        </div>

        <!-- 계약현황 카드 -->
        <div class="dashboard-card">
            <div class="card-title">계약현황 <span class="title-sub">(최근 1개월 기준)</span></div>
            <div class="status-container">
                <div class="status-box" onclick="location.href='my_documents.jsp?status=draft'">
                    <div class="status-header">
                        <div class="status-label-group">
                            <i class="fa-solid fa-pen-to-square status-icon color-draft"></i>
                            <span class="status-label">작성중</span>
                        </div>
                        <i class="fa-solid fa-chevron-right status-arrow"></i>
                    </div>
                    <div class="status-value">0<span class="status-unit">건</span></div>
                </div>

                <div class="status-box" onclick="location.href='my_documents.jsp?status=ing'">
                    <div class="status-header">
                        <div class="status-label-group">
                            <i class="fa-solid fa-clock-rotate-left status-icon color-ing"></i>
                            <span class="status-label">진행중</span>
                        </div>
                        <i class="fa-solid fa-chevron-right status-arrow"></i>
                    </div>
                    <div class="status-value">0<span class="status-unit">건</span></div>
                </div>

                <div class="status-box" onclick="location.href='my_documents.jsp?status=complete'">
                    <div class="status-header">
                        <div class="status-label-group">
                            <i class="fa-solid fa-circle-check status-icon color-complete"></i>
                            <span class="status-label">완료</span>
                        </div>
                        <i class="fa-solid fa-chevron-right status-arrow"></i>
                    </div>
                    <div class="status-value">0<span class="status-unit">건</span></div>
                </div>

                <div class="status-box" onclick="location.href='my_documents.jsp?status=reject'">
                    <div class="status-header">
                        <div class="status-label-group">
                            <i class="fa-solid fa-circle-xmark status-icon color-reject"></i>
                            <span class="status-label">서명거부</span>
                        </div>
                        <i class="fa-solid fa-chevron-right status-arrow"></i>
                    </div>
                    <div class="status-value">0<span class="status-unit">건</span></div>
                </div>
            </div>
        </div>

        <div class="bottom-row">
            <div class="dashboard-card billing-card">
                <div class="card-title">요금제 정보</div>
                <div style="display: flex; flex-direction: column; align-items: center; padding: 20px 0;">
                    <p style="color: #94a3b8; font-size: 14px; margin-bottom: 20px;">이용 중인 요금제가 없습니다.</p>
                    <button class="btn-pay">결제하기</button>
                </div>
            </div>

            <div class="dashboard-card support-card">
                <div class="card-title">고객센터</div>
                <div style="font-size: 24px; font-weight: 800; color: #1e293b; margin-bottom: 5px;">1234-5678</div>
                <button class="btn-pay" style="width:100%; background:#f8f9fc; color:#4e4e4e;">이용가이드 보러가기</button>
            </div>
        </div>
    </div>

    <script>
        function toggleSub(obj) {
            var submenu = obj.nextElementSibling;
            if (submenu && submenu.classList.contains('submenu')) {
                submenu.style.display = (submenu.style.display === 'block') ? 'none' : 'block';
            }
        }
    </script>
</body>
</html>