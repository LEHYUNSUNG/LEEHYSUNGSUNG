<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ERP SYSTEM - 내 문서함</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* 기본 스타일 초기화 */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f8f9fc; color: #333; display: flex; }
        
        /* 링크 스타일: 클릭 영역 확장을 위해 display: block 설정 */
        a { text-decoration: none; color: inherit; display: block; width: 100%; }

        /* 사이드바 영역 */
        .sidebar { width: 240px; background: #fff; border-right: 1px solid #e3e6f0; height: 100vh; position: fixed; padding: 20px 0; z-index: 100; }
        .logo { padding: 0 25px 30px; font-weight: 800; color: #4e73df; font-size: 22px; letter-spacing: -0.5px; }
        .nav-menu { list-style: none; }
        .nav-section-title { font-size: 11px; font-weight: 700; color: #b7b9cc; padding: 10px 25px; text-transform: uppercase; margin-top: 10px; }
        
        /* 메뉴 아이템 스타일 */
        .nav-item { 
            padding: 13px 25px; 
            font-size: 14px; 
            cursor: pointer; 
            color: #6e707e; 
            display: flex; 
            align-items: center; 
            transition: all 0.2s ease;
        }
        
        /* 마우스 올렸을 때 효과 */
        .nav-item:hover { 
            background: #f8f9fc; 
            color: #4e73df; 
            padding-left: 30px; /* 살짝 오른쪽으로 이동하는 애니메이션 */
        }
        
        /* 활성화된 메뉴 스타일 (현재 페이지) */
        .nav-item.active { 
            color: #4e73df; 
            font-weight: 700; 
            background: #f8f9fc; 
            border-right: 4px solid #4e73df; 
        }
        
        .sub-item { padding-left: 45px; font-size: 13px; }
        .sub-item:hover { padding-left: 50px; }

        /* 메인 콘텐츠 영역 */
        .main-container { margin-left: 240px; width: calc(100% - 240px); padding: 30px 40px; min-height: 100vh; }
        .page-header { margin-bottom: 20px; }
        .page-title { font-size: 20px; font-weight: 700; color: #222; }

        /* 필터 섹션 */
        .filter-card { 
            background: #fff; 
            border-radius: 8px; 
            border: 1px solid #e3e6f0; 
            padding: 24px; 
            margin-bottom: 20px; 
            display: flex; 
            flex-wrap: wrap; 
            gap: 15px; 
            align-items: flex-end;
            box-shadow: 0 2px 4px rgba(0,0,0,0.03);
        }
        
        .filter-group { display: flex; flex-direction: column; gap: 8px; flex: 1; min-width: 120px; }
        .filter-group.search-box { flex: 2.5; min-width: 350px; }
        .filter-group label { font-size: 13px; color: #555; font-weight: 600; margin-left: 2px; }
        .filter-group select, .filter-group input { 
            padding: 0 12px; border: 1px solid #d1d3e2; border-radius: 5px; font-size: 14px; 
            outline: none; background: #fff; color: #444; height: 40px; transition: border 0.2s;
        }
        .filter-group select:focus, .filter-group input:focus { border-color: #4e73df; }
        
        .search-input-group { display: flex; align-items: center; border: 1px solid #d1d3e2; border-radius: 5px; background: #fff; height: 40px; overflow: hidden; }
        .search-input-group select { border: none; border-right: 1px solid #d1d3e2; border-radius: 0; min-width: 100px; height: 100%; background: #fdfdfd; }
        .search-input-group input { border: none; flex: 1; height: 100%; padding: 0 15px; }
        .search-input-group .search-btn { padding: 0 15px; color: #4e73df; cursor: pointer; background: none; border: none; font-size: 16px; }

        .btn-detail { padding: 0 18px; background: #f8f9fc; border: 1px solid #d1d3e2; border-radius: 5px; cursor: pointer; font-size: 13px; height: 40px; color: #4e73df; font-weight: 600; white-space: nowrap; }
        
        .top-action-group { width: 100%; display: flex; justify-content: flex-end; gap: 8px; margin-top: 10px; border-top: 1px dashed #eee; padding-top: 15px; }
        .btn-outline { padding: 0 16px; background: #fff; border: 1px solid #d1d3e2; border-radius: 5px; font-size: 13px; cursor: pointer; height: 36px; display: flex; align-items: center; gap: 8px; color: #5a5c69; font-weight: 500; }
        .btn-outline:hover { background: #f8f9fc; border-color: #b7b9cc; }
        .btn-excel-img { color: #1d6f42; }

        /* 테이블 섹션 */
        .content-card { background: #fff; border-radius: 8px; border: 1px solid #e3e6f0; overflow: hidden; box-shadow: 0 2px 4px rgba(0,0,0,0.02); }
        table { width: 100%; border-collapse: collapse; }
        thead th { background: #f8f9fc; color: #4e73df; font-size: 13px; font-weight: 700; padding: 15px; border-bottom: 1px solid #e3e6f0; text-align: center; }
        tbody td { padding: 40px 15px; border-bottom: 1px solid #f2f2f2; font-size: 14px; text-align: center; color: #858796; }
        .text-left { text-align: left; padding-left: 25px; }
        .empty-row td { color: #b7b9cc; font-size: 15px; }

        /* 페이지네이션 */
        .pagination { padding: 30px; display: flex; justify-content: center; align-items: center; gap: 20px; position: relative; }
        .page-arrow { color: #d1d3e2; font-size: 18px; cursor: pointer; transition: 0.2s; }
        .page-arrow:hover { color: #4e73df; }
        .page-num-circle { width: 36px; height: 36px; display: flex; align-items: center; justify-content: center; border-radius: 50%; background: #4e73df; color: #fff; font-weight: 700; font-size: 14px; box-shadow: 0 4px 10px rgba(78, 115, 223, 0.3); }
        .view-count-select { position: absolute; right: 25px; }
        .view-count-select select { padding: 8px 12px; border-radius: 5px; border: 1px solid #d1d3e2; font-size: 13px; color: #6e707e; outline: none; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="logo">ERP SYSTEM</div>
        <ul class="nav-menu">
            <li>
                <a href="list.jsp">
                    <div class="nav-item">🏠 홈</div>
                </a>
            </li>

            <div class="nav-section-title">Documents</div>
            
            <li>
                <a href="my-docs.jsp">
                    <div class="nav-item active sub-item">📄 내 문서함</div>
                </a>
            </li>
            
            <li>
                <a href="external_documents.jsp">
                    <div class="nav-item sub-item">🌐 외부계약서</div>
                </a>
            </li>
            
            <li>
                <a href="trash_bin.jsp">
                    <div class="nav-item sub-item">🗑️ 휴지통</div>
                </a>
            </li>

            <div class="nav-section-title">Management</div>
            <li>
                <a href="employees.jsp">
                    <div class="nav-item">👥 사원 명부</div>
                </a>
            </li>
            <li>
                <a href="settings.jsp">
                    <div class="nav-item">⚙️ 설정</div>
                </a>
            </li>
        </ul>
    </div>

    <div class="main-container">
        <div class="page-header">
            <h2 class="page-title">내 문서함</h2>
        </div>

        <div class="filter-card">
            <div class="filter-group">
                <label>계약 유형</label>
                <select><option>전체</option></select>
            </div>
            <div class="filter-group">
                <label>진행 상태</label>
                <select><option>전체</option></select>
            </div>
            <div class="filter-group">
                <label>폴더</label>
                <select><option>전체</option></select>
            </div>
            <div class="filter-group">
                <label>멤버</label>
                <select><option>전체</option></select>
            </div>
            <div class="filter-group">
                <label>기간</label>
                <select><option>전체기간</option></select>
            </div>
            
            <div class="filter-group search-box">
                <label>검색어</label>
                <div class="search-input-group">
                    <select>
                        <option>계약서명</option>
                        <option>발송자</option>
                    </select>
                    <input type="text" placeholder="검색어를 입력하세요">
                    <button class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
                </div>
            </div>
            
            <button class="btn-detail">상세검색</button>

            <div class="top-action-group">
                <button class="btn-outline">폴더관리</button>
                <button class="btn-outline">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Microsoft_Office_Excel_%282019%E2%80%93present%29.svg/20px-Microsoft_Office_Excel_%282019%E2%80%93present%29.svg.png" width="16">
                    <span class="btn-excel-img">엑셀 다운로드</span>
                </button>
            </div>
        </div>

        <div class="content-card">
            <table>
                <thead>
                    <tr>
                        <th width="10%">계약유형</th>
                        <th width="35%" class="text-left">문서제목</th>
                        <th width="12%">발송자</th>
                        <th width="12%">진행상태</th>
                        <th width="15%">발송일</th>
                        <th width="15%">마지막 활동일</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="empty-row">
                        <td colspan="6">조회된 문서가 없습니다.</td>
                    </tr>
                </tbody>
            </table>

            <div class="pagination">
                <span class="page-arrow">&laquo;</span>
                <div class="page-num-circle">1</div>
                <span class="page-arrow">&raquo;</span>
                
                <div class="view-count-select">
                    <select>
                        <option>10개씩 보기</option>
                        <option>30개씩 보기</option>
                        <option>50개씩 보기</option>
                    </select>
                </div>
            </div>
        </div>
    </div>

</body>
</html>