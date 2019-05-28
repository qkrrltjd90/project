package com.spring.client.reply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.client.board.dao.BoardDao;
import com.spring.client.reply.dao.ReplyDao;
import com.spring.client.reply.vo.ReplyVO;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{
	
	
	@Setter(onMethod_=@Autowired)
	private BoardDao boardDao;
	
	@Setter(onMethod_=@Autowired)
	private ReplyDao replyDao;

	@Override
	public List<ReplyVO> replyList(Integer b_num) {
		List<ReplyVO> list = null;
		list = replyDao.replyList(b_num);
		return list;
	}
	//글입력구현
	@Transactional
	@Override
	public int replyInsert(ReplyVO rvo) {
		int result = 0;
		//try{
			result = replyDao.replyInsert(rvo);
			boardDao.replyCntUpdate(rvo.getB_num(), 1);
		//}catch(Exception e){
		//e.rpintStackTrace();
		//result = 0;
		//}
	
			return result;
	}

	@Override
	public int pwdConfirm(ReplyVO rvo) {
		int result = 0;
		result = replyDao.pwdConfirm(rvo);
		return result;
	}
	
	//글삭제구현
	@Transactional
	@Override
	public int replyDelete(int r_num, int b_num) {
		int result = 0;
		//try{
		
		
			result = replyDao.replyDelete(r_num);
			boardDao.replyCntUpdate(b_num,  -1);
	//}catch(Exception e) {
		//e.printStackTrace();
		//result = 0;
	//}
	return result;
}


	//���� �� ���ڵ� ��ȸ
	@Override
	public ReplyVO replySelect(int r_num) {
		ReplyVO rvo = null;
		rvo = replyDao.replySelect(r_num);
		return rvo;
	}

	@Override
	public int replyUpdate(ReplyVO rvo) {
		int result = 0;
		result = replyDao.replyUpdate(rvo);
		return result;
	}

	@Override
	public int replyCnt(int b_num) {
		int result = 0;
		result = replyDao.replyCnt(b_num);
		return result;
	}

}
