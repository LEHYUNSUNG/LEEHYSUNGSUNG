<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ERP SYSTEM - 외부계약서</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* 기본 스타일 초기화 */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f8f9fc; color: #333; display: flex; }
        a { text-decoration: none; color: inherit; display: block; width: 100%; }

        /* 사이드바 영역 */
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
        
        .header-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .page-title { font-size: 22px; font-weight: 700; color: #222; }
        .storage-info { font-size: 13px; color: #858796; display: flex; align-items: center; gap: 10px; }
        .storage-bar { width: 120px; height: 8px; background: #eaecf4; border-radius: 10px; overflow: hidden; }
        .storage-fill { width: 2%; height: 100%; background: #4e73df; }

        /* 필터/액션바 영역 */
        .filter-card { 
            background: #fff; border-radius: 10px; border: 1px solid #e3e6f0; 
            padding: 15px 20px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }
        .filter-card select, .filter-card input { 
            height: 40px; padding: 0 12px; border: 1px solid #d1d3e2; border-radius: 6px; font-size: 14px; outline: none;
        }
        .input-search { flex: 1; max-width: 250px; }
        .btn-blue { height: 40px; padding: 0 18px; background: #4e73df; color: #fff; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 8px; font-size: 14px; }
        .btn-white { height: 40px; padding: 0 15px; background: #fff; border: 1px solid #d1d3e2; border-radius: 6px; color: #5a5c69; font-weight: 600; cursor: pointer; font-size: 14px; }

        /* [이미지 1b3501 반영] 테이블 콘텐츠 영역 */
        .content-card { background: #fff; border-radius: 10px; border: 1px solid #e3e6f0; box-shadow: 0 2px 10px rgba(0,0,0,0.02); }
        table { width: 100%; border-collapse: collapse; }
        
        thead th { 
            text-align: left; padding: 15px 20px; border-bottom: 1px solid #f1f3f9;
            color: #b7b9cc; font-size: 13px; font-weight: 500;
        }
        
        tbody td { padding: 18px 20px; border-bottom: 1px solid #f8f9fc; font-size: 14px; color: #4e4e4e; }
        
        /* 폴더명 컬럼 아이콘 및 체크박스 */
        .folder-cell { display: flex; align-items: center; gap: 15px; font-weight: 500; color: #333; }
        .folder-cell i { color: #f6c23e; font-size: 18px; }
        .checkbox-custom { width: 16px; height: 16px; cursor: pointer; accent-color: #4e73df; }

        /* 더보기 버튼 및 하단 설정 */
        .btn-more { background: none; border: 1px solid #eee; border-radius: 4px; padding: 4px 8px; color: #ccc; cursor: pointer; }
        .btn-more:hover { background: #f8f9fc; color: #888; }
        
        .table-footer { padding: 20px; display: flex; justify-content: flex-end; }
        .view-select { padding: 8px 12px; border: 1px solid #d1d3e2; border-radius: 6px; font-size: 13px; color: #6e707e; outline: none; }

    </style>
</head>
<body>

    <div class="sidebar">
        <div class="logo">ERP SYSTEM</div>
        <ul class="nav-menu">
            <li><a href="list.jsp"><div class="nav-item">🏠 홈</div></a></li>
            <div class="nav-section-title">Documents</div>
            <li><a href="my_documents.jsp"><div class="nav-item">📄 내 문서함</div></a></li>
            <li><a href="external_documents.jsp"><div class="nav-item active">🌐 외부계약서</div></a></li>
            <li><a href="trash_bin.jsp"><div class="nav-item">🗑️ 휴지통</div></a></li>
            <div class="nav-section-title">Management</div>
            <li><a href="employees.jsp"><div class="nav-item">👥 사원 명부</div></a></li>
            <li><a href="settings.jsp"><div class="nav-item">⚙️ 설정</div></a></li>
        </ul>
    </div>

    <div class="main-container">
        
        <div class="header-top">
            <h2 class="page-title">외부계약서 <span style="font-size:16px; color:#b7b9cc; font-weight:400;">&gt; 전체</span></h2>
            <div class="storage-info">
                사용 용량 현황 
                <div class="storage-bar"><div class="storage-fill"></div></div>
                <span style="color:#4e73df; font-weight:700;">0 GB</span> / 5 GB
            </div>
        </div>

        <div class="filter-card">
            <select style="width: 130px;"><option>폴더명</option></select>
            <select style="width: 130px;"><option>전체기간</option></select>
            <input type="text" class="input-search" placeholder="검색어를 입력하세요">
            
            <div style="margin-left: auto; display: flex; gap: 8px;">
                <button class="btn-white"><i class="fa-solid fa-folder-plus"></i> 폴더추가</button>
                <button class="btn-blue"><i class="fa-solid fa-plus"></i> 외부계약서 추가</button>
            </div>
        </div>

        <div class="content-card">
            <table>
                <thead>
                    <tr>
                        <th style="width: 45%;">폴더명</th>
                        <th style="width: 15%; text-align: center;">작성자</th>
                        <th style="width: 15%; text-align: center;">작성일</th>
                        <th style="width: 15%; text-align: center;">수정일</th>
                        <th style="width: 10%; text-align: center;"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div class="folder-cell">
                                <input type="checkbox" class="checkbox-custom">
                                <i class="fa-solid fa-folder"></i>
                                기본폴더
                            </div>
                        </td>
                        <td style="text-align: center; color: #b7b9cc;">-</td>
                        <td style="text-align: center; color: #b7b9cc;">-</td>
                        <td style="text-align: center; color: #b7b9cc;">-</td>
                        <td style="text-align: center;">
                            <button class="btn-more"><i class="fa-solid fa-ellipsis"></i></button>
                        </td>
                    </tr>
                    
                </tbody>
            </table>

            <div class="table-footer">
                <select class="view-select">
                    <option>10개씩 보기</option>
                    <option>20개씩 보기</option>
                    <option>30개씩 보기</option>
                    <option>40개씩 보기</option>
                    <option>50개씩 보기</option>
                </select>
            </div>
        </div>
    </div>

</body>
</html>