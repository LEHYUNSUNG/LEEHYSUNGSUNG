<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ERP SYSTEM - 공문발송</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* 기본 레이아웃 */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f5f7fb; color: #333; overflow-x: hidden; }
        a { text-decoration: none; color: inherit; display: block; }
        
        .header { position: fixed; top: 0; left: 0; right: 0; height: 60px; background: #fff; border-bottom: 1px solid #ebedf3; display: flex; align-items: center; justify-content: space-between; padding: 0 24px; z-index: 1000; }
        .sidebar { width: 240px; background: #fff; border-right: 1px solid #ebedf3; height: 100vh; position: fixed; top: 0; left: 0; padding-top: 80px; z-index: 900; }
        .main-content { margin-left: 240px; margin-top: 60px; padding: 30px 40px; min-height: calc(100vh - 60px); }

        /* 사이드바 */
        .btn-contract-start { margin: 0 20px 25px; background: #3366ff; color: #fff; padding: 14px; border-radius: 8px; text-align: center; font-weight: 700; border: none; width: calc(100% - 40px); cursor: pointer; font-size: 14px; transition: 0.2s; }
        .nav-item { padding: 12px 25px; font-size: 14px; color: #64748b; display: flex; align-items: center; gap: 12px; cursor: pointer; }
        .nav-item.active { background: #f0f4ff; color: #3366ff; font-weight: 700; border-right: 4px solid #3366ff; }

        /* 카드 및 섹션 */
        .content-card { background: #fff; border: 1px solid #ebedf3; border-radius: 12px; padding: 25px 30px; margin-bottom: 25px; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.02); }
        .section-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .section-title { font-size: 17px; font-weight: 700; color: #1e293b; display: flex; align-items: center; gap: 8px; }

        /* 접기 버튼 */
        .btn-toggle-section { width: 28px; height: 28px; border-radius: 50%; border: 1px solid #e2e8f0; background: #fff; color: #94a3b8; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: 0.2s; }
        .btn-toggle-section.closed i { transform: rotate(180deg); }

        /* 템플릿 영역 */
        .template-container { transition: max-height 0.3s ease-out, opacity 0.2s; max-height: 500px; opacity: 1; }
        .template-container.hide { max-height: 0; opacity: 0; pointer-events: none; }
        .template-wrapper { display: flex; gap: 16px; padding: 10px 0; }
        .template-item { width: 210px; height: 130px; border: 1px solid #e2e8f0; border-radius: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center; cursor: pointer; transition: 0.2s; background: #fff; }
        .template-item:hover { border-color: #3366ff; transform: translateY(-3px); }

        /* [수정] 필터 및 검색 바 레이아웃 */
        .filter-box { display: flex; flex-wrap: wrap; gap: 15px; align-items: flex-end; padding-top: 25px; border-top: 1px solid #f1f3f9; }
        .filter-item { display: flex; flex-direction: column; gap: 8px; }
        .filter-item label { font-size: 12px; font-weight: 700; color: #94a3b8; margin-left: 2px; }
        
        /* 공통 입력창 스타일 */
        .filter-item select, .filter-item input { height: 42px; border: 1px solid #e2e8f0; border-radius: 8px; padding: 0 12px; font-size: 13px; outline: none; background-color: #fff; }
        
        /* [수정] 검색창 박스 크기 조절 */
        .search-group { display: flex; border: 1px solid #e2e8f0; border-radius: 8px; overflow: hidden; height: 42px; background: #fff; min-width: 400px; } /* 너비를 넓게 설정 */
        .search-group select { border: none; border-right: 1px solid #e2e8f0; background: #f8faff; width: 100px; height: 100%; border-radius: 0; }
        .search-group input { border: none; flex: 1; padding-left: 15px; font-size: 13px; }
        .btn-search { background: #fff; border: none; padding: 0 15px; color: #3366ff; cursor: pointer; font-size: 16px; }

        .date-picker-group { display: none; align-items: center; gap: 8px; }
        .date-picker-group.active { display: flex; }

        /* 버튼류 */
        .btn-outline-sm { background: #fff; border: 1px solid #e2e8f0; padding: 8px 16px; border-radius: 8px; font-size: 12px; font-weight: 600; color: #64748b; cursor: pointer; }
        .btn-primary-sm { background: #3366ff; color: #fff; border: none; padding: 8px 16px; border-radius: 8px; font-size: 12px; font-weight: 600; cursor: pointer; }
        .btn-secondary { height: 42px; background: #fff; border: 1px solid #e2e8f0; border-radius: 8px; padding: 0 20px; font-size: 13px; color: #3366ff; font-weight: 600; cursor: pointer; }

        /* Empty State */
        .empty-state { text-align: center; padding: 80px 0; }
        .icon-circle { width: 80px; height: 80px; background: #f0f4ff; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px; font-size: 28px; color: #3366ff; }
        .btn-main { background: #3366ff; color: #fff; border: none; padding: 14px 40px; border-radius: 8px; font-weight: 700; cursor: pointer; }
    </style>
</head>
<body>

    <header class="header">
        <div style="font-weight: 800; color: #3366ff; font-size: 20px;"><i class="fa-solid fa-file-invoice"></i> ERP SYSTEM</div>
    </header>

    <nav class="sidebar">
        <button class="btn-contract-start">계약 시작하기</button>
        <div class="nav-list">
            <a href="list.jsp"><div class="nav-item"><i class="fa-solid fa-house"></i> 홈</div></a>
            <a href="my_documents.jsp"><div class="nav-item"><i class="fa-solid fa-file-lines"></i> 내 문서함</div></a>
            <a href="extemal_documents.jsp"><div class="nav-item"><i class="fa-solid fa-earth-americas"></i> 외부계약서</div></a>
            <a href="bulk_send.jsp"><div class="nav-item"><i class="fa-solid fa-layer-group"></i> 대량발송</div></a>
            <a href="link_signature.jsp"><div class="nav-item"><i class="fa-solid fa-link"></i> 링크서명</div></a>
            <a href="official_letter_list.jsp"><div class="nav-item active"><i class="fa-solid fa-paper-plane"></i> 공문발송</div></a>
            <a href="trash_bin.jsp"><div class="nav-item"><i class="fa-solid fa-trash-can"></i> 휴지통</div></a>
        </div>
    </nav>

    <main class="main-content">
        <div class="content-card">
            <div class="section-header">
                <div style="display: flex; align-items: center; gap: 12px;">
                    <h3 class="section-title">자주 쓰는 템플릿</h3>
                    <div class="btn-toggle-section" id="toggleTemplate" onclick="toggleTemplateSection()"><i class="fa-solid fa-chevron-up"></i></div>
                </div>
                <div class="btn-group" style="display: flex; gap: 8px;">
                    <button class="btn-outline-sm">템플릿 가져오기</button>
                    <button class="btn-primary-sm">+ 템플릿 만들기</button>
                </div>
            </div>
            <div class="template-container" id="templateContainer">
                <div class="template-wrapper">
                    <div class="template-item"><i class="fa-regular fa-file-lines" style="font-size:26px; color:#cbd5e1; margin-bottom:12px;"></i><span style="font-size:13px;">일반 공문 양식</span></div>
                    <div class="template-item add-template-btn"><i class="fa-solid fa-plus" style="font-size:20px; color:#94a3b8; margin-bottom:8px;"></i><span style="font-size:13px; font-weight:600; color:#94a3b8;">템플릿 추가</span></div>
                </div>
            </div>
        </div>

        <div class="content-card">
            <div class="section-header">
                <h3 class="section-title">공문발송 문서함</h3>
            </div>

            <div class="filter-box">
                <div class="filter-item">
                    <label>폴더</label>
                    <select style="width: 120px;"><option>전체</option></select>                                     
                </div>
                <div class="filter-item">
                    <label>멤버</label>
                    <select style="width: 120px;"><option>전체</option></select>                                     
                </div>
                <div class="filter-item">
                    <label>기간</label>
                    <div style="display: flex; gap: 8px;">
                        <select id="periodSelect" style="width: 120px;" onchange="toggleDatePicker()">
                            <option value="all">전체기간</option>
                            <option value="custom">기간지정</option>
                        </select>
                        <div id="datePickerGroup" class="date-picker-group">
                            <input type="date"> <span style="align-self:center; color:#cbd5e1;">~</span> <input type="date">
                        </div>
                    </div>
                </div>

                <div class="filter-item">
                    <label>검색어</label>
                    <div class="search-group">
                        <select><option>문서명</option></select>
                        <input type="text" placeholder="검색어를 입력하세요">
                        <button class="btn-search"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </div>
                </div>
                
                <button class="btn-secondary">상세검색</button>
                <button class="btn-outline-sm" style="margin-left: auto; height: 42px;">폴더관리</button>
            </div>

            <div class="empty-state">
                <div class="icon-circle"><i class="fa-solid fa-envelope-open-text"></i></div>
                <h4 style="font-size:18px; font-weight:700; margin-bottom:10px;">출력/스캔 없이 문서 작성 후 바로 공문을 발송해보세요.</h4>
                <p style="color:#64748b; font-size:14px; margin-bottom:30px;">전자직인은 물론 발송 시점을 확인할 수 있는 발송도장까지 날인할 수 있어요.</p>
                <button class="btn-main">공문발송 시작하기</button>
            </div>
        </div>
    </main>

    <script>
        function toggleTemplateSection() {
            const container = document.getElementById('templateContainer');
            const btn = document.getElementById('toggleTemplate');
            container.classList.toggle('hide');
            btn.classList.toggle('closed');
        }
        function toggleDatePicker() {
            const select = document.getElementById('periodSelect');
            const group = document.getElementById('datePickerGroup');
            group.classList.toggle('active', select.value === 'custom');
        }
    </script>
</body>
</html>