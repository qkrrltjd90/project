package com.spring.client.reply.vo;

import lombok.Data;

@Data
public class ReplyVO {
	private int    b_num	=0;	//게시판글번호
	private int    r_num	=0;	//댓글번호
	private String r_name	="";//댓글 작성자
	private String r_content="";//댓글 내용
	private String r_pwd	="";//댓글 비밀번호
	private String r_date	="";//댓글 작성일
}
