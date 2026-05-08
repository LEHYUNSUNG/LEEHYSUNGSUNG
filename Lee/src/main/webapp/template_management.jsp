<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>ERP SYSTEM - 서식관리</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --primary-blue: #0062ff; --bg-gray: #f8f9fc; --border-color: #ebedf3; }
        body { margin: 0; font-family: 'Noto Sans KR', sans-serif; background-color: var(--bg-gray); display: flex; }
        .main-content { flex-grow: 1; padding: 40px; margin-left: 260px; }
        .mgmt-card { background: #fff; border-radius: 12px; border: 1px solid var(--border-color); padding: 25px; }
        .table-toolbar { display: flex; justify-content: space-between; margin-bottom: 20px; }
        
        .status-badge { padding: 4px 10px; border-radius: 4px; font-size: 12px; font-weight: 700; }
        .status-active { background: #e1fdf4; color: #10b981; }
        .status-stop { background: #fee2e2; color: #ef4444; }
        
        .action-icon { color: #94a3b8; cursor: pointer; margin-left: 10px; }
        .action-icon:hover { color: var(--primary-blue); }
    </style>
</head>
<body>
    <div class="main-content">
        <div class="page-title" style="margin-bottom: 20px;">서식관리</div>
        <div class="mgmt-card">
            <div class="table-toolbar">
                <span style="color: #64748b;">총 5건의 서식이 등록되어 있습니다.</span>
                <div>
                    <button class="btn-add" style="padding: 8px 15px;">서식 등록</button>
                </div>
            </div>
            
            <table class="lib-table"> <thead>
                    <tr>
                        <th>번호</th>
                        <th>서식명</th>
                        <th>상태</th>
                        <th>등록자</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>연봉계약서 (2024년형)</td>
                        <td><span class="status-badge status-active">사용중</span></td>
                        <td>관리자</td>
                        <td>
                            <i class="fa-solid fa-pen-to-square action-icon"></i>
                            <i class="fa-solid fa-trash-can action-icon"></i>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>