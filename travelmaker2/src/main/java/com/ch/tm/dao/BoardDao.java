package com.ch.tm.dao;

import java.util.List;

import com.ch.tm.model.Board;

public interface BoardDao {

	// 게시글 번호 생성
	int getMaxNum();

	// 게시글 입력
	int insert(Board board);

	// 조회수 증가
	void updateReadCount(int bno);

	// 게시글 보기
	Board select(int bno);

	// 게시글 수정 
	int update(Board board);

	// 게시글 삭제
	int delete(int bno);

	// 전체 게시글 수 
	int getTotal(Board board);

	// 게시글 전체 목록
	List<Board> list(Board board);

	// (관리자 기능) 해당 회원이 좋아요한 게시글 목록 
	List<Board> myLikeList(int mno, int startRow, int endRow);

	// (관리자 기능) 해당 회원이 쓴 글 수
	int allMyBoard(int mno);

	// (관리자 기능) 해당 회원이 쓴 게시글 목록 
	List<Board> myBoardList(int mno, int startRow, int endRow);

	// (관리자 기능) 게시글 삭제 기능
	int adminDelete(int bno);


}
