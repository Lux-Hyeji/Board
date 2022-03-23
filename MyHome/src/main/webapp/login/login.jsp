<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//쿠키파일 검색해서 아이디 기억하기한
	//아이디 찾아서
	//loginForm으로 전송
	
	boolean check = false; //아이디 기억하기 체크 유무
	
	String id = request.getParameter("id");   //string id = ""
	
	//파라미터 값이 넘어오면 값이 있는거고 넘어오지 않으면 null값	
	if(id == null){
		//쿠키파일들 읽어오기...
		Cookie[] cks = request.getCookies();
		
		//쿠키파일 검색
		if(cks != null){
			for(Cookie ck : cks){
				if(ck.getName().equals("ckid")) { //ckid라는 쿠키파일 검색
					id = ck.getValue();//Content값 받기...
					check = true;
					break;
				}
			}
		}
	}
	
	request.setAttribute("id", id);
	request.setAttribute("check", check);
	
	pageContext.forward("/login/form.jsp");
%>