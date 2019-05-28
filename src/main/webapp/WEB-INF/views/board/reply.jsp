<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		
		<title>댓글</title>
		
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
			var message = "작성시 입력한 비밀번호를 입력해 주세요.", btnKind="";
		
			$(function(){
				
				/* 비밀번호 체크 화면에서 "취소" 버튼 클릭 처리*/
				$(document).on("click", ".pwdResetBut", function(){
					$(this).parents("div.panel .panel-heading .pwdArea").remove();
				});
				
				/*비밀번호 확인 버튼 클릭 시 처리 이벤트*/
				$(document).on("click", ".pwdCheckBut", function(){
					var r_num = $(this).parents("div.panel").attr("data-num");
					var form = $(this).parents(".inline");
					var pwd = form.find(".passwd");
					var msg = form.find(".msg");
					var value = 0;
					if(!formCheck(pwd, msg, "비밀번호를")) return;
					else{
							/*호출 함수.then() 함수 매개변수로 성공 콜백함수, 실패 콜백함수 넘겨줌 - 각 함수의 매개변수는 resolve,
							reject 함수에서 넘겨준 매개변수를 자동으로 넘겨 받는다.*/
						
							pwdCheck(r_num, pwd, msg).then(function(data){
								console.log("data : " + data);
								if(data == 1){
									console.log("비밀번호 학인 후 btnKind : " +btnKind);
									if(btnKind=="upBtn"){
										console.log("수정 폼 출력");
										updateForm(r_num);
									}else if(btnKind=="delBtn"){
										console.log("삭제 처리");
										deleteBtn(b_num, r_num);
									}
								}
								btnKind="";		
							});
						}	
					});
					
				
				
				
				/** 기본 댓글 목록 불러오기*/
	
				//addItem(1, "ㅋ", "ㅋ", "ㅋ");
				var b_num = ${detail.b_num};
				listAll(b_num);
				
				if(!$("replyInsertBtn").attr("data-button")){
					$("#replyInsertBtn").attr("data-button", "insertBtn");
				}
				$("#replyInsertFormBtn").click(function(){
					setModal("댓글등록", "insertBtn", "등록");
					dataReset();
					$("#replyModal").modal();
				});
				
				//modal 내 등록 버튼 클릭 이벤트 처리
				/** 글입력을 위한 Ajax 연동 처리*/
				//$("#replyInserBtn").click(function(){
				$(document).on("click", "button[data-button='insertBtn']", function(){
					//입력 유효성 체크
					if(!checkForm("#r_name", "작성자를")) return;
					else if(!checkForm("#r_content", "댓글 내용을")) return;
					else if(!checkForm("#r_pwd", "비밀번호를")) return;
					else{
						var insertUrl = "/replies/replyInsert";
						
						//글 저장을 위한 post 방식의 ajax 연동 처리
						$.ajax({
							url : insertUrl,
							type : "post",
							headers : {
								"Content-Type":"application/json",
								"X-HTTP-Method-Override":"POST"
							},
							dataType:"text",
							data : JSON.stringify({
								b_num:b_num,
								r_name:$("#r_name").val(),
								r_pwd:$("#r_pwd").val(),
								r_content:$("#r_content").val()
							}),
							error : function(){
								alert('시스템 오류입니다. 관리자에게 문의 하세요.');
							},
							success : function(result){
								if(result=="SUCCESS"){
									alert("댓글 등록이 완료되었습니다.");
									dataReset();
									$('#replyModal').modal('hide');
									listAll(b_num);
								}
							}
						});
					}
				});
				
				$('button[data-dismiss="modal"]').click(function(){
					dataReset();
				});
				
				/** 수정 및 삭제를 위한 Ajax 연동 처리*/

				
				
				
			
				
				/*비밀번호 체크화면에서 "취소" 버튼 클릭 처리*/
		 		$(document).on("click", "button[data-btn]", function(){
					$(".btn").parents("div.panel .panel-heading .pwdArea").remove();
					$(this).parents("div.panel .panel-heading").append(pwdView());
						btnKind = $(this).attr("data-btn")
						console.log("클릭 버튼 btnkind : " +btnKind);
				
				});
				
				$(document).on("click", "button[data-button='updateBtn']", function(){
					//console.log("수정버튼")
					var r_num = $("input[name='r_num']").val();
					if(!checkForm("#r_content", "댓글 내용을")) return;
					else{
						$.ajax({
							url : "/replies/" + r_num,
							type : "put",
							headers : {
								"Content-Type":"application/json",
								"X-HTTP-Method-Override":"PUT"
							},
							data : JSON.stringify({
								r_content:$("#r_content").val(),
								r_pwd:$("#r_pwd").val()
							}),
							dataType:"text",
							error : function(){
								alert('시스템 오류입니다. 관리자에게 문의 하세요.');
							},
							success : function(result){
								console.log("result: " + result);
								if(result=="SUCCESS"){
									alert("댓글 수정이 완료되었습니다.");
									$('#replyModal').modal('hide');
									listAll(b_num);
								}
							}
						});
					}
				}); 
			
				
				/* 비밀번호 입력 양식에 키보드로 문자를 누르면 처리 이벤트*/
				$(document).on("keydown", ".passwd", function(){
					var span=$(this).parents("form").find("span");
					span.removeClass("msg_error");
					span.addClass("msg_defalut");
					span.html(message);
					});
			
				
				
				
			}); //최종 종료 $
			
			//입력폼 초기화
			function dataReset(){
				$("#r_name").val("");
				$("#r_content").val("");
				$("#r_pwd").val("");
				setModal("댓글 등록", "insertBtn", "등록");
			}
			
			function setModal(title, value, text){
				$("#replyModalLabel").html(title);
				$("#replyInsertBtn").attr("data-button", value);
				$("#replyInsertBtn").html(text);
			}
			
			// 댓글 등록 메서드
			function addItem(r_num, r_name, r_content, r_date){
				var wrapper_div = $("<div>");
				wrapper_div.attr("data-num", r_num);
				wrapper_div.addClass("panel panel-default");
				
				var new_div = $("<div>");
				new_div.addClass("panel-heading form-inline");
				
				// 작성자 정보의 이름
				var name_span = $("<span>");
				name_span.addClass("name");
				name_span.html(r_name + "님")
				
				//작성일시
				var date_span = $("<span>");
				date_span.html(" / " + r_date + " ")
				
				//수정하기 버튼
				//var upBtn = $("<input>");
				//upBtn.attr({"type" : "button", "value" : "수정하기"});
				var upBtn=$("<button>");
				upBtn.attr({"type" : "button"});
				upBtn.attr("data-btn","upBtn");
				upBtn.addClass("btn btn-primary gap");
				upBtn.html("수정하기");
							
				//삭제하기 버튼
				//var delBtn = $("<input>");
				//delBtn.attr({"type" : "button", "value" : "삭제하기"});
				var delBtn = $("<button>");
				delBtn.attr({"type" : "button"});
				delBtn.attr("data-btn","delBtn");
				delBtn.addClass("btn btn-primary gap");
				delBtn.html("삭제하기");
				
				/* //비밀번호 확인 
				var pwdInput = $("<input>");
				pwdInput.attr("type", "password");
				pwdInput.attr("visible", "hide");
				pwdInput.addClass("form-control");
				
				//비밀번호 확인 버튼
				var pwdBtn = $("<input>");
				pwdBtn.attr({"type" : "button", "value" : "확인"});
				pwdBtn.attr("visible", "hide");
				pwdBtn.addClass("btn btn-primary btn-sm"); */
				
				//내용
				var content_div = $("<div>");
				content_div.html(r_content);
				content_div.addClass("panel-body");
				
				//조립하기
				new_div.append(name_span).append(date_span).append(upBtn).append(delBtn);
				//new_div.append(name_span).append(date_span).append(upBtn).append(delBtn).append(pwdInput).append(pwdBtn);
				wrapper_div.append(new_div).append(content_div);
				$("#reviewList").append(wrapper_div);
			}
			
			function listAll(b_num){
				$("#reviewList").html("");
				var url = "/replies/all/" + b_num + ".json";
				
				$.getJSON(url, function(data){
					console.log("list count: " + data.length);
					replyCnt = data.length;
					$(data).each(function(){
						var r_num = this.r_num;
						var r_name = this.r_name;
						var r_content = this.r_content;
						var r_date = this.r_date;
						r_content = r_content.replace(/(\r\n|\r|\n)/g, "<br/>");
						addItem(r_num, r_name, r_content, r_date);
					});
				}).fail(function(){
					alert("댓글 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.");
				});
			}
			
			/** 비밀번호 체크를 화면 구현*/
			function pwdView(area){
	            var span = $("<span>");
	            span.addClass("pwdArea");
	            
	            var pwd_form = $("<form>");
	            pwd_form.attr("name", "f_pwd");
	            pwd_form.addClass("form-inline inline");
	            
	            var pwd_label = $("<label>");
	            pwd_label.attr("for", "passwd");
	            pwd_label.html("비밀번호 : ");
	         
	            var pwd_input = $("<input>");
	            pwd_input.attr({ "type":"password", "name":"passwd"})
	            pwd_input.addClass("form-control passwd gap");
	            pwd_input.prop("autofocus", "autofocus");
	                   
	         
	            var pwd_check = $("<input>");
	            pwd_check.attr({"type":"button", "value":"확인"});
	            pwd_check.addClass("btn btn-default pwdCheckBut gap");
	            
	            var pwd_reset = $("<input>");
	            pwd_reset.attr({"type":"button", "value":"취소"});
	            pwd_reset.addClass("btn btn-default pwdResetBut gap");
	            
	            var pwd_span = $("<span>");
	            pwd_span.addClass("msg");
	            pwd_span.html(message);
	            
	            pwd_form.append(pwd_label).append(pwd_input).append(pwd_check).append(pwd_reset).append(pwd_span);
	           	return span.append(pwd_form);
	         }
			
			/**삭제 처리 함수*/
			function deleteBtn(b_num, r_num){
				if(confirm("선택하신 댓글을 삭제하시겠습니까?")){
					$.ajax({
						url : '/replies/' +b_num +"/"+ r_num,
						type : 'delete',
						headers : {
							
							"Content-Type":"application/json",
							"X-HTTP-Method-Override" : "DELETE"
						},
						/* data : "b_num="+b_num, */
						dataType : 'text',
						error : function(){
							alert('시스템오류 입니다. 관리자에게 문의하세요.');
						},
						success : function(result){
							console.log("result:" + result);
							if(result=='SUCCESS'){
								alert("삭제 되었습니다.");
								listAll(b_num);
							}
						}
					});
				}
			}
			
			function updateForm(r_num){
				$.ajax({
					url : "/replies/" + r_num + ".json",
					type : "get",
					dataType : "json",
					error : function(){
						alert('시스템오류 입니다. 관리자에게 문의하세요.');
					},
					success : function(data){
						$("#r_name").val(data.r_name);
						$("#r_content").val(data.r_content);
						
						var num_input = $("<input>");
						num_input.attr({"type":"hidden", "name":"r_num"})
						num_input.val(r_num);
						$("#comment_form").append(num_input);
						
						setModal("댓글 수정", "updateBtn", "수정");
						
						$("#replyModal").modal();
					}
				});
			}
			
			/*비밀번호 확인 버튼 클릭 시 실질적인 처리 함수*/
			/*------------------------------------------------------------------------------------
			참고: Pramise는 비동기 처리가 성공(fulfilled)하였는지 또는 실패(rejected)하였는지 등의 상태 정보와 처리종료 후 실행될 콜백함수(then, catch)담고
			있는 객체이다. jQuery Deferred는 각각의 비동기식 처리에 Pramise 객체를 연계하여 그 상태를 전파하는 것으로 pramise를 구현한
			jQuery 객체이다. Deferred 객체는 상태를 가지고 있는데 이는 비동기식 처리의 상태가 변경되는 시점에 특정 함수(resolve(), reject())를 호출하여
			Deffered 객체에 상태를 부여하기 때문이다.
			
			-------------------------------------------------------------------------------------------------*/
		function pwdCheck(r_num, pwd, msg){
			var def = new $.Deferred();
			
			$.ajax({
				url : "/replies/pwdConfirm.json",
				data : "r_num="+r_num+"&r_pwd="+pwd.val(),
				type : "post" , 
				dataType : "text",
				error : function(){
					alert('시스템 오류입니다. 관리자에게 문의 하세요.');
				},
				success : function(resultData){
					console.log("resultData : " + resultData);
					//비동기 함수 success 콜백 함수에 def.resolve() 함수 호출
					if(resultData==0){ //일치하지 않는 경우
						msg.addClass("msg_error");
						msg.text("입력한 비밀번호가 일치하지 않습니다.");
						pwd.select();
					}else if(resultData==1){
						def.resolve(resultData);
						$(pwd).parents("div.panel .panel-heading .pwdArea").remove();
					}
				}
			});
			//def.promise() 함수 리턴
			return def.promise();
		}
			
		
		
		
		</script>
	</head>
	<body>
		<div id="replyContainer">
			
			<!-- 등록 버튼 영역 -->
			<p class="tar">
				<button type="button" class="btn btn-primary" id="replyInsertFormBtn">댓글등록</button>
			</p>
			
			<!-- 리스트 영역 -->
			<div id="reviewList"></div>
			
			<!-- 등록 화면 영역(modal) -->
			<div class="modal fade" id="replyModal" tabindex="-1" role="dialog" aria-labelledby="replyModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							<h4 class="modal-title" id="replyModalLabel">댓글 등록</h4>
						</div>
						<div class="modal-body">
							<form id="comment_form" name="comment_form">
								<div class="form-group">
							    	<label for="g_name" class="control-label">작성자</label>
							    	<input type="text" class="form-control" name="r_name" id="r_name" maxlength="5" />
							    </div>
							    <div class="form-group">
									<label for="g_content" class="control-label">글내용</label>
									<textarea class="form-control" name="r_content" id="r_content" rows="5"></textarea>
							    </div>
							    <div class="form-group">
									<label for="g_pwd" class="control-label">비밀번호</label>
									<input type="text" class="form-control" name="r_pwd" id="r_pwd" />
							    </div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
							<button type="button" class="btn btn-primary" id="replyInsertBtn">등록</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 패스워드 확인 화면 영역(modal) -->
			<div class="modal " id="pwdConfirmModal" tabindex="-1" role="dialog" aria-labelledby="pwdConfirmModalLabel" aria-hidden="true">
			   <div class="modal-dialog modal-sm">
			      <div class="modal-content">
			         <div class="modal-header">
			            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			            <h4 class="modal-title" id="pwdConfirmModalLabel">비밀번호 확인</h4>
			         </div>
			         <div class="modal-body">
			            <form id="pwdConfirmForm">
			               <input type="hidden" name="r_num">
			               <div class="form-group">
			                  <label for="r_pwd" class="control-label">비밀번호:</label>
			                  <input type="password" class="form-control" name="r_pwd" maxlength="18" required="required">
			                  <span class="error_msg"></span>
			               </div>
			            </form>
			         </div>
			         <div class="modal-footer">
			            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			            <button type="button" class="btn btn-primary" id="btnPwdConfirm">확인</button>
			         </div>
			      </div>
			   </div>
			</div>
		</div>
	</body>
</html>