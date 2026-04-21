<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP SYSTEM - 외부계약서</title>
<style>
    body { margin: 0; font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; display: flex; }
    .main-content { margin-left: 260px; flex-grow: 1; padding: 30px; }
    
    .header-info { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    .storage-info { font-size: 13px; color: #666; }
    .storage-bar { display: inline-block; width: 100px; height: 8px; background: #eee; border-radius: 4px; margin: 0 10px; overflow: hidden; }
    .storage-fill { width: 2%; height: 100%; background: #0062ff; }

    .action-bar { display: flex; gap: 10px; align-items: center; margin-bottom: 20px; background: #fff; padding: 15px; border-radius: 8px; border: 1px solid #e1e4e8; }
    .btn-blue { padding: 10px 20px; background: #0062ff; color: #fff; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; }
    
    .folder-list { background: #fff; border-radius: 8px; border: 1px solid #e1e4e8; padding: 20px; }
    .folder-item { display: flex; align-items: center; padding: 15px; border-bottom: 1px solid #f1f1f1; cursor: pointer; }
    .folder-item:hover { background: #fafafa; }
</style>
</head>
<body>
    <div class="main-content">
        <div class="header-info">
            <h3>전체 ></h3>
            <div class="storage-info">
                사용 용량 현황 <span class="storage-bar"><span class="storage-fill"></span></span> <b style="color:#0062ff">0 GB</b> / 2 GB
            </div>
        </div>

        <div class="action-bar">
            <select style="padding:8px; border-radius:4px; border:1px solid #ddd;"><option>폴더명</option></select>
            <input type="text" placeholder="검색어를 입력하세요" style="padding:8px; border-radius:4px; border:1px solid #ddd; width:200px;">
            <div style="margin-left:auto; display:flex; gap:10px;">
                <button style="padding:8px 15px; background:#fff; border:1px solid #ddd; border-radius:4px;">📁 폴더추가</button>
                <button class="btn-blue">+ 외부계약서 추가</button>
            </div>
        </div>

        <div class="folder-list">
            <div class="folder-item">
                <span style="font-size:20px; margin-right:15px;">📁</span>
                <span style="flex-grow:1; font-weight:bold;">기본폴더</span>
                <span style="color:#aaa;">-</span>
            </div>
        </div>
    </div>
</body>
</html>