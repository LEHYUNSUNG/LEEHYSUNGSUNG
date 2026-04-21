<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ERP SYSTEM - 내 문서함</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        /* 기본 스타일 초기화 */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f5f7f9; color: #333; display: flex; }

        /* 사이드바 영역 */
        .sidebar { width: 240px; background: #fff; border-right: 1px solid #e1e4e8; height: 100vh; position: fixed; padding: 20px 0; }
        .logo { padding: 0 20px 30px; font-weight: bold; color: #007bff; font-size: 20px; letter-spacing: -1px; }
        .nav-menu { list-style: none; }
        .nav-item { padding: 12px 25px; font-size: 14px; cursor: pointer; color: #555; display: flex; align-items: center; transition: 0.2s; }
        .nav-item.active { background: #eef5ff; color: #007bff; border-right: 3px solid #007bff; font-weight: bold; }
        .nav-item:hover { background: #f8f9fa; color: #007bff; }

        /* 메인 콘텐츠 영역 */
        .main-container { margin-left: 240px; width: calc(100% - 240px); padding: 30px; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .page-title { font-size: 18px; font-weight: 700; color: #222; }

        /* 필터 섹션 */
        .filter-card { background: #fff; border-radius: 8px; border: 1px solid #eef0f2; padding: 20px; margin-bottom: 20px; display: flex; flex-wrap: wrap; gap: 12px; align-items: flex-end; }
        .filter-group { display: flex; flex-direction: column; gap: 6px; }
        .filter-group label { font-size: 12px; color: #888; font-weight: 500; }
        .filter-group select, .filter-group input { padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px; font-size: 13px; min-width: 110px; outline: none; background-color: #fff; }
        
        .btn-search { padding: 8px 20px; background: #fff; border: 1px solid #ddd; border-radius: 4px; cursor: pointer; font-size: 13px; font-weight: 600; height: 36px; transition: 0.2s; }
        .btn-search:hover { background: #f8f9fa; border-color: #bbb; }
        
        .action-group { margin-left: auto; display: flex; gap: 8px; }
        .btn-outline { padding: 8px 15px; background: #fff; border: 1px solid #ddd; border-radius: 4px; font-size: 13px; display: flex; align-items: center; gap: 5px; cursor: pointer; font-weight: 500; }
        .btn-excel { color: #1d6f42; border-color: #1d6f42; }
        .btn-excel:hover { background: #f1f9f5; }

        /* 테이블 섹션 */
        .content-card { background: #fff; border-radius: 8px; border: 1px solid #eef0f2; overflow: hidden; box-shadow: 0 2px 4px rgba(0,0,0,0.02); min-height: 200px; }
        table { width: 100%; border-collapse: collapse; }
        thead th { background: #fafbfc; color: #888; font-size: 13px; font-weight: 500; padding: 15px; border-bottom: 1px solid #eee; text-align: center; }
        tbody td { padding: 25px 15px; border-bottom: 1px solid #f8f9fa; font-size: 14px; vertical-align: middle; text-align: center; color: #ccc; }
        
        /* 테이블 제목 열 왼쪽 정렬 */
        .text-left { text-align: left; }
        
        /* 페이지네이션 */
        .pagination { padding: 20px; display: flex; justify-content: center; align-items: center; gap: 15px; font-size: 14px; color: #888; position: relative; }
        .page-num { width: 28px; height: 28px; display: flex; align-items: center; justify-content: center; border-radius: 4px; cursor: pointer; transition: 0.2s; }
        .page-num.active { background: #eef5ff; color: #007bff; font-weight: bold; }
        .page-num:hover:not(.active) { background: #f1f3f5; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="logo">ERP SYSTEM</div>
        <ul class="nav-menu">
            <li class="nav-item">🏠 홈</li>
            <li class="nav-item">📁 문서함</li>
            <li class="nav-item active">&nbsp;&nbsp;내 문서함</li>
            <li class="nav-item">&nbsp;&nbsp;외부계약서</li>
            <li class="nav-item">&nbsp;&nbsp;휴지통</li>
            <li class="nav-item">👥 사원 명부</li>
            <li class="nav-item">⚙️ 설정</li>
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
            <div class="filter-group">
                <label>검색어</label>
                <input type="text" placeholder="문서 제목 입력">
            </div>
            <button class="btn-search">상세검색</button>

            <div class="action-group">
                <button class="btn-outline">폴더관리</button>
                <button class="btn-outline btn-excel">📊 엑셀 다운로드</button>
            </div>
        </div>

        <div class="content-card">
            <table>
                <thead>
                    <tr>
                        <th>계약유형</th>
                        <th width="35%" class="text-left">문서제목</th>
                        <th>발송자</th>
                        <th>진행상태</th>
                        <th>발송일</th>
                        <th>마지막 활동일</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>-</td>
                        <td class="text-left" style="color:#eee;">문서가 없습니다.</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                </tbody>
            </table>

            <div class="pagination">
                <span style="cursor:pointer;">&lt;</span>
                <span class="page-num active">1</span>
                <span style="cursor:pointer;">&gt;</span>
                
                <div style="position: absolute; right: 20px;">
                    <select style="padding: 6px 10px; border-radius: 4px; border: 1px solid #ddd; font-size: 12px; outline: none; cursor: pointer;">
                        <option>10개씩 보기</option>
                    </select>
                </div>
            </div>
        </div>
    </div>

</body>
</html>