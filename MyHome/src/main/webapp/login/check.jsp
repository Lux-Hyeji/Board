<%@page import="member.memberdto.MemberDTO"%>
<%@page import="member.memberdao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 처리...
	//쿠키파일 저장....
	
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	MemberDTO dto = new MemberDTO();
	
	dto.setId(id);
	dto.setPassword(password);
	
	MemberDAO dao = MemberDAO.getInstance();
	
	dto = dao.checkLogin(dto);
	
	boolean check = false;  // 로그인 됫나 안됫나
	String msg = null;
	
	if(dto != null){
		msg = dto.getName() + "님이 로그인 하셨습니다.";
		check = true;
		
		//로그인 처리...
		session.setAttribute("login", dto);
		
		//쿠키파일 생성 유무
		
		//아이디 기억하기 체크 유무
		String ckid = request.getParameter("ckid");
		
		Cookie ck = null;
		
		Cookie[] cks = request.getCookies();
		
		if(cks != null){
			for(Cookie c : cks){
				if(c.getName().equals("ckid")){
					ck = c;
					break;
				}
			}
		}
		
		if(ckid != null){ // 체크됨
			if(ck == null){ // 쿠키가 없다
				//쿠키 객체 생성
				ck = new Cookie("ckid",id);
				
				//유효시간 설정. 초단위로 넣음. 24시간
				ck.setMaxAge(60*60*24);
				
				//쿠키파일 생성
				response.addCookie(ck);				
			}else{  // 쿠키가 있다
				if(!ck.getValue().equals(id)){ // 새로들어온게 기존기억된 id랑 같지않다 -> 쿠키 생성
					ck.setValue(id); // 지금 들어온 아이디 집어넣음
					response.addCookie(ck);
				}
			}
		}else{   // 체크 해제
			if(ck != null){ // 쿠키가 있다
				if(ck.getValue().equals(id)){ // 새로들어온게 기존기억된 id랑 같다 -> 쿠키삭제
					ck.setMaxAge(0);      // 유효시간 0
					response.addCookie(ck);
				}
			}
		}
		
	}else{
		msg = "아이디 혹은 비밀번호가 잘못되었습니다.";
	}
	
	request.setAttribute("check", check);
	request.setAttribute("msg", msg);
	
	pageContext.forward("/login/result.jsp");
%>























