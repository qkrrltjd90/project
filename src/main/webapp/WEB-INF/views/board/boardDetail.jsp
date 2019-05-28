<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		
		<title>boardDetail.jsp</title>
		
		<link rel="shortcut icon" href="/resources/images/icon.png" />
		<link rel="apple-touch-icon" href="/resources/images/icon.png" />
		
		<!-- [if lt IE 9]>
		<script src="../js/html5shiv.js"></script> 
		<![endif]-->
		
		<link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap-theme.min.css" />
		<link rel="stylesheet" type="text/css" href="/resources/include/css/default.css"/>
		
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<script type="text/javascript">
			var butChk = 0;
			$(function(){
				$("#pwdChk").css("visibility","hidden"); //영역은 남겨두고 안에 내용만 없어짐
				
				/* 수정 버튼 클릭 시 처리 이벤트 */
				$("#updateFormBtn").click(function(){
					$("#pwdChk").css("visibility", "visible");
					$("#b_pwd").focus();
					$("#msg").text("작성시 입력한 비밀번호를 입력해 주세요.").css("color", "#000099");
					butChk = 1;
				});
				
			/* 	/* 삭제 버튼 클릭 시 처리 이벤트 
				$("#boardDeleteBtn").click(function(){
					$("#pwdChk").css("visibility", "visible");
					$("#b_pwd").focus();
					$("#msg").text("작성시 입력한 비밀번호를 입력해 주세요.").css("color", "#000099");
					butChk = 2;
				}); */
				
				/*삭제 버튼 클릭 시 댓글 확인 후 처리 이벤트*/
				$("#boardDeleteBtn").click(function(){
					$.ajax({
						url : "/board/replyCnt" ,
						type : "post",
						data : "b_num="+$("#b_num").val(),
						dataType : "text",
						error : function(){
							alert('시스템 오류 입니다. 관리자에게 문의 하세요.');
						},
						success : function(resultData){
							if(resultData==0){
								$("#pwdChk").css("visiblility","visible");
								$("#msg").text("작성시 입력한 비밀번호를 입력해 주세요.").css("color","#0000099");
								btnChk = 2;
							}else{
								alert("댓글 존재시 게시물 작성할 수가 없습니다.\n댓글 삭제 후 다시 확인해 주세요.");
								return;
							}
						}
					});
				});
				
				/* 비밀번호 입력 양식 enter 제거 */
				$("#b_pwd").bind("keydown", function(event){
					if(event.keycode == 13){
						event.preventDefault();
					}
				});
				
				/* 비밀번호 확인 버튼 클릭 시 처리 이벤트 */
				$("#pwdBtn").click(function(){
					boardPwdConfirm();
				});
				
				/* 목록 버튼 클릭 시 처리 이벤트 */
				$("#boardListBtn").click(function(){
					var queryString= "?pageNum="+$("#pageNum").val()+"&amount="+$("#amount").val();
					location.href="/board/boardList"+queryString;
				});
				
			}); //최상위 function 종료
			
			/* 비밀확호 확인 버튼 클릭 실질적인 처리 함수 */
			function boardPwdConfirm(){
				if(!chkSubmit($('#b_pwd'), "비밀번호를")) return;
				else{
					$.ajax({
						url : "/board/pwdConfirm",	//전송 url
						type : "post",
						data : $("#f_pwd").serialize(),	//폼 전체 전송
						datatype : "text",
						error : function(){
							alert('시스템 오류입니다. 관리자에게 문의하세요.');
						},
						success : function(resultData){
							var goUrl="";
							if(resultData=="실패"){
								$("#msg").text("작성 시 입력한 비밀번호와 일치하지 않습니다.").css("color", "red");
								$("#b_pwd").select();
							}else if(resultData=="성공"){
								$("#msg").text("");
								if(butChk == 1){	//수정버튼 클릭 시
									goUrl = "/board/updateForm";
								} else if(butChk == 2){	//삭제 버튼 클릭 시 
									goUrl = "/board/boardDelete";
								}
								$("#f_data").attr("action", goUrl);
								$("#f_data").submit();
							}
						}
					});	//ajax 종결
				}
			}	//boardPwdConfirm() 종결
		</script>
	</head>
	<body>
		<div class="contentContainer container-fluid">
			<div class="contentTit page-header"><h3 class="text-center">게시판 상세보기</h3></div>
			
			<form name="f_data" id="f_data" method="post">
				<input type="hidden" name="b_num" value="${detail.b_num}">
				<input type="hidden" name="pageNum" id="pageNum" value="${data.pageNum}">
				<input type="hidden" name="amount" id="amount" value="${data.amount}">
			</form>
			
			<div id="boardPwdBut" class="row text-center">
				<div id="pwdChk" class="authArea col-md-8">
					<form name="f_pwd" id="f_pwd">
						<input type="hidden" name="b_num" id="b_num" value="${detail.b_num}" />
						<label for="b_pwd" id="l_pwd">비밀번호: </label>
						<input type="password" name="b_pwd" id="b_pwd" />
						
						<button type="button" id="pwdBtn">확인</button> &nbsp;
						<span id="msg"></span>
					</form>
				</div>
				<div class="btnArea col-md-4">
					<input type="button" value="수정" id="updateFormBtn"  class="btn btn-primary">
					<input type="button" value="삭제" id="boardDeleteBtn"  class="btn btn-primary">
					<input type="button" value="목록" id="boardListBtn"  class="btn btn-primary">
				</div>
			</div><br/>
			
			<div class="contentTB text-center">
				<table class="table table-bordered">
					<colgroup>
						<col width="17%" />
						<col width="33%" />
						<col width="17%" />
						<col width="33%" />
					</colgroup>
					<tbody>
						<tr>
							<td>작성자</td>
							<td class="text-left">${detail.b_name}</td>
							<td>작성일</td>
							<td class="text-left">${detail.b_date}</td>
						</tr>
						<tr>
							<td>제목</td>
							<td colspan="3" class="text-left">${detail.b_title}</td>
						</tr>
						<tr class="table-height">
							<td>내용</td>
							<td colspan="3" class="text-left">${detail.b_content}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<%--====================상세 정보 보여주기 종료 --%>
			<%-- <c:import url="reply.jsp"></c:import> 
			<c:import url="review.jsp"></c:import>--%>
			<jsp:include page="reply.jsp" />
		</div>
	</body>
</html>