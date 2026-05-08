<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>ERP SYSTEM - 서식자료실</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --primary-blue: #0062ff; --bg-gray: #f8f9fc; --border-color: #ebedf3; }
        body { margin: 0; font-family: 'Noto Sans KR', sans-serif; background-color: var(--bg-gray); display: flex; }
        .main-content { flex-grow: 1; padding: 40px; margin-left: 260px; }
        .search-area { background: #fff; padding: 30px; border-radius: 12px; border: 1px solid var(--border-color); margin-bottom: 30px; text-align: center; }
        .search-input { width: 50%; padding: 12px 20px; border: 1px solid #ddd; border-radius: 30px; outline: none; font-size: 15px; }
        
        .category-tab { display: flex; gap: 10px; margin-bottom: 20px; }
        .tab { padding: 8px 16px; background: #fff; border: 1px solid var(--border-color); border-radius: 20px; cursor: pointer; font-size: 14px; color: #64748b; }
        .tab.active { background: var(--primary-blue); color: #fff; border-color: var(--primary-blue); }
        
        .lib-table { width: 100%; background: #fff; border-collapse: collapse; border-radius: 12px; overflow: hidden; border: 1px solid var(--border-color); }
        .lib-table th { background: #f8f9fc; padding: 15px; text-align: left; border-bottom: 1px solid var(--border-color); color: #475569; font-size: 14px; }
        .lib-table td { padding: 15px; border-bottom: 1px solid var(--border-color); color: #334155; font-size: 14px; }
        .btn-use { padding: 6px 12px; border: 1px solid var(--primary-blue); color: var(--primary-blue); background: transparent; border-radius: 4px; cursor: pointer; font-size: 13px; font-weight: 700; }
        .btn-use:hover { background: var(--primary-blue); color: #fff; }
    </style>
</head>
<body>
    <div class="main-content">
        <div class="page-title" style="margin-bottom: 20px;">서식자료실</div>
        <div class="search-area">
            <input type="text" class="search-input" placeholder="필요한 서식을 검색해보세요. (예: 임대차계약서)">
        </div>
        
        <div class="category-tab">
            <div class="tab active">전체</div>
            <div class="tab">인사/노무</div>
            <div class="tab">구매/판매</div>
            <div class="tab">행정/공문</div>
        </div>

        <table class="lib-table">
            <thead>
                <tr>
                    <th>서식명</th>
                    <th>카테고리</th>
                    <th>조회수</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>비밀유지 서약서(NDA)</td>
                    <td>행정</td>
                    <td>1,245</td>
                    <td><button class="btn-use">가져오기</button></td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>