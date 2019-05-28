package com.spring.client.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.client.board.dao.BoardDao;
import com.spring.client.board.vo.BoardVO;
import com.spring.client.reply.dao.ReplyDao;
import com.spring.client.reply.vo.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MyBatisTests {
	@Setter(onMethod_= @Autowired)
	private BoardDao boardDao;
	
	@Setter(onMethod_= @Autowired)
	private ReplyDao replyDao;
	
/*	@Test
	public void testBoardList() {
		log.info(boardDao.getClass().getName());
		log.info("boardList() 메서드 실행");
		log.info("--------------------------------------------");
		log.info(boardDao.boardList());
		
		BoardVO bvo = new BoardVO();
		bvo.setPageNum(2);
		bvo.setAmount(10);
		
		bvo.setSearch("b_title");
		bvo.setKeyword("노력");
		log.info(boardDao.boardList(bvo));
	}*/
	
	/*@Test
	public void testBoardInsert1() {
		BoardVO bvo = new BoardVO();
		bvo.setB_name("��ö��");
		bvo.setB_title("���鶧 ���� �Ǵ� ���2");
		bvo.setB_content("�ҽ��ϰ� �����̴� �ڿ��Դ� ��� ���� �Ұ����ϴ�. �ֳ��ϸ� ������ �Ұ����ϰ� ���̱� �����̴�.");
		bvo.setB_pwd("1234");
		
		log.info("BoardVO : " + bvo);
		log.info("------------------------");
		log.info("��ȯ��: " + boardDao.boardInsert(bvo));
	}*/
	
	/*@Test
	public void testBoardInsert2() {
		BoardVO bvo = new BoardVO();
		bvo.setB_name("������");
		bvo.setB_title("���鶧 ���� �Ǵ� ���3");
		bvo.setB_content("���� �Ϻ��� �غ�� �����ϴ�. ���� ������ �����̰� �� ������ ���� �� ��ȥ�� ������ ���� �б��Դϴ�.");
		bvo.setB_pwd("1234");
		
		log.info("BoardVO : " + bvo);
		log.info("------------------------");
		log.info("��ȯ��: " + boardDao.boardInsert(bvo));
	}*/
	
	/*@Test
	public void testBoardDetail() {
		BoardVO bvo = new BoardVO();
		bvo.setB_num(2);
		log.info("BoardVO : " + bvo);
		log.info("-------------------------");
		log.info("��ȯ��:" + boardDao.boardDetail(bvo));
	}*/
	
	
	/*@Test
	public void testPwdConfirm() {
		BoardVO bvo = new BoardVO();
		bvo.setB_num(2);
		bvo.setB_pwd("1235");
		log.info("BoardVO : " + bvo);
		log.info("-------------------------");
		log.info("��ȯ��(0 or 1):" + boardDao.pwdConfirm(bvo));	//��й�ȣ ��ġ�ϸ� 1, �ƴϸ� 0 ��ȯ
	}*/
	
	/*@Test
	public void testBoardUpdate() {
		BoardVO bvo = new BoardVO();
		bvo.setB_num(26);
		bvo.setB_title("�������2");
		bvo.setB_content("�������2");
		//bvo.setB_pwd("12345");
		log.info("BoardVO : " + bvo);
		log.info("-------------------------");
		log.info("��ȯ��:" + boardDao.boardUpdate(bvo));
	}*/
	
	/*@Test
	public void testBoardDelete() {
		int b_num = 26;
		log.info("��ȯ��:" + boardDao.boardDelete(b_num));
	}*/
	
	
	/*@Test
	public void replyList() {
		log.info(replyDao.getClass().getName());
		log.info("replyList() �޼��� ����");
		log.info(replyDao.replyList(42));
		log.info("--------------------------------------------");
	}*/
	
	/*@Test
	public void testReplyInsert() {
		ReplyVO rvo = new ReplyVO();
		rvo.setB_num(42);
		rvo.setR_name("����");
		rvo.setR_content("�� �Ź� ������~");
		rvo.setR_pwd("123");
		
		log.info("replyInsert() �޼��� ����");
		log.info("ReplyVO: " + rvo);
		log.info("��ȯ��:" + replyDao.replyInsert(rvo));
	}*/
	
	/*@Test 
	public void testPwdConfirm() {
		ReplyVO rvo = new ReplyVO();
		rvo.setR_num(2);
		rvo.setR_pwd("1234");
		
		log.info("pwdConfirm() �޼��� ����");
		log.info("��ȯ��:" + replyDao.pwdConfirm(rvo));
	}*/
	
	/*@Test 
	public void testReplyDelete() {
		log.info("��� ���� ��ȯ��: " + replyDao.replyDelete(2));
	}*/
	
	/*@Test
	public void testBoardListCnt() {
		BoardVO bvo = new BoardVO();
		bvo.setSearch("b_title");
		bvo.setKeyword("노력");
		log.info(boardDao.boardListCnt(bvo));
	}*/

}