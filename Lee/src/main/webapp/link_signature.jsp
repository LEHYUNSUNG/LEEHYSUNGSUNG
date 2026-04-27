<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ERP SYSTEM - 링크서명</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* 기본 설정 */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f0f2f5; color: #333; }
        a { text-decoration: none; color: inherit; }

        /* 헤더 & 사이드바 */
        .header { position: fixed; top: 0; left: 0; right: 0; height: 60px; background: #fff; border-bottom: 1px solid #e3e6f0; display: flex; align-items: center; justify-content: space-between; padding: 0 24px; z-index: 1000; }
        .sidebar { width: 240px; background: #fff; border-right: 1px solid #e3e6f0; height: 100vh; position: fixed; top: 0; left: 0; padding-top: 80px; z-index: 900; }
        .main-content { margin-left: 240px; margin-top: 60px; padding: 40px; min-height: calc(100vh - 60px); }

        /* 사이드바 메뉴 */
        .btn-contract-start { margin: 0 20px 25px; background: #2e59d9; color: #fff; padding: 14px; border-radius: 8px; text-align: center; font-weight: 700; border: none; width: calc(100% - 40px); cursor: pointer; font-size: 14px; }
        .nav-item { padding: 12px 25px; font-size: 14px; color: #4e73df; display: flex; align-items: center; gap: 12px; cursor: pointer; transition: 0.2s; }
        .nav-item:hover { background: #f8f9fc; }
        .nav-item.active { background: #f0f3ff; font-weight: 700; border-right: 4px solid #2e59d9; }

        /* 통합 카드 스타일 */
        .content-card { background: #fff; border: 1px solid #e3e6f0; border-radius: 12px; padding: 30px; margin-bottom: 30px; box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.03); }
        
        /* [핵심] 제목 하단 연한 구분선 추가 */
        .section-header { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            padding-bottom: 15px; 
            margin-bottom: 25px; 
            border-bottom: 1px solid #f2f4f7; /* 매우 연한 선 */
        }
        
        .section-title { font-size: 17px; font-weight: 700; color: #333; display: flex; align-items: center; gap: 8px; }
        .section-title i.chevron { font-size: 12px; color: #b7b9cc; }

        /* 자주 쓰는 템플릿 영역 */
        .add-template-btn { width: 220px; height: 140px; border: 2px dashed #eaecf4; border-radius: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center; color: #b7b9cc; cursor: pointer; background: #fafafa; transition: 0.2s; }
        .add-template-btn:hover { background: #f8f9fc; border-color: #4e73df; color: #4e73df; }

        /* 필터 영역 */
        .filter-box { display: flex; flex-wrap: wrap; gap: 12px; align-items: flex-end; margin-bottom: 40px; }
        .filter-item { display: flex; flex-direction: column; gap: 6px; }
        .filter-item label { font-size: 12px; font-weight: 700; color: #858796; margin-left: 2px; }
        .filter-item select, .filter-item input { height: 38px; border: 1px solid #d1d3e2; border-radius: 6px; padding: 0 12px; font-size: 13px; color: #6e707e; outline: none; }
        .filter-item select:focus, .filter-item input:focus { border-color: #4e73df; }

        /* 검색창 세부 디자인 */
        .search-group { display: flex; border: 1px solid #d1d3e2; border-radius: 6px; overflow: hidden; }
        .search-group select { border: none; border-right: 1px solid #d1d3e2; border-radius: 0; background: #f8f9fc; }
        .search-group input { border: none; width: 220px; }
        .btn-search { background: #fff; border: none; padding: 0 12px; color: #b7b9cc; cursor: pointer; }
        
        .btn-secondary { height: 38px; background: #fff; border: 1px solid #d1d3e2; border-radius: 6px; padding: 0 18px; font-size: 13px; color: #4e73df; font-weight: 600; cursor: pointer; transition: 0.2s; }
        .btn-secondary:hover { background: #f8f9fc; }
        .btn-folder-mgmt { margin-left: auto; height: 38px; background: #fff; border: 1px solid #d1d3e2; border-radius: 6px; padding: 0 18px; font-size: 13px; color: #6e707e; cursor: pointer; }

        /* 하단 빈 상태 (Empty State) */
        .empty-state { text-align: center; padding: 80px 0; }
        .icon-circle { width: 90px; height: 90px; background: #f8faff; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 25px; font-size: 32px; color: #4e73df; border: 1px solid #eef2ff; }
        .empty-title { font-size: 19px; font-weight: 700; color: #2e2e2e; margin-bottom: 12px; }
        .empty-desc { font-size: 14px; color: #858796; margin-bottom: 35px; line-height: 1.6; }
        .btn-start { background: #2e59d9; color: #fff; border: none; padding: 14px 40px; border-radius: 8px; font-weight: 700; cursor: pointer; transition: 0.3s; font-size: 15px; }
        .btn-start:hover { background: #224abe; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(46,89,217,0.2); }

        /* 상단 버튼 그룹 */
        .btn-group { display: flex; gap: 10px; }
        .btn-outline-sm { background: #fff; border: 1px solid #d1d3e2; padding: 8px 16px; border-radius: 6px; font-size: 12px; font-weight: 600; color: #6e707e; cursor: pointer; }
        .btn-primary-sm { background: #2e59d9; color: #fff; border: none; padding: 8px 16px; border-radius: 6px; font-size: 12px; font-weight: 600; cursor: pointer; }
    </style>
</head>
<body>

    <header class="header">
        <div style="font-weight: 800; color: #2e59d9; font-size: 20px; letter-spacing: -0.5px;">
            <i class="fa-solid fa-file-signature"></i> ERP SYSTEM
        </div>
        <div style="display: flex; align-items: center; gap: 20px;">
            <i class="fa-regular fa-bell" style="color: #b7b9cc; font-size: 20px; cursor: pointer;"></i>
            <div style="width: 35px; height: 35px; background: #eaecf4; border-radius: 50%; cursor: pointer;"></div>
        </div>
    </header>

    <nav class="sidebar">
        <button class="btn-contract-start">계약 시작하기</button>
        <div class="nav-list">
            <a href="list.jsp"><div class="nav-item"><i class="fa-solid fa-house"></i> 홈</div></a>
            <a href="my_documents.jsp"><div class="nav-item"><i class="fa-solid fa-file-lines"></i> 내 문서함</div></a>
            <a href="extemal_documents.jsp"><div class="nav-item"><i class="fa-solid fa-earth-americas"></i> 외부계약서</div></a>
            <a href="bulk_send.jsp"><div class="nav-item"><i class="fa-solid fa-layer-group"></i> 대량발송</div></a>
            <a href="link_signature.jsp"><div class="nav-item active"><i class="fa-solid fa-link"></i> 링크서명</div></a>
            <a href="trash_bin.jsp"><div class="nav-item"><i class="fa-solid fa-trash-can"></i> 휴지통</div></a>
            <div style="margin: 20px 25px 10px; font-size: 11px; font-weight: 700; color: #b7b9cc; text-transform: uppercase;">Management</div>
            <div class="nav-item"><i class="fa-solid fa-user-gear"></i> 사원 명부</div>
            <div class="nav-item"><i class="fa-solid fa-gear"></i> 설정</div>
        </div>
    </nav>

    <main class="main-content">
        
        <div class="content-card">
            <div class="section-header">
                <h3 class="section-title">자주 쓰는 템플릿 <i class="fa-solid fa-chevron-right chevron"></i></h3>
                <div class="btn-group">
                    <button class="btn-outline-sm">템플릿 가져오기</button>
                    <button class="btn-primary-sm">+ 템플릿 만들기</button>
                </div>
            </div>
            <div class="template-grid">
                <div class="add-template-btn">
                    <i class="fa-solid fa-plus" style="font-size: 22px; margin-bottom: 12px; color: #d1d3e2;"></i>
                    <span style="font-size: 13px; font-weight: 500;">자주 쓰는 템플릿 추가</span>
                </div>
            </div>
        </div>

        <div class="content-card">
            <div class="section-header">
                <h3 class="section-title">링크서명 문서함</h3>
            </div>

            <div class="filter-box">
                <div class="filter-item">
                    <label>진행 상태</label>
                    <select style="width: 110px;"><option>전체</option></select>
                </div>
                <div class="filter-item">
                    <label>폴더</label>
                    <select style="width: 110px;"><option>전체</option></select>
                </div>
                <div class="filter-item">
                    <label>멤버</label>
                    <select style="width: 110px;"><option>전체</option></select>
                </div>
                <div class="filter-item">
                    <label>기간</label>
                    <select style="width: 130px;"><option>전체기간</option></select>
                </div>
                <div class="filter-item">
                    <label>검색어</label>
                    <div class="search-group">
                        <select style="width: 100px;"><option>계약서명</option></select>
                        <input type="text" placeholder="검색어를 입력하세요">
                        <button class="btn-search"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </div>
                </div>
                <button class="btn-secondary">상세검색</button>
                <button class="btn-folder-mgmt">폴더관리</button>
            </div>

            <div class="empty-state">
                <div class="icon-circle">
                    <i class="fa-solid fa-link"></i>
                </div>
                <h4 class="empty-title">불특정 다수에게 링크/QR코드로 서명된 문서를 수집해보세요.</h4>
                <p class="empty-desc">
                    QR코드/URL 링크만 공유하여 어디서든 서명을 받을 수 있습니다.<br>
                    작성된 문서는 실시간으로 문서함에 저장됩니다.
                </p>
                <button class="btn-start">링크서명 시작하기</button>
            </div>
        </div>

    </main>

</body>
</html>