package com.ch.tm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.tm.model.Board;
import com.ch.tm.dao.BoardDao;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDao bd;

	// 게시글 번호 생성 
	@Override
	public int getMaxNum() {
		return bd.getMaxNum();
	}

	// 게시글 입력
	@Override
	public int insert(Board board) {
		return bd.insert(board);
	}

	// 조회수 증가
	@Override
	public void updateReadCount(int bno) {
		bd.updateReadCount(bno);
	}

	// 게시글 보기
	@Override
	public Board select(int bno) {
		return bd.select(bno);
	}

	// 게시글 수정 
	@Override
	public int update(Board board) {
		return bd.update(board);
	}

	// 게시글 삭제
	@Override
	public int delete(int bno) {
		return bd.delete(bno);
	}

	// 전체 게시글 수 
	@Override
	public int getTotal(Board board) {
		return bd.getTotal(board);
	}

	// 게시글 전체 목록
	@Override
	public List<Board> list(Board board) {
		return bd.list(board);
	}

	// (관리자 기능) 해당 회원이 좋아요한 게시글 목록 
	@Override
	public List<Board> myLikeList(int mno, int startRow, int endRow) {
		return bd.myLikeList(mno, startRow, endRow);
	}

	// (관리자 기능) 해당 회원이 쓴 글 수
	@Override
	public int allMyBoard(int mno) {
		return bd.allMyBoard(mno);
	}

	// (관리자 기능) 해당 회원이 쓴 게시글 목록 
	@Override
	public List<Board> myBoardList(int mno, int startRow, int endRow) {
		return bd.myBoardList(mno, startRow, endRow);
	}

	// (관리자 기능) 게시글 삭제 기능
	@Override
	public int adminDelete(int bno) {
		return bd.adminDelete(bno);
	}



}
