<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP SYSTEM - 휴지통</title>
<style>
    body { margin: 0; font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; display: flex; }
    .main-content { margin-left: 260px; flex-grow: 1; padding: 30px; }
    
    .trash-action { display: flex; justify-content: flex-end; margin-bottom: 20px; }
    .btn-trash-empty { padding: 8px 15px; background: #fff; border: 1px solid #ddd; border-radius: 4px; color: #666; cursor: pointer; }

    .empty-container { background: #fff; border-radius: 8px; border: 1px solid #e1e4e8; height: 400px; display: flex; flex-direction: column; align-items: center; justify-content: center; }
    .empty-icon { font-size: 50px; color: #eee; margin-bottom: 20px; }
    .empty-text { color: #888; font-size: 16px; font-weight: bold; }
</style>
</head>
<body>
    <div class="main-content">
        <div class="trash-action">
            <button class="btn-trash-empty">🗑️ 휴지통 비우기</button>
        </div>

        <div class="empty-container">
            <div class="empty-icon">🗄️</div>
            <div class="empty-text">삭제된 문서가 없습니다.</div>
        </div>
    </div>
</body>
</html>