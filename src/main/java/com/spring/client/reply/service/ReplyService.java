package com.spring.client.reply.service;

import java.util.List;

import com.spring.client.reply.vo.ReplyVO;

public interface ReplyService {
	public List<ReplyVO> replyList(Integer b_num);

	public int replyInsert(ReplyVO rvo);
	
	public int pwdConfirm(ReplyVO rvo);

	public int replyUpdate(ReplyVO rvo);

	public int replyDelete(int r_num, int b_num);

	public ReplyVO replySelect(int r_num);
	
	public int replyCnt(int b_num);

	
}
