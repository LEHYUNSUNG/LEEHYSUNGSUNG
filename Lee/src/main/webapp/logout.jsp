<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    /* 세션(Session) 무효화: 
       서버에 저장된 로그인 정보(userName, userId 등)를 모두 삭제합니다.
    */
    session.invalidate();

    /* 로그아웃 완료 후 알림창을 띄우고 목록 페이지로 이동합니다.
    */
%>
<script>
    alert("로그아웃 되었습니다. 이용해주셔서 감사합니다.");
    location.href = "list.jsp"; // 로그아웃 후 보여줄 페이지 (사원명부 등)
</script>