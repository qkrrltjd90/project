package com.spring.client.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.client.board.vo.BoardVO;

public interface BoardDao {
	public List<BoardVO> boardList(BoardVO bvo);
	
	public int boardInsert(BoardVO bvo);
	
	public BoardVO boardDetail(BoardVO bvo);
	
	public int pwdConfirm(BoardVO bvo);
	
	public BoardVO updateForm(BoardVO bvo);
	
	public int boardUpdate(BoardVO bvo);
	
	public int boardDelete(int b_num);
	
	public int boardListCnt(BoardVO bvo);
	
	public void replyCntUpdate(@Param("b_num") int b_num, @Param("amount") int amount);

	public List<BoardVO> boardList();
}
