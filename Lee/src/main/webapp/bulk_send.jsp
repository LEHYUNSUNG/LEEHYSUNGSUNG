<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ERP SYSTEM - 대량발송</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* 기본 스타일 초기화 */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f8f9fc; color: #333; overflow-x: hidden; }
        a { text-decoration: none; color: inherit; display: block; }

        /* 상단 헤더 */
        .header { position: fixed; top: 0; left: 0; right: 0; height: 60px; background: #fff; border-bottom: 1px solid #e3e6f0; display: flex; align-items: center; justify-content: space-between; padding: 0 25px; z-index: 1000; }
        .header-logo { font-size: 20px; font-weight: 800; color: #5142f5; display: flex; align-items: center; gap: 8px; }
        .header-right { display: flex; align-items: center; gap: 20px; color: #b7b9cc; }
        .user-info { display: flex; align-items: center; gap: 10px; color: #6e707e; font-size: 14px; cursor: pointer; }
        .user-avatar { width: 32px; height: 32px; background: #f8f9fc; border-radius: 50%; display: flex; align-items: center; justify-content: center; border: 1px solid #e3e6f0; }

        /* 사이드바 */
        .sidebar { width: 240px; background: #fff; border-right: 1px solid #e3e6f0; height: 100vh; position: fixed; top: 0; left: 0; padding-top: 80px; z-index: 900; }
        .btn-contract-start { margin: 0 20px 25px; background: #5142f5; color: #fff; padding: 12px; border-radius: 6px; text-align: center; font-weight: 700; font-size: 14px; cursor: pointer; border: none; width: calc(100% - 40px); display: flex; align-items: center; justify-content: center; gap: 8px; transition: 0.3s; }
        .btn-contract-start:hover { background: #3d2fd4; box-shadow: 0 4px 12px rgba(81,66,245,0.3); }
        
        .nav-menu { list-style: none; }
        .nav-item { padding: 13px 25px; font-size: 14px; cursor: pointer; color: #6e707e; display: flex; align-items: center; gap: 12px; transition: 0.2s; border-right: 4px solid transparent; }
        .nav-item:hover { background: #f8f9fc; color: #5142f5; }
        .nav-item.active { color: #5142f5; font-weight: 700; background: #f0f1ff; border-right: 4px solid #5142f5; }
        .nav-item i { width: 20px; text-align: center; font-size: 16px; }

        /* 메인 콘텐츠 */
        .main-container { margin-left: 240px; margin-top: 60px; padding: 30px 40px; min-height: calc(100vh - 60px); }
        
        /* 섹션 타이틀 및 버튼 */
        .section-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .section-title { font-size: 17px; font-weight: 700; color: #2e2f37; }
        .btn-group { display: flex; gap: 8px; }
        .btn-outline { padding: 8px 16px; border-radius: 4px; font-size: 13px; font-weight: 600; cursor: pointer; border: 1px solid #d1d3e2; background: #fff; color: #6e707e; display: flex; align-items: center; gap: 6px; transition: 0.2s; }
        .btn-outline:hover { background: #f8f9fc; border-color: #b7b9cc; }
        .btn-primary { background: #5142f5; color: #fff; border: none; padding: 8px 16px; border-radius: 4px; font-size: 13px; font-weight: 600; cursor: pointer; }

        /* 템플릿 카드 */
        .template-container { display: flex; gap: 20px; margin-bottom: 40px; }
        .template-card-add { width: 240px; height: 140px; background: #fff; border: 1px dashed #d1d3e2; border-radius: 12px; display: flex; flex-direction: column; align-items: center; justify-content: center; color: #b7b9cc; cursor: pointer; transition: 0.3s; }
        .template-card-add:hover { border-color: #5142f5; color: #5142f5; background: #f0f1ff; }

        /* 필터 카드 (이미지 디자인 100% 반영) */
        .filter-card { background: #fff; border-radius: 8px; border: 1px solid #e3e6f0; padding: 20px; margin-bottom: 25px; box-shadow: 0 2px 4px rgba(0,0,0,0.02); }
        .filter-row { display: flex; flex-wrap: wrap; gap: 12px; align-items: flex-end; }
        .filter-group { display: flex; flex-direction: column; gap: 6px; }
        .filter-group label { font-size: 11px; color: #858796; font-weight: 700; }
        .filter-group select, .filter-group input { height: 34px; padding: 0 10px; border: 1px solid #d1d3e2; border-radius: 4px; font-size: 13px; color: #4e4e4e; }
        
        .search-box { display: flex; align-items: center; }
        .search-box select { border-radius: 4px 0 0 4px; border-right: none; }
        .search-box input { border-radius: 0; width: 200px; border-right: none; }
        .btn-search { height: 34px; width: 36px; background: #fff; border: 1px solid #d1d3e2; border-radius: 0 4px 4px 0; color: #b7b9cc; cursor: pointer; }
        
        .btn-detail-search { height: 34px; padding: 0 15px; background: #fff; border: 1px solid #d1d3e2; border-radius: 4px; color: #5142f5; font-weight: 700; font-size: 12px; cursor: pointer; }
        .right-actions { margin-left: auto; display: flex; gap: 8px; }

        /* 빈 리스트 상태 (X 표시된 이미지 깨짐 제거) */
        .dashboard-main { background: #fff; border-radius: 8px; border: 1px solid #e3e6f0; min-height: 450px; display: flex; align-items: center; justify-content: center; }
        .empty-state { text-align: center; padding: 40px; }
        .empty-icon { width: 80px; height: 80px; background: #f8f9fc; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 25px; color: #d1d3e2; font-size: 32px; border: 1px solid #eaecf4; }
        .empty-title { font-size: 18px; font-weight: 700; color: #333; margin-bottom: 15px; }
        .empty-desc { font-size: 14px; color: #858796; line-height: 1.6; margin-bottom: 35px; }
        .btn-start-large { padding: 14px 35px; background: #5142f5; color: #fff; border-radius: 4px; font-weight: 700; border: none; cursor: pointer; font-size: 14px; transition: 0.3s; }
        .btn-start-large:hover { background: #3d2fd4; transform: translateY(-1px); }
    </style>
</head>
<body>

    <header class="header">
        <div class="header-logo">
            <i class="fa-solid fa-file-signature"></i> ERP SYSTEM
        </div>        
    </header>

    <div class="sidebar">
        <button class="btn-contract-start"><i class="fa-solid fa-plus"></i> 계약 시작하기</button>
        <ul class="nav-menu">
            <a href="list.jsp"><li class="nav-item"><i class="fa-solid fa-house"></i> 홈</li></a>
            <a href="my_documents.jsp"><li class="nav-item"><i class="fa-solid fa-file-lines"></i> 내 문서함</li></a>
            <a href="external_documents.jsp"><li class="nav-item"><i class="fa-solid fa-earth-americas"></i> 외부계약서</li></a>
            <a href="bulk_send.jsp"><li class="nav-item active"><i class="fa-solid fa-layer-group"></i> 대량발송</li></a>
            <a href="link_signature.jsp"><li class="nav-item"><i class="fa-solid fa-link"></i> 링크서명</li></a>
            <a href="trash_bin.jsp"><li class="nav-item"><i class="fa-solid fa-trash-can"></i> 휴지통</li></a>
            <a href="total_list.jsp"><li class="nav-item"><i class="fa-solid fa-user-group"></i> 사원 명부</li></a>
            <a href="#"><li class="nav-item"><i class="fa-solid fa-gear"></i> 설정</li></a>
        </ul>
    </div>

    <div class="main-container">
        <div class="section-header">
            <h3 class="section-title">자주 쓰는 템플릿 <i class="fa-solid fa-chevron-right" style="font-size: 12px; color: #ccc; margin-left: 5px;"></i></h3>
            <div class="btn-group">
                <button class="btn-outline"><i class="fa-solid fa-file-import"></i> 템플릿 가져오기</button>
                <button class="btn-primary">+ 템플릿 만들기</button>
            </div>
        </div>

        <div class="template-container">
            <div class="template-card-add">
                <i class="fa-solid fa-circle-plus" style="font-size: 24px; margin-bottom: 10px;"></i>
                <span style="font-weight: 600; font-size: 14px;">+ 자주 쓰는 템플릿</span>
            </div>
        </div>

        <div class="section-header">
            <h3 class="section-title">대량발송 문서함</h3>
        </div>

        <div class="filter-card">
            <div class="filter-row">
                <div class="filter-group">
                    <label>계약 유형</label>
                    <select style="width: 90px;"><option>전체</option></select>
                </div>
                <div class="filter-group">
                    <label>진행 상태</label>
                    <select style="width: 90px;"><option>전체</option></select>
                </div>
                <div class="filter-group">
                    <label>폴더</label>
                    <select style="width: 90px;"><option>전체</option></select>
                </div>
                <div class="filter-group">
                    <label>멤버</label>
                    <select style="width: 90px;"><option>전체</option></select>
                </div>
                <div class="filter-group">
                    <label>기간</label>
                    <select style="width: 110px;"><option>전체기간</option></select>
                </div>
                <div class="filter-group">
                    <label>검색어</label>
                    <div class="search-box">
                        <select style="width: 90px;"><option>계약서명</option></select>
                        <input type="text" placeholder="검색어를 입력하세요">
                        <button class="btn-search"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </div>
                </div>
                <button class="btn-detail-search">상세검색</button>

                <div class="right-actions">
                    <button class="btn-outline">폴더관리</button>
                    <button class="btn-outline" style="color: #2dce89;"><i class="fa-solid fa-file-excel"></i> 엑셀 다운로드</button>
                </div>
            </div>
        </div>

        <div class="dashboard-main">
            <div class="empty-state">
                <div class="empty-icon">
                    <i class="fa-solid fa-file-csv"></i>
                </div>
                <h4 class="empty-title">동일한 양식의 문서를 다수의 서명자들에게 한번에 발송해보세요.</h4>
                <p class="empty-desc">
                    서명자별로 문서 내에 입력되는 정보와 다수의 서명자 정보를<br>
                    <strong>엑셀 파일</strong>을 이용하여 한 번에 발송할 수 있어 업무 효율이 높아집니다.
                </p>
                <button class="btn-start-large">대량발송 시작하기</button>
            </div>
        </div>
    </div>

</body>
</html>