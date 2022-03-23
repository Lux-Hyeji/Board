<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//session.removeAttribute("login");
	session.invalidate();//세션초기화... remove 해야 될게 많을때 
	
	session = request.getSession(); // 세션이 무효 됬기 때문에 다시 넣음
	
	session.setAttribute("login", null);
	
	out.println("<script type='text/javascript'>");
	out.println("alert('로그아웃 되었습니다.');");
	out.println("location.href='/MyHome/index.jsp';");
	out.println("</script>");
%>