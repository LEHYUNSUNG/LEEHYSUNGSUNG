<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ERP SYSTEM - 휴지통</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* 기본 스타일 초기화 */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f8f9fc; color: #333; display: flex; }
        a { text-decoration: none; color: inherit; display: block; width: 100%; }

        /* [사진 2 스타일] 사이드바 영역 */
        .sidebar { width: 250px; background: #fff; border-right: 1px solid #e3e6f0; height: 100vh; position: fixed; padding: 30px 0; z-index: 100; }
        .logo { padding: 0 25px 40px; font-weight: 800; color: #4e73df; font-size: 24px; letter-spacing: -0.5px; }
        .nav-menu { list-style: none; }
        .nav-section-title { font-size: 12px; font-weight: 700; color: #b7b9cc; padding: 15px 25px 10px; text-transform: uppercase; }
        .nav-item { padding: 14px 25px; font-size: 15px; cursor: pointer; color: #6e707e; display: flex; align-items: center; gap: 12px; transition: 0.2s; position: relative; }
        .nav-item:hover { background: #f8f9fc; color: #4e73df; }
        .nav-item.active { color: #4e73df; font-weight: 700; background: #f0f3ff; }
        .nav-item.active::after { content: ''; position: absolute; right: 0; top: 0; width: 4px; height: 100%; background: #4e73df; }

        /* 메인 콘텐츠 영역 */
        .main-container { margin-left: 250px; width: calc(100% - 250px); padding: 40px; min-height: 100vh; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .page-title { font-size: 22px; font-weight: 700; color: #222; }

        /* [사진 1 스타일] 상세 필터 바 */
        .filter-card { 
            background: #fff; border-radius: 10px; border: 1px solid #e3e6f0; 
            padding: 20px; margin-bottom: 25px; display: flex; align-items: flex-end; gap: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
            overflow-x: auto; /* 화면 작아질 때 스크롤 */
        }
        .filter-group { display: flex; flex-direction: column; gap: 6px; }
        .filter-group label { font-size: 11px; color: #b7b9cc; font-weight: 700; }
        .filter-group select, .filter-group input { 
            height: 38px; padding: 0 10px; border: 1px solid #d1d3e2; border-radius: 4px; font-size: 13px; outline: none; color: #6e707e;
        }
        .search-input { width: 180px; }
        
        .btn-search-icon { height: 38px; width: 38px; background: #fff; border: 1px solid #d1d3e2; border-radius: 4px; cursor: pointer; color: #b7b9cc; }
        .btn-detail { height: 38px; padding: 0 15px; background: #fff; border: 1px solid #d1d3e2; border-radius: 4px; color: #4e73df; font-size: 13px; font-weight: 600; cursor: pointer; }

        /* 우측 상단 버튼 그룹 */
        .top-action-group { margin-left: auto; display: flex; gap: 8px; }
        .btn-white { height: 38px; padding: 0 15px; background: #fff; border: 1px solid #d1d3e2; border-radius: 4px; color: #5a5c69; font-size: 13px; font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 6px; }
        .btn-trash-empty { color: #e74a3b; border-color: #f5c6cb; }
        .btn-trash-empty:hover { background: #fff1f0; }

        /* 빈 화면 컨테이너 */
        .empty-card { 
            background: #fff; border-radius: 10px; border: 1px solid #e3e6f0; 
            height: 450px; display: flex; flex-direction: column; align-items: center; justify-content: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.02);
        }
        .empty-icon { font-size: 60px; color: #f1f3f9; margin-bottom: 20px; }
        .empty-text { color: #b7b9cc; font-size: 16px; font-weight: 500; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="logo">ERP SYSTEM</div>
        <ul class="nav-menu">
            <li><a href="list.jsp"><div class="nav-item">🏠 홈</div></a></li>
            <div class="nav-section-title">Documents</div>
            <li><a href="my_documents.jsp"><div class="nav-item">📄 내 문서함</div></a></li>
            <li><a href="external_documents.jsp"><div class="nav-item">🌐 외부계약서</div></a></li>
            <li><a href="trash_bin.jsp"><div class="nav-item active">🗑️ 휴지통</div></a></li>
            <div class="nav-section-title">Management</div>
            <li><a href="employees.jsp"><div class="nav-item">👥 사원 명부</div></a></li>
            <li><a href="settings.jsp"><div class="nav-item">⚙️ 설정</div></a></li>
        </ul>
    </div>

    <div class="main-container">
        
        <div class="page-header">
            <h2 class="page-title">휴지통</h2>
        </div>

        <div class="filter-card">
            <div class="filter-group">
                <label>계약 유형</label>
                <select style="width: 80px;"><option>전체</option></select>
            </div>
            <div class="filter-group">
                <label>진행 상태</label>
                <select style="width: 80px;"><option>전체</option></select>
            </div>
            <div class="filter-group">
                <label>폴더</label>
                <select style="width: 80px;"><option>전체</option></select>
            </div>
            <div class="filter-group">
                <label>멤버</label>
                <select style="width: 80px;"><option>전체</option></select>
            </div>
            <div class="filter-group">
                <label>기간</label>
                <select style="width: 100px;"><option>전체기간</option></select>
            </div>
            <div class="filter-group">
                <label>검색어</label>
                <div style="display: flex; gap: 5px;">
                    <select style="width: 90px;"><option>계약서명</option></select>
                    <input type="text" class="search-input" placeholder="검색어를 입력하세요">
                    <button class="btn-search-icon"><i class="fa-solid fa-magnifying-glass"></i></button>
                </div>
            </div>
            <button class="btn-detail">상세검색</button>

            <div class="top-action-group">                
                <button class="btn-white btn-trash-empty"><i class="fa-solid fa-trash-can"></i> 휴지통 비우기</button>
            </div>
        </div>

        <div class="empty-card">
            <div class="empty-icon">
                <i class="fa-solid fa-box-open"></i>
            </div>
            <div class="empty-text">삭제된 문서가 없습니다.</div>
        </div>
    </div>

</body>
</html>