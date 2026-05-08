<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>템플릿 관리 - 내 템플릿</title>
    <style>
        /* 기본 초기화 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
        }

        body {
            display: flex;
            background-color: #fff;
            color: #333;
            height: 100vh;
            overflow: hidden;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        /* --- 사이드바 --- */
        .sidebar {
            width: 230px; 
            background-color: #fcfcfd; /* 살짝 밝은 회색톤으로 세련되게 */
            border-right: 1px solid #eee;
            display: flex;
            flex-direction: column;
            padding-top: 20px;
            flex-shrink: 0;
        }

        .btn-contract-start {
            background-color: #0066ff;
            color: white;
            border: none;
            margin: 0 15px 10px 15px;
            padding: 12px 0;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            font-size: 14px;
            text-align: center;
            display: block;
        }

        .contract-count {
            font-size: 12px;
            color: #888;
            margin: 0 20px 25px 20px;
        }

        .contract-count span {
            color: #0066ff;
            font-weight: bold;
        }

        /* 메뉴 공통 스타일 */
        .nav-menu {
            list-style: none;
        }

        .nav-item a {
            padding: 12px 20px;
            font-size: 14px;
            color: #444;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: 0.2s;
        }

        .nav-item:hover {
            background-color: #f2f4f7;
        }

        .nav-item.active > a {
            color: #0066ff;
            font-weight: bold;
        }

        /* --- 두 번째 사진(문서함 스타일) 적용: 서브 메뉴 --- */
        .sub-menu {
            list-style: none;
            background-color: #f8f9fb; /* 하위 메뉴 영역 배경색 분리 */
            padding: 5px 0;
        }

        .sub-item a {
            /* 이미지 cf37a0.png 처럼 여유 있는 간격과 아이콘 공간 확보 */
            padding: 10px 20px 10px 48px; 
            font-size: 13.5px;
            color: #666;
            display: flex;
            align-items: center;
            position: relative;
        }

        /* 선택된 메뉴 스타일 (내 템플릿) */
        .sub-item.selected a {
            color: #0066ff;
            font-weight: 600;
            background-color: #eff5ff; /* 부드러운 강조 배경 */
        }

        /* 선택된 메뉴 왼쪽 파란색 바(Indicator) - 필요 시 추가 */
        .sub-item.selected a::before {
            content: "";
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 3px;
            background-color: #0066ff;
        }

        /* --- 메인 콘텐츠 --- */
        .main-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            background-color: #fff;
        }

        .top-header {
            height: 60px;
            display: flex;
            align-items: center;
            padding: 0 30px;
            background: #fff;
            border-bottom: 1px solid #eee;
            font-size: 16px;
            font-weight: 700;
        }

        .content-area {
            padding: 30px 40px;
            overflow-y: auto;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .section-header h2 {
            font-size: 17px;
            font-weight: 700;
        }

        .header-btns {
            display: flex;
            gap: 8px;
        }

        .header-btns button {
            padding: 8px 16px;
            font-size: 13px;
            border-radius: 4px;
            cursor: pointer;
            border: 1px solid #e0e0e0;
            background: #fff;
            color: #555;
            font-weight: 500;
        }

        .btn-create-blue {
            background: #0066ff !important;
            border: 1px solid #0066ff !important;
            color: #fff !important;
        }

        /* 자주 쓰는 템플릿 카드 */
        .fav-box {
            width: 280px;
            height: 160px;
            border: 1px dashed #d0d7de;
            border-radius: 8px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background: #fff;
            color: #888;
            font-size: 14px;
            cursor: pointer;
            margin-bottom: 40px;
            transition: 0.2s;
        }

        .fav-box:hover {
            border-color: #0066ff;
            background-color: #f8faff;
        }

        /* 필터/테이블 스타일 */
        .filter-bar {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }

        .filter-bar select, .search-container input {
            padding: 9px 12px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            font-size: 13px;
        }

        .search-container {
            display: flex;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
        }

        .search-container input { border: none; width: 250px; outline: none; }

        /* 빈 상태 안내 */
        .empty-placeholder {
            text-align: center;
            padding: 80px 0;
            border-top: 1px solid #eee;
        }

        .empty-icon {
            width: 60px;
            height: 60px;
            margin: 0 auto 20px;
            background: #f5f5f5;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            color: #ccc;
        }

        .btn-create-large {
            background: #0066ff;
            color: #fff;
            border: none;
            padding: 14px 45px;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            font-size: 15px;
            margin-top: 25px;
        }
    </style>
</head>
<body>

    <aside class="sidebar">
        <a href="new_contract.jsp" class="btn-contract-start">계약 시작하기</a>
        <p class="contract-count">남은 계약건수 <span>0건</span></p>
        
        <ul class="nav-menu">
            <li class="nav-item"><a href="list.jsp">🏠 홈</a></li>
            <li class="nav-item"><a href="my_documents.jsp">📁 문서함</a></li>
            <li class="nav-item"><a href="bulk_send.jsp">📢 대량발송</a></li>
            <li class="nav-item"><a href="link_signature.jsp">🔗 링크서명</a></li>
            <li class="nav-item"><a href="official_letter_list.jsp">✉️ 공문발송</a></li>
            
            <li class="nav-item active">
                <a href="my_templates.jsp">📋 템플릿 관리</a>
                <ul class="sub-menu">
                    <li class="sub-item selected"><a href="my_templates.jsp">내 템플릿</a></li>
                    <li class="sub-item"><a href="template_library.jsp">서식자료실</a></li>
                    <li class="sub-item"><a href="template_management.jsp">서식관리</a></li>
                </ul>
            </li>
            
            <li class="nav-item"><a href="signature.jsp">🖋️ 사인/도장</a></li>
            <li class="nav-item"><a href="settings.jsp">⚙️ 설정</a></li>
        </ul>
    </aside>

    <div class="main-container">
        <header class="top-header">템플릿 관리</header>

        <div class="content-area">
            <div class="section-header">
                <h2>자주 쓰는 템플릿 &gt;</h2>
                <div class="header-btns">
                    <button type="button">템플릿 가져오기</button>
                    <button type="button" class="btn-create-blue" onclick="location.href='create_template.jsp'">+ 템플릿 만들기</button>
                </div>
            </div>

            <div class="fav-box" onclick="location.href='create_template.jsp'">
                <div style="font-size: 28px; margin-bottom: 10px; color: #ccc;">+</div>
                자주 쓰는 템플릿
            </div>

            <div class="filter-bar">
                <select><option>전체</option></select>
                <select><option>전체기간</option></select>
                <div class="search-container">
                    <select style="border:none; background:none; padding-right:5px;"><option>템플릿명</option></select>
                    <input type="text" placeholder="검색어를 입력하세요">
                </div>
            </div>

            <table style="width: 100%; border-collapse: collapse; background: #fff; border-top: 1px solid #333;">
                <thead>
                    <tr style="border-bottom: 1px solid #eee; background-color: #fcfcfc;">
                        <th style="width: 50px; padding: 15px;"><input type="checkbox"></th>
                        <th style="text-align: left; font-size: 13px; color: #666; font-weight: 600;">계약유형</th>
                        <th style="text-align: left; font-size: 13px; color: #666; font-weight: 600;">템플릿 제목</th>
                        <th style="text-align: left; font-size: 13px; color: #666; font-weight: 600;">작성자</th>
                        <th style="text-align: left; font-size: 13px; color: #666; font-weight: 600;">작성일</th>
                        <th style="text-align: left; font-size: 13px; color: #666; font-weight: 600;">마지막 활동일</th>
                    </tr>
                </thead>
            </table>

            <div class="empty-placeholder">
                <div class="empty-icon">📄</div>
                <p style="font-size: 17px; margin-bottom: 10px; color: #222;">자주쓰는 문서는 템플릿으로 만들어보세요.</p>
                <span style="font-size: 14px; color: #888; line-height: 1.6;">서명 영역, 텍스트 등의 입력항목을 지정하여<br>빠르게 계약서를 발송할 수 있어요.</span>
                <br>
                <button type="button" class="btn-create-large" onclick="location.href='create_template.jsp'">템플릿 만들기</button>
            </div>
        </div>
    </div>

</body>
</html>