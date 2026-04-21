<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String userName = (String)session.getAttribute("userName");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP SYSTEM - 홈</title>
<style>
    body { margin: 0; font-family: 'Malgun Gothic', 'Apple SD Gothic Neo', sans-serif; background-color: #f8f9fa; display: flex; overflow-x: hidden; }
    
    /* 사이드바 스타일 */
    .sidebar { width: 260px; height: 100vh; background-color: #fff; border-right: 1px solid #e1e4e8; position: fixed; display: flex; flex-direction: column; overflow-y: auto; z-index: 1000; }
    .sidebar-logo { padding: 25px 20px; }
    .logo-text { font-size: 22px; font-weight: 800; color: #0062ff; letter-spacing: -1px; }
    .sidebar-btn-area { padding: 0 20px 20px 20px; }
    .btn-start { width: 100%; padding: 14px; background-color: #0062ff; color: #fff; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; font-size: 15px; margin-bottom: 10px; display: flex; align-items: center; justify-content: center; gap: 8px; }
    .contract-count { font-size: 13px; color: #666; text-align: center; }
    .count-num { color: #0062ff; font-weight: 600; }
    
    .sidebar-menu { list-style: none; padding: 0; margin: 0; }
    .menu-item { padding: 13px 20px; display: flex; align-items: center; cursor: pointer; color: #333; text-decoration: none; font-size: 15px; position: relative; transition: 0.2s; font-weight: 500; }
    .menu-item:hover { background-color: #f8f9fa; color: #0062ff; }
    .menu-item.active { background-color: #f0f7ff; color: #0062ff; font-weight: 600; }
    .menu-icon { width: 25px; margin-right: 12px; font-size: 18px; text-align: center; }
    .has-sub::after { content: '∨'; position: absolute; right: 20px; font-size: 10px; transition: 0.3s; color: #bbb; }
    .has-sub.open::after { transform: rotate(180deg); }
    .submenu { list-style: none; padding: 0; background-color: #fff; display: none; }
    .submenu li a { padding: 10px 20px 10px 57px; display: block; color: #555; text-decoration: none; font-size: 14px; transition: 0.2s; font-weight: 500; }
    .submenu li a:hover { color: #0062ff; background-color: #fcfcfc; }

    /* 메인 콘텐츠 영역 */
    .main-content { margin-left: 260px; flex-grow: 1; padding: 40px; }
    
    /* 공통 카드 스타일 */
    .dashboard-card { background-color: #fff; border-radius: 12px; border: 1px solid #e1e4e8; padding: 25px; margin-bottom: 25px; }
    .card-title { font-size: 16px; font-weight: 700; color: #333; margin-bottom: 20px; display: block; }
    .title-sub { font-size: 12px; color: #aaa; font-weight: 400; margin-left: 5px; }

    /* 자주 쓰는 기능 */
    .quick-list { display: flex; gap: 20px; justify-content: center; align-items: center; padding: 10px 0; }
    .quick-item { flex: 1; text-align: center; text-decoration: none; color: #333; transition: 0.2s; padding: 20px; border-radius: 12px; }
    .quick-item:hover { background-color: #f8f9fa; transform: translateY(-5px); }
    .quick-img-box { width: 100%; height: 80px; display: flex; align-items: center; justify-content: center; margin-bottom: 10px; }
    .quick-img { width: 50px; height: 50px; object-fit: contain; }
    .quick-text { font-size: 15px; font-weight: 600; display: block; }

    /* 계약현황 스타일 */
    .status-list { display: flex; justify-content: space-around; align-items: center; border-top: 1px solid #f1f1f1; padding-top: 30px; }
    .status-item { text-align: center; flex: 1; cursor: pointer; }
    .status-header { display: flex; align-items: center; justify-content: center; gap: 5px; margin-bottom: 15px; font-size: 15px; font-weight: 600; color: #444; }
    .status-dot { width: 22px; height: 22px; border-radius: 6px; display: inline-flex; align-items: center; justify-content: center; font-size: 10px; }
    .status-count { font-size: 24px; font-weight: 800; color: #333; }

    /* 하단 레이아웃 */
    .bottom-row { display: flex; gap: 25px; }
    .billing-card { flex: 2; min-height: 180px; display: flex; flex-direction: column; }
    .support-card { flex: 1; }
    .billing-content { flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; border-top: 1px solid #f1f1f1; }
    .btn-pay { padding: 10px 25px; background-color: #f0f7ff; color: #0062ff; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; }
    .support-info { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
    .support-num { font-size: 22px; font-weight: 800; color: #333; }
    .support-btns { display: flex; gap: 10px; }
    .btn-outline { flex: 1; padding: 14px; background: #f8f9fa; border: none; border-radius: 8px; font-size: 13px; font-weight: 600; cursor: pointer; text-align: center; color: #444; }

    .sidebar-footer { padding: 20px; border-top: 1px solid #f1f1f1; margin-top: auto; background: #fff; }
    .footer-link { display: block; padding: 8px 0; color: #888; text-decoration: none; font-size: 13px; font-weight: 500; }
</style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-logo"><div class="logo-text">ERP SYSTEM</div></div>
        <div class="sidebar-btn-area">
            <button class="btn-start" onclick="location.href='insert.jsp'">🚀 계약 시작하기</button>
            <div class="contract-count">남은 계약건수 <span class="count-num" id="totalCount">0</span>건</div>
        </div>
        <nav class="sidebar-menu">
            <a href="main.jsp" class="menu-item active"><span class="menu-icon">🏠</span> 홈</a>
            
            <div class="menu-item has-sub" onclick="toggleSub(this)"><span class="menu-icon">📁</span> 문서함</div>
            <ul class="submenu">
                <li><a href="my_documents.jsp">내 문서함</a></li>
                <li><a href="external_documents.jsp">외부계약서</a></li>
                <li><a href="trash_bin.jsp">휴지통</a></li>
            </ul>

            <a href="#" class="menu-item"><span class="menu-icon">📇</span> 대량발송</a>
            <a href="#" class="menu-item"><span class="menu-icon">🔗</span> 링크서명</a>
            <a href="#" class="menu-item"><span class="menu-icon">📜</span> 공문발송</a>
            <div class="menu-item has-sub" onclick="toggleSub(this)"><span class="menu-icon">📄</span> 템플릿 관리</div>
            <ul class="submenu">
                <li><a href="#">내 템플릿</a></li>
                <li><a href="#">서식자료실</a></li>
                <li><a href="#">서식관리</a></li>
            </ul>
            <a href="#" class="menu-item"><span class="menu-icon">🖋️</span> 사인/도장</a>
            
            <div class="menu-item has-sub open" onclick="toggleSub(this)"><span class="menu-icon">👥</span> 사원 명부</div>
            <ul class="submenu" style="display: block;">
                <li><a href="total_list.jsp">전체 사원 명부</a></li> 
                <li><a href="insert.jsp">사원 등록</a></li>
                <li><a href="salary_list.jsp">급여 관리</a></li>
            </ul>
            <a href="#" class="menu-item"><span class="menu-icon">⚙️</span> 설정</a>
        </nav>
        <div class="sidebar-footer">
            <% if(userName != null) { %>
                <div style="font-size:13px; margin-bottom:5px; font-weight: 600;"><b><%= userName %>님</b> 접속중</div>
                <a href="logout.jsp" class="footer-link">🔓 로그아웃</a>
                <a href="withdraw_db.jsp" class="footer-link" onclick="return confirm('탈퇴하시겠습니까?')" style="font-size:11px;">회원탈퇴</a>
            <% } else { %>
                <a href="login.jsp" class="footer-link">🔒 로그인</a>
            <% } %>
        </div>
    </div>

    <div class="main-content">
        <div class="dashboard-card">
            <span class="card-title">자주 쓰는 기능</span>
            <div class="quick-list">
                <a href="insert.jsp" class="quick-item" style="background-color: #f8f9fa;">
                    <div class="quick-img-box"><img src="https://cdn-icons-png.flaticon.com/512/3064/3064155.png" class="quick-img"></div>
                    <span class="quick-text">계약 시작하기</span>
                </a>
                <a href="my_documents.jsp" class="quick-item">
                    <div class="quick-img-box"><img src="https://cdn-icons-png.flaticon.com/512/3767/3767084.png" class="quick-img"></div>
                    <span class="quick-text">내 문서함</span>
                </a>
                <a href="#" class="quick-item">
                    <div class="quick-img-box"><img src="https://cdn-icons-png.flaticon.com/512/2991/2991108.png" class="quick-img"></div>
                    <span class="quick-text">내 템플릿</span>
                </a>
            </div>
        </div>

        <div class="dashboard-card">
            <span class="card-title">계약현황 <span class="title-sub">(최근 1개월)</span></span>
            <div class="status-list">
                <div class="status-item">
                    <div class="status-header"><span class="status-dot" style="background:#fff1f0; color:#ff4d4f;">•••</span> 작성중 ></div>
                    <div class="status-count">0건</div>
                </div>
                <div class="status-item">
                    <div class="status-header"><span class="status-dot" style="background:#e6f7ff; color:#1890ff;">•••</span> 진행중 ></div>
                    <div class="status-count">0건</div>
                </div>
                <div class="status-item">
                    <div class="status-header"><span class="status-dot" style="background:#f6ffed; color:#52c41a;">✓</span> 완료 ></div>
                    <div class="status-count">0건</div>
                </div>
                <div class="status-item">
                    <div class="status-header"><span class="status-dot" style="background:#f5f5f5; color:#bfbfbf;">✕</span> 서명거부 ></div>
                    <div class="status-count">0건</div>
                </div>
            </div>
        </div>

        <div class="bottom-row">
            <div class="dashboard-card billing-card">
                <span class="card-title">요금제</span>
                <div class="billing-content">
                    <div style="color: #888; font-size: 14px; margin-bottom: 15px;">이용 중인 요금제가 없습니다.</div>
                    <button class="btn-pay">결제하기</button>
                </div>
            </div>

            <div class="dashboard-card support-card">
                <div class="support-info">
                    <div>
                        <div class="support-num">1234-5678</div>
                        <div style="font-size: 12px; color: #888;">싸인오케이 고객센터</div>
                    </div>
                    <div style="font-size: 30px; color: #ff4d4f;">📞</div>
                </div>
                <div class="support-btns">
                    <button class="btn-outline">서비스 설정 ></button>
                    <button class="btn-outline">이용가이드 ></button>
                </div>
            </div>
        </div>
    </div>

    <%
        int totalCount = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/company?serverTimezone=UTC", "root", "root1234");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM employee");
            if(rs.next()) totalCount = rs.getInt(1);
            conn.close();
        } catch (Exception e) { }
    %>

    <script>
        document.getElementById('totalCount').innerText = '<%= totalCount %>';
        function toggleSub(obj) {
            obj.classList.toggle('open');
            var submenu = obj.nextElementSibling;
            if (submenu.style.display === 'block') { submenu.style.display = 'none'; } 
            else { submenu.style.display = 'block'; }
        }
    </script>
</body>
</html>