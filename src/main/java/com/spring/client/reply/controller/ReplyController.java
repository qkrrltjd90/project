package com.spring.client.reply.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.client.reply.service.ReplyService;
import com.spring.client.reply.vo.ReplyVO;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/replies/*")
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	@Setter(onMethod_=@Autowired)
	private ReplyService replyService;
	
	
	/**
	 * ��� �۸�� ����
	 * @param b_num
	 * @return List<ReplyVO>
	 * ���� : @pathVariable�� URI�� ��ο��� ���ϴ� �����͸� �����ϴ� �뵵�� ������̼�
	 * ���� ��û URL : http://localhost:8080/replies/all/�Խ��Ǳ۹�ȣ
	 * ���� ��û URL : http://localhost:8080/replies/replyList?b_num=�Խ��Ǳ۹�ȣ
	 */
	@GetMapping(value = "/all/{b_num}",
			produces = { MediaType.APPLICATION_XML_VALUE,
						 MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ReplyVO>> replyList(@PathVariable("b_num") Integer b_num){
		log.info("list ȣ�� ����");
		
		ResponseEntity<List<ReplyVO>> entity = null;
		entity = new ResponseEntity<>(replyService.replyList(b_num), HttpStatus.OK);
		return entity;
	}
	
	@PostMapping(value = "/replyInsert", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> replyInsert(@RequestBody ReplyVO rvo){
		log.info("replyInsert ȣ�� ����");
		log.info("ReplyVO: " + rvo);
		int result = 0;
		
		result = replyService.replyInsert(rvo);
		return result==1 ? new ResponseEntity<String>("SUCCESS", HttpStatus.OK) :
						   new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	/**
	 * ��� ���� ó��
	 * @param r_num
	 * @return
	 */
	//@RequestMapping(value = "/{r_num}", method = RequestMethod.DELETE, produces = {MediaType.TEXT_PLAIN_VALUE})
	@DeleteMapping(value =  "/{b_num}/{r_num}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> replyDelete(@PathVariable("r_num") Integer r_num,
			@PathVariable("b_num") Integer b_num){
		
		log.info("replyDelete 호출 성공");
		
		//int result = replyService.replyDelete(r_num);
		int result = replyService.replyDelete(r_num, b_num);
		return result==1?
				new ResponseEntity<String>("SUCCESS", HttpStatus.OK):
				new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@GetMapping(value = "/{r_num}",
			produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> replySelect(@PathVariable("r_num") Integer r_num){
		log.info("replySelect ȣ�� ����");
		
		ResponseEntity<ReplyVO> entity = null;
		entity = new ResponseEntity<ReplyVO>(replyService.replySelect(r_num), HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value = "/{r_num}",
			method = { RequestMethod.PUT, RequestMethod.PATCH},
			consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> replyUpdate(@PathVariable("r_num") Integer r_num, @RequestBody ReplyVO rvo){
		log.info("replyUpdate ȣ�� ����");
		
		rvo.setR_num(r_num);
		int result = replyService.replyUpdate(rvo);
		return result==1?
				new ResponseEntity<String>("SUCCESS", HttpStatus.OK):
				new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	/************************************
	 * 댓글 비밀번호 확인
	 * @return String
	 * 참고: @RequestBody
	 * 
	 *************************************/
	@RequestMapping(value="/pwdConfirm")
	public ResponseEntity<Integer> pwdConfirm(@ModelAttribute ReplyVO rvo){
		log.info("pwdConfirm 호출 성공");
		
		ResponseEntity<Integer> entity = null;
		int result = 0;
		
		result = replyService.pwdConfirm(rvo);
		entity = new ResponseEntity<Integer>(result, HttpStatus.OK);
		return entity;
	}
	
}
